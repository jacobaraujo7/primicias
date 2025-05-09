// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:basic_mcp/server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:stream_channel/stream_channel.dart';

/// Cria um SSE channel
StreamChannel<String> createSseChannel() {
  final controller = StreamController<String>();
  final stream = controller.stream;
  final sink = controller.sink;
  return StreamChannel.withCloseGuarantee(stream, sink);
}

/// Handler que expõe o SSE para o client
Response sseHandler(Request request, StreamChannel<String> channel) {
  final headers = {
    HttpHeaders.contentTypeHeader: 'text/event-stream',
    HttpHeaders.cacheControlHeader: 'no-cache',
    HttpHeaders.connectionHeader: 'keep-alive',
  };

  final stream = channel.stream.map(utf8.encode);

  return Response.ok(stream, headers: headers);
}

void main() async {
  final channel = createSseChannel();

  final handler = Pipeline().addHandler((Request request) {
    if (request.url.path == 'sse') {
      DartMCPServer(channel);

      return sseHandler(request, channel);
    }

    return Response.ok('Servidor SSE rodando. Acesse /sse');
  });

  channel.stream.listen((data) {
    print('Recebido: $data');
  });

  final server = await io.serve(handler, 'localhost', 8080);
  print('🚀 Servidor iniciado em http://${server.address.host}:${server.port}');
}
