import 'package:device_preview/device_preview.dart';
import 'package:flutter/widgets.dart';

import 'showcase_app.dart';

void main() {
  runApp(
    DevicePreview(enabled: true, builder: (context) => const ShowcaseApp()),
  );
}
