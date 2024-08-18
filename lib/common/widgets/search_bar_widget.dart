import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/main/presentation/screens/search_data_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 44,
          color: theme.searchViewTheme.backgroundColor!,
          child: TextField(
                  onSubmitted: (name) async{
                    await Navigator.of(context).pushNamed(SearchDataScreen.routeName,arguments: name);
                  },
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  maxLines: 1,
                  cursorColor: Colors.grey,
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
                  decoration:  InputDecoration(
                      hintMaxLines: 1,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(
                          size: 30,
                          CupertinoIcons.search,
                          color: Colors.black54,
                        ),
                      ),
                      hintText: 'فیلم خاصی مد نظرته؟',
                      hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize: 12),

                      border: InputBorder.none
                  ),
                ),
        ),
      ),
    );
  }
}
