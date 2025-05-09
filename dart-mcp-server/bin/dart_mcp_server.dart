import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dart_mcp/server.dart';
import 'package:stream_channel/stream_channel.dart';

void main(List<String> args) {
  final channel = StreamChannel //
          .withCloseGuarantee(stdin, stdout)
      .transform(StreamChannelTransformer.fromCodec(utf8))
      .transformStream(LineSplitter())
      .transformSink(StreamSinkTransformer.fromHandlers(
        handleData: (value, sink) => sink.add('$value\n'),
      ));

  MyServerMCP(channel: channel);
}

final class MyServerMCP extends MCPServer with ToolsSupport {
  MyServerMCP({required super.channel})
      : super.fromStreamChannel(
          implementation: ServerImplementation(
            name: 'Dart TOOLS',
            version: '1.0.0',
          ),
          instructions: 'A tools for Dart SDK',
        );

  @override
  FutureOr<InitializeResult> initialize(InitializeRequest request) {
    registerTool(
      Tool(
        name: 'dart_version',
        description: 'Get the Dart SDK version',
        inputSchema: ObjectSchema(),
      ),
      (request) {
        final process = Process.runSync(
          '/Users/jacob/fvm/default/bin/dart',
          ['--version'],
        );

        if (process.exitCode != 0) {
          return CallToolResult(
            content: [TextContent(text: 'Dart not installed')],
            isError: true,
          );
        }

        return CallToolResult(
          content: [
            TextContent(text: '${process.stdout}'),
          ],
        );
      },
    );

    return super.initialize(request);
  }
}
