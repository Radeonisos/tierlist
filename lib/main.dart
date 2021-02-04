import 'package:flutter/material.dart';
import 'package:flutter_app/pages/category_page.dart';
import 'package:flutter_app/pages/classement_page.dart';
import 'package:flutter_app/pages/sub_category_page.dart';
import 'package:flutter_app/providers/catgories_provider.dart';
import 'package:flutter_app/providers/item_provider.dart';
import 'package:flutter_app/providers/sub_categories_provider.dart';
import 'package:provider/provider.dart';

import 'pages/add_item_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final heroC = HeroController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriesProviders()),
        ChangeNotifierProvider(create: (_) => SubCategoriesProviders()),
        ChangeNotifierProvider(create: (_) => ItemProvider())
      ],
      child: MaterialApp(
        title: 'Tier List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CategoryPage(),
        onGenerateRoute: (RouteSettings settings) {
          print('build route for ${settings.name}');
          var routes = <String, WidgetBuilder>{
            CategoryPage.routeName: (ctx) => CategoryPage(),
            SubCategoryPage.routeName: (ctx) =>
                SubCategoryPage(settings.arguments),
            ClassementPage.routeName: (ctx) => ClassementPage(
                (settings.arguments as Map)['subCategory'],
                (settings.arguments as Map)['imgCategory']),
            AddItemPage.routeName: (ctx) => AddItemPage(settings.arguments),
          };
          WidgetBuilder builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder(ctx));
        },
      ),
    );
  }
}
