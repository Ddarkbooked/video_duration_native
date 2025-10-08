import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_duration_native/video_duration_native.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _platformName;
  Duration? _videoDuration;
  String? _selectedVideoPath;
  final _pathController = TextEditingController(
    text: '/path/to/video.mp4',
  );

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final path = file.path;

        if (path != null) {
          setState(() {
            _selectedVideoPath = path;
            _pathController.text = path;
          });

          // Automatically get duration when video is selected
          if (mounted) {
            final duration = await getDuration(path);
            setState(() => _videoDuration = duration);
          }
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error picking video: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VideoDurationNative Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_platformName != null) ...[
              Text(
                'Platform Name: $_platformName',
                style: Theme.of(context).textTheme.headlineSmall,
                key: const Key('platform_name_text'),
              ),
              const SizedBox(height: 24),
            ],
            ElevatedButton(
              onPressed: () async {
                if (!context.mounted) return;
                try {
                  final result = await getPlatformName();
                  setState(() => _platformName = result);
                } on Exception catch (error) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Get Platform Name'),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              key: const Key('pick_video_button'),
              onPressed: _pickVideo,
              icon: const Icon(Icons.video_library),
              label: const Text('Pick Video File'),
            ),
            const SizedBox(height: 16),
            if (_selectedVideoPath != null) ...[
              Text(
                'Selected: ${_selectedVideoPath!.split('/').last}',
                key: const Key('selected_video_text'),
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _pathController,
              key: const Key('video_path_input'),
              decoration: const InputDecoration(
                labelText: 'Video Path or URI',
                hintText: '/path/to/video.mp4 or content://...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              key: const Key('get_duration_button'),
              onPressed: () async {
                if (!context.mounted) return;
                try {
                  final path = _pathController.text.trim();
                  if (path.isEmpty) {
                    throw Exception('Please enter a video path');
                  }
                  final result = await getDuration(path);
                  setState(() => _videoDuration = result);
                } on Exception catch (error) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('$error'),
                    ),
                  );
                }
              },
              child: const Text('Get Duration'),
            ),
            const SizedBox(height: 24),
            if (_videoDuration != null) ...[
              Text(
                'Duration: ${_videoDuration!.inSeconds} seconds',
                style: Theme.of(context).textTheme.headlineSmall,
                key: const Key('duration_text'),
              ),
              const SizedBox(height: 8),
              Text(
                '(${_videoDuration!.inMilliseconds} ms)',
                style: Theme.of(context).textTheme.bodyMedium,
                key: const Key('duration_ms_text'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
