import 'package:fellowship/core/core.dart';
import 'package:fellowship/features/admin/home/presentation/widgets/home_body.dart';
import 'package:fellowship/features/features.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String route = 'home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.home.getUser();
      context.home.getMembers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Consumer<HomeNotifier>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        '$hello ${viewModel.user?.fullName?.getFirstName() ?? 'there'},',
                        fontSize: kfsExtraLarge,
                        fontWeight: w600,
                      ),
                      vSpace(kMinute),
                      if (viewModel.user?.email != null)
                        SizedBox(
                          width: screenWidth * .8,
                          child: TextWidget(
                            'Your Admin ID is:\n${viewModel.user?.email ?? ''}',
                          ),
                        ),
                    ],
                  ),
                  GestureDetector(
                    onTap: context.auth.logOut,
                    child: signOutIcon.svg(kPrimaryColor),
                  ),
                ],
              ),
              vSpace(kXtremeLarge),
              TextFieldWidget(
                hintText: searchMembers,
                onChanged: viewModel.updateSearchQuery,
              ),
              vSpace(kXtremeLarge),
              HomeBody(
                members: viewModel.filteredMembers,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddMemberBS.show(context),
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.add,
          color: kWhiteColor,
        ),
      ),
      useSingleScroll: false,
    );
  }
}
