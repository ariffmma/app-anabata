class FeedbackForm {
  String _name;
  String _email;
  String _nomor;
  String _profession;
  String _age;
  String _domicile;

  FeedbackForm(this._name, this._email, this._nomor, this._profession, this._age, this._domicile);

  // Method to make GET parameters.
  String toParams() => "?name=$_name&email=$_email&nomor=$_nomor&profession=$_profession&age=$_age&domicile=$_domicile";
}
