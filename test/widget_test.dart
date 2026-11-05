import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('顯示菜單標題與套餐分類', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('麥香堡菜單'), findsOneWidget);
    expect(find.text('套餐系列'), findsOneWidget);
    expect(find.text('備註：套餐均附中杯飲料，飲料另選折抵 5 元。'), findsOneWidget);
    await tester.tap(find.text('中式餐點'));
    await tester.pumpAndSettle();
    expect(find.textContaining('備註：'), findsNothing);
  });

  testWidgets('可以切換明亮與夜間模式', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byTooltip('切換夜間模式'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('切換明亮模式'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );

    await tester.tap(find.byTooltip('切換明亮模式'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('切換夜間模式'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.light,
    );
  });

  testWidgets('點擊餐點後顯示詳情', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.textContaining('兒童套餐 A').first);
    await tester.pumpAndSettle();

    expect(find.byType(Dialog), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(Dialog),
        matching: find.textContaining('兒童套餐 A'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(Dialog), matching: find.text(r'$65')),
      findsOneWidget,
    );
  });

  testWidgets('加入購物車後可調整數量並查看明細', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.textContaining('兒童套餐 A').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('加入購物車'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();
    expect(find.text('總金額：\$65'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pumpAndSettle();
    expect(find.text('總金額：\$130'), findsOneWidget);
    await tester.tap(find.text('查看餐點明細'));
    await tester.pumpAndSettle();
    expect(find.text('餐點明細'), findsOneWidget);
    expect(find.text('總金額：\$130'), findsOneWidget);
    expect(find.text('此畫面僅供確認，不會付款或送出訂單。'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.remove_circle_outline));
    await tester.pumpAndSettle();
    expect(find.text('總金額：\$65'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove_circle_outline));
    await tester.pumpAndSettle();
    expect(find.text('購物車目前沒有餐點'), findsOneWidget);
  });

  testWidgets('加蛋餐點的價格會計入購物車', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('中式餐點'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('蔥抓餅'),
      400,
      scrollable: find.descendant(
        of: find.byType(ListView).first,
        matching: find.byType(Scrollable),
      ).first,
    );
    await tester.ensureVisible(find.text('蔥抓餅'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('蔥抓餅'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('加蛋 (+\$10)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('加入購物車'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();
    expect(find.text('總金額：\$35'), findsOneWidget);
    expect(find.textContaining('加蛋・單價'), findsOneWidget);
  });
}
