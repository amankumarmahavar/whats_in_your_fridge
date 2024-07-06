import 'package:flutter/material.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.suggessions,
  });

  final List<String> suggessions;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kGraywhite),
                ),
                Image.asset(
                  'assets/images/chef.png',
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: EdgeInsets.symmetric(vertical: 21, horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(
                  color: kBlack,
                ),
                borderRadius:
                    BorderRadius.circular(22).copyWith(topLeft: Radius.zero)),
            child: Text(
              'Check your fridge and get ready for the journy !!!',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: suggessions.map((suggesstion) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 21.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: kPink,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(suggesstion),
                  );
                }).toList()),
          ),
          // AssistantMic()
        ],
      ),
    );
  }
}
