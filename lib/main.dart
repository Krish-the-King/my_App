import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                    fontWeight: FontWeight.bold,
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
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                ? Icon(Icons.star)
                : Icon(Icons.star_border)
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children:[
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image(image: AssetImage('assets/image 4.jpg')),
              Positioned(
                child: Image(
                    image: AssetImage('assets/image 5.jpg'),
                  height: 201,
                ),
                bottom: -125,
                right: 10,
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
          ),
        ],
      )
    );
  }
}

