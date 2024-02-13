class User {
  String? id;
  String? createdAt;
  String? modifiedAt;
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? coverPicture;
  String? gender;
  BirthDate? birthDate;
  String? phone;
  String? userTypeId;
  UserType? userType;
  String? groupId;
  Group? group;
  String? codeforcesHandle;
  int? numberOfProblemsTaken;
  int? numberOfProblemsSolved;

  User(
      {this.id,
      this.createdAt,
      this.modifiedAt,
      this.userName,
      this.email,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.coverPicture,
      this.gender,
      this.birthDate,
      this.phone,
      this.userTypeId,
      this.userType,
      this.groupId,
      this.group,
      this.codeforcesHandle,
      this.numberOfProblemsTaken,
      this.numberOfProblemsSolved});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    userName = json['userName'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
    coverPicture = json['coverPicture'];
    gender = json['gender'];
    birthDate = json['birthDate'] != null
        ? new BirthDate.fromJson(json['birthDate'])
        : null;
    phone = json['phone'];
    userTypeId = json['userTypeId'];
    userType = json['userType'] != null
        ? new UserType.fromJson(json['userType'])
        : null;
    groupId = json['groupId'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    codeforcesHandle = json['codeforcesHandle'];
    numberOfProblemsTaken = json['numberOfProblemsTaken'];
    numberOfProblemsSolved = json['numberOfProblemsSolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicture'] = this.profilePicture;
    data['coverPicture'] = this.coverPicture;
    data['gender'] = this.gender;
    if (this.birthDate != null) {
      data['birthDate'] = this.birthDate!.toJson();
    }
    data['phone'] = this.phone;
    data['userTypeId'] = this.userTypeId;
    if (this.userType != null) {
      data['userType'] = this.userType!.toJson();
    }
    data['groupId'] = this.groupId;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    data['codeforcesHandle'] = this.codeforcesHandle;
    data['numberOfProblemsTaken'] = this.numberOfProblemsTaken;
    data['numberOfProblemsSolved'] = this.numberOfProblemsSolved;
    return data;
  }
}

class BirthDate {
  int? year;
  int? month;
  int? day;
  int? dayOfWeek;
  int? dayOfYear;
  int? dayNumber;

  BirthDate(
      {this.year,
      this.month,
      this.day,
      this.dayOfWeek,
      this.dayOfYear,
      this.dayNumber});

  BirthDate.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
    dayOfWeek = json['dayOfWeek'];
    dayOfYear = json['dayOfYear'];
    dayNumber = json['dayNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
    data['dayOfWeek'] = this.dayOfWeek;
    data['dayOfYear'] = this.dayOfYear;
    data['dayNumber'] = this.dayNumber;
    return data;
  }
}

class UserType {
  String? id;
  String? createdAt;
  String? modifiedAt;
  String? name;
  int? priority;

  UserType(
      {this.id, this.createdAt, this.modifiedAt, this.name, this.priority});

  UserType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    name = json['name'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['name'] = this.name;
    data['priority'] = this.priority;
    return data;
  }
}

class Group {
  String? id;
  String? createdAt;
  String? modifiedAt;
  String? name;
  String? abbreviation;
  String? generation;
  String? year;
  String? locationId;
  Location? location;

  Group(
      {this.id,
      this.createdAt,
      this.modifiedAt,
      this.name,
      this.abbreviation,
      this.generation,
      this.year,
      this.locationId,
      this.location});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    generation = json['generation'];
    year = json['year'];
    locationId = json['locationId'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['generation'] = this.generation;
    data['year'] = this.year;
    data['locationId'] = this.locationId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? id;
  String? createdAt;
  String? modifiedAt;
  String? location;
  String? country;

  Location(
      {this.id, this.createdAt, this.modifiedAt, this.location, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    location = json['location'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['modifiedAt'] = this.modifiedAt;
    data['location'] = this.location;
    data['country'] = this.country;
    return data;
  }
}
