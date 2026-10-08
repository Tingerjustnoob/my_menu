// lib/data/menu_data.dart

class MenuData {
  // 將餐點資料宣告為 static final，讓其他檔案可以直接讀取，不需重複實例化
  static final Map<String, List<Map<String, dynamic>>> categories = {
    '套餐': [
        
        //
      {'name': '兒童套餐 A (60元)：小雞塊  薯條  雞堡熱狗', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '招牌套餐 (70元)：蔓越莓花生醬  蔬菜沙拉  蛋', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '快樂套餐 (70元)：法國吐司  黃金脆薯', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '活力套餐 (80元)：薯條  德式香腸  四角薯餅  荷包蛋', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},    
      {'name': '千層蛋燒套餐 (90元)：千層蛋燒（香濃起司、玉米、蛋）＋ 蔬菜沙拉', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '法式套餐 (85元)：法式麵包抹蒜香  蔬菜沙拉  培根  薯餅  蛋', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '美式鬆餅特餐 (90元)：鬆餅  美式炒蛋  培根', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': 'A、B、C餐飯 (85元)', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '幸福套餐 (90元)：法國吐司  德式香肠  蔬菜沙拉', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '樂活套餐 (95元)：香蒜麵包抹奶油  薯餅蛋塔  黑胡椒豬排  蔬菜沙拉', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '都會套餐 (100元)：貝果  藍莓醬  美式炒蛋  火腿  薯餅  蔬菜沙拉', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '蘿蔔糕特餐 (95元)', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '蛋餅': [
      {'name': '原味蛋餅', 'price': 35,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '起司蛋餅', 'price': 45,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '培根蛋餅', 'price': 50,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '火腿蛋餅', 'price': 50,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '玉米蛋餅', 'price': 50,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '鮪魚蛋餅', 'price': 55,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '蘿蔔糕蛋餅', 'price': 55,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '鐵板麵': [
      {'name': '黑胡椒鐵板麵+蛋', 'price': 65,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '奶油鐵板麵+蛋', 'price': 65,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '蘑菇鐵板麵+蛋', 'price': 65,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '番茄鐵板麵+蛋', 'price': 65,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '經典麵包': [
      {'name': '奶油厚片', 'price': 30,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '蒜香厚片', 'price': 35,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '貝果': [
      {'name': '藍莓貝果', 'price': 45,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '乳酪貝果', 'price': 45,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '捲餅': [
      {'name': '雞肉生菜捲餅', 'price': 60,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '豬肉生菜捲餅', 'price': 60,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '早午餐系列': [
      {'name': '法式早午餐盤', 'price': 139,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '漢堡/湯種吐司': [
      {'name': '卡拉雞腿堡', 'price': 70,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '豬肉排堡', 'price': 70,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '牛肉堡', 'price': 75,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '雞肉排蛋吐司', 'price': 55,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '豬肉排蛋吐司', 'price': 55,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '烤吐司': [
      {'name': '花生烤吐司', 'price': 30,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '草莓烤吐司', 'price': 30,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '蔬菜沙拉': [
      {'name': '凱薩雞肉沙拉', 'price': 85,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '點心': [
      {'name': '薯餅', 'price': 20,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '雞塊 (3塊)', 'price': 35,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '雞塊 (5塊)', 'price': 50,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
    '飲料': [
      {'name': '招牌奶茶 (大)', 'price': 40,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '古早味紅茶 (大)', 'price': 30,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
      {'name': '鮮奶茶', 'price': 50,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100},
    ],
  };
}
