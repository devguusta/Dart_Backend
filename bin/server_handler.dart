import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ServeHandler {
  Handler get handler {
    final router = Router();
    router.get("/", (Request request) {
      return Response.ok("Hello, world!");
    });

    router.get('/ola/<user>', (Request req, String user) {
      return Response.ok("Olá, $user!");
    });
    router.get('/query', (Request req) {
      String name = req.url.queryParameters['name'] ?? 'Anônimo';
      String age = req.url.queryParameters['age'] ?? '0';
      return Response.ok("Olá, $name! Você tem $age anos.");
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();
      Map json = jsonDecode(result);
      String name = json['name'] ?? 'Anônimo';
      if (name == "Gustavo") {
        return Response.ok(json['name']);
      }
      return Response.notFound("Usuário não encontrado");
    });

    return router;
  }
}
