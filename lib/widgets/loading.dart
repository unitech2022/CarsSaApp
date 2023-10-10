
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



void showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.1),
      builder: (context) {
        return  const LoadingDialog();
      });
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 10);
    Curve insetAnimationCurve = Curves.bounceIn;

    // RoundedRectangleBorder _defaultDialogShape = const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(20.0)));

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,

      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child:  const SpinKitDoubleBounce(
          color: homeColor,
          size: 70,

        ),
      ),
    );
  }
}


class LoadPhoto2 extends StatelessWidget {
final  String photoUrl;
  var w;
 final double h;
  final enabled;


  LoadPhoto2(this.photoUrl, this.h,{this.w,this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return enabled? GestureDetector(

      onTap: (){
        // pushPage(context:context,page: PhotoViewWidget(photoUrl));

      },
      child: Material(
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            child: Center(
              child: SpinKitDoubleBounce(
                color: homeColor,
                size: 30,

              ),
            ),
            width: h,
            height:w==null? h:w,
            // padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Material(
            child: Container(),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            clipBehavior: Clip.hardEdge,
          ),
          imageUrl: photoUrl,
          width: h,
          height: h,
          fit: BoxFit.cover,
        ),
      ),
    ):Material(
      child: CachedNetworkImage(
        placeholder: (context, url) => Container(
          child: Center(
            child: SpinKitDoubleBounce(
              color: homeColor,
              size: 30,

            ),
          ),
          width: h,
          height:w==null? h:w,
          // padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Material(
          child: Image.asset(
            'assets/images/logo.png',
            width: w,
            height: h,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          clipBehavior: Clip.hardEdge,
        ),
        imageUrl: photoUrl,
        width: h,
        height: h,
        fit: BoxFit.cover,
      ),
    );
  }
}

