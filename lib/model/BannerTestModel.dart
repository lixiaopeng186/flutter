


class BannerTestModel{
  List<_ItemBannerTest> data;
  BannerTestModel({this.data});

  factory BannerTestModel.fromJson(Map<String,dynamic> map) {
    List list =   map['data'];
    List<_ItemBannerTest> l =  list.map((f) => _ItemBannerTest.fromJson(f) ).toList();
    return new BannerTestModel(data:l);
  }

}

class _ItemBannerTest{
   String image;
   _ItemBannerTest({this.image});

   factory _ItemBannerTest.fromJson(Map<String,dynamic> map){
     return new _ItemBannerTest(image:map['image']);
   }

}