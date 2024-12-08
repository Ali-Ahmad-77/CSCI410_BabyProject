import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(BabyMonitorApp());
}

class BabyMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Monitor App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Baby Monitor',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedingPage()),
                );
              },
              child: Text('Feeding'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepingPage()),
                );
              },
              child: Text('Sleeping'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiaperChangingPage()),
                );
              },
              child: Text('Diaper Changing'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicinePage()),
                );
              },
              child: Text('Medicine'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedingPage extends StatefulWidget {
  @override
  _FeedingPageState createState() => _FeedingPageState();
}

class _FeedingPageState extends State<FeedingPage> {
  String feedingType = '';
  String quantity = '';
  String timeSpent = '';
  String result = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeding'),
        backgroundColor: Colors.blue, // Matches the theme
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Feeding',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type of Feeding:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Breastfeeding',
                        groupValue: feedingType,
                        onChanged: (value) {
                          setState(() {
                            feedingType = value!;
                          });
                        },
                      ),
                      Text('Breastfeeding', style: TextStyle(color: Colors.white)),
                      Radio<String>(
                        value: 'Bottle',
                        groupValue: feedingType,
                        onChanged: (value) {
                          setState(() {
                            feedingType = value!;
                          });
                        },
                      ),
                      Text('Bottle', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Quantity (mL):',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter quantity',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      quantity = value;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Time Spent (minutes):',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter time spent',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      timeSpent = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    errorMessage = ''; // Clear any previous error
                    try {
                      // Validate timeSpent input
                      final int time = int.parse(timeSpent);
                      if (time < 0) {
                        throw Exception('Time spent must be positive.');
                      }

                      // If valid, process data
                      result =
                      'Type: $feedingType\nQTY: $quantity mL\nTime: $time mins';
                    } catch (e) {
                      result = ''; // Clear result if invalid
                      errorMessage = e.toString().replaceAll('Exception: ', '');
                    }
                  });
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              SizedBox(height: 20),
              if (result.isNotEmpty)
                Text(
                  result,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}



class SleepingPage extends StatefulWidget {
  @override
  _SleepingPageState createState() => _SleepingPageState();
}

class _SleepingPageState extends State<SleepingPage> {
  // Timer-related variables
  bool isTimerRunning = false;
  int elapsedSeconds = 0;
  Timer? timer;

  // Manual entry variables
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  String manualDuration = '';
  String errorMessage = '';

  // Start the timer
  void startTimer() {
    if (!isTimerRunning) {
      setState(() {
        isTimerRunning = true;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          elapsedSeconds++;
        });
      });
    }
  }

  // Stop the timer
  void stopTimer() {
    if (isTimerRunning) {
      setState(() {
        isTimerRunning = false;
        timer?.cancel();
        timer = null;
      });
    }
  }

  // Calculate duration from manual input
  void calculateManualDuration() {
    setState(() {
      errorMessage = '';
      manualDuration = '';
    });

    try {
      // Parse and validate input times
      final startTimeParts = startTimeController.text.split(':');
      final endTimeParts = endTimeController.text.split(':');

      if (startTimeParts.length != 2 || endTimeParts.length != 2) {
        throw Exception('Invalid format! Use HH:MM.');
      }

      final startHour = int.parse(startTimeParts[0]);
      final startMinute = int.parse(startTimeParts[1]);
      final endHour = int.parse(endTimeParts[0]);
      final endMinute = int.parse(endTimeParts[1]);

      if (startHour < 0 || startHour > 23 || endHour < 0 || endHour > 23) {
        throw Exception('Hours must be between 0 and 23.');
      }
      if (startMinute < 0 || startMinute > 59 || endMinute < 0 || endMinute > 59) {
        throw Exception('Minutes must be between 0 and 59.');
      }

      final startInMinutes = startHour * 60 + startMinute;
      final endInMinutes = endHour * 60 + endMinute;

      if (endInMinutes <= startInMinutes) {
        throw Exception('End time must be after start time.');
      }

      // Calculate duration
      final durationInMinutes = endInMinutes - startInMinutes;
      final hours = durationInMinutes ~/ 60;
      final minutes = durationInMinutes % 60;

      setState(() {
        manualDuration = '${hours}h ${minutes}m';
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  // Convert elapsed seconds to H:M:S format
  String formatElapsedTime() {
    final hours = elapsedSeconds ~/ 3600;
    final minutes = (elapsedSeconds % 3600) ~/ 60;
    final seconds = elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleeping'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sleeping Tracker',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: startTimer,
                    child: Text('Start'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: stopTimer,
                    child: Text('Stop'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Elapsed Time: ${formatElapsedTime()}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 40),
              Text(
                'Manual Entry',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              TextField(
                controller: startTimeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Start Time (HH:MM)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 20),
              TextField(
                controller: endTimeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'End Time (HH:MM)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateManualDuration,
                child: Text('Calculate Duration'),
              ),
              SizedBox(height: 20),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              if (manualDuration.isNotEmpty)
                Text(
                  'Duration: $manualDuration',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}



class DiaperChangingPage extends StatefulWidget {
  @override
  _DiaperChangingPageState createState() => _DiaperChangingPageState();
}

class _DiaperChangingPageState extends State<DiaperChangingPage> {
  String changeType = '';
  String changeTime = '';

  void updateChangeTime() {
    final currentTime = DateTime.now();
    final formattedTime =
        '${currentTime.year}-${currentTime.month.toString().padLeft(2, '0')}-${currentTime.day.toString().padLeft(2, '0')} '
        '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}:${currentTime.second.toString().padLeft(2, '0')}';
    setState(() {
      changeTime = 'You changed for the baby at: $formattedTime';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diaper Changing'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Diaper Changing',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'What type of change?',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'Pipi',
                    groupValue: changeType,
                    onChanged: (value) {
                      setState(() {
                        changeType = value!;
                      });
                    },
                  ),
                  Text('Pipi', style: TextStyle(color: Colors.white)),
                  Radio<String>(
                    value: 'Kaka',
                    groupValue: changeType,
                    onChanged: (value) {
                      setState(() {
                        changeType = value!;
                      });
                    },
                  ),
                  Text('Kaka', style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: updateChangeTime,
                child: Text('Get Time'),
              ),
              SizedBox(height: 20),
              if (changeTime.isNotEmpty)
                Text(
                  '$changeType: $changeTime',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class MedicinePage extends StatefulWidget {
  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  // Controllers for text fields
  final TextEditingController medicineNameController = TextEditingController();
  final TextEditingController timeTakenController = TextEditingController();

  // Dropdown menu selection
  int selectedFrequency = 1; // Default value

  // Variables to display submitted data
  String medicineName = '';
  String timeTaken = '';
  int frequency = 1;

  // Error message for invalid time
  String errorMessage = '';

  @override
  void dispose() {
    medicineNameController.dispose();
    timeTakenController.dispose();
    super.dispose();
  }

  // Validate and submit data
  void submitData() {
    final enteredMedicineName = medicineNameController.text.trim();
    final enteredTimeTaken = timeTakenController.text.trim();

    if (enteredMedicineName.isEmpty || enteredTimeTaken.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields!'),
      ));
      return;
    }

    // Validate the time format
    try {
      final timeParts = enteredTimeTaken.split(':');
      if (timeParts.length != 2) {
        throw Exception('Invalid format! Use HH:MM.');
      }

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      if (hour < 0 || hour > 23) {
        throw Exception('Hours must be between 0 and 23.');
      }
      if (minute < 0 || minute > 59) {
        throw Exception('Minutes must be between 0 and 59.');
      }

      // If time is valid, update state
      setState(() {
        errorMessage = '';
        medicineName = enteredMedicineName;
        timeTaken = enteredTimeTaken;
        frequency = selectedFrequency;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Medicine Tracker',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: medicineNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter medicine name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Frequency:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  DropdownButton<int>(
                    value: selectedFrequency,
                    dropdownColor: Colors.white,
                    items: [1, 2, 3]
                        .map((frequency) => DropdownMenuItem<int>(
                      value: frequency,
                      child: Text('$frequency times'),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFrequency = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: timeTakenController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter time (HH:MM)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: submitData,
                  child: Text('Submit'),
                ),
              ),
              SizedBox(height: 30),
              if (medicineName.isNotEmpty && timeTaken.isNotEmpty)
                Text(
                  'Medicine "$medicineName" was last taken at "$timeTaken" and should be taken $frequency times.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}