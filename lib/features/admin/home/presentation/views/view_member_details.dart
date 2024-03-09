import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:flutter/services.dart';

class ViewMemberDetails extends StatelessWidget {
  const ViewMemberDetails({super.key, required this.member});

  final AddMemberParams member;

  static const String route = 'view-details';
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        children: [
          _Header(name: member.name),
          _Body(member),
        ],
      ),
      safeAreaTop: false,
      useSingleScroll: true,
      usePadding: false,
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.member);

  final AddMemberParams member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding1,
      child: Column(
        children: [
          vSpace(kGlobalPadding),
          _Tile(
            title: 'Name: ',
            trailing: member.name,
          ),
          vSpace(kfsMedium),
          _Tile(
            title: 'Phone Number: ',
            trailing: member.phoneNumber,
          ),
          vSpace(kfsMedium),
          _Tile(
            title: 'Address: ',
            trailing: member.address,
          ),
          vSpace(kfsMedium),
          _Tile(
            title: 'Gender: ',
            trailing: member.gender == 'male' ? 'Male' : 'Female',
          ),
          vSpace(kfsMedium),
          if (!member.isCurrentMember) ...[
            _Tile(
              title: 'Unique ID: ',
              trailing:
                  '${member.name}${member.phoneNumber.substring(member.phoneNumber.length - 2)}',
            ),
            verticalGap(screenHeight * .14),
            Button(
              onTap: () async {
                await Clipboard.setData(
                  ClipboardData(
                    text:
                        '${member.name}${member.phoneNumber.substring(member.phoneNumber.length - 2)}',
                  ),
                );
                Toast.showSuccessToast(
                    message: 'Unique ID successfully copied!');
              },
              text: 'Copy Unique ID',
            ),
          ],
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.trailing,
  });
  final String title;
  final String trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title,
          fontSize: kfsMedium,
          fontWeight: w400,
        ),
        SizedBox(
          width: screenWidth * .5,
          child: TextWidget(
            trailing,
            textAlign: TextAlign.end,
            fontSize: kfsMedium,
            maxLines: 3,
            fontWeight: w700,
            textColor: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'view-details-$name',
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Container(
              height: screenHeight * .4,
              color: kBg4.withOpacity(.2),
              child: Center(
                child: TextWidget(
                  name.getInitials(),
                  fontWeight: FontWeight.w600,
                  fontSize: kfs100,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * .06,
              left: kfsMedium,
              child: const BackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
