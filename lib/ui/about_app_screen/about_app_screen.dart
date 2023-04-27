import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/models/setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../my_profile_screen/componts/container_profile_text.dart';


class AboutAppScreen extends StatefulWidget {
  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getSitting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: homeColor,
          ),
        ),
        title: const Text(
          "عن التطبيق",
          style: TextStyle(color: homeColor, fontFamily: "pnuR"),
        ),
      ),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return AppCubit.get(context).loadSittings
              ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: homeColor,
            ),
          )
              : ListView.builder(
            itemCount: AppCubit.get(context).sittings.length,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (BuildContext context, int index) {
              SittingModel sittingModel=AppCubit.get(context).sittings[index];
              return ContainerProfileText(
                text: sittingModel.name!,
                icon: Icons.info,
                isIcon: true,
                onPress: () {


                  if(index==0){

                  }else if(index==1){
                    print("policy");

                  }


                },
              );
            },
          );
        },
      ),
    );
  }
}
