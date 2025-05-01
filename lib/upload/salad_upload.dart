import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_menu/model/post_model.dart';
import 'package:food_menu/pages/tabs_page.dart';
import 'package:food_menu/servise/RTDBServise.dart';
import 'package:food_menu/servise/storage_servise.dart';
import 'package:image_picker/image_picker.dart';

class Salad_Upload extends StatefulWidget {
  const Salad_Upload({super.key});

  @override
  State<Salad_Upload> createState() => _Salad_UploadState();
}

class _Salad_UploadState extends State<Salad_Upload> {
  var isLoading = false;
  final nameController = TextEditingController();
  final captionController = TextEditingController();
  final captionController1 = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Container(
                child: Wrap(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF1F2C4C),
                              Color(0xFF1F2C4C),
                              Color(0xFF1F2C4C),
                              Color(0xFF357EA0),
                              Color(0xFF4CD1F5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(28.5),topRight: Radius.circular(28.5),)
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo,size: 50,color: Colors.white60,),
                                  Text("Galerya",style: TextStyle(color: Colors.white,fontSize: 20,),)
                                ],
                              ),
                            ),
                            onTap: (){
                              _imageFromGalarya();
                              Navigator.of(context).pop();
                            },
                          ),
                          InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.2,
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt,size: 50,color: Colors.white60,),
                                  Text("Camera",style: TextStyle(color: Colors.white,fontSize: 20,),)
                                ],
                              ),
                            ),
                            onTap: (){
                              _imageFromCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  _imageFromGalarya() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  _imageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  _createPost() {
    String name = nameController.text.toString().trim();
    String caption = captionController.text.toString().trim();
    String caption1 = captionController1.text.toString().trim();

    if (name.isEmpty || caption.isEmpty || caption1.isEmpty) return;

    _apiUploadImage(name, caption,caption1);
  }

  _apiUploadImage(String name, String content,String caption1) {
    setState(() {
      isLoading = true;
    });
    StorageService.uploadImage(_image!).then((img_url) => {
      _apiCreateSalads(name, content, img_url,caption1),
    });
  }

  _apiCreateSalads(String name, String content, String img_url,String caption1) {
    var post = Post(name: name, caption: content, img_url: img_url,caption1: caption1);
    RTDBService.addSalads(post).then((value) => {
      _resAddPost(),
    });
  }


  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "S a l a t   U p l o a d",
          style:  TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold,fontFamily: "Billabong"),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,),onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return Tabs_Page();
          }));
        },),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: InkWell(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                        height: 133,
                        width: 150,
                        child: _image != null
                            ? Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 3,color: Color(0xFF4CD1F5)),
                            image: DecorationImage(
                                image: AssetImage("assets/images/upload.png")
                          ),
                        )),
                  )),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:Border.all(width: 1,color:Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Nomi",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.closed_caption,color: Colors.black,),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      border:Border.all(width: 1,color:Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: captionController,
                    decoration: InputDecoration(
                        hintText: "Narxi",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.price_change,color: Colors.black,),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      border:Border.all(width: 1,color:Colors.white),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: captionController1,
                    decoration: InputDecoration(
                        hintText: "Caption",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.closed_caption,color: Colors.black,),
                        )
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    _createPost();
                  },
                  child: isLoading?
                  Center(child: CircularProgressIndicator())
                      :Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: Color(0xFF4CD1F5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                          "Upload",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
