import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Get_userData_controller extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUserData(String uId) async {
    try {
      final QuerySnapshot userData =
      await _firestore.collection('users').where('uId', isEqualTo: uId).get();

      // Map the query results to a list of Maps
      return userData.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching user data: $e");
      return [];
    }
  }
}
