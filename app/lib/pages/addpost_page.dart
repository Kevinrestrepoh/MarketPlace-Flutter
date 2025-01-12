import 'package:app/api/api.dart';
import 'package:app/components/button.dart';
import 'package:app/components/text_field.dart';
import 'package:app/models/post_model.dart';
import 'package:app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _titleValid = true;
  bool _descriptionValid = true;
  bool _priceValid = true;

  Future add(String? userId) async{
    final title = _titleController.text;
    final description = _descriptionController.text;
    double price;

    try {
      price = double.parse(_priceController.text);
    } catch (e) {
      price = 0;
    }

    final Api api = Api();
    
    setState(() {
      _titleValid = title.isNotEmpty;
      _descriptionValid = description.isNotEmpty;
      _priceValid = price > 0;
    });

    if(!_titleValid || !_descriptionValid || !_priceValid){
      _triggerErrorAnimation();
      return;
    }

    try {
      Post p = Post(title: title, description: description, price: price, images: [], userId: userId);
      await api.addPost(p);
      if(mounted){
        Navigator.pop(context, true);
      }
    } catch (e) {
      setState(() {
        _titleValid = false;
        _descriptionValid = false;
        _priceValid = false;
      });
      _triggerErrorAnimation();
    }
  }
  
  BoxDecoration inputError = BoxDecoration();

  void _triggerErrorAnimation() {
    setState(() {
      inputError = BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.red,
          width: 1
        )
      );
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        inputError = BoxDecoration(borderRadius: BorderRadius.circular(15));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.watch<UserProvider>().user?.id;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed:(){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios))
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: CustomScrollView(
          slivers: [SliverToBoxAdapter(
              child: Column(
                children: [
                  MyTextField(hintText: 'Title', controller: _titleController, anim: !_titleValid ? inputError : null,),
                  SizedBox(height: 10,),
                  MyTextField(hintText: 'Description', maxLines: 10, controller: _descriptionController, anim: !_descriptionValid ? inputError : null,),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/2),
                    child: MyTextField(hintText: 'Price', textInputType: TextInputType.number, controller: _priceController, anim: !_priceValid ? inputError : null,),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10,),
                  MyButton(onTap: () async {add(userId);}, text: 'Create',),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}