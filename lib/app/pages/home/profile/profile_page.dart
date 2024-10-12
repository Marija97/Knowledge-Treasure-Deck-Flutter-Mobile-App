import 'package:flutter/material.dart';

import '../../../widgets/button.dart';
import '../../../widgets/text.dart';

class ProfilePage extends StatelessWidget {
  void _uploadAPhoto() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const Spacer(),
        AppText.large('Profile :)'),
        const SizedBox(height: 20),
        AppButton(title: 'Upload photo', onTap: _uploadAPhoto),
        const Spacer(),
      ]),
    );
  }
}
