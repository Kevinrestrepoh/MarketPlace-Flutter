import 'package:app/api/api.dart';
import 'package:app/components/post_card.dart';
import 'package:app/components/search.dart';
import 'package:app/models/post_model.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List<Post>> _fetchPosts() async{
    final api = Api();
    return await api.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: (){
                context.read<UserProvider>().setUser(user: null);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              }, 
              child: Text('Log Out')
            ),

            SearchField(),

            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _fetchPosts(), 
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error loading posts: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No posts available."));
                  }

                  final posts = snapshot.data!;

                  return ListView.separated(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    itemCount: posts.length,
                    separatorBuilder: (context, index)=>SizedBox(height: 10,),
                    itemBuilder: (context, index){
                      final post = posts[index];
                      return PostCard(post: post,);
                    },
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}