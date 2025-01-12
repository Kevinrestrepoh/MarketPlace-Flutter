import 'package:app/models/post_model.dart';
import 'package:app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(id: post.userId.id)));},
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(post.userId.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),)
                ],
              ),
            ),
            SizedBox(height: 8,),
            Text(post.title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18), maxLines: 2, overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5,),
            Text(post.description, maxLines: 8, overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5,),
            Text('\$${post.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
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