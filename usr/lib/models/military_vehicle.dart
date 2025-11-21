class MilitaryVehicle {
  // -- Caafimaadka Gaariga (Vehicle Health) --
  double currentHealth;
  double maxHealth;

  // Movement state for UI visualization
  double currentThrottle = 0.0; // Represents MoveForward value (-1.0 to 1.0)
  double currentSteering = 0.0; // Represents MoveRight value (-1.0 to 1.0)
  String lastAction = "Idle";

  MilitaryVehicle({
    this.currentHealth = 100.0,
    this.maxHealth = 100.0,
  });

  // -- Qaybaha Xakamaynta Dhaqdhaqaaqa (Movement Functions) --
  
  void moveForward(double value) {
    currentThrottle = value;
    if (value > 0.1) {
      lastAction = "Accelerating Forward";
    } else if (value < -0.1) {
      lastAction = "Reversing";
    } else {
      lastAction = "Idling";
    }
    print("MilitaryVehicle: MoveForward input $value");
  }

  void moveRight(double value) {
    currentSteering = value;
    // Only update action text if we are actually steering significantly
    if (value.abs() > 0.1) {
      if (value > 0) {
        lastAction = "Steering Right";
      } else {
        lastAction = "Steering Left";
      }
    }
    print("MilitaryVehicle: MoveRight input $value");
  }

  void takeDamage(double damageAmount) {
    currentHealth -= damageAmount;
    if (currentHealth < 0) currentHealth = 0;
    lastAction = "Vehicle Damaged (-$damageAmount)";
    print("MilitaryVehicle: Took damage. Current Health: $currentHealth");
  }

  void repair() {
    currentHealth = maxHealth;
    lastAction = "Vehicle Repaired";
  }
}
