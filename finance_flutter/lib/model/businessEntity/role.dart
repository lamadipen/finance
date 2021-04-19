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


class StringToEnumConverter {
  //GENERIC Function
//  static T toEnum<T>(String value, List<T> list) => list.firstWhere((d) => d.toString().toLowerCase() == value);
  static Role toEnum<T>(String value, List<Role> list){
     print("Here is enum list ${list}");
     list.firstWhere((Role d){
       return d.name == value;
     });
     return list.firstWhere((Role d) => d.name == value);
  }
}