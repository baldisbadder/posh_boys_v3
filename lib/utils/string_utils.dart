import 'package:html/parser.dart';

class StringUtilsHelper {
  static String stripHTML(String htmlText) {
    final document = parse(htmlText); // ✅ Parses HTML into a DOM document
    return document.body?.text ?? ''; // ✅ Extracts text, or empty string if null
  }
}
