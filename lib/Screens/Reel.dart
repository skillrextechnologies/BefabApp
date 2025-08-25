// reel_screen.dart
import 'dart:io';
import 'package:befab/components/CustomBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';

class Reel extends StatefulWidget {
  const Reel({super.key});

  @override
  State<Reel> createState() => _ReelState();
}

class _ReelState extends State<Reel> {
  VideoPlayerController? _controller;
  String? _category;
  String? _videoPath;
  String? _coverImagePath;
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isPlaying = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    _videoPath = args?['videoPath'] as String?;
    _category = args?['category'] as String?;

    if (_videoPath != null && _controller == null) {
      _controller = VideoPlayerController.file(File(_videoPath!))
        ..initialize().then((_) {
          setState(() {}); // refresh once video is ready
        });
    }
  }

  Future<void> _pickCoverImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _coverImagePath = image.path;
      });
    }
  }

  void _togglePreview() {
    if (_controller == null) return;
    setState(() {
      if (_isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _captionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 100,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SvgPicture.asset(
                  'assets/images/Arrow.svg',
                  width: 14,
                  height: 14,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Back',
                style: TextStyle(
                  color: Color(0xFF862633),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: const Text(
          'New Reel',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Video / Cover
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_coverImagePath != null)
                      Image.file(
                        File(_coverImagePath!),
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    else if (_controller != null &&
                        _controller!.value.isInitialized)
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                    else
                      Image.asset(
                        'assets/images/FRAME10.png',
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                    // Preview button
                    Positioned(
                      top: 16,
                      child: GestureDetector(
                        onTap: _togglePreview,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _isPlaying ? "Pause" : "Preview",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Edit cover button
                    Positioned(
                      bottom: 16,
                      child: GestureDetector(
                        onTap: _pickCoverImage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Edit cover",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Caption input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: "Add a caption...",
                  border: InputBorder.none,
                ),
                maxLines: 3,
              ),
            ),

            // Location input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  hintText: "Add location...",
                  border: InputBorder.none,
                ),
              ),
            ),

            // Post button
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF862633),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/single-reel',
                      arguments: {
                        'videoPath': _videoPath,
                        'category': _category,
                        'caption': _captionController.text,
                        'location': _locationController.text,
                        'coverImagePath': _coverImagePath,
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    child: Text(
                      'Post',
                      style: GoogleFonts.lexend(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: IconButton(
          icon: const Icon(
            Icons.add_circle,
            size: 70,
            color: Color(0xFF862633),
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 3),
    );
  }
}
