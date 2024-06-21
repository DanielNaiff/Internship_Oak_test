import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_inventory_internship_oak_tecnologia/models/product.dart';
import 'package:product_inventory_internship_oak_tecnologia/state/product_state.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final int? index;

  ProductForm({this.product, this.index});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late bool _availableForSale;
  late String? _imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController = TextEditingController(text: widget.product!.name);
      _descriptionController =
          TextEditingController(text: widget.product!.description);
      _priceController =
          TextEditingController(text: widget.product!.price.toString());
      _availableForSale = widget.product!.availableForSale;
      _imagePath = widget.product!.imagePath;
    } else {
      _nameController = TextEditingController();
      _descriptionController = TextEditingController();
      _priceController = TextEditingController();
      _availableForSale = true;
      _imagePath = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final String imagePath = pickedFile.path;
        setState(() {
          _imagePath = imagePath;
        });
      }
    } catch (e) {
      print('Erro ao selecionar imagem: $e');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        availableForSale: _availableForSale,
        imagePath: _imagePath,
      );
      if (widget.index == null) {
        Provider.of<ProductProvider>(context, listen: false)
            .addProduct(newProduct);
      } else {
        Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(widget.index!, newProduct);
      }
      Navigator.of(context).pop(); // Fechar a tela de formulário
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? 'Cadastrar Produto' : 'Editar Produto',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Descrição do Produto'),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration:
                    const InputDecoration(labelText: 'Valor do Produto'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              SwitchListTile(
                title: const Text('Disponível para Venda'),
                value: _availableForSale,
                onChanged: (value) {
                  setState(() {
                    _availableForSale = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Exibição da imagem selecionada
              _imagePath != null && _imagePath!.isNotEmpty
                  ? Image.network(_imagePath!)
                  : const Text('Nenhuma imagem selecionada'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Selecionar Imagem'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.product == null ? 'Cadastrar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
