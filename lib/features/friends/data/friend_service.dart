import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/config/api_config.dart';

class FriendService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<List<dynamic>> getFriends() async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConfig.baseUrl}/friends/');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<List<dynamic>> getPendingRequests() async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConfig.baseUrl}/friendships/pending/');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<void> sendFriendRequest(int receiverId) async {
    final token = await _getToken();
    final url = Uri.parse('${ApiConfig.baseUrl}/friendships/send/');
    await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'receiver_id': receiverId}),
    );
  }

  Future<void> respondRequest(int requestId, String action) async {
    final token = await _getToken();
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/friendships/respond/$requestId/',
    );
    await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'action': action}),
    );
  }
}
