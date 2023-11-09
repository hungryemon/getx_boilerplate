

class AppDatabase {
// Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

// Singleton accessor
  static AppDatabase get instance => _singleton;



  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  
}
