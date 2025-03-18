import 'package:docucare/utils/core.dart';

class Environment {
  static String get fileName {
    return ".env.variables";
  }

  static String get supabaseUrl {
    return dotenv.env["SUPABASEURL"] ?? "";
  }

  static String get supabaseKey {
    return dotenv.env["SUPABASE_KEY"] ?? "";
  }
}
