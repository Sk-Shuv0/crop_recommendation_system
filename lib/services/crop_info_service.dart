import '../models/crop_info.dart';

class CropInfoService {

  static final Map<String, CropInfo> cropDetails = {

    "apple": CropInfo(
      description: "আপেল একটি শীতপ্রধান ফল। ঠান্ডা আবহাওয়ায় ভালো জন্মে এবং দোআঁশ মাটিতে ভালো ফলন দেয়।",
      season: "শীতকাল",
      soil: "দোআঁশ মাটি",
    ),

    "banana": CropInfo(
      description: "কলা একটি উষ্ণমণ্ডলীয় ফল। গরম ও আর্দ্র আবহাওয়ায় ভালো জন্মে।",
      season: "সারা বছর",
      soil: "উর্বর দোআঁশ মাটি",
    ),

    "blackgram": CropInfo(
      description: "কালো মাষকলাই একটি ডাল জাতীয় ফসল যা উষ্ণ আবহাওয়ায় জন্মে এবং মাটির উর্বরতা বৃদ্ধি করে।",
      season: "খরিফ মৌসুম",
      soil: "দোআঁশ মাটি",
    ),

    "chickpea": CropInfo(
      description: "ছোলা একটি রবি মৌসুমের ডাল ফসল যা ঠান্ডা ও শুষ্ক আবহাওয়ায় ভালো জন্মে।",
      season: "রবি মৌসুম",
      soil: "বেলে দোআঁশ মাটি",
    ),

    "coconut": CropInfo(
      description: "নারিকেল উপকূলীয় ও আর্দ্র অঞ্চলে ভালো জন্মে।",
      season: "সারা বছর",
      soil: "বেলে ও পানি নিষ্কাশনযুক্ত মাটি",
    ),

    "coffee": CropInfo(
      description: "কফি পাহাড়ি ও ছায়াযুক্ত এলাকায় জন্মে এবং মাঝারি বৃষ্টিপাত প্রয়োজন।",
      season: "বসন্তকাল",
      soil: "উর্বর ও পানি নিষ্কাশনযুক্ত মাটি",
    ),

    "cotton": CropInfo(
      description: "তুলা একটি আঁশ জাতীয় ফসল যা উষ্ণ আবহাওয়ায় ভালো জন্মে।",
      season: "খরিফ মৌসুম",
      soil: "কালো মাটি",
    ),

    "grapes": CropInfo(
      description: "আঙুর উষ্ণ ও শুষ্ক অঞ্চলে জন্মে এবং নিয়ন্ত্রিত সেচ প্রয়োজন।",
      season: "গ্রীষ্মকাল",
      soil: "বেলে দোআঁশ মাটি",
    ),

    "jute": CropInfo(
      description: "পাট উষ্ণ ও আর্দ্র এলাকায় জন্মে এবং বেশি বৃষ্টিপাত প্রয়োজন।",
      season: "খরিফ মৌসুম",
      soil: "পলি মাটি",
    ),

    "kidneybeans": CropInfo(
      description: "রাজমা মাঝারি আবহাওয়ায় জন্মে এবং উর্বর মাটিতে ভালো ফলন দেয়।",
      season: "রবি মৌসুম",
      soil: "দোআঁশ মাটি",
    ),

    "lentil": CropInfo(
      description: "মসুর ডাল শীতকালীন ডাল ফসল যা ঠান্ডা আবহাওয়ায় ভালো জন্মে।",
      season: "রবি মৌসুম",
      soil: "বেলে দোআঁশ মাটি",
    ),

    "maize": CropInfo(
      description: "ভুট্টা একটি উষ্ণ আবহাওয়ার শস্য যা মাঝারি বৃষ্টিপাত প্রয়োজন।",
      season: "খরিফ ও রবি",
      soil: "দোআঁশ মাটি",
    ),

    "mango": CropInfo(
      description: "আম একটি উষ্ণমণ্ডলীয় ফল যা গরম আবহাওয়ায় ভালো জন্মে।",
      season: "গ্রীষ্মকাল",
      soil: "গভীর দোআঁশ মাটি",
    ),

    "mothbeans": CropInfo(
      description: "মথবিন খরা সহনশীল ডাল জাতীয় ফসল যা শুষ্ক অঞ্চলে জন্মে।",
      season: "খরিফ মৌসুম",
      soil: "বেলে মাটি",
    ),

    "mungbean": CropInfo(
      description: "মুগ ডাল স্বল্পমেয়াদি ডাল ফসল যা উষ্ণ আবহাওয়ায় জন্মে।",
      season: "খরিফ মৌসুম",
      soil: "দোআঁশ মাটি",
    ),

    "muskmelon": CropInfo(
      description: "খরমুজ একটি গ্রীষ্মকালীন ফল যা উষ্ণ আবহাওয়ায় জন্মে।",
      season: "গ্রীষ্মকাল",
      soil: "বেলে দোআঁশ মাটি",
    ),

    "orange": CropInfo(
      description: "কমলা একটি উপ-উষ্ণমণ্ডলীয় ফল যা মাঝারি আবহাওয়ায় জন্মে।",
      season: "শীতকাল",
      soil: "দোআঁশ মাটি",
    ),

    "papaya": CropInfo(
      description: "পেঁপে একটি উষ্ণমণ্ডলীয় ফল যা সারা বছর চাষ করা যায়।",
      season: "সারা বছর",
      soil: "উর্বর ও পানি নিষ্কাশনযুক্ত মাটি",
    ),

    "pigeonpeas": CropInfo(
      description: "আরহার ডাল আধা-শুষ্ক অঞ্চলে জন্মে এবং মাঝারি বৃষ্টিপাত প্রয়োজন।",
      season: "খরিফ মৌসুম",
      soil: "দোআঁশ মাটি",
    ),

    "pomegranate": CropInfo(
      description: "ডালিম শুষ্ক ও উষ্ণ আবহাওয়ায় ভালো জন্মে।",
      season: "শীতকাল",
      soil: "বেলে দোআঁশ মাটি",
    ),

    "rice": CropInfo(
      description: "ধান একটি প্রধান খাদ্য শস্য যা উষ্ণ ও আর্দ্র আবহাওয়ায় জন্মে।",
      season: "খরিফ মৌসুম",
      soil: "কাদামাটি",
    ),

    "watermelon": CropInfo(
      description: "তরমুজ একটি গ্রীষ্মকালীন ফল যা উষ্ণ আবহাওয়ায় জন্মে।",
      season: "গ্রীষ্মকাল",
      soil: "বেলে দোআঁশ মাটি",
    ),
  };

  static CropInfo? getInfo(String cropName) {
    return cropDetails[cropName.toLowerCase()];
  }
}
