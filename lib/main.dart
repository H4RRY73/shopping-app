import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 213, 117, 39)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> cartItems = []; // Lista de productos en el carrito

  // Agregar producto al carrito
  void _addToCart(String product) {
    setState(() {
      cartItems.add(product);
    });
  }

  // Quitar producto del carrito
  void _removeFromCart(String product) {
    setState(() {
      cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // Lista de productos (StatelessWidget)
          Expanded(child: ProductList(onAddToCart: _addToCart)),
          // Vista del carrito (StatefulWidget)
          Cart(
            cartItems: cartItems,
            onRemoveFromCart: _removeFromCart,
          ),
        ],
      ),
    );
  }
}

// StatelessWidget: Lista de productos
class ProductList extends StatelessWidget {
  final Function(String) onAddToCart;

  // Lista de productos
  final List<String> products = [
    'Leche',
    'Arroz',
    'Sal',
    'Aceite',
    'Azúcar',
    'Huevos',
  ];

  ProductList({required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]),
          trailing: Icon(Icons.add_shopping_cart),
          onTap: () {
            onAddToCart(products[index]); // Llamada a la función para agregar
          },
        );
      },
    );
  }
}

// StatefulWidget: Vista del carrito
class Cart extends StatefulWidget {
  final List<String> cartItems;
  final Function(String) onRemoveFromCart;

  const Cart({required this.cartItems, required this.onRemoveFromCart});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        border: Border(
          top: BorderSide(color: const Color.fromARGB(255, 61, 76, 83)),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Carrito (${widget.cartItems.length} productos)',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (widget.cartItems.isEmpty)
            const Text('Tu carrito está vacío'),
          if (widget.cartItems.isNotEmpty)
            Column(
              children: widget.cartItems
                  .map(
                    (item) => ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          widget.onRemoveFromCart(item); // Remover producto
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}