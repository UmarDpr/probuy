import 'package:flutter/material.dart';

import '../style/common_size.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return  Center(child:
    Image.network(
      'https://firebasestorage.googleapis.com/v0/b/probuy-728a9.appspot.com/o/products%2F1719934006269_shirt.png?alt=media&token=aeaaf238-7b6b-4849-afca-1a2efc5b437d',
      // height: displayHeight(context) * 0.25,
      // fit: BoxFit.fitHeight,
      // loadingBuilder: (BuildContext context,
      //     Widget child,
      //     ImageChunkEvent? loadingProgress) {
      //   if (loadingProgress == null) {
      //     return child;
      //   }
      //   return Center(
      //     child: CircularProgressIndicator(
      //       value: loadingProgress
      //           .expectedTotalBytes !=
      //           null
      //           ? loadingProgress
      //           .cumulativeBytesLoaded /
      //           (loadingProgress
      //               .expectedTotalBytes ??
      //               1)
      //           : null,
      //     ),
      //   );
      // },
      // errorBuilder: (BuildContext context,
      //     Object error, StackTrace? stackTrace) {
      //   print(error);
      //   return const Icon(Icons.error);
      // },
    ),
    );
  }
}
