import 'package:flutter/material.dart';
import 'package:product_inventory_internship_oak_tecnologia/screens/form_products.dart';
import 'package:product_inventory_internship_oak_tecnologia/state/product_state.dart';
import 'package:product_inventory_internship_oak_tecnologia/state/theme_state.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return ListTile(
                leading: product.imagePath != null
                    ? Image.network(
                        product.imagePath!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey[200],
                        child: Icon(Icons.image),
                      ),
                title: Text(product.name),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('R\$ ${product.price.toStringAsFixed(2)}'),
                    product.availableForSale
                        ? const Text(
                            'O produto está disponível para compra',
                            style: TextStyle(fontSize: 10),
                          )
                        : const Text(
                            'O produto não está disponível para compra',
                            style: TextStyle(fontSize: 10),
                          )
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductForm(
                              product: product,
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Provider.of<ProductProvider>(context, listen: false)
                            .deleteProduct(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
