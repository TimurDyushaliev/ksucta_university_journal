class StringResource {
  static final auth = _Auth();
  static final home = _Home();
  static final students = _Students();
  static final groups = _Groups();
}

class _Auth {
  final login = 'Войти';
  final noSuchUser = 'Такого пользователя не существует';
  final hintText = 'Ф.И.О';
  final existingUserName = 'Дюшалиев Тимур';
  final successfullyValidated = 'Успешно!';
}

class _Home {
  final title = 'Электронный журнал';
  final add = 'Добавить';
  final schedule = 'Расписание';
  final journal = 'Журнал';
  final logout = 'Выйти';
  final newSubject = 'Новый предмет';
}

class _Groups {
  final newGroup = 'Новая группа';
}

class _Students {
  final markStudent = 'Отметить как:';
  final attend = 'Присутствует';
  final notAttend = 'Отсутствует';
  final newStudent = 'Новый студент';
}
