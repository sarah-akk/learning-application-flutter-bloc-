class RegisterStates{
  String userName;
  String email;
  String password;
  String repassword;

  RegisterStates(
      {this.userName = "",
    this.email="",
    this.password="",
    this.repassword="",
  }   );

  RegisterStates copywith({
    String? userName,
    String? email,
    String? password,
    String? repassword,
})
{
return RegisterStates(
    userName : userName??this.userName,
    email : email??this.email,
    password:password??this.password,
    repassword:repassword??this.repassword
);
}

}