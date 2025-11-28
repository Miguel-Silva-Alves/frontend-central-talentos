enum Role { admin, partner, user }

// Converte string → Role
Role roleFromString(String value) {
  switch (value.toLowerCase()) {
    case 'admin':
      return Role.admin;
    case 'partner':
      return Role.partner;
    case 'user':
      return Role.user;
    default:
      throw Exception("Invalid role: $value");
  }
}

// Converte Role → string
String roleToString(Role role) {
  return role.toString().split('.').last; // "admin", "partner", "user"
}
