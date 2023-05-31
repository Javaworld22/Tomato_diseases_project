import 'package:flutter/foundation.dart';
import 'package:scoped_model/scoped_model.dart';

class DiseaseModel extends Model{
  late var confidence;
  late var index;
  late String label;
  late List<String> prevention = List.filled(0, "", growable: true);


  DiseaseModel(this.confidence,this.label,this.index);
  DiseaseModel.fromOject(dynamic o) {
    this.confidence = o[0]["confidence"];
    this.index = o[0]["index"];
    this.label = o[0]["label"] ;
    if (kDebugMode) {
      print('Query here $confidence');
    }
    if (kDebugMode) {
      print('Data here $index');
    }
    if(prevention.isNotEmpty)
      prevention.clear();
    if(label.contains("Tomato___Late_blight")){
      index = 1;
      prevention.add("Use a neonicotinoid insecticide, such as imidacloprid ");
      prevention.add("Use a neonicotinoid insecticide, such as  dinotefuran ");
      prevention.add("Use a neonicotinoid insecticide, such as  thiamethoxam");
      notifyListeners();
    }else if(label.contains("Tomato___healthy")){
      index = 2;
      notifyListeners();
    } else if(label.contains("Tomato___Early_blight")){
      index = 3;
      prevention.add("use liquid copper fungicide concentrate");
      prevention.add("use of Bonide Liquid Copper Fungicide");
      prevention.add("chlorothalonil under brand names Echo");
      notifyListeners();
    } else if(label.contains("Tomato___Septoria_leaf_spot")){
      index = 4;
      prevention.add("Organic fungicides based on  mancozeb");
      prevention.add("Organic fungicides based on  chlorothalonil");
      prevention.add("Organic fungicides based on  benomyl");
      notifyListeners();
    }else if(label.contains("Tomato___Tomato_Yellow_Leaf_Curl_Virus")){
      index = 5;
      prevention.add("Use a neonicotinoid insecticide, such as imidacloprid");
      prevention.add("Use a neonicotinoid insecticide, such as  dinotefuran");
      prevention.add("Use a neonicotinoid insecticide, such as  thiamethoxam");
      notifyListeners();
    }else if(label.contains("Tomato___Bacterial_spot")){
      this.index = 6;
      prevention.add("Spray a Copper Fungicide");
      prevention.add("Inducer such as Regalia");
      prevention.add("Inducer such ar Actigard");
      notifyListeners();
    }else if(label.contains("Tomato___Target_Spot")){
      this.index = 7;
      prevention.add("Products containing chlorothalonil");
      prevention.add("Products containing mancozeb");
      prevention.add("Products containing copper oxychloride");
      notifyListeners();
    }else if(label.contains("Tomato___Tomato_mosaic_virus")){
      this.index = 8;
      prevention.add("Treat with Neem Oil");
      prevention.add("Use Row Covers like aluminum foil mulches ");
      prevention.add("Control your weeds");
      notifyListeners();
    }else if(label.contains("Tomato___Leaf_Mold")){
      this.index = 9;
      prevention.add("Use of chlorothalonil");
      prevention.add("Use of Camelot O' fungicide.");
      prevention.add("Use of Cueva");
      notifyListeners();
    }else if(label.contains("Tomato___Spider_mites Two-spotted_spider_mite")){
      this.index = 10;
      prevention.add("Use of horticultural oils");
      prevention.add("Use of insecticidal Ortho® BugClear™ Insect Killer");
      prevention.add("Use of neem oil");
      notifyListeners();
    }else{
      this.index = 0;
      this.confidence = 0.0;
      this.label = "No Detection";
      notifyListeners();
    }
    notifyListeners();
    //Currency.fromData(data);
  }

  dynamic getConfidence(){
    return confidence;
  }
  int getIndex(){
    return index;
  }
  dynamic getLabel(){
    return label;
  }

  dynamic getPrevention(){
    return prevention;
  }

}