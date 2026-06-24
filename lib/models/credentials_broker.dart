
class CredentialsBroker {
  final int? id;
  final String broker;
  final String? username;
  final String? password;
  final bool tls;

  // Construtor
  CredentialsBroker({
    this.id,
    required this.broker,
    this.username,
    this.password,
    required this.tls,
  });

  // Cria uma cópia do objeto com alguns campos alterados
  CredentialsBroker copyWith({
    int? id,
    String? broker,
    String? username,
    String? password,
    bool? tls,
  }) {
    return CredentialsBroker(
      id: id ?? this.id,
      broker: broker ?? this.broker,
      username: username ?? this.username,
      password: password ?? this.password,
      tls: tls ?? this.tls,
    );
  }

  // Converte para Map para SALVAR NO BANCO
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'broker': broker,
      'username': username,
      'password': password,
      'tls': tls ? 1 : 0,
    };
  }

  // LEITURA DO BANCO
  factory CredentialsBroker.fromMap(Map<String, dynamic> map) {
    return CredentialsBroker(
      id: map['id'] as int?,
      broker: map['broker'] ?? '',
      username: map['username'] as String?,
      password: map['password'] as String?,
      tls: map['tls'] == 1,
    );
  }
}