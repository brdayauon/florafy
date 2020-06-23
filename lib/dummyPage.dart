//import 'package:flutter/material.dart';
//
//class DummyPage extends StatefulWidget {
//  @override
//  _DummyPageState createState() => _DummyPageState();
//}
//
//class _DummyPageState extends State<DummyPage> {
//  static int page = 1;
//  @override
//  Widget build(BuildContext context) {
//    Map<int, Widget> pageview = {
//      1 : getMain(),
//      2 : getLikes(the_post.likes),
//      3 : getComments(the_post.comments)
//    };
//    return pageview[page];
//  }
//
//  Widget getMain() {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Instagram", style: textStyleBold),
//        backgroundColor: Colors.white,
//      ),
//      body: Container(
//          child: ListView(
//            children: <Widget>[
//              Column(
//                children: <Widget> [
//                  Container(
//                    height: 85,
//                    child: getStories(),
//                  ),
//                  Divider(),
//                  Column(
//                    children: getPosts(context),
//                  )
//                ],
//              )
//            ],
//          )
//      ),
//    );
//  }
//
//
//
//  List<Widget> getPosts(BuildContext context) {
//    List<Widget> posts = [];
//    int index = 0;
//    for (Post post in userPosts) {
//      posts.add(getPost(context, post, index));
//      index ++;
//    }
//    return posts;
//  }
//
//  Widget getPost(BuildContext context, Post post, int index) {
//    return Container(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              margin: EdgeInsets.all(5),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(right: 10),
//                        child: CircleAvatar(backgroundImage: post.user.profilePicture,),
//                      ),
//                      Text(post.user.username,)
//                    ],
//                  ),
//                  IconButton(
//                    icon: Icon(Icons.more_horiz),
//                    onPressed: () {
//
//                    },
//                  )
//                ],
//              ),
//            ),
//            Container(
//              constraints: BoxConstraints.expand(height: 1),
//              color: Colors.grey,
//            ),
//            Container(
//              constraints: BoxConstraints(
//                  maxHeight: 282
//              ),
//              decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: post.image
//                  )
//              ),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Stack(
//                      alignment: Alignment(0, 0),
//                      children: <Widget>[
//                        Icon(Icons.favorite, size: 30, color: post.isLiked ? Colors.red : Colors.black,),
//                        IconButton(icon: Icon(Icons.favorite), color: post.isLiked ? Colors.red : Colors.white,
//                          onPressed: () {
//                            setState(() {
//                              userPosts[index].isLiked = post.isLiked ? false : true;
//                              if (!post.isLiked) {
//                                post.likes.remove(user);
//                              } else {
//                                post.likes.add(user);
//                              }
//                            });
//                          },)
//                      ],
//                    ),
//                    Stack(
//                      alignment: Alignment(0, 0),
//                      children: <Widget>[
//                        Icon(Icons.mode_comment, size: 30, color: Colors.black,),
//                        IconButton(icon: Icon(Icons.mode_comment), color: Colors.white,
//                          onPressed: () {
//
//                          },)
//                      ],
//                    ),
//                    Stack(
//                      alignment: Alignment(0, 0),
//                      children: <Widget>[
//                        Icon(Icons.send, size: 30, color: Colors.black,),
//                        IconButton(icon: Icon(Icons.send), color: Colors.white,
//                          onPressed: () {
//
//                          },)
//                      ],
//                    )
//                  ],
//                ),
//                Stack(
//                  alignment: Alignment(0, 0),
//                  children: <Widget>[
//                    Icon(Icons.bookmark, size: 30, color: Colors.black,),
//                    IconButton(icon: Icon(Icons.bookmark), color: post.isSaved ? Colors.black : Colors.white,
//                      onPressed: () {
//                        setState(() {
//                          userPosts[index].isSaved = post.isSaved ? false : true;
//                          if (!post.isSaved) {
//                            user.savedPosts.remove(post);
//                          } else {
//                            user.savedPosts.add(post);
//                          }
//                        });
//                      },)
//                  ],
//                )
//              ],
//            ),
//
//            Row(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(left: 15, right: 10),
//                  child: Text(
//                    post.user.username,
//                    style: textStyleBold,
//                  ),
//                ),
//                Text(
//                  post.description,
//                  style: textStyle,
//                )
//              ],
//            ),
//            FlatButton(
//              child: Text("View all " + post.comments.length.toString() + " comments", style: textStyleLigthGrey,),
//              onPressed: () {
//                setState(() {
//                  the_post = post;
//                  page = 3;
//                  build(context);
//                });
//              },
//            ),
//          ],
//        )
//    );
//  }
//
//
//
//
//}