
class MessageMethod{
    String message = '请填写';
    String message2 = '';
    bool IfTure = true;

    MessageMethod(List MessageList,List NullList){
      int length = MessageList.length;
      List ErrorList = [];

      if( NullList[length-1] == null ){
        message2 = MessageList[length-1];
        IfTure = false;
      }
      for(int i = 0; i < (length - 1); i++){
        if(NullList[i] == null){
          ErrorList.add(MessageList[i]);
          IfTure = false;
        }
      }
      if(!IfTure){
        if(ErrorList.length != 0){
          message += ErrorList[0];
          if(ErrorList.length > 1){
            ErrorList.removeAt(0);
            for( var temp in ErrorList )
              message = message + '、' + temp;
        }
          message += ('\n' + message2);
        }
        else
          message = message2;
      }


    }

    List getMessage(){
      return [message,IfTure];
    }

}