class MilitaryCharacter {
  // -- Astaamaha Dagaalka (Combat Properties) --
  double fireRate;
  double detectionRadius;

  // -- Caafimaadka Askariga (Soldier Health) --
  double currentHealth;
  final double maxHealth;

  // Status flags for UI representation
  bool isFiring = false;
  String lastAction = "Idle";

  MilitaryCharacter({
    this.fireRate = 1.0,
    this.detectionRadius = 1000.0,
    this.currentHealth = 100.0,
    this.maxHealth = 100.0,
  });

  // -- Shaqooyinka AI (AI Functions) --
  
  void startFiring() {
    isFiring = true;
    lastAction = "Started Firing";
    print("MilitaryCharacter: StartFiring called");
  }

  void stopFiring() {
    isFiring = false;
    lastAction = "Stopped Firing";
    print("MilitaryCharacter: StopFiring called");
  }

  void findTarget() {
    lastAction = "Scanning for Targets...";
    print("MilitaryCharacter: FindTarget called within radius $detectionRadius");
  }

  void takeDamage(double amount) {
    currentHealth -= amount;
    if (currentHealth < 0) currentHealth = 0;
    lastAction = "Took $amount Damage";
    print("MilitaryCharacter: Took damage. Current Health: $currentHealth");
  }
}
