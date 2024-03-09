import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/admin/home/presentation/widgets/home_body.dart';
import 'package:fellowship/features/features.dart';
import 'package:provider/provider.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({super.key});
  static const String route = 'member-home';

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.member.getMemberDetails();
      context.member.getAllMembers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Consumer<MemberNotifier>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'Hello ${viewModel.member?.name.getFirstName() ?? 'there'},',
                fontSize: kfsExtraLarge,
                fontWeight: w600,
              ),
              vSpace(kXtremeLarge),
              TextFieldWidget(
                hintText: searchMembers,
                onChanged: viewModel.updateSearchQuery,
              ),
              vSpace(kXtremeLarge),
              HomeBody(
                members: viewModel.filteredMembers,
                currentMemberId: viewModel.currentMemberId,
                isMember: true,
              ),
            ],
          );
        },
      ),
      useSingleScroll: false,
    );
  }
}
