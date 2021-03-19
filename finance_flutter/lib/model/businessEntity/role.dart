enum Role { ADMIN, MANAGER, EDITOR, VIEWER }

extension RoleExtension on Role {
  String get name {
    switch (this) {
      case Role.ADMIN:
        return 'admin';
      case Role.MANAGER:
        return 'manager';
      case Role.EDITOR:
        return 'editor';
      case Role.VIEWER:
      default:
        return 'viewer';
    }
  }
}
