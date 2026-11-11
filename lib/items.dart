// lib/data/menu_data.dart

class MenuData {
  static const Set<String> eggAndCheeseCategories = {
    '經典麵包／貝果',
    '捲餅系列',
    '漢堡／湯種吐司系列',
  };

  static const Map<String, String> categoryNotes = {
    '套餐系列': '套餐均附中杯飲料，飲料另選折抵 5 元。',
    '早午餐系列': '早午餐均附中杯飲料，飲料另選折抵 5 元。',
    '經典麵包／貝果系列': '加蛋或加芝士另加 10 元。',
    '捲餅系列': '加蛋或加芝士另加 10 元。',
    '漢堡／湯種吐司系列': '加蛋或加芝士另加 10 元。',
    '蔬菜沙拉系列': '和風醬/千島醬/優格醬/蜂蜜芥末醬(任選)',
  };

  static final Map<String, List<Map<String, dynamic>>> categories = {
    '套餐': [
        
        //
      {'name': '兒童套餐', 'price': 60,'image':'web/icons/item_img/kids_special.jpg','height':100,'width':100,'index':3,'description':['小雞塊','薯條', '雞堡熱狗']},
      {'name': '招牌套餐', 'price': 70,'image':'web/icons/item_img/signature_special.jpg','height':100,'width':100,'index':3,'description':['蔓越莓花生醬','蔬菜沙拉', '蛋']},
      {'name': '快樂套餐', 'price': 70,'image':'web/icons/item_img/happiness_special.jpg','height':100,'width':100,'index':2,'description':['法國吐司','脆薯']},
      {'name': '活力套餐', 'price': 80,'image':'web/icons/item_img/thriving_special.jpg','height':100,'width':100,'index':4,'description':['薯條','德式香腸','四角薯餅','荷包蛋']}, 
      {'name': '千層蛋燒套餐', 'price': 90,'image':'web/icons/item_img/tamagoyaki_special.jpg','height':100,'width':100,'index':3,'description':['香濃起司','玉米','蛋','蔬菜沙拉']},
      {'name': '法式套餐', 'price': 85,'image':'web/icons/item_img/French_meal.jpg','height':100,'width':100,'index':4,'description':['麵抹蒜香','蔬菜沙拉','培根','薯餅','蛋']},
      {'name': '美式鬆餅特餐', 'price': 90,'image':'web/icons/item_img/pancake_special.jpg','height':100,'width':100,'index':4,'description':['松餅','美式炒蛋','培根','蛋']},
      {'name': 'A、B、C餐飯', 'price': 85,'image':'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg','height':100,'width':100,'description':'A、B、C餐飯'},
      {'name': '幸福套餐', 'price': 90,'image':'web/icons/item_img/Pleasure_special.jpg','height':100,'width':100,'description':'幸福套餐'},
      {'name': '樂活套餐', 'price': 95,'image':'web/icons/item_img/lohas.jpg','height':100,'width':100,'description':'樂活套餐'},
      {'name': '都會套餐', 'price': 100,'image':'web/icons/item_img/city_special.jpg','height':100,'width':100,'description':'會都套餐'},
      {'name': '蘿蔔糕特餐', 'price': 95,'image':'web/icons/item_img/Radish_Cake_Special.jpg','height':100,'width':100,'description':'蘿蔔糕特餐'},
    ],
    '中式餐點': [
      {
        'name': '全麥蛋餅',
        'price': 25,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '芝士蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '火腿蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '玉米蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '肉鬆蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '熱狗蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '培根蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鮮蔬蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '泡菜蛋餅',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鮪魚蛋餅',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '豬排蛋餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '薯餅蛋餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      // 點心、麵食與主食
      {
        'name': '板條',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '日式涼麵',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '薯餅蛋塔',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {'name': '湯種法國吐司', 'price': 35, 'image': 'web/icons/item_img/湯種法國吐司.png'},
      {
        'name': '蘿蔔糕',
        'price': 30,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '泡菜蘿蔔糕',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鐵板麵',
        'price': 35,
        'optionLabel': '請選擇口味',
        'options': ['蘑菇', '黑胡椒'],
        'image': 'web/icons/item_img/鐵板麵.png',
      },
      {
        'name': '荷包蛋',
        'price': 15,
        'optionLabel': '請選擇熟度',
        'options': ['全熟', '半熟'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '蔥抓餅',
        'price': 30,
        'eggPrice': 10,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '泡菜蔥抓餅',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '宮保雞丁鐵板麵',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '日式辛炒烏龍',
        'price': 65,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '雞絲蛋麵',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],
    '經典麵包／貝果系列': [
      {
        'name': '鮮蔬',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '歐姆蛋',
        'price': 45,
        'noExtraEgg': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鮪魚',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '檸檬雞',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '燻雞',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '培根芝士',
        'price': 55,
        'noExtraCheese': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '香烤雞腿',
        'price': 60,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '卡啦雞腿',
        'price': 65,
        'optionLabel': '請選擇口味',
        'options': ['原味', '辣味'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '超厚牛肉芝士',
        'price': 80,
        'noExtraCheese': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],
    '捲餅系列': [
      {
        'name': '燻雞捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '檸檬雞捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '脆雞捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '德式香腸捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '雞柳條捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '黑胡椒豬排捲餅',
        'price': 45,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],
    '早午餐系列': [
      {
        'name': '茄汁檸檬雞義大利麵',
        'price': 90,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '奶油培根義大利麵',
        'price': 90,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '青醬燻雞義大利麵',
        'price': 90,
        'image': 'web/icons/item_img/青醬雞肉義大利麵.png',
      },
      {
        'name': '燉飯',
        'price': 95,
        'optionLabel': '請選擇醬料',
        'options': ['茄汁', '奶油', '青醬'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '德式百匯',
        'price': 110,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '澳洲純牛漢堡排',
        'price': 130,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '大法式佐紅醬餐',
        'price': 125,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '脆薯烤雞',
        'price': 140,
        'optionLabel': '請選擇主食',
        'options': ['麵', '飯'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '泰式卡啦脆雞',
        'price': 150,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '美式鄉村餐',
        'price': 150,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],
    '漢堡／湯種吐司系列': [
      {
        'name': '火腿',
        'price': 25,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '肉鬆',
        'price': 25,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鮮蔬',
        'price': 30,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '素肉鬆（素）',
        'price': 30,
        'noExtraEgg': true,
        'noExtraCheese': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '豬肉',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '歐姆蛋',
        'price': 40,
        'noExtraEgg': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '香雞',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '鮪魚',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {'name': '薯餅', 'price': 35, 'image': 'web/icons/item_img/薯餅蛋吐司.png'},
      {
        'name': '黑胡椒豬排',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '燻雞',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '檸檬雞',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '培根芝士',
        'price': 45,
        'noExtraCheese': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '香烤雞腿',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '烤總匯',
        'price': 65,
        'noExtraEgg': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '卡啦雞腿',
        'price': 55,
        'optionLabel': '請選擇口味',
        'options': ['原味', '辣味'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '超厚牛肉芝士',
        'price': 70,
        'noExtraCheese': true,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],
    '烤土司系列': [
      {
        'name': '草莓',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '奶酥',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '花生',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '奶油',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '香蒜',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '巧克力',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '藍莓',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],

    '蔬菜沙拉系列': [
      {
        'name': '蛋沙拉',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '火腿沙拉',
        'price': 60,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '燻雞沙拉',
        'price': 60,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],

    '點心系列': [
      {'name': '四角薯餅', 'price': 20, 'image': 'web/icons/item_img/四角薯餅.jpg'},
      {
        'name': '雞優熱狗',
        'price': 15,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '薯條',
        'price': 20,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '雞塊小不點',
        'price': 20,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '麥克雞塊',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '印尼炒麵',
        'price': 50,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '黃金脆薯',
        'price': 30,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '卡啦雞',
        'price': 40,
        'optionLabel': '請選擇口味',
        'options': ['原味', '辣味'],
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '香檸雞柳條',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '黃金QQ棒',
        'price': 35,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '大法式佐紅醬',
        'price': 40,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
      {
        'name': '玉米濃湯',
        'price': 30,
        'image': 'web/icons/item_img/Pork_and_Eggs_with_salad_hamburger.jpg',
      },
    ],

    '飲料系列': [
      {'name': '紅茶（中杯）', 'price': 15, 'image': 'web/icons/item_img/紅茶.jpg'},
      {'name': '紅茶（大杯）', 'price': 20, 'image': 'web/icons/item_img/紅茶.jpg'},
      {'name': '豆漿（中杯）', 'price': 15, 'image': 'web/icons/item_img/豆漿.jpg'},
      {'name': '豆漿（大杯）', 'price': 20, 'image': 'web/icons/item_img/豆漿.jpg'},
      {'name': '奶茶（中杯）', 'price': 15, 'image': 'web/icons/item_img/奶茶.jpg'},
      {'name': '奶茶（大杯）', 'price': 20, 'image': 'web/icons/item_img/奶茶.jpg'},
      {'name': '冰釀綠茶（中杯）', 'price': 15, 'image': 'web/icons/item_img/綠茶.jpg'},
      {'name': '冰釀綠茶（大杯）', 'price': 20, 'image': 'web/icons/item_img/綠茶.jpg'},
      {'name': '咖啡（中杯）', 'price': 25, 'image': 'web/icons/item_img/咖啡.jpg'},
      {'name': '咖啡（大杯）', 'price': 30, 'image': 'web/icons/item_img/咖啡.jpg'},
      {'name': '可可牛奶（中杯）', 'price': 20, 'image': 'web/icons/item_img/可可牛奶.jpg'},
      {'name': '可可牛奶（大杯）', 'price': 25, 'image': 'web/icons/item_img/可可牛奶.jpg'},
      {'name': '柳橙汁（中杯）', 'price': 20, 'image': 'web/icons/item_img/柳橙汁.jpg'},
      {'name': '柳橙汁（大杯）', 'price': 25, 'image': 'web/icons/item_img/柳橙汁.jpg'},
      {'name': '鮮奶茶（中杯）', 'price': 25, 'image': 'web/icons/item_img/鮮奶茶.jpg'},
      {'name': '鮮奶茶（大杯）', 'price': 30, 'image': 'web/icons/item_img/鮮奶茶.jpg'},
      {'name': '豆漿紅茶（中杯）', 'price': 20, 'image': 'web/icons/item_img/豆漿紅茶.jpg'},
      {'name': '豆漿紅茶（大杯）', 'price': 25, 'image': 'web/icons/item_img/豆漿紅茶.jpg'},
      {'name': '水果冰茶（中杯）', 'price': 25, 'image': 'web/icons/item_img/水果冰茶.jpg'},
      {'name': '水果冰茶（大杯）', 'price': 30, 'image': 'web/icons/item_img/水果冰茶.jpg'},
    ],
  };
}
