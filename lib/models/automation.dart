class Automation {
  final int? id;
  String name;
  int type;
  bool enable;
  int action;
  int triggerConfig;

  Automation({
    required this.id,
    required this.name,
    required this.type,
    required this.enable,
    required this.action,
    required this.triggerConfig
  });

  Automation copyWith({
    int? id,
    String? name,
    int? type,
    bool? enable,
    int? action,
    int? triggerConfig,
  }) {
    return Automation(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      enable: enable ?? this.enable,
      action: action ?? this.action,
      triggerConfig: triggerConfig ?? this.triggerConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "enable": enable,
      "action": action,
      "triggerConfig": triggerConfig,
    };
  }

  factory Automation.fromMap(Map<String, dynamic> map) {
    return Automation(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: map['type'] as int,
      enable: map['enable'] as bool,
      action: map['action'] as int,
      triggerConfig: map['triggerConfig'] as int,
    );
  }
}