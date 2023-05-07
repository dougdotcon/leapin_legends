import 'package:flappy_game/config/const.dart';
import 'package:flappy_game/features/game/presentation/blocs/bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../config/route.dart';
import '../blocs/user/user_bloc.dart';
import '../widget/custom_button_widget.dart';
import '../widget/custom_textfield_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/logo_widget.dart';
import '../widget/text_carousel_widget.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: darkGray,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: 400.w,
              ),
              child: IntrinsicHeight(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const LogoWidget(),
                      Gap(20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            const TextCarousel(),
                            Gap(10.h),
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, userState) {
                                return userState.loading
                                    ?
                                    //loading
                                    const LoadingWidget()
                                    : userState.user == null
                                        ?
                                        //user not authenticated
                                        Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: CustomTextField(
                                                      userNameController: userNameController,
                                                      hint: 'Username',
                                                      icon: Icons.person,
                                                      textFieldTitle: userState.userExists ? 'Username already exists' : 'Type username',
                                                    ),
                                                  ),
                                                  Gap(10.h),
                                                  Expanded(
                                                    flex: 2,
                                                    child: CustomButton(
                                                      color: Colors.white,
                                                      icon: Icons.person_add_alt_1_rounded,
                                                      text: 'Add user',
                                                      onPressed: () {
                                                        if (userNameController.text.isNotEmpty) {
                                                          context.read<UserBloc>().add(AddUserEvent(name: userNameController.text));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Gap(40.h),
                                            ],
                                          )
                                        :
                                        //user authenticated
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              CustomButton(
                                                color: darkGray,
                                                icon: Icons.play_arrow_rounded,
                                                text: 'Start game',
                                                onPressed: () {
                                                  Navigator.pushNamedAndRemoveUntil(context, gameView, (route) => false);
                                                },
                                              ),
                                              Gap(40.h),
                                            ],
                                          );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
