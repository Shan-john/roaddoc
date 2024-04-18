import 'package:flutter/material.dart';
import 'package:roaddoc/core/images.dart';
import 'package:roaddoc/models/user_model/user_model.dart';

NetworkImage avatarImageProvider({required UserModel model}) {
  return model.image == null
      ? NetworkImage(personAvatar)
      : model.image == ""
          ? NetworkImage(personAvatar)
          : NetworkImage(model.image!);
}
