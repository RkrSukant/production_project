import 'package:production_project/common_models/furniture_model.dart';
import 'package:production_project/feature/search/data/remote/search_remote.dart';

class SearchRemoteImpl implements SearchRemote {
  @override
  Future<List<FurnitureModel>> getFurnitureList() async{
    List<FurnitureModel> furnitures= [
      FurnitureModel(id: 1,
          title: "Sofa",
          category: "sofa",
          price: 1000,
          desc: "Lorem Ipsum",
          rooms: ["rooms"],
          imageNames: ["imageNames"]),
      FurnitureModel(id: 2,
          title: "Couch",
          category: "sofa",
          price: 1000,
          desc: "Lorem Ipsum",
          rooms: ["rooms"],
          imageNames: ["imageNames"]),
      FurnitureModel(id: 3,
          title: "Chair",
          category: "Chair",
          price: 1000,
          desc: "Lorem Ipsum",
          rooms: ["rooms"],
          imageNames: ["imageNames"]),
      FurnitureModel(id: 4,
          title: "Table",
          category: "Table",
          price: 1000,
          desc: "Lorem Ipsum",
          rooms: ["rooms"],
          imageNames: ["imageNames"]),
      FurnitureModel(id: 6,
          title: "Lawn Table",
          category: "Table",
          price: 1000,
          desc: "Lorem Ipsum",
          rooms: ["rooms"],
          imageNames: ["imageNames"]),

    ];
    return furnitures;
  }

}