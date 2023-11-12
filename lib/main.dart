import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<String>> locations=[['AF','Afghanistan'],['AL','Albania        '],['DZ','Algeria       '],['AD','Andorra   '],['AO','Angola   ']];
  List<String> images=['assets/image 2.jpg','assets/image 1.jpg','assets/image 3.jpg'];
  List<bool> isSelected2=[false,false,false,false,false,false];
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                  onPressed: () {},
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
                padding: EdgeInsets.fromLTRB(90, 25, 75, 0),
              ),
              Container(
                child: IconToggleButton(
                  isSelected: isSelected,
                  onPressed: () {
                    setState(() {
                      isSelected=!isSelected;
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
              options: CarouselOptions(initialPage: 1,height: 200,autoPlay: true, autoPlayInterval: Duration(seconds: 5),enableInfiniteScroll: false),
              itemCount: images.length,
              itemBuilder: (context,index,realindex){
                final Image =images[index];
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
              borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular((10))),
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
               itemCount: locations.length,
               itemBuilder: (context, index){
                return(Card(
                  child: ListTile(
                     onTap: () {
                       next(context);
                     },
                     title: Row(
                       children: [
                         Text(
                           locations[index][0],
                           style: TextStyle(
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                         Text(
                           '    '+locations[index][1],
                           style: TextStyle(
                             fontFamily: 'Poppins',
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                         Spacer(),
                         Spacer(),
                         Spacer(),
                         Spacer(),
                         Expanded(
                           child: IconToggleButton2(
                             isSelected: isSelected2[index],
                             onPressed: () {
                               setState(() {
                                 isSelected2[index]=!isSelected2[index];
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
      ),
    );
  }
  void next(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen2()));
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
      color: Colors.white,
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
      color: Colors.white,
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
  const screen2({super.key});

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  List<bool> isSelected2=[false,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children:[
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(child:Image(image: AssetImage('assets/image 4.jpg'),height: 213.5),borderRadius: BorderRadius.circular(20),),
              Positioned(
                child: ClipRRect(child: Image(
                    image: AssetImage('assets/image 5.jpg'),
                    height: 195,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                bottom: -115,
                right: 14,
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
          margin: EdgeInsets.fromLTRB(0, 140, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child:Column(
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
                        'IN',
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
                  child:Column(
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
                        'New Delhi',
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
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
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
                          '+91',
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
              fixedSize: MaterialStateProperty.all<Size>(Size(150,45)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.indigo)
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
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
          ),margin: EdgeInsets.fromLTRB(0, 15, 0, 0),),
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: isSelected2.length,
                itemBuilder: (context, index){
                  return(Card(
                    child: ListTile(
                        onTap: () {
                          next(context);
                        },
                        title: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mumbai',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'Maharashtra',
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
                                    isSelected2[index]=!isSelected2[index];
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
      )
    );
  }
  void next(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen3()));
  }
  // wiki() async {
  //   final Uri url = Uri.parse('https://en.wikipedia.org/wiki/India');
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
class screen3 extends StatefulWidget {
  const screen3({super.key});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  List<String> images=['assets/image 9.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                child: Image(
                  image: AssetImage('assets/image 8.jpg'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
                child:IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_sharp,color: Colors.white,size: 0,),
                )
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: CarouselSlider.builder(
              options: CarouselOptions(initialPage: 5,height: 550,enableInfiniteScroll: true,enlargeCenterPage: true,viewportFraction: 0.65),
              itemCount: images.length,
              itemBuilder: (context,index,realindex){
                final Image =images[index];
                return buildImage(Image, index);
              },
            ),
          ),
        ],
      ),
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