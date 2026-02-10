import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/constant/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/screens/user_details.dart';
import 'package:tasky/features/screens/welcome_screen.dart';
import 'package:tasky/features/widget/list_tile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivationQuote;
  bool isloading = true;
  bool isDarkMode = false;
  String? userImagePath;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString(StorageKey.username) ?? '';
      motivationQuote =
          PreferencesManager().getString(StorageKey.motivationQuote) ??
          'One task at a time. One step closer.';
      isDarkMode = PreferencesManager().getBool(StorageKey.theme) ?? false;
      userImagePath = PreferencesManager().getString(StorageKey.userimage);
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Text(
                  "My Profile ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 100.0,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            userImagePath == null
                                ? AssetImage('assets/images/Thumbnail.png')
                                : FileImage(File(userImagePath!)),
                      ),
                      GestureDetector(
                        onTap: () async {
                          _showImageSourceDilog(context, (XFile file) {
                            _saveImage(file);
                            log(file.path);
                            setState(() {
                              userImagePath = file.path;
                              log(userImagePath!);
                            });
                          });
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Icon(Icons.camera_alt_outlined, size: 26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    username,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),

                  Text(
                    motivationQuote,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Text(
              'Profile Info',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 24),
            ListTileWidget(
              onTap: () async {
                final bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => UserDetails(
                          username: username,
                          motivationQuote: motivationQuote,
                        ),
                  ),
                );
                if (result != null && result) {
                  _loadData();
                }
              },
              title: 'User Details',
              iconData: Icons.arrow_forward,
              svgAssetPath: 'assets/svg/profile_icon.svg',
            ),

            Divider(thickness: 1),

            ListTileWidget(
              svgAssetPath: 'assets/svg/dark_icon.svg',

              title: 'Dark Mode',
              switchWidget: Switch(
                activeTrackColor: Color(0xff15B86C),
                value: isDarkMode,
                onChanged: (value) async {
                  setState(() {
                    isDarkMode = value;

                    ThemeController.notifierthem.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  });
                  await PreferencesManager().setBool(StorageKey.theme, value);
                },
              ),
            ),

            Divider(thickness: 1),

            ListTileWidget(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomScreen()),
                  (Route<dynamic> route) => false,
                );
              },

              svgAssetPath: 'assets/svg/log_out_icon.svg',

              title: 'Log Out',
              iconData: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDilog(
    BuildContext context,
    Function(XFile) selectedFile,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Choose Image Source'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(16),

              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null && image.path.isNotEmpty) {
                  selectedFile(image);
                  log(image.path);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null && image.path.isNotEmpty) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 8),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newfile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString(StorageKey.userimage, newfile.path);
    log(newfile.path);
  }
}
