import 'package:flutter/material.dart';

Future<
  ({
    bool addEgg,
    bool addCheese,
    String? bread,
    String? drink,
    int drinkCharge,
    String? option,
    int optionCharge,
    String? temperature,
  })?
>
showCustomDialog(
  BuildContext context,
  Map<String, dynamic> item, {
  int? eggPrice,
  int? cheesePrice,
  List<String>? breadOptions,
  List<Map<String, dynamic>>? drinks,
  List<String>? choices,
  String? choiceLabel,
  Map<String, int>? choicePrices,
  bool standaloneDrink = false,
}) {
  bool addEgg = false;
  bool addCheese = false;
  String? bread;
  String? selectedOption;
  final options = choices ?? item['options'] as List<String>?;
  int optionCharge() => selectedOption == null || choicePrices == null
      ? 0
      : choicePrices[selectedOption]! - (item['price'] as int);
  Map<String, dynamic>? drink;
  String? drinkTemperature;
  Widget choiceButton(String label, bool selected, VoidCallback onPressed) {
    return Builder(
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        return Semantics(
          selected: selected,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(0, 36),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: selected ? colors.primaryContainer : null,
              foregroundColor: selected
                  ? colors.onPrimaryContainer
                  : colors.onSurface,
            ),
            child: Text(label, textAlign: TextAlign.center),
          ),
        );
      },
    );
  }

  int chargeForDrink(Map<String, dynamic> selectedDrink) {
    final name = selectedDrink['name'] as String;
    if (name == '紅茶（中杯）' || name == '奶茶（中杯）') return 0;
    return (selectedDrink['price'] as int) - 5;
  }

  int drinkCharge() => drink == null ? 0 : chargeForDrink(drink!);

  return showDialog<
    ({
      bool addEgg,
      bool addCheese,
      String? bread,
      String? drink,
      int drinkCharge,
      String? option,
      int optionCharge,
      String? temperature,
    })
  >(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          // 圓角
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          constraints: const BoxConstraints(maxWidth: 480),
          child: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. 餐點圖片
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Image.asset(item['image'], fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. 餐點名稱與價格
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${(item['price'] as int) + (addEgg ? eggPrice! : 0) + (addCheese ? cheesePrice! : 0) + drinkCharge() + optionCharge()}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (item['description'] case final String description) ...[
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '內容物：\n• ${description.replaceAll(RegExp(r'[+＋]'), '\n• ')}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                    if (drinks != null) ...[
                      const SizedBox(height: 12),
                      DropdownButtonFormField<Map<String, dynamic>>(
                        isExpanded: true,
                        decoration: const InputDecoration(labelText: '請選擇飲料'),
                        items: drinks.map((option) {
                          final name = option['name'] as String;
                          final charge = chargeForDrink(option);
                          return DropdownMenuItem(
                            value: option,
                            child: Text('$name（+\$$charge）'),
                          );
                        }).toList(),
                        onChanged: (value) => setDialogState(() {
                          drink = value;
                          drinkTemperature = null;
                        }),
                      ),
                    ],
                    if (standaloneDrink || drink != null) ...[
                      const SizedBox(height: 12),
                      const Text('請選擇溫度'),
                      Wrap(
                        spacing: 8,
                        children:
                            ((standaloneDrink
                                                ? item['name'] as String
                                                : drink!['name'] as String)
                                            .startsWith('冰釀綠茶') ||
                                        (standaloneDrink
                                                ? item['name'] as String
                                                : drink!['name'] as String)
                                            .startsWith('柳橙汁') ||
                                        (standaloneDrink
                                                ? item['name'] as String
                                                : drink!['name'] as String)
                                            .startsWith('水果冰茶')
                                    ? ['冰']
                                    : ['冰', '溫'])
                                .map((temperature) {
                                  return choiceButton(
                                    temperature,
                                    drinkTemperature == temperature,
                                    () => setDialogState(
                                      () => drinkTemperature = temperature,
                                    ),
                                  );
                                })
                                .toList(),
                      ),
                    ],
                    if (breadOptions != null) ...[
                      const SizedBox(height: 12),
                      const Text('請選擇麵包種類'),
                      Wrap(
                        spacing: 8,
                        children: breadOptions.map((option) {
                          return choiceButton(
                            option,
                            bread == option,
                            () => setDialogState(() => bread = option),
                          );
                        }).toList(),
                      ),
                    ],
                    if (options != null) ...[
                      const SizedBox(height: 12),
                      Text(choiceLabel ?? item['optionLabel'] as String),
                      Wrap(
                        spacing: 8,
                        children: options
                            .map(
                              (option) => choiceButton(
                                choicePrices == null
                                    ? option
                                    : '$option (\$${choicePrices[option]})',
                                selectedOption == option,
                                () => setDialogState(
                                  () => selectedOption = option,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                    if (eggPrice != null)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('加蛋 (+\$$eggPrice)'),
                        value: addEgg,
                        onChanged: (value) {
                          setDialogState(() => addEgg = value ?? false);
                        },
                      ),
                    if (cheesePrice != null)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('加芝士 (+\$$cheesePrice)'),
                        value: addCheese,
                        onChanged: (value) {
                          setDialogState(() => addCheese = value ?? false);
                        },
                      ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed:
                          (breadOptions != null && bread == null) ||
                              (drinks != null &&
                                  (drink == null ||
                                      drinkTemperature == null)) ||
                              (standaloneDrink && drinkTemperature == null) ||
                              (options != null && selectedOption == null)
                          ? null
                          : () => Navigator.of(context).pop((
                              addEgg: addEgg,
                              addCheese: addCheese,
                              bread: bread,
                              drink: drink == null
                                  ? null
                                  : '${drink!['name']}・$drinkTemperature',
                              drinkCharge: drinkCharge(),
                              option: selectedOption,
                              optionCharge: optionCharge(),
                              temperature: standaloneDrink
                                  ? drinkTemperature
                                  : null,
                            )),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('加入購物車'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
