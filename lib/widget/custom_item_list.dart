import 'package:flutter/material.dart';
class CustomItemList extends StatelessWidget {
  final String title;
  final String image;
  final int number;
  final Color color;
  var function;

  CustomItemList({
    required this.title,
    required this.image,
    required this.number,
    required this.color,
    required this.function
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: function,


        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [

            Container(
              width: 160,
              height: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child:   Padding(
                padding: EdgeInsets.only(top: 70),
                child: Image(image: AssetImage(image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(title,style:  TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),

                  Text('$number  الاساله',style:  TextStyle(
                      fontSize: 12,
                      color: Colors.white
                  ),),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
