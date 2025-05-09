import 'dart:async';
import 'dart:io';

import 'package:dart_mcp/server.dart';
import 'package:stream_channel/stream_channel.dart';

/// Our actual MCP server.
final class DartMCPServer extends MCPServer with ToolsSupport {
  DartMCPServer(StreamChannel<String> channel)
      : super.fromStreamChannel(
          channel: channel,
          implementation: ServerImplementation(name: 'example dart server', version: '0.1.0'),
          instructions: 'A basic tool that can respond with "hello world!"',
        );

  @override
  FutureOr<InitializeResult> initialize(InitializeRequest request) {
    registerTool(
      Tool(
        name: 'check_dart',
        description: 'Checks if the dart is installed',
        inputSchema: ObjectSchema(),
      ),
      (_) async {
        final result = await Process.run('dart', ['--version']);
        if (result.exitCode != 0) {
          return CallToolResult(
            content: [
              TextContent(text: 'Dart is not installed'),
            ],
          );
        }
        final version = result.stdout.toString().split(' ').last;

        return CallToolResult(
          content: [
            TextContent(text: 'Yes, Dart is installed. Version $version'),
          ],
        );
      },
    );

    registerTool(
      Tool(
        name: 'sum_numbers',
        description: 'Sums two numbers',
        inputSchema: ObjectSchema(
          properties: {
            'a': NumberSchema(),
            'b': NumberSchema(),
          },
          required: ['a', 'b'],
        ),
      ),
      (request) {
        final a = request.arguments!['a'] as num;
        final b = request.arguments!['b'] as num;
        return CallToolResult(
          content: [
            TextContent(text: 'The sum of $a and $b is ${a + b}'),
          ],
        );
      },
    );
    return super.initialize(request);
  }
}
