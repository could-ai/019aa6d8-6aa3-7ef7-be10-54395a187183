import 'package:flutter/material.dart';
import '../models/military_character.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  // Create an instance of our character
  final MilitaryCharacter _character = MilitaryCharacter(
    fireRate: 5.0,
    detectionRadius: 1500.0,
    currentHealth: 100.0,
  );

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Military Character Control'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildCombatPropertiesCard(),
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
              "Character Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Current Action:"),
                Chip(
                  label: Text(_character.lastAction),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Firing State:"),
                Icon(
                  _character.isFiring ? Icons.local_fire_department : Icons.circle_outlined,
                  color: _character.isFiring ? Colors.red : Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCombatPropertiesCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Combat Properties (Astaamaha Dagaalka)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Fire Rate: ${_character.fireRate.toStringAsFixed(1)} rounds/sec"),
            Slider(
              value: _character.fireRate,
              min: 0.0,
              max: 20.0,
              divisions: 20,
              label: _character.fireRate.toString(),
              onChanged: (value) {
                setState(() {
                  _character.fireRate = value;
                });
              },
            ),
            Text("Detection Radius: ${_character.detectionRadius.toStringAsFixed(0)} units"),
            Slider(
              value: _character.detectionRadius,
              min: 0.0,
              max: 5000.0,
              divisions: 50,
              label: _character.detectionRadius.toString(),
              onChanged: (value) {
                setState(() {
                  _character.detectionRadius = value;
                });
              },
            ),
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
              "Health (Caafimaadka Askariga)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _character.currentHealth / _character.maxHealth,
              backgroundColor: Colors.grey[300],
              color: _character.currentHealth < 30 ? Colors.red : Colors.green,
              minHeight: 10,
            ),
            const SizedBox(height: 5),
            Text(
              "${_character.currentHealth.toStringAsFixed(0)} / ${_character.maxHealth.toStringAsFixed(0)} HP",
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
              "AI Functions (Shaqooyinka AI)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _character.startFiring();
                    _updateState();
                  },
                  icon: const Icon(Icons.flash_on),
                  label: const Text("Start Firing"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _character.stopFiring();
                    _updateState();
                  },
                  icon: const Icon(Icons.flash_off),
                  label: const Text("Stop Firing"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _character.findTarget();
                    _updateState();
                  },
                  icon: const Icon(Icons.radar),
                  label: const Text("Find Target"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _character.takeDamage(10);
                    _updateState();
                  },
                  icon: const Icon(Icons.local_hospital),
                  label: const Text("Take Damage (10)"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _character.currentHealth = _character.maxHealth;
                      _character.lastAction = "Healed";
                    });
                  },
                  icon: const Icon(Icons.healing),
                  label: const Text("Heal Full"),
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
