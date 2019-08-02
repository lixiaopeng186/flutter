//json banner 数据
class MainBannerModel{

    List<BannerImage> data ;
    MainBannerModel({this.data});
    factory MainBannerModel.fromJson(Map<String,dynamic> map){
      List list = map['data'];
      List<BannerImage> t = list.map((t) => new BannerImage.fromJson(t)).toList();
//      print("json data ${list.length}\t${t.length}\t${list.elementAt(0).runtimeType}");
      return new MainBannerModel(data: t  );
    }
    @override
    String toString() {
      return 'MainBannerModel{data: $data}';
    }
}

class BannerImage{
   String image;

   BannerImage({this.image});
   factory BannerImage.fromJson(Map<String,dynamic> map){
     return new BannerImage(image: map['image']);
   }

   @override
   String toString() {
     return 'BannerImage{image: $image}';
   }

}