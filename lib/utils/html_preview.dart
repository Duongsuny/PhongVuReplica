import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

//This file is dedicated to generate the preview of the html string
class HTMLPreview {
  String preview(String htmlString, int limit) {
    var document = html_parser.parse(htmlString);
    var buffer = StringBuffer();
    int charCount = 0;

    void traverse(Node node) {
      if (charCount >= limit) return;

      if (node is Text) {
        String text = node.text;
        if (charCount + text.length > limit) {
          buffer.write(text.substring(0, limit - charCount));
          charCount = limit;
        } else {
          buffer.write(text);
          charCount += text.length;
        }
      } else if (node is Element) {
        buffer.write('<${node.localName}');
        node.attributes.forEach((key, value) {
          buffer.write(' $key="$value"');
        });
        buffer.write('>');

        for (var child in node.nodes) {
          traverse(child);
          if (charCount >= limit) break;
        }

        buffer.write('</${node.localName}>');
      }
    }

    for (var node in document.body!.nodes) {
      traverse(node);
      if (charCount >= limit) break;
    }

    return buffer.toString();
  }
}
