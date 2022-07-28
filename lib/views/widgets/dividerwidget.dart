part of 'widgets.dart';

Widget dividerWidget({String? text = 'Lorem ipsum dolor sit amet'}) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
          Text(
            text!,
            style: interheadline6.copyWith(color: spanishGray),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
