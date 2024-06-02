import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:trimming_video/core/utils/show_snackbar.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:trimming_video/features/trimming_videos/presentation/pages/trimmer_view.dart';

class HomePage extends StatefulWidget {
  String? outputPath;
  HomePage({Key? key, this.outputPath}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.outputPath != null) {
      _controller = VideoPlayerController.file(
        File(widget.outputPath!),
      )..initialize().then(
          (_) {
            setState(() {});
            _controller.play();
          },
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.outputPath != null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Trimmer'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: widget.outputPath == null
            ? GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.video,
                    allowCompression: false,
                  );

                  if (result != null) {
                    final file = File(result.files.single.path!);
                    if (!mounted) return;

                    final controller = VideoPlayerController.file(file);
                    await controller.initialize();

                    if (controller.value.duration <=
                        const Duration(seconds: 120)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TrimmerView(file),
                        ),
                      );
                    } else {
                      showSnackbar(context, "Выберите видео менее 120 секунд");
                    }
                    controller.dispose();
                  }
                },
                child: DottedBorder(
                  color: const Color.fromRGBO(52, 51, 67, 1),
                  dashPattern: const [10, 8],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Select Video",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.video,
                    allowCompression: false,
                  );

                  if (result != null) {
                    final file = File(result.files.single.path!);
                    if (!mounted) return;

                    final controller = VideoPlayerController.file(file);
                    await controller.initialize();

                    if (controller.value.duration <=
                        const Duration(seconds: 120)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TrimmerView(file),
                        ),
                      );
                    } else {
                      showSnackbar(context, "Выберите видео менее 120 секунд");
                    }
                    controller.dispose();
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: VideoPlayer(
                    _controller,
                  ),
                ),
              ),
      ),
    );
  }
}
