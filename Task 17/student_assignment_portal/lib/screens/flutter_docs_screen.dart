import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../main.dart';

/// Displays https://flutter.dev inside an in-app WebView.
///
/// Requires the `webview_flutter` package — see pubspec.yaml.
class FlutterDocsScreen extends StatefulWidget {
  const FlutterDocsScreen({super.key});

  @override
  State<FlutterDocsScreen> createState() => _FlutterDocsScreenState();
}

class _FlutterDocsScreenState extends State<FlutterDocsScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _canGoBack = false;
  bool _canGoForward = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) async {
            final back = await _controller.canGoBack();
            final fwd = await _controller.canGoForward();
            setState(() {
              _isLoading = false;
              _canGoBack = back;
              _canGoForward = fwd;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Documentation')),
      body: Column(
        children: [
          if (_isLoading) const LinearProgressIndicator(minHeight: 2),
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: _canGoBack ? kPrimaryColor : Colors.grey.shade300,
              onPressed: _canGoBack ? () => _controller.goBack() : null,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              color: _canGoForward ? kPrimaryColor : Colors.grey.shade300,
              onPressed: _canGoForward ? () => _controller.goForward() : null,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              color: kPrimaryColor,
              onPressed: () => _controller.reload(),
            ),
            IconButton(
              icon: const Icon(Icons.home_outlined),
              color: kPrimaryColor,
              onPressed: () =>
                  _controller.loadRequest(Uri.parse('https://flutter.dev')),
            ),
          ],
        ),
      ),
    );
  }
}
