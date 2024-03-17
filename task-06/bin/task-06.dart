// Класс Person
abstract class Person {
  String name;
  int age;

  Person(this.name, this.age);

  @override
  String toString() {
    return 'Имя: $name, Возраст: $age';
  }
}

// Перечисление ролей
enum TeamRole { Driver, Manager }

// Интерфейс "Член команды"
abstract interface class TeamMember {
  TeamRole get role;
}

// Класс Driver
class Driver extends Person implements TeamMember {
  int racesWon;

  Driver(String name, int age, this.racesWon) : super(name, age);

  @override
  String toString() {
    return '${super.toString()}, Побед: $racesWon, Роль: ${role.toString().split('.').last}';
  }

  @override
  TeamRole get role => TeamRole.Driver;
}

// Класс Manager
class Manager extends Person implements TeamMember {
  int yearsOfExperience;

  Manager(String name, int age, this.yearsOfExperience) : super(name, age);

  @override
  String toString() {
    return '${super.toString()}, Опыт: $yearsOfExperience, Роль: ${role.toString().split('.').last}';
  }

  @override
  TeamRole get role => TeamRole.Manager;
}

// Класс Team
class Team {
  String teamName;
  List<TeamMember> members;

  Team(this.teamName, this.members);

  void addMember(TeamMember member) {
    members.add(member);
  }

  @override
  String toString() {
    return 'Команда: $teamName\nСостав:\n ${members.map((m) => m.toString()).join(';\n ')}';
  }
}

void main() {
  var driver1 = Driver('Max Verstappen', 24, 20);
  var driver2 = Driver('Sergio Perez', 32, 5);
  var manager = Manager('Christian Horner', 48, 15);
  var redBullTeam = Team('Red Bull Racing', [driver1, driver2, manager]);

  print('Информация о команде:');
  print(redBullTeam);
}
