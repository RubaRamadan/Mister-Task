class InputValidator{

  static String? validate(String? value) {
     if(value!.isEmpty ) {
       return 'This field is required' ;
     }
     return null;
  }
}