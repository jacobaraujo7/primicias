import 'package:body/config/routes/route_extension.dart';
import 'package:body/ui/notification/notification_page.dart';
import 'package:body/ui/start/config/config_page.dart';
import 'package:body/ui/start/faq/faq_page.dart';
import 'package:body/ui/start/home/home_page.dart';
import 'package:body/ui/start/perfil/perfil_page.dart';
import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://cdn.awsli.com.br/2626/2626174/logo/design-sem-nome-sx1b37pn14.png',
            fit: BoxFit.contain,
          ),
        ),
        title: const Text('Araújo Cestas'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('2'),
              child: Icon(UIcons.regularRounded.bell),
            ),
            onPressed: () {
              context.push(const NotificationPage());
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [HomePage(), FaqPage(), PerfilPage(), ConfigPage()],
      ),

      bottomNavigationBar: ListenableBuilder(
        listenable: _pageController,
        builder: (context, _) {
          return NavigationBar(
            onDestinationSelected: _pageController.jumpToPage,
            selectedIndex: _pageController.page?.round() ?? 0,
            destinations: [
              NavigationDestination(
                icon: Icon(UIcons.regularRounded.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(UIcons.regularRounded.info),
                label: 'Dúvidas',
              ),
              NavigationDestination(
                icon: Icon(UIcons.regularRounded.user),
                label: 'Perfil',
              ),
              NavigationDestination(
                icon: Icon(UIcons.regularRounded.settings),
                label: 'Config',
              ),
            ],
          );
        },
      ),
    );
  }
}
