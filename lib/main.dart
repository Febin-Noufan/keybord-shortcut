import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Shortcuts',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Focus nodes for text fields and button
  final FocusNode nameFocus = FocusNode();
  final FocusNode ageFocus = FocusNode();
  final FocusNode placeFocus = FocusNode();
  final FocusNode numberFocus = FocusNode();
  final FocusNode bloodGroupFocus = FocusNode();
  final FocusNode genderFocus = FocusNode();
  final FocusNode buttonFocus = FocusNode(); // Focus node for button

  // Whether to show tooltips or allow shortcuts
  bool showTooltips = false;
  bool altPressed = false; // Track Alt key press state

  // Map of shortcuts to focus nodes
  late final Map<String, FocusNode> shortcutMap;

  @override
  void initState() {
    super.initState();
    shortcutMap = {
      'n': nameFocus,
      'a': ageFocus,
      'p': placeFocus,
      'm': numberFocus,
      'b': bloodGroupFocus,
      'g': genderFocus,
      's': buttonFocus, // Shortcut for button
    };
  }

  void handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      // If the Alt key is pressed
      if (event.logicalKey == LogicalKeyboardKey.altLeft || event.logicalKey == LogicalKeyboardKey.altRight) {
        setState(() {
          altPressed = !altPressed; // Toggle Alt key press state
          showTooltips = altPressed; // Show tooltips only when Alt is pressed
        });
      } else if (!event.isAltPressed && altPressed) {
        // Handle shortcut keys when Alt is pressed
        String keyLabel = event.logicalKey.keyLabel.toLowerCase();
        if (shortcutMap.containsKey(keyLabel)) {
          shortcutMap[keyLabel]!.requestFocus();
          if (keyLabel == 's') {
            // Simulate button press when Alt + S is pressed
            handleSubmit();
          }
        }
      }
    }
  }

  void handleSubmit() {
    // Handle submit action here, for example, print input values or validate
    print("Submit button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(), // Focus node for keyboard events
      onKey: handleKeyPress,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Keyboard Shortcuts Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                focusNode: nameFocus,
                decoration: InputDecoration(
                  labelText: 'Name',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + N', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: ageFocus,
                decoration: InputDecoration(
                  labelText: 'Age',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + A', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: placeFocus,
                decoration: InputDecoration(
                  labelText: 'Place',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + P', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: numberFocus,
                decoration: InputDecoration(
                  labelText: 'Number',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + M', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: bloodGroupFocus,
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + B', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                focusNode: genderFocus,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  suffixIcon: showTooltips ? Tooltip(message: 'Alt + G', child: Icon(Icons.keyboard)) : null,
                ),
              ),
              SizedBox(height: 20),
              // Submit button
              Focus(
                focusNode: buttonFocus,
                child: ElevatedButton(
                  onPressed: handleSubmit,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}