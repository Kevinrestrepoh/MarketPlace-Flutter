import 'package:app/api/api.dart';
import 'package:app/components/post_card.dart';
import 'package:app/models/post_model.dart';
import 'package:app/models/user_model.dart';
import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final String? id;
  const ProfilePage({super.key, this.id});

  Future<List<Post>> _fetchUserPosts(String? id) async{
    final api = Api();
    return await api.getUserPosts(id);
  }

  Future<User> _fetchUser(String ?id) async{
    final api = Api();
    return await api.getUser(id);
  }

  Future<Map<String, dynamic>> _fetchUserAndPosts(String? id, User? localUser) async {
    final user = localUser ?? await _fetchUser(id);
    final posts = await _fetchUserPosts(id);
    return {'user': user, 'posts': posts};
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>().user;
    bool hasId = id != null;
    return 
        Scaffold(
          backgroundColor: Colors.white,
          appBar: hasId ? AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(onPressed:(){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios))
          ) : null,
          body: FutureBuilder<Map<String, dynamic>>(
            future: _fetchUserAndPosts(hasId ? id : userProvider?.id, hasId ? null : userProvider), 
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.black,));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error loading user: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return Center(child: Text("No data available."));
              }
              
              final user = snapshot.data!['user'] as User;
              final posts = snapshot.data!['posts'] as List<Post>;
          
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle
                                  ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(user.name),
                                Text(user.email),
                                Text(user.phone.toString()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.black, thickness: 0.5),
                          SizedBox(height: 10),
                          Text("${user.name}'s posts", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index){
                        final post = posts[index];
                        return PostCard(post: post);
                      },
                      childCount: posts.length
                    ),
                  )
                ],
              );
            }
          ),
        );
  }
}