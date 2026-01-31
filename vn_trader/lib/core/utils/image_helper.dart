import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vn_trader/core/constants/index.dart';

class ImageHelper {
  static Widget loadFromAsset(
      String imageFilePath, {
        double? width,
        double? height,
        BorderRadius? radius,
        BoxFit? fit,
        Color? tinColor,
        Alignment? alignment
      }) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(0),
      child: Image.asset(
        imageFilePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: tinColor,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }
  //
  static Widget loadFromUrl(
      String imageFilePath, {
        double? width,
        double? height,
        BorderRadius? radius,
        BoxFit? fit,
        Color? tinColor,
        Alignment? alignment
      }){
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageFilePath,
        fit:  fit ?? BoxFit.fill,
        width: width,
        height: height,
        placeholder: (context, url) {
          return Center(child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ));
        } ,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}