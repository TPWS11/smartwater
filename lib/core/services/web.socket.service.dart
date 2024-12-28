import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String websocketUrl;
  late final WebSocketChannel _channel;
  late final StreamController<Map<String, dynamic>> _streamController;

  WebSocketService({required this.websocketUrl}) {
    _channel = WebSocketChannel.connect(Uri.parse(websocketUrl));
    _streamController = StreamController<Map<String, dynamic>>();
    _listenToWebSocket();
  }

  Stream<Map<String, dynamic>> get stream => _streamController.stream;

  void _listenToWebSocket() {
    _channel.stream.listen(
          (message) {
        try {
          final parsedData = jsonDecode(message);
          _streamController.add(parsedData);
        } catch (e) {
          _streamController.addError('Error parsing WebSocket message: $e');
        }
      },
      onError: (error) => _streamController.addError('WebSocket error: $error'),
      cancelOnError: true,
    );
  }

  void dispose() {
    _channel.sink.close();
    _streamController.close();
  }
}
