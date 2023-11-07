import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
    title: "Login Page",
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController controller1;
  late Animation<double> animation1;
  late Animation<double> animation2;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    animation1 = Tween<double>(begin: 0.1, end: 0.15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    );

    animation2 = Tween<double>(begin: 0.02, end: 0.04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    );

    controller1.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff192028),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Top-left animated orange circle
            Positioned(
              top: 20,
              left: 20,
              child: CustomPaint(
                painter: CirclePainter(animation1.value, Colors.orange),
              ),
            ),

            // Bottom-right animated blue circle
            Positioned(
              bottom: 20,
              right: 20,
              child: CustomPaint(
                painter: CirclePainter(animation2.value, Colors.blue),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Username input field
                CurvedInputField(Icons.account_circle_outlined, 'Username...'),

                // Password input field with curved sides
                CurvedInputField(Icons.lock_outline, 'Password...'),

                // Forgot Password? text
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      // Handle the forgot password action
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  CirclePainter(this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(Offset(0, 0), radius * 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  CurvedInputField(this.icon, this.hintText);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
      child: Container(
        height: 50,
        width: 300,
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
            ),
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white.withOpacity(.8)),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
