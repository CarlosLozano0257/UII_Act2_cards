import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MiCarritoApp(),
  ));
}

class Producto {
  final String titulo;
  final String subtitulo;
  final String imgUrl;
  int cantidad;
  final double precio;

  Producto({
    required this.titulo,
    required this.subtitulo,
    required this.imgUrl,
    required this.cantidad,
    required this.precio,
  });
}

class MiCarritoApp extends StatefulWidget {
  const MiCarritoApp({super.key});

  @override
  State<MiCarritoApp> createState() => _MiCarritoAppState();
}

class _MiCarritoAppState extends State<MiCarritoApp> {
  final List<Producto> juegos = [
    Producto(titulo: "Minecraft", subtitulo: "Mundo abierto", imgUrl: "https://raw.githubusercontent.com/CarlosLozano0257/Imagenes-para-flutter-6J-11-02-2026/refs/heads/main/mclogo.jpg", cantidad: 2, precio: 29.99),
    Producto(titulo: "Roblox", subtitulo: "Plataforma", imgUrl: "https://raw.githubusercontent.com/CarlosLozano0257/Imagenes-para-flutter-6J-11-02-2026/refs/heads/main/rblxlogo.jpg", cantidad: 1, precio: 10.00),
    Producto(titulo: "Fortnite", subtitulo: "Battle Royale", imgUrl: "https://raw.githubusercontent.com/CarlosLozano0257/Imagenes-para-flutter-6J-11-02-2026/refs/heads/main/fort.jpg", cantidad: 3, precio: 15.50),
  ];

  double calcularSubtotal() {
    return juegos.fold(0, (sum, item) => sum + (item.precio * item.cantidad));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo gris claro para que resalten las cartas
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Center(
          child: Text("G", style: TextStyle(color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        actions: const [
          Icon(Icons.shopping_cart_outlined, color: Colors.blue),
          SizedBox(width: 15),
          Icon(Icons.account_circle, color: Colors.black, size: 30),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Mi Carrito", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            // Lista de tarjetas
            Expanded(
              child: ListView(
                children: juegos.map((juego) => TarjetaJuego(
                  producto: juego,
                  onUpdate: () => setState(() {}),
                )).toList(),
              ),
            ),

            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("\$${calcularSubtotal().toStringAsFixed(2)}", 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 15),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: const Center(
                child: Text("Metodo de Pago", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border, size: 30), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 30), label: ""),
        ],
      ),
    );
  }
}

class TarjetaJuego extends StatelessWidget {
  final Producto producto;
  final VoidCallback onUpdate;

  const TarjetaJuego({super.key, required this.producto, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Sombreado de la tarjeta
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Imagen con borde
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(producto.imgUrl, width: 70, height: 70, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 15),
            
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(producto.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(producto.subtitulo, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text("\$${producto.precio}", style: const TextStyle(fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Controles de cantidad
            Row(
              children: [
                GestureDetector(
                  onTap: () { if (producto.cantidad > 0) { producto.cantidad--; onUpdate(); } },
                  child: const CircleAvatar(radius: 12, backgroundColor: Colors.blue, child: Icon(Icons.remove, size: 16, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text("${producto.cantidad}"),
                  ),
                ),
                GestureDetector(
                  onTap: () { producto.cantidad++; onUpdate(); },
                  child: const CircleAvatar(radius: 12, backgroundColor: Colors.blue, child: Icon(Icons.add, size: 16, color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}