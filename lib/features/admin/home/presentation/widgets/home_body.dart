import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/features.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.members,
    this.currentMemberId,
    this.isMember = false,
  });

  final List<AddMemberParams> members;
  final String? currentMemberId;
  final bool isMember;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          context.home.refresh();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: switch (members.isEmpty) {
            true => const _EmptyState(),
            false => Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, _) => vSpace(kfsMedium),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: members.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return _MembersTile(
                        name: member.name,
                        isCurrentMember: currentMemberId ==
                            '${member.name}${member.phoneNumber.substring(member.phoneNumber.length - 2)}',
                        address: member.address,
                        onTap: () => goTo(
                          ViewMemberDetails.route,
                          arguments: member.copyWith(
                            isCurrentMember: isMember,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          },
        ),
      ),
    );
  }
}

class _MembersTile extends StatelessWidget {
  const _MembersTile({
    required this.name,
    required this.address,
    required this.onTap,
    this.isCurrentMember = false,
  });

  final String name;
  final String address;
  final VoidCallback onTap;
  final bool isCurrentMember;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Hero(
            tag: 'view-details-$name',
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                height: h(kfs70),
                width: w(kfs70),
                decoration: BoxDecoration(
                  color: kBg4.withOpacity(.2),
                  borderRadius: BorderRadius.circular(sr(kMinute)),
                ),
                child: Center(
                  child: TextWidget(
                    name.getInitials(),
                    fontWeight: w600,
                    fontSize: kGlobalPadding,
                  ),
                ),
              ),
            ),
          ),
          hSpace(kfsMedium),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  isCurrentMember ? 'You' : name,
                  fontWeight: w500,
                ),
                vSpace(kMinute),
                SizedBox(
                  width: screenWidth * .6,
                  child: TextWidget(
                    address,
                    fontSize: kfsVeryTiny,
                    textColor: kTextColor4,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Icon(CupertinoIcons.chevron_forward)
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(emptyMember),
        const TextWidget(
          'You have no members in your fellowship\nyet.',
          textAlign: TextAlign.center,
          fontWeight: w600,
        )
      ],
    );
  }
}
