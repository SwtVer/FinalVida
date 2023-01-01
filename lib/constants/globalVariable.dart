import 'package:flutter/material.dart';

class GlobalVariables {
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Homeopathy',
      'image': 'assets/icons/homeopathy.svg',
    },
    {
      'title': 'Allopathy',
      'image': 'assets/icons/allopathy.svg',
    },
    {
      'title': 'Ayurvedic',
      'image': 'assets/icons/ayurvedic.svg',
    },
    {
      'title': 'OTC',
      'image': 'assets/icons/otc.svg',
    },
   
  ];
  static const List<Map<String, String>> subscriptionPlans = [
    {
      'title': '1 month',
      'image': 'assets/icons/onemonth.svg',
    },
    {
      'title': '2 months',
      'image': 'assets/icons/two.svg',
    },
    {
      'title': '3 months',
      'image': 'assets/icons/3month.svg',
    },
    //{
      //'title': 'OTC Product',
      //'image': 'assets/icons/otc.svg',
   // },
   
  ];
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const butonColor = Color(0xFF1B3834);

}
