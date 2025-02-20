import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
//initial couter value
  int _counter = 20;
  final TextEditingController _controller = TextEditingController();
  final List<int> _counterHistory = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
//displays the current number
                '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  // I love ternary operators!!!!!
                  color: _counter == 0
                      ? Colors.red
                      : _counter >= 50
                          ? Colors.green
                          : Colors.black,
                ),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                if (_counter >= 0) _counter = value.toInt();
              });
              _checkForSuccess();
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Decrement'),
                onPressed: () {
                  setState(() {
                    if (_counter > 0) {
                      _counter -= 1;
                      _addToHistory();
                      _checkForSuccess();
                    }
                  });
                },
              ),
              SizedBox(width: 10), // Sets space between the buttons
              ElevatedButton(
                child: Text('Reset'),
                onPressed: () {
                  setState(() {
                    _counter = 0;
                    _addToHistory();
                  });
                },
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    int incrementValue = int.tryParse(_controller.text) ??
                        0; // Validate and convert input
                    if (_counter + incrementValue <= 100) {
                      _counter +=
                          incrementValue; // Increment by the entered value
                      _addToHistory();
                      _checkForSuccess();
                    } else {
                      _counter = 100;
                      _addToHistory();
                    }
                    if (_counter == 100) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Maximum limit reached!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      _checkForSuccess();
                    }
                  });
                },
                child: Row(
                  children: [
                    Text('+'),
                    SizedBox(
                        width: 10), // Space between text field and button label
                    Container(
                      width: 35, // Width of the text field inside the button
                      height: 30, // Height of the text field inside the button
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.number, // Numeric keyboard
                        decoration: InputDecoration(
                          hintText: '',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),

              ElevatedButton(
                  child: Text('Undo'),
                  onPressed: () {
                    setState(() {
                      if (_counterHistory.length > 1) {
                        _counterHistory.removeLast();
                        _counter = _counterHistory.last; // Revert to last value
                      }
                    });
                  })
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _counterHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Counter Value: ${_counterHistory[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addToHistory() {
    _counterHistory.add(_counter);

    // After the history is updated, scroll to the bottom
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _checkForSuccess() {
    if (_counter == 50 || _counter == 100) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have reached the target value of $_counter!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
