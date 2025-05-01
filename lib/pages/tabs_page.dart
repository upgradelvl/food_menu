import 'package:flutter/material.dart';
import 'package:food_menu/model/provider.dart';
import 'package:food_menu/model/thema_data_style.dart';
import 'package:food_menu/pages/main/drink_page.dart';
import 'package:food_menu/pages/main/food_page.dart';
import 'package:food_menu/pages/main/salad_page.dart';
import 'package:food_menu/pages/main/sweet_page.dart';
import 'package:food_menu/servise/url_servise.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tabs_Page extends StatefulWidget {
  const Tabs_Page({super.key});

  @override
  State<Tabs_Page> createState() => _Tabs_PageState();
}

class _Tabs_PageState extends State<Tabs_Page> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Text(
            "M e n u",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40,fontFamily: "Billabong"),),
          centerTitle: true,
          actions: [

          ],
          bottom: TabBar(
            indicator: BoxDecoration(),
            labelColor: Color(0xFF4CD1F5),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 18,
            ),
            tabs: [
              Tab(text: "Food",),
              Tab(text: "Drink",),
              Tab(text: "Salad",),
              Tab(text: "Sweet",),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              children: [
                SizedBox(height: 70,),
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.white),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),fit: BoxFit.cover,
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child: Text(
                    "F o o d  M e n u",style: TextStyle(color: Colors.white,fontFamily: "Billabong",fontSize: 45,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: Offset(0,5),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12,),
                        Icon(Icons.home,size: 35,color: Color(0xFF4CD1F5),),
                        SizedBox(width: 12,),
                        Text(
                          "Home",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    UrlService.launchInBrauther(
                        Uri.parse("https://pub.dev/packages/url_launcher/install"));
                  },
                  child: Container(

                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: Offset(0,5),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12,),
                        Icon(Icons.location_pin,size: 35,color: Color(0xFF4CD1F5),),
                        SizedBox(width: 12,),
                        Text(
                          "Location",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    UrlService.makePhoneCall(
                        "+998880764321"
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1.5,
                          offset: Offset(0,5),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    height:MediaQuery.of(context).size.height*0.075,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(width: 12,),
                        Icon(Icons.phone,size: 35,color: Color(0xFF4CD1F5),),
                        SizedBox(width: 12,),
                        Text(
                          "For reference",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18),),
                      ],
                    ),
                  ),
                ),
            Container(
              margin: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height*0.075,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: themeProvider.themeDataStyle == ThemeDataStyle.dark? Icon(Icons.dark_mode,color: Color(0xFF4CD1F5),size: 35,):Icon(Icons.light_mode,color: Color(0xFF4CD1F5),size: 35,)
                  ),
                  Expanded(
                    child: Text(
                      themeProvider.themeDataStyle == ThemeDataStyle.dark
                          ? ' Dark mode'
                          : ' Light mode',
                      style: const TextStyle(fontSize: 20,color: Colors.black54),
                    ),
                  ),
                  SizedBox(width: 20),
                  Switch(
                    value: themeProvider.themeDataStyle == ThemeDataStyle.dark,
                    onChanged: (value) {
                      themeProvider.changeTheme();
                    },
                  ),
                ],
              ),
            ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Food_Page(),
            Drink_Page(),
            Salad_Page(),
            SweetPage()
          ],
        ),
      ),
    );
  }
}
