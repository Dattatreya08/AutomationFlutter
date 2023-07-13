import 'package:flutter/material.dart';
import 'package:iot/helper/helper.dart';
import 'package:iot/screens/connectivity.dart';
import 'package:iot/screens/more.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex=0;
  final List<dynamic>  tabs=[
    const Center(child: Text("Home",style: TextStyle(fontSize: 50),)),
    const Center(child: Text("Profile")),
    const Center(child: Text("Settings")),
    const Center(child: Text("Schdule")),
    More()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){

        },splashColor: Colors.transparent,
          highlightColor: Colors.transparent,child: const CircleAvatar(
          child: CreateImage('images/texohamIconDarkBackground.png',width:28,height:28),
        ),
        ),
        title: Text("Automation",style: TextStyle(fontSize: 24),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(CustomPageRoute(builder: (context){
              return Connectivity();
            }));
          },
              icon: const Icon(Icons.connect_without_contact_outlined))
        ],
      ),body: tabs[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined,),
              label:"Home",
              activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined,),
              label: "Account",
              activeIcon: Icon(Icons.person)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings_applications_outlined,),
              label:"Settings",
              activeIcon: Icon(Icons.settings_applications)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined,),
              label:"Schdule",
              activeIcon: Icon(Icons.calendar_month)
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_outlined,),
              label:"More",
              activeIcon: Icon(Icons.more)
          ),


        ],onTap: (int newIndex){
          setState(() {
            _selectedIndex=newIndex;
          });
      },
        selectedItemColor: const Color.fromARGB(255, 255, 200, 0),
        unselectedItemColor: Colors.white70,//0xffeceff1
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: const TextStyle(color: Color.fromARGB(255, 0, 52, 122)),
        backgroundColor: const Color.fromARGB(255, 0, 52, 122),
      ),
    );
  }
}


class CustomPageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;

  CustomPageRoute({required this.builder})
      : super(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) =>
        builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}