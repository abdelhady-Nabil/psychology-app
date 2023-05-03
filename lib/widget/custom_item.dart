import 'package:flutter/material.dart';
class CustomItem extends StatelessWidget {
   final String title;
   final String image;
   final int number;
   final Color color;
    var function;

    CustomItem({
    required this.title,
    required this.image,
    required this.number,
    required this.color,
    required this.function
});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: function,

        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [

            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Image(image: AssetImage(image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:  [
                  Text(title,style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),),

                  Text('$number  الاساله',style: const TextStyle(
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
