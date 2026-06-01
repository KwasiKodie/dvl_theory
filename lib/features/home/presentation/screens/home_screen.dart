import 'package:flutter/material.dart';
import '../../widgets/home_header_section.dart';
import '../../../../shared/widgets/action_card.dart';
import '../../../../shared/navigation/app_bottom_navigation.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final width = media.size.width;
    final height = media.size.height;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: theme.colorScheme.background,
              foregroundColor: theme.colorScheme.onBackground,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              floating: false,
              stretch: true,
              automaticallyImplyLeading: false,
              expandedHeight: isTablet ? 260 : 220,
              collapsedHeight: 80,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: Padding(
                  padding: EdgeInsets.only(top: height * 0.03),
                  child: const HomeHeaderSection(userName: 'Kwasi'),
                ),
                titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    final collapsed = constraints.biggest.height <= 120;

                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: collapsed ? 1 : 0,
                      child: AnimatedSlide(
                        duration: const Duration(milliseconds: 250),
                        offset: collapsed ? Offset.zero : const Offset(0, 0.5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/shared/logo.png',
                              width: 30,
                            ),
                            const SizedBox(width: 10),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'DVL',
                                    style: TextStyle(
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'THEORY',
                                    style: TextStyle(
                                      color: Color.fromRGBO(249, 52, 26, 0.965),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? width * 0.08 : 16,
                vertical: 18,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  HomeActionCard(
                    title: "Start Practice Test",
                    subtitle: "Quick practice to sharpen your knowledge",
                    color: Colors.blue,
                    icon: Icons.assignment,
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.practice),
                  ),
                  HomeActionCard(
                    title: "Start Mock Exam",
                    subtitle: "Real exam simulation just like the real test",
                    color: Colors.green,
                    icon: Icons.school,
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.mockExam),
                  ),
                  HomeActionCard(
                    title: "Continue Learning",
                    subtitle: "Pick up where you left off",
                    color: Colors.orange,
                    icon: Icons.menu_book,
                    onTap: () {},
                  ),
                  HomeActionCard(
                    title: "View Progress",
                    subtitle: "Track your performance and improvement",
                    color: Colors.purple,
                    icon: Icons.bar_chart,
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.progress),
                  ),
                  HomeActionCard(
                    title: "Review Wrong Answers",
                    subtitle: "Learn from your mistakes and get better",
                    color: Colors.red,
                    icon: Icons.assignment_turned_in,
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.review),
                  ),
                  SizedBox(height: height * 0.03),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
