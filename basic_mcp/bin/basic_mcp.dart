// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io' as io;

import 'package:async/async.dart';
import 'package:basic_mcp/server.dart';
import 'package:stream_channel/stream_channel.dart';

void main() {
  final channel = StreamChannel //
          .withCloseGuarantee(io.stdin, io.stdout)
      .transform(StreamChannelTransformer.fromCodec(utf8))
      .transformStream(const LineSplitter())
      .transformSink(
    StreamSinkTransformer.fromHandlers(
      handleData: (data, sink) {
        sink.add('$data\n');
      },
    ),
  );

  DartMCPServer(channel);
}
