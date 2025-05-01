  import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
  import 'package:flutter/material.dart';
  import 'package:food_menu/model/post_model.dart';
  import 'package:food_menu/upload/drinks_upload.dart';

  import '../../servise/RTDBServise.dart';

  class Drink_Page extends StatefulWidget {
    const Drink_Page({super.key});

    @override
    State<Drink_Page> createState() => _Drink_PageState();
  }

  class _Drink_PageState extends State<Drink_Page> {
    List<Post> items = [];



    Future _callUploadPage() async {
      Map result = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return UploadIchimliklar();
      }));
      if (result != null && result.containsKey("data")) {
        print(result['data']);
      }

      _apiPostList();
    }

    _apiPostList() async {
      var list = await RTDBService.getDrink();
      items.clear();
      setState(() {
        items = list;
      });
    }

    @override
    void initState() {
      super.initState();
      _apiPostList();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.23,
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1F2C4C),
                          Color(0xFF1F2C4C),
                          Color(0xFF1F2C4C),
                          Color(0xFF357EA0),
                          Color(0xFF4CD1F5),

                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      color: Color(0xFF1F2C4C),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0,5),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*0.23,
                              width: MediaQuery.of(context).size.width*0.35,
                              child: items[index].img_url != null
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),

                                  image: DecorationImage(
                                    image: NetworkImage(items[index].img_url!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage("assets/image/upload.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.04,
                                  width: MediaQuery.of(context).size.width*0.57,
                                  child: Text(
                                    "Nomi:${items[index].name!}",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Narxi: ${items[index].caption!}so'm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.055,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: Text(
                                    items[index].caption1!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                TextButton(
                                  onPressed: () {
                                    _showFullTextDialog(context, items[index].caption1!);
                                  },
                                  child: Text(
                                    "To'liq ko'rish",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),

                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              try {
                                // Firebase-dan postni o'chirish
                                await RTDBService.deleteDrink(items[index].id!);

                                // Mahalliy ro'yxatni o'chirish va UI-ni yangilash
                                setState(() {
                                  items.removeAt(index);
                                });

                                // Muvaffaqiyatli o'chirilgani haqida xabar
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Post muvaffaqiyatli o\'chirildi!')),
                                );
                              } catch (e) {
                                // Xatolarni ushlash va foydalanuvchini ogohlantirish
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Postni o\'chirishda xato yuz berdi: $e')),
                                );
                              }
                            },
                                child: Icon(
                                  Icons.close,
                                  size: 30,
                                  color: Colors.red,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          },
        ),
      ),
        floatingActionButton: kIsWeb
            ? null
            : FloatingActionButton(
          onPressed: () {
            _callUploadPage();
          },
          child: Icon(Icons.add),
        ),
      );
    }
    void _showFullTextDialog(BuildContext context, String fullText) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Full text'),
            content: Text(fullText),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Yopish'),
              ),
            ],
          );
        },
      );
    }
  }
