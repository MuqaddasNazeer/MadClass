import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users/assistance/assistant_method.dart';
import 'package:users/data_handler/app_data.dart';
import 'package:users/mainScreens/search_screen.dart';
import 'package:users/widgets/divider.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position currentPosition;
  var geolocator = Geolocator();

// Add a marker set for the user's location
   Marker? userLocationMarker;

//  double bottomPaddingOfMap = 0.0;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      // Update the user location marker
      userLocationMarker = Marker(
        markerId: MarkerId('user_location'),
        position: latLatPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
    });

    // Reverse geocoding
     String address = await AssistantMethods.searchCoordinateAddress(position, context);
     print("This is your Address :: " + address);
  }

  late EdgeInsets _mapPadding;

    @override
    void initState() {
      super.initState();
      _mapPadding = EdgeInsets.zero;
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 250.0,
        child: Drawer(
          child: ListView(
            children: [
              // Draw header
              Container(
                height: 100.0,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/profile.png", height: 130, width: 80,),
                      const SizedBox(width: 10.0,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: TextStyle(
                            fontSize: 16.0, fontFamily: "Brand-Bold",
                          ),
                          ),
                          SizedBox(height: 6.0,),
                          Text("Visit profile", style: TextStyle(
                            fontSize: 16.0, fontFamily: "Brand-Bold",
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              const SizedBox(height: 12.0,),

              // Drawer body
              const ListTile(
              leading: SizedBox( 
                width: 10.0, // Set the desired width
                child: Icon(Icons.history),
              ),
              title: Text("History", style: TextStyle(fontSize: 12.0)),
            ),

              const ListTile(
              leading: SizedBox( // Use SizedBox to specify a fixed width
                width: 10.0, // Set the desired width
                child: Icon(Icons.person),
              ),
              title: Text("Visit Profile", style: TextStyle(fontSize: 12.0)),
            ),


              const ListTile(
              leading: SizedBox( // Use SizedBox to specify a fixed width
                width: 10.0, // Set the desired width
                child: Icon(Icons.info),
              ),
              title: Text("About", style: TextStyle(fontSize: 12.0)),
            ),

            ],
          ),
        ),
      ),
      body: Stack(
        children: [
              GoogleMap(
              padding: _mapPadding,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller)
              {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;
          
                setState(() {
                   // _mapPadding = EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3);
                  // _mapPadding = EdgeInsets.only(top: 50.0, bottom: 50.0, left: 50.0, right: 50.0);
                });
              },
               markers: {
                if (userLocationMarker != null) userLocationMarker!,
              },
            ),
          

  // Floating location button
              Positioned(
                        top: 40,
                        right: 16,
                        child: FloatingActionButton(
                          onPressed: () {
                            locatePosition();
                          },
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                          ),
                        ),
              ),

  // Hamburger button for drawer

        Positioned(
          top: 45.0,
          left: 22.0,
          child: GestureDetector(
            onTap: (){
              scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ]
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.menu, color: Colors.black,),
                radius: 20.0,
              ),
            ),
          ),
        ),

         Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: 300.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ]
            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6.0,),
                  const Text("Hi there,",
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                  ),
                  const Text("Where to,",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Brand-Bold"
                  ),
                  ),
                  const SizedBox(height: 20.0,),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 6.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        )
                        ]
                     ),
                     child: const Padding(
                       padding: EdgeInsets.all(12.0),
                       child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.blueAccent,),
                          SizedBox(width: 10.0,),
                          Text(("Search Drop off"))
                        ],
                       ),
                     ),
                    ),
                  ),
                  const SizedBox(height: 24.0,),
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.grey,),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Provider.of<AppData>(context).pickUpLocation != null
                            ? Provider.of<AppData>(context).pickUpLocation.placeName
                            : "Add Home"
                          ),
                          SizedBox(height: 4.0,),
                          Text("Your living home address",
                          style: TextStyle(
                            color: Colors.black,fontSize: 12.0,
                          ),)
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 10.0,),
                  DividerWidget(),
                  const SizedBox(height: 16.0,),
                  const Row(
                    children: [
                      Icon(Icons.work, color: Colors.grey,),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add Work"),
                          SizedBox(height: 4.0,),
                          Text("Your office address",
                          style: TextStyle(
                            color: Colors.black,fontSize: 12.0,
                          ),)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
         ),
        ],
      )
    );
  }
}