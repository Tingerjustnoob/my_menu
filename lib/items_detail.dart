import 'package:flutter/material.dart';

// 💡 關鍵 1：將返回值改為 Future<Map<String, dynamic>?>，並加上 return
Future<Map<String, dynamic>?> showCustomDialog(BuildContext context, Map<String, dynamic> item) {
  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['image'],
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
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
                  const SizedBox(width: 32),
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
              Row(
                children: [
                  const Text('\n\n\n'),
                  const Icon(Icons.assignment, size: 30),
                  const SizedBox(width: 8),
                  const Text(
                    '餐點描述',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              if (item['index'] == null)
                Row(
                  children: [
                    const SizedBox(width: 32),
                    const Icon(Icons.circle, size: 20),
                    Text(
                      item['description'].toString(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              else
                for (int i = 0; i < item['index']; i++)
                  Row(
                    children: [
                      const SizedBox(width: 32),
                      const Icon(Icons.circle, size: 20),
                      Text(
                        item['description'][i],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 141, 210, 214),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: InkWell(
                  onTap: () {
                    // 💡 關鍵 2：透過 pop 把目前的 item 資訊回傳給主網頁
                    Navigator.pop(context, item); 
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.add, size: 30),
                          Text(
                            '加入訂單',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
