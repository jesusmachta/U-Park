import 'package:flutter/material.dart';

class ParkingCardAvailability extends StatelessWidget {
  final String name;
  final int available;
  final int total;

  const ParkingCardAvailability({
    super.key,
    required this.name,
    required this.available,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    Color availableColor;
    if (available == 0) {
      availableColor = Colors.red; 
    } else if(available>= total/2){
      availableColor = Colors.green; 
    }
    else {
      availableColor = Colors.orange; 
    }

    return Center( 
  child: LayoutBuilder(
    builder: (context, constraints) {
      
      final cardWidth = constraints.maxWidth > 600
          ? 600.0 
          : (constraints.maxWidth * 0.9).toDouble(); 

      return Container(
        key: ValueKey(name),
        width: cardWidth,  
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.02,
          horizontal: size.width * 0.05,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, -4),
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título del estacionamiento en mayúsculas
                Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Row para mostrar disponibilidad y total de espacios
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$available',
                      style: TextStyle(
                        fontSize: size.width * 0.12,
                        fontWeight: FontWeight.bold,
                        color: availableColor,
                      ),
                    ),
                    Text(
                      '/$total',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
);
  }
}
