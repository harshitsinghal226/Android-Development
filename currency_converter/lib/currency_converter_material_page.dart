import 'package:flutter/material.dart';

/*
 * 1. Create a new variable that stores the converted currency value
 * 2. Create a function that multiplies the value given in the textfield by 90
 * 3. stores the value in the variable  that we created 
 * 4. display the variable
 */

class MaterialHomePage  extends StatefulWidget {
  const MaterialHomePage({super.key});

  @override
  State<MaterialHomePage> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<MaterialHomePage> {
  double result = 0; // Variable to store the converted currency value
  final TextEditingController textEditingController = TextEditingController();

  // @override
  // void initState() {
  //   // super.initState() is called to initialize the state of the widget
  //   super.initState();    

  // }

  @override
  void dispose() {
    // Dispose of the text editing controller to free up resources
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 2.0, style: BorderStyle.solid),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text('Currency Converter', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'INR ${result != 0 ? result.toStringAsFixed(2) : result.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),

            //padding
            //container
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter Amount want convert in rupees',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.attach_money),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),

            /**button
               * 1. raised
               * 2. appear as text
               */
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Call setState to update the UI
                    result = (double.parse(textEditingController.text) * 86.07);  
                  });
                },

                /**method one to style button */
                // style: ButtonStyle(
                //   backgroundColor: const WidgetStatePropertyAll(Colors.black),
                //   foregroundColor: const WidgetStatePropertyAll(Colors.white),
                //   minimumSize: const WidgetStatePropertyAll(
                //     Size(double.infinity, 50),
                //   ),
                //   shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                /**method two to style button */
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





/**below code is for stateless which is not mutable */
/*
class MaterialHomePagee extends StatelessWidget {
  const MaterialHomePagee({super.key});

  @override
  Widget build(BuildContext context) {
    double result = 0; // Variable to store the converted currency value
    final TextEditingController textEditingController = TextEditingController();

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 2.0, style: BorderStyle.solid),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: const Text('Currency Converter', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.toString(),
              style: const TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),

            //padding
            //container
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter Amount want convert in rupees',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.attach_money),
                  prefixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),

            /**button
               * 1. raised
               * 2. appear as text
               */
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  // debug, release, profile
                  result = (double.parse(textEditingController.text) * 86.07);
                  build(context); // Rebuild the widget to update the UI
                },

                /**method one to style button */
                // style: ButtonStyle(
                //   backgroundColor: const WidgetStatePropertyAll(Colors.black),
                //   foregroundColor: const WidgetStatePropertyAll(Colors.white),
                //   minimumSize: const WidgetStatePropertyAll(
                //     Size(double.infinity, 50),
                //   ),
                //   shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
                /**method two to style button */
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
