import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_app/GoogleSignInProvider.dart';
import 'package:my_app/Login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'iconProvider.dart';
import 'package:firebase_database/firebase_database.dart';
void main() => runApp(MaterialApp(home: Home(),));
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<String> images=['assets/image 2.jpg','assets/image 1.jpg','assets/image 3.jpg'];
  bool isSelected=false;
  @override
  List<dynamic> names=[];
  List<dynamic> code=[];
  List<dynamic> isSelected2=[];
  Future<String> getCountries() async {
    const url='https://restcountries.com/v3.1/all?fields=name,cca2';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    final body=response.body;
    final json=jsonDecode(body);
    for(var country in json){
      names.add(country['name']);
      code.add(country['cca2']);
      isSelected2.add(false);
    }
    print("getcounties executed");
    return 'Done';
  }
  @override
  void initState(){
    super.initState();
    getCountries();
  }
  int count=0;
  Widget build(BuildContext context) {
    //final provider=Provider.of<iconProvider>(context);
    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body:FutureBuilder<void>(
        future: getCountries(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return
              Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                              if(provider.user==null){
                                provider.googleLogin();
                              }
                              else{
                                next2(context);
                              }
                          },
                          icon: Icon(
                            Icons.account_circle_outlined,
                            size: 50,
                            color: Colors.redAccent[100],
                          ),
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    Container(
                      child: Text(
                        'HOME',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(90, 25, 65, 0),
                    ),
                    Container(
                        child: IconToggleButton(
                          isSelected: isSelected,
                          onPressed: () {
                            setState(() {
                              isSelected = !isSelected;
                            });
                          },
                        )
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
                Container(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(initialPage: 1,
                        height: 200,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 5),
                        enableInfiniteScroll: false),
                    itemCount: images.length,
                    itemBuilder: (context, index, realindex) {
                      final Image = images[index];
                      return buildImage(Image, index);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 30, 0),
                  child: ClipRRect(
                    child: Image(
                      image: AssetImage('assets/image 7.jpg'),
                      width: 360,
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular((10))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 15, 30, 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Country',
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((60)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: names.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider(
                          create: (context)=>iconProvider(),
                          child: Card(
                          color: Colors.white,
                          child: ListTile(
                              onTap: () {
                                next(context,code: code[index]);
                              },
                              title: Row(
                                children: [
                                  Text(
                                    code[index].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    '    ' + names[index]['official']
                                        .toString()
                                        .substring(0, names[index]['official']
                                        .toString()
                                        .length > 27
                                        ? 27
                                        : names[index]['official']
                                        .toString()
                                        .length),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Expanded(
                                    child: IconToggleButton2(
                                      isSelected: isSelected2[index],
                                      onPressed: () {
                                        //provider.toggleIcon(names[index]['official']);
                                        setState(() {
                                          isSelected2[index] =
                                          !isSelected2[index];
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ),
                        )
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        }
      )
      )
    );
  }
  void next(BuildContext context, {required code}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen2(code: code)));
  }
  void next2(BuildContext context){
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> provider.build(context)));
  }
  Widget buildImage(String image,int index) => Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 1),
    color: Colors.grey[50],
    child: Image(
      image: AssetImage(image),
    ),
  );
}
class IconToggleButton extends StatelessWidget {
  final bool isSelected;
  final Function onPressed;
  IconToggleButton({required this.isSelected, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IconButton(
        iconSize: 30.0,
        padding: EdgeInsets.all(5),
        icon: Padding(
            padding: EdgeInsets.zero,
            child: isSelected == true
                ? Icon(Icons.stars_sharp,color: Colors.redAccent[100],size: 50,)
                : Icon(Icons.stars_outlined,color: Colors.redAccent[100],size: 50,)),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
class IconToggleButton2 extends StatelessWidget {
  final bool isSelected;
  final Function onPressed;
  IconToggleButton2({required this.isSelected, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: IconButton(
        iconSize: 30.0,
        padding: EdgeInsets.all(5),
        icon: Padding(
            padding: EdgeInsets.zero,
            child: isSelected == true
                ? Icon(Icons.star,color: Colors.blue[600],)
                : Icon(Icons.star_border,color: Colors.blue[600])
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
class IconToggleButton3 extends StatelessWidget {
  final bool isSelected;
  final Function onPressed;
  IconToggleButton3({required this.isSelected, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 30.0,
        padding: EdgeInsets.all(5),
        icon: Padding(
            padding: EdgeInsets.zero,
            child: isSelected == true
                ? Icon(Icons.star,color: Colors.yellow[600],)
                : Icon(Icons.star_border,color: Colors.yellow[600])
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
class screen2 extends StatefulWidget {
  final String code;
  const screen2({Key? key,required this.code}):super(key: key);
  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  List<dynamic> names=[];
  List<dynamic> code=[];
  List<dynamic> isSelected2=[];
  late String name;
  late String image;
  late String cap;
  late String ISD;
  List<List<dynamic>> cities=[];
  List<dynamic> regions=[];
  Future<String> getDet() async{
    String url='https://wft-geo-db.p.rapidapi.com/v1/geo/countries/'+widget.code;
    Map<String,String> head={'X-RapidAPI-Key': '080f6c1ee2msh4a92d6cfe258b03p10115djsnc512a9eaacd2','X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com'};
    final uri=Uri.parse(url);
    final response=await http.get(uri,headers: head);
    final body=response.body;
    final json=jsonDecode(body)['data'];
    name=json['name'];
    image=json['flagImageUri'];
    cap=json['capital'];
    ISD=json['callingCode'];
    String url1='https://wft-geo-db.p.rapidapi.com/v1/geo/countries/'+widget.code+'/regions';
    final uri1=Uri.parse(url1);
    final response1=await http.get(uri1,headers: head);
    final body1=response1.body;
    final json1=jsonDecode(body1)['data'];
    int len=(json1 as List<dynamic>).length;
    for (int i=0;i<len;i++){
      regions.add(json1[i]['isoCode']);
      String url2='https://wft-geo-db.p.rapidapi.com/v1/geo/countries/'+widget.code+'/regions/'+regions[i]+'/cities';
      final uri2=Uri.parse(url2);
      final response2=await http.get(uri2,headers: head);
      final body2=response2.body;
      final json2=jsonDecode(body2)['data'];
      print(json2);
      if(json2==null){
        continue;
      }
      int len2=(json2 as List<dynamic>).length;
      for(int j=0;j<len2;j++){
        cities.add([json2[j]['name'],json1[i]['name'],json2[j]['wikiDataId']]);
        isSelected2.add(false);
      }
    }
    print('done');
    return ('done');
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body:FutureBuilder<void>(
        future: getDet(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(child: Image(
                        image: AssetImage('assets/image 4.jpg'), height: 213.5),
                      borderRadius: BorderRadius.circular(20),),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontFamily: 'ZenAntique-Regular.ttf',
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                      alignment: Alignment.center,
                      child: ClipRRect(child: SvgPicture.network(
                        image,
                        height: 195,
                      ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 35, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Code',
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              ),
                            ),
                            Text(
                              widget.code,
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Capital',
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18
                              ),
                            ),
                            Text(
                              cap,
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'ISD',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              ISD,
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(Size(150, 45)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.indigo),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.indigo)
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '   WIKIPEDIA   ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 15, 30, 10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search City',
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular((60)),
                        borderSide: BorderSide(
                            width: 3, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(child: Text(
                  'CITIES',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ), margin: EdgeInsets.fromLTRB(0, 15, 0, 0),),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: isSelected2.length,
                      itemBuilder: (context, index) {
                        return (Card(
                          child: ListTile(
                              onTap: () {
                                next(context,cities[index][2]);
                              },
                              title: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cities[index][0],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        cities[index][1],
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Expanded(
                                    child: IconToggleButton3(
                                      isSelected: isSelected2[index],
                                      onPressed: () {
                                        setState(() {
                                          isSelected2[index] =
                                          !isSelected2[index];
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ));
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        }
        )
    );
  }
  void next(BuildContext context,String code) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen3(code: code,)));
  }
}
class screen3 extends StatefulWidget {
  final String code;
  const screen3({Key? key,required this.code}):super(key: key);

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  late String name,lat,long,ele,pop;
  List<String> images=['assets/image 9.jpg'];
  Future<String> getDet() async{
    String url='https://wft-geo-db.p.rapidapi.com/v1/geo/cities/'+widget.code;
    Map<String,String> head={'X-RapidAPI-Key': '080f6c1ee2msh4a92d6cfe258b03p10115djsnc512a9eaacd2','X-RapidAPI-Host': 'wft-geo-db.p.rapidapi.com'};
    final uri=Uri.parse(url);
    final response=await http.get(uri,headers: head);
    final body=response.body;
    final json=jsonDecode(body)['data'];
    print(json);
    name=json['name'];
    print(name);
    lat=json['latitude'].toString();
    print(lat);
    long=json['longitude'].toString();
    print(long);
    ele=json['elevationMeters'].toString();
    print(ele);
    pop=json['population'].toString();
    print(pop);
    print('done');
    return('done');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<void>(
        future: getDet(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: Image(
                        image: AssetImage('assets/image 8.jpg'),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_sharp, color: Colors.white,
                            size: 0,),
                        )
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(initialPage: 5,
                        height: 550,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.65),
                    itemCount: images.length,
                    itemBuilder: (context, index, realindex) {
                      final Image = images[index];
                      return buildImage(Image, index);
                    },
                  ),
                ),
              ],
            );
          }
        }
      )
    );
  }
  Widget buildImage(String image,int index) => Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 1),
    color: Colors.grey[50],
    child: Image(
      image: AssetImage(image),
    ),
  );
}