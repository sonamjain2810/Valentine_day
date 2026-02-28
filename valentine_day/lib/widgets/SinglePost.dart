import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class SinglePost extends StatelessWidget {
  const SinglePost(
    this.s,
    this.name,
    this.callback, {
    super.key,
  });

  final String s, name;
  final VoidCallback callback; // Notice the variable type

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
        Padding(
          
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.width(150.0)),
                    topLeft: Radius.circular(SizeConfig.width(150.0)))),
            
            height: MediaQuery.of(context).size.height*0.60,
            width: MediaQuery.of(context).size.width*0.75,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.width(150.0)),
                    topLeft: Radius.circular(SizeConfig.width(150.0))),
                child: Image.asset(s)),
          ),
        ),
        SizedBox(height: SizeConfig.height(8)),
        Container(
          margin: EdgeInsets.only(
              left: SizeConfig.width(10.0),
              right: SizeConfig.width(5.0),
              bottom: SizeConfig.height(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0)),
              SizedBox(
                width: SizeConfig.width(10),
              ),
              Row(
                children: [
                  Icon(Icons.comment_outlined,
                      size: SizeConfig.width(16.0), color: Colors.white),
                  SizedBox(width: SizeConfig.width(5)),
                  const Text("15",
                      style: TextStyle(color: Colors.white, fontSize: 14.0)),
                  SizedBox(width: SizeConfig.width(10)),
                  Icon(Icons.favorite_border,
                      size: SizeConfig.width(16.0), color: Colors.white),
                  SizedBox(width: SizeConfig.width(5)),
                  const Text("150k",
                      style: TextStyle(color: Colors.white, fontSize: 14.0)),
                ],
              ),
            ],
          ),
        ),
      
      ]),
    );
  }
}
