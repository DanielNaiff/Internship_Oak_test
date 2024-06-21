import 'package:flutter/material.dart';
import 'package:product_inventory_internship_oak_tecnologia/screens/list_products.dart';
import 'package:product_inventory_internship_oak_tecnologia/state/product_state.dart';
import 'package:product_inventory_internship_oak_tecnologia/state/theme_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Cadastro de Produtos',
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: ProductList(),
          );
        },
      ),
    );
  }
}
