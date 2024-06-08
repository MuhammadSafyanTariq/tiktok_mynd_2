// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:insta_clone/Provider/user_provider.dart';
// import 'package:insta_clone/Resource/FireStore_methods.dart';
// import 'package:insta_clone/utils/colors.dart';
// import 'package:insta_clone/utils/utils.dart';
// import 'package:provider/provider.dart';

// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);

//   @override
//   _AddPostScreenState createState() => _AddPostScreenState();
// }

// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//   bool isLoading = false;
//   final TextEditingController _descriptionController = TextEditingController();

//   _selectImage(BuildContext parentContext) async {
//     return showDialog(
//       context: parentContext,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Create a Post'),
//           children: <Widget>[
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a photo'),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                   Uint8List file = await pickImage(ImageSource.camera);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose from Gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(ImageSource.gallery);
//                   setState(() {
//                     _file = file;
//                   });
//                 }),
//             SimpleDialogOption(
//               padding: const EdgeInsets.all(20),
//               child: const Text("Cancel"),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             )
//           ],
//         );
//       },
//     );
//   }

//   void postImage(String uid, String username, String profImage) async {
//     setState(() {
//       isLoading = true;
//     });
//     // start the loading
//     try {
//       // upload to storage and db
//       String res = await firestoreMethods().uploadPost(
//         _descriptionController.text,
//         _file!,
//         uid,
//         username,
//         profImage,
//       );
//       if (res == "success") {
//         setState(() {
//           isLoading = false;
//         });
//         showSnackBar(
//           'Posted!',
//           context,
//         );
//         clearImage();
//       } else {
//         showSnackBar(res, context);
//       }
//     } catch (err) {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(
//         err.toString(),
//         context,
//       );
//     }
//   }

//   void clearImage() {
//     setState(() {
//       _file = null;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _descriptionController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = Provider.of<UserProvider>(context);

//     return _file == null
//         ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.upload,
//                 ),
//                 onPressed: () => _selectImage(context),
//               ),
//               Text(
//                 'Add a post',
//                 style: TextStyle(
//                   fontFamily: 'Billabong',
//                   fontSize: 35,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           )
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: mobileBackgroundColor,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: clearImage,
//               ),
//               title: const Text(
//                 'Post to',
//               ),
//               centerTitle: false,
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () => postImage(
//                     userProvider.getUser.uid!,
//                     userProvider.getUser.username!,
//                     userProvider.getUser.photoUrl!,
//                   ),
//                   child: const Text(
//                     "Post",
//                     style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16.0),
//                   ),
//                 )
//               ],
//             ),
//             // POST FORM
//             body: Column(
//               children: <Widget>[
//                 isLoading
//                     ? const LinearProgressIndicator()
//                     : const Padding(padding: EdgeInsets.only(top: 0.0)),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         userProvider.getUser.photoUrl!,
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       child: TextField(
//                         controller: _descriptionController,
//                         decoration: const InputDecoration(
//                             hintText: "Write a caption...",
//                             border: InputBorder.none),
//                         maxLines: 8,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 45.0,
//                       width: 45.0,
//                       child: AspectRatio(
//                         aspectRatio: 487 / 451,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                             fit: BoxFit.fill,
//                             alignment: FractionalOffset.topCenter,
//                             image: MemoryImage(_file!),
//                           )),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//               ],
//             ),
//           );
//   }
// }
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/Widgets/app_bar.dart';
import 'package:insta_clone/Widgets/custom_button.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';

class VideoUploadScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();

  VideoUploadScreen({super.key});

  Future<void> _uploadVideo(BuildContext context) async {
    // Handle video upload logic here
  }
  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      _videoController.text = result.files.single.name;
      // Handle the file, e.g., upload it to Firebase Storage
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file selected'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MyAppBar(title: 'Upload Video', backButton: true),
            // const Spacer(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return _buildMobileLayout(context);
                    } else {
                      return _buildWebLayout(context);
                    }
                  },
                ),
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputFeilds(
              textEditingController: _titleController,
              hintText: "Video Title",
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          TextInputFeilds(
            textEditingController: _descriptionController,
            hintText: "Write your Video Description ... ",
            textInputType: TextInputType.text,
            maxLines: 5,
          ),
          const SizedBox(height: 20),
          TextInputFeilds(
              textEditingController: _tagsController,
              hintText: "Tags",
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          TextInputFeilds(
              textEditingController: _videoController,
              hintText: "Upload Video",
              textInputType: TextInputType.text),
          const SizedBox(height: 20),
          TextInputFeilds(
              textEditingController: _titleController,
              hintText: "Post Video",
              textInputType: TextInputType.text),
          SizedBox(
            height: 30,
          ),
          CustomButton(
            text: 'Post Video',
            onPressed: () => _uploadVideo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInputFeilds(
                    textEditingController: _titleController,
                    hintText: "Video Title",
                    textInputType: TextInputType.text),
                const SizedBox(height: 20),
                TextInputFeilds(
                    textEditingController: _descriptionController,
                    hintText: "Video Description",
                    textInputType: TextInputType.text,
                    maxLines: 5),
                const SizedBox(height: 20),
                TextInputFeilds(
                    textEditingController: _tagsController,
                    hintText: "Tags",
                    textInputType: TextInputType.text),
                const SizedBox(height: 20),
                TextInputFeilds(
                    textEditingController: _videoController,
                    hintText: "Upload Video",
                    textInputType: TextInputType.text),
                const SizedBox(height: 20),
                TextInputFeilds(
                    textEditingController: _titleController,
                    hintText: "Post Video",
                    textInputType: TextInputType.text),
                CustomButton(
                  text: 'Post Video',
                  onPressed: () => _uploadVideo(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
