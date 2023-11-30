import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tflite/tflite.dart';
import 'package:tomato_diseases/model.dart';

import 'camera.dart';

class Detect extends StatefulWidget{

  final XFile picture;
  const Detect(this.picture);

  @override
  State<Detect> createState() => _Detect();
}


class _Detect extends State<Detect>{

  late File? _imageFile =  File('assets/images/default.png');
  var flag = false;
  late var _classifiedResult;
  late DiseaseModel base;

   @override
   void initState() {
     super.initState();
     setState(() {
       _imageFile = File(widget.picture.path);
       base = DiseaseModel("0", "No detection", 0);
       loadImageModel();
      // _imageFile =  File('');
     });

     //  _loadAsset().then((value){
     //   setState(()  async{
     //
     //     await
     //   });
     // }).onError((error, stackTrace) {
     //   print('Error occurred here ${error}');
     //   stackTrace;
     // });

   }

  Future<String> _loadAsset() async {
    //rootBundle.load('assets/image/default.png');
    //String sd = String(" ");
    print('Image list ${_imageFile?.path}');
    return 'assets/images/default.png';
    return await rootBundle.loadString('assets/images/default.png');
  }

  Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    print("classification start $image");
    final List? result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.03, //0.05
       imageMean: 0,
       imageStd:  255.0,
    );
    print("classification done");
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
        _classifiedResult = result;
        if (kDebugMode) {
          print('Printed result here ${result}');
        }
        base = DiseaseModel.fromOject(_classifiedResult);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future selectImage() async {
    flag = true;
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery, maxHeight: 300);
    classifyImage(image);
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future loadImageModel() async {
    Tflite.close();
    String? result;
    result = await Tflite.loadModel(
      model: "assets/images/plant_diseas_model.tflite",
      labels: "assets/images/labels.txt",
    );
    print(result);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tomato Diseases"),
      ),
      body: SingleChildScrollView(
      child: FutureBuilder(
          future: _loadAsset(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      //return  ? new Image.file(snapshot.data) : new Container();
          if (kDebugMode) {
            print('Snapshot data ${snapshot.data}');
          }
      return snapshot.data != null ? ScopedModel<DiseaseModel>(
        model: base,
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children : [
        Column(
        children: [
        Container(
          height: 300,
        margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                spreadRadius: 2,
                blurRadius: 1,
              ),
            ],
          ),
          child: (_imageFile!.path.contains('assets/images/default.png') || (_imageFile!.path == '')) ?
          const Image(image: AssetImage('assets/images/default.png')) ://Image.network('https://i.imgur.com/sUFH1Aq.png')
          Image.file(_imageFile!),

      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
          onPressed: (){
            selectImage();
          },
          child: const Icon(Icons.camera)
      ),
          SizedBox(width: 15,),

          ElevatedButton(
              onPressed: ()async{
                await availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
              },
              child: const Icon(Icons.camera_alt)
          ),

          ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Gallery",
                style: TextStyle(color: Color.fromRGBO(19, 52, 116, 1),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Acme'),),
              SizedBox(width: 55,),

              Text("Photo",
                style: TextStyle(color: Color.fromRGBO(19, 52, 116, 1),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Acme'),),

            ],
          ),

      ],
    ),
      ScopedModelDescendant<DiseaseModel>(builder: (context, child, model) {
        model.notifyListeners();
        return SingleChildScrollView(
          child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24,),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          const LimitedBox(
                            child: Image(
                                image: AssetImage('assets/images/download.png')),
                          ),
                          // Positioned(
                          //   child: SvgPicture.asset('assets/images/status.svg'),
                          //   left: 29,
                          // ),
                        ],
                      ),
                      const SizedBox(width: 16,),
                      Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Tomato Diseases",
                              style: TextStyle(
                                  color: Color.fromRGBO(25, 26, 25, 1),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Nunito'),),
                            const SizedBox(height: 4,),
                            // Text("2 Services",
                            //   style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),fontStyle: FontStyle.normal,
                            //       fontWeight: FontWeight.w500, fontSize: 10, fontFamily: 'Nunito'),),
                            Row(
                              children: [
                                SvgPicture.asset('assets/images/star.svg'),
                                SvgPicture.asset('assets/images/star.svg'),
                                SvgPicture.asset('assets/images/star.svg'),
                                SvgPicture.asset('assets/images/star.svg'),
                                SvgPicture.asset('assets/images/half_star.svg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ), /////
            const SizedBox(height: 24,),
            Container(
              // width: 197,
              height: 34,
              margin: const EdgeInsets.only(left: 24.0,),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/small_oval.svg',
                          color: const Color.fromRGBO(39, 232, 62, 1),),
                        const SizedBox(width: 10,),
                        const Text("Detail Info",
                          style: TextStyle(
                              color: Color.fromRGBO(39, 232, 62, 1),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Nunito'
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(250, 250, 250, 1),
                    ),
                  ),

                  // FlatButton(
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children:[
                  //       SvgPicture.asset('assets/images/small_oval.svg',color: const Color.fromRGBO(196, 196, 196, 1),),
                  //       const SizedBox(width: 10,),
                  //       const Text("Prices",
                  //         style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),fontStyle: FontStyle.normal,
                  //             fontWeight: FontWeight.w400, fontSize: 14, fontFamily: 'Nunito'
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  //   onPressed: () {
                  //   },
                  //   color: const Color.fromRGBO(250, 250, 250, 1),
                  // ),
                ],
              ),
            ), /////////////
            SingleChildScrollView(
                child: Container(
              child: Column(
                children: [
            Container(
              margin: const EdgeInsets.only(left: 24.0,),
              child: Container(
                width: 285,
                //height: 68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About",
                      style: TextStyle(color: Color.fromRGBO(25, 26, 25, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Nunito'
                      ),
                    ),

                    Text("${model.getLabel()}",
                      style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Nunito'
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14,),
            Container(
              margin: const EdgeInsets.only(left: 24.0,),
              child: Container(
                width: 285,
                //height: 68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Confidence Level:",
                      style: TextStyle(color: Color.fromRGBO(25, 26, 25, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Nunito'
                      ),
                    ),

                    Text('${model.getConfidence()}',
                      style: const TextStyle(color: Color.fromRGBO(196, 196, 196, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: 'Nunito'
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24,),
            Container(
              margin: const EdgeInsets.only(left: 24.0,),
              child: Container(
                width: 300,
                //height: 68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text("Prevention",
                      style: TextStyle(color: Color.fromRGBO(25, 26, 25, 1),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Nunito'
                      ),
                    ),
                    if(model.prevention.length > 0)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.prevention.length,
                        itemBuilder: (context,index)=> Container(
                          height: 50,
                         child:  Row(
                           mainAxisSize: MainAxisSize.max,
                           children: [
                             Column(
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 SizedBox(height: 14,),
                             SvgPicture.asset('assets/images/small_oval.svg',
                               color: const Color.fromRGBO(39, 232, 62, 1),),
                        ],
                      ),
                             const SizedBox(width: 10,),
                    Expanded(
                    child: Text('${model.prevention[index]}',
                          style: const TextStyle(color: Color.fromRGBO(196, 196, 196, 1),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Nunito'
                          ),
                        ),
                      ),
                          ],
                        ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10,),
        ],
            ),
        ),
        ),
          ],
        ),
        );
      }),
          ],
        ),
      ),
      ) : Container();
  })
    ),
    );
  }
}