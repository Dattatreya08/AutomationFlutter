import 'package:flutter/material.dart';

/*
Below class generate image by taking image path value as String,
 image Width as double, image height as double and opacity as double values
 from the constructor call for initializing the instance variables img,
  width, height, opacity
 */

class CreateImage extends StatelessWidget {
  final String img;
  final double? width;
  final double? height;
  final double?opacity;
  const CreateImage(this.img,{this.width,this.height,this.opacity,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return generateImage(img,imgWidth:width,imgHeight:height,imgOpacity:opacity);
  }

  Image generateImage(String image,{double? imgWidth,double? imgHeight,double? imgOpacity}){
    AssetImage assetImage=AssetImage(img);
    Image image=Image(image: assetImage,width: imgWidth,height: imgHeight,);
    return image;
  }

}

class CreateText extends StatelessWidget {
  final String text;
  const CreateText(String this.text,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CreateIconButton extends StatelessWidget {
  final dynamic chooseIcon;
  final Function functionality;
  final dynamic iconColor;
  final double? iconSize;
  const CreateIconButton(this.functionality,this.chooseIcon,{this.iconColor,this.iconSize,Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      this.functionality;
      },
      icon: Icon(chooseIcon),
      color:iconColor,
      iconSize:iconSize,
      splashRadius: 0,
      splashColor: Colors.transparent,
    );
  }
}


class CreateIcon extends StatelessWidget {
  final dynamic chooseIcon;
  final iconSize;
  final iconColor;
  const CreateIcon(this.chooseIcon,{this.iconSize, this.iconColor, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Icon(chooseIcon,size:iconSize , color:iconColor ,);
  }
}


