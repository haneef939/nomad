class UserModel {
  final String? userId;
  final String? email;
  final String? fullName;
  final String? country;
  final String? gender;
  final String? dob;
  final String? lat;
  final String? lng;
  final String? userType;
  final String? userImg;
  final String? userPassport;
  final String? userRole;
  double? distance;
  final List? followers;
  final List? following;
  final bool? isActive;
  final String? createdBy;
  final String? updatedBy;

  UserModel({
    this.userId,
    this.fullName,
    this.country,
    this.gender,
    this.dob,
    this.lat,
    this.lng,
    this.email,
    this.userType,
    this.userImg,
    this.userPassport,
    this.userRole,
    this.followers,
    this.following,
    this.isActive,
    this.createdBy,
    this.updatedBy,
  });

  //used upon show all users
  Map<String, dynamic> setEventUserDataMap() {
    return {
      "userId": userId,
      "fullName": fullName,
      "country": country,
      "gender": gender,
      "dob": dob,
      "email": email,
      "userType": userType,
      "followers": followers,
      "following": following,
      "userImg": userImg,
      "isActive": isActive,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
    };
  }

  //used upon registration of the user
  Map<String, dynamic> setDataMap() {
    return {
      "userId": userId,
      "fullName": fullName,
      "country": country,
      "gender": gender,
      "dob": dob,
      "email": email,
      "userRole": "user",
      "lat": lat,
      "lng": lng,
      "userType": userType,
      "followers":  [],
      "following":  [],
      "isActive": isActive,
      "createdBy": createdBy,
      "updatedBy": updatedBy,
    };
  }

  Map<String, dynamic> getImgDataMap() {
    return {
      "userImg": userImg,
    };
  }

  Map<String, dynamic> setUserActive() {
    return {
      "isActive": isActive,
    };
  }

  Map<String, dynamic> getPassportImgDataMap() {
    return {
      "userPassport": userPassport,
    };
  }
}
