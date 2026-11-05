import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> openMenu(WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('訂餐方式說明'), findsOneWidget);
    expect(find.textContaining('無法線上結帳或送出訂單'), findsOneWidget);
    await tester.tap(find.text('我知道了'));
    await tester.pumpAndSettle();
  }

  testWidgets('顯示菜單標題與套餐分類', (tester) async {
    await openMenu(tester);
    expect(find.text('麥香堡'), findsOneWidget);
    expect(find.text('套餐系列'), findsOneWidget);
    expect(find.text('備註：套餐均附中杯飲料，飲料另選折抵 5 元。'), findsOneWidget);
    await tester.tap(find.text('中式餐點'));
    await tester.pumpAndSettle();
    expect(find.textContaining('備註：'), findsNothing);
  });

  testWidgets('可跟隨系統並手動切換淺色與深色模式', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await openMenu(tester);
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byTooltip('選擇顯示模式'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.ancestor(
        of: find.text('淺色模式'),
        matching: find.byType(CheckedPopupMenuItem<ThemeMode>),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.light,
    );
    await tester.tap(find.byTooltip('選擇顯示模式'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.ancestor(
        of: find.text('深色模式'),
        matching: find.byType(CheckedPopupMenuItem<ThemeMode>),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.dark,
    );
    await tester.tap(find.byTooltip('選擇顯示模式'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.ancestor(
        of: find.text('跟隨系統'),
        matching: find.byType(CheckedPopupMenuItem<ThemeMode>),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.byType(Scaffold).first)).brightness,
      Brightness.light,
    );
  });

  testWidgets('點擊餐點後顯示詳情', (tester) async {
    await openMenu(tester);
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
    await openMenu(tester);
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
    expect(find.text('打電話訂餐'), findsOneWidget);
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
    await openMenu(tester);
    await tester.tap(find.text('中式餐點'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('蔥抓餅'),
      400,
      scrollable: find
          .descendant(
            of: find.byType(ListView).first,
            matching: find.byType(Scrollable),
          )
          .first,
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

  testWidgets('麵包餐點可同時加蛋及芝士，並記錄在明細', (tester) async {
    await openMenu(tester);
    await tester.tap(find.text('經典麵包系列'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('鮮蔬'));
    await tester.pumpAndSettle();
    expect(find.text('請選擇麵包種類'), findsOneWidget);
    await tester.tap(find.text('丹麥麵包'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('加蛋 (+\$10)'));
    await tester.tap(find.text('加蛋 (+\$10)'));
    await tester.ensureVisible(find.text('加芝士 (+\$10)'));
    await tester.tap(find.text('加芝士 (+\$10)'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('加入購物車'));
    await tester.tap(find.text('加入購物車'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
    await tester.pumpAndSettle();
    expect(find.text('鮮蔬（丹麥麵包）'), findsOneWidget);
    expect(find.text('總金額：\$60'), findsOneWidget);
    expect(find.text('加蛋、加芝士・單價 \$60'), findsOneWidget);
    await tester.tap(find.text('查看餐點明細'));
    await tester.pumpAndSettle();
    expect(find.textContaining('（加蛋、加芝士）'), findsOneWidget);
  });
}
