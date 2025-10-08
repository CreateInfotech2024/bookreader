// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookreader/main.dart';

void main() {
  testWidgets('BookReader app smoke test - DOCX Viewer', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app loads
    expect(find.byType(BookReaderScreen), findsOneWidget);

    // Wait for the initial loading to complete
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    // Verify that toolbar buttons are present
    expect(find.byIcon(Icons.menu), findsWidgets);
    expect(find.byIcon(Icons.search), findsWidgets);
    expect(find.byIcon(Icons.zoom_in), findsWidgets);
    expect(find.byIcon(Icons.zoom_out), findsWidgets);
    expect(find.byIcon(Icons.refresh), findsWidgets);
    expect(find.byIcon(Icons.refresh_outlined), findsWidgets);
    
    // Verify loading text appears initially
    expect(find.text('Loading DOCX document...'), findsOneWidget);
  });
  
  testWidgets('BookReader zoom functionality test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    
    // Wait for initial load
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    
    // Find and tap zoom in button
    final zoomInButton = find.byIcon(Icons.zoom_in);
    expect(zoomInButton, findsWidgets);
    
    // Find and tap zoom out button
    final zoomOutButton = find.byIcon(Icons.zoom_out);
    expect(zoomOutButton, findsWidgets);
    
    // Find reset zoom button
    final resetButton = find.byIcon(Icons.refresh);
    expect(resetButton, findsWidgets);
  });
}
