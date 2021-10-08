// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:package_info_example/main.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:universal_io/io.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('fromPlatform', (WidgetTester tester) async {
    final info = await PackageInfo.fromPlatform();
    // These tests are based on the example app. The tests should be updated if any related info changes.
    if (Platform.isAndroid) {
      expect(info.appName, 'package_info_example');
      expect(info.buildNumber, '4');
      expect(info.packageName, 'io.flutter.plugins.packageinfoexample');
      expect(info.version, '1.2.3');
    } else if (Platform.isIOS) {
      expect(info.appName, 'Package Info Example');
      expect(info.buildNumber, '1');
      expect(info.packageName, 'io.flutter.plugins.packageInfoExample');
      expect(info.version, '1.0');
    } else if (Platform.isMacOS) {
      expect(info.appName, 'Package Info Example');
      expect(info.buildNumber, '1');
      expect(info.packageName, 'io.flutter.plugins.packageInfoExample');
      expect(info.version, '1.0.0');
    } else if (kIsWeb) {
      expect(info.appName, 'package_info_example');
      expect(info.buildNumber, '4');
      expect(info.packageName, isEmpty);
      expect(info.version, '1.2.3');
    } else if (Platform.isLinux) {
      expect(info.appName, 'package_info_example');
      expect(info.buildNumber, '4');
      expect(info.packageName, isEmpty);
      expect(info.version, '1.2.3');
    } else {
      throw (UnsupportedError('platform not supported'));
    }
  });

  testWidgets('example', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    if (Platform.isAndroid) {
      expect(find.text('package_info_example'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(
          find.text('io.flutter.plugins.packageinfoexample'), findsOneWidget);
      expect(find.text('1.2.3'), findsOneWidget);
    } else if (Platform.isIOS) {
      expect(find.text('Package Info Example'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(
          find.text('io.flutter.plugins.packageInfoExample'), findsOneWidget);
      expect(find.text('1.0'), findsOneWidget);
    } else if (Platform.isMacOS) {
      expect(find.text('Package Info Example'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(
          find.text('io.flutter.plugins.packageInfoExample'), findsOneWidget);
      expect(find.text('1.0.0'), findsOneWidget);
    } else if (kIsWeb) {
      expect(find.text('package_info_example'), findsOneWidget);
      expect(find.text('1.2.3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Not set'), findsOneWidget);
    } else if (Platform.isLinux) {
      expect(find.text('package_info_example'), findsOneWidget);
      expect(find.text('1.2.3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('Not set'), findsOneWidget);
    } else {
      throw (UnsupportedError('platform not supported'));
    }
  });
}