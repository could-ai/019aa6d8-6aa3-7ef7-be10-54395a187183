import 'package:flutter/material.dart';
import '../models/military_vehicle.dart';

class VehicleDetailScreen extends StatefulWidget {
  const VehicleDetailScreen({super.key});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  final MilitaryVehicle _vehicle = MilitaryVehicle(
    maxHealth: 200.0,
    currentHealth: 200.0,
  );

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Military Vehicle Control'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildMovementControlCard(),
            const SizedBox(height: 20),
            _buildHealthCard(),
            const SizedBox(height: 20),
            _buildActionsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Vehicle Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Current Action:"),
                Chip(
                  label: Text(_vehicle.lastAction),
                  backgroundColor: Colors.orange.shade100,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Icon(Icons.speed, color: Colors.blueGrey),
                    const SizedBox(height: 4),
                    Text("Throttle: ${_vehicle.currentThrottle.toStringAsFixed(2)}"),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.directions_car, color: Colors.blueGrey),
                    const SizedBox(height: 4),
                    Text("Steering: ${_vehicle.currentSteering.toStringAsFixed(2)}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementControlCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Movement Controls (Xakamaynta Dhaqdhaqaaqa)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Move Forward / Backward (Throttle)"),
            Row(
              children: [
                const Icon(Icons.arrow_downward),
                Expanded(
                  child: Slider(
                    value: _vehicle.currentThrottle,
                    min: -1.0,
                    max: 1.0,
                    divisions: 20,
                    label: _vehicle.currentThrottle.toStringAsFixed(1),
                    activeColor: _vehicle.currentThrottle > 0 ? Colors.green : Colors.red,
                    onChanged: (value) {
                      setState(() {
                        _vehicle.moveForward(value);
                      });
                    },
                  ),
                ),
                const Icon(Icons.arrow_upward),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Move Right / Left (Steering)"),
            Row(
              children: [
                const Icon(Icons.turn_left),
                Expanded(
                  child: Slider(
                    value: _vehicle.currentSteering,
                    min: -1.0,
                    max: 1.0,
                    divisions: 20,
                    label: _vehicle.currentSteering.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _vehicle.moveRight(value);
                      });
                    },
                  ),
                ),
                const Icon(Icons.turn_right),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _vehicle.moveForward(0.0);
                    _vehicle.moveRight(0.0);
                  });
                },
                child: const Text("Stop / Reset Controls"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHealthCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Vehicle Health (Caafimaadka Gaariga)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _vehicle.currentHealth / _vehicle.maxHealth,
              backgroundColor: Colors.grey[300],
              color: _vehicle.currentHealth < 50 ? Colors.red : Colors.blue,
              minHeight: 10,
            ),
            const SizedBox(height: 5),
            Text(
              "${_vehicle.currentHealth.toStringAsFixed(0)} / ${_vehicle.maxHealth.toStringAsFixed(0)} HP",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _vehicle.takeDamage(25);
                    _updateState();
                  },
                  icon: const Icon(Icons.warning),
                  label: const Text("Take Damage (25)"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _vehicle.repair();
                    });
                  },
                  icon: const Icon(Icons.build),
                  label: const Text("Repair Vehicle"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
