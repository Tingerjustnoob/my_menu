import 'package:flutter/material.dart';

// 💡 關鍵 1：將返回值改為 Future<Map<String, dynamic>?>，並加上 return

Future<Map<String, dynamic>?> showCustomDialog(
  BuildContext context,
  Map<String, dynamic> item,
) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      // 支援單筆及多筆餐點描述
      final rawDescription = item['description'];

      final List<String> allDescriptions =
          rawDescription is List
              ? rawDescription.map((e) => e.toString()).toList()
              : [rawDescription?.toString() ?? ''];

      // 保留原本 index 控制描述數量的邏輯
      final count = item['index'];
      final descriptions = count is int && count >= 0
          ? allDescriptions.take(count).toList()
          : allDescriptions;

      return Dialog(
        // Dialog 圓角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 480,
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
          ),

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
                      child: Image.asset(
                        item['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. 餐點名稱與價格
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Text(
                        '\$${item['price']}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 3. 餐點描述標題
                  Row(
                    children: const [
                      Icon(
                        Icons.assignment,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '餐點描述',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 4. 餐點描述內容
                  for (final description in descriptions)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 8,
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Icon(
                              Icons.circle,
                              size: 12,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              description,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // 5. 加入訂單按鈕
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      color: const Color.fromARGB(
                        255, 141, 210, 214,
                      ),
                      borderRadius:
                          BorderRadius.circular(16),

                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(16),

                        onTap: () {
                          // 回傳餐點資料給主頁面
                          Navigator.pop(context, item);
                        },

                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 30,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '加入訂單',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

    