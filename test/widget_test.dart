import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('顯示菜單標題與套餐分類', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('麥香堡菜單'), findsOneWidget);
    expect(find.text('套餐系列'), findsOneWidget);
  });

  testWidgets('可以切換明亮與夜間模式', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('切換夜間模式'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('切換明亮模式'), findsOneWidget);
    expect(Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
        Brightness.dark);

    await tester.tap(find.byTooltip('切換明亮模式'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('切換夜間模式'), findsOneWidget);
    expect(Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
        Brightness.light);
  });

  testWidgets('點擊餐點後顯示詳情', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.textContaining('兒童套餐 A').first);
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsOneWidget);
    expect(find.descendant(
      of: find.byType(Dialog),
      matching: find.textContaining('兒童套餐 A'),
    ), findsOneWidget);
    expect(find.descendant(
      of: find.byType(Dialog),
      matching: find.text(r'$65'),
    ), findsOneWidget);
  });
}
