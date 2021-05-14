
class MessageMethod{
    String message = '请完整填写';
    bool IfTure = true;

    MessageMethod(List MessageList,List NullList){
      int length = MessageList.length;
      List ErrorList = [];
      for(int i = 0; i< length; i++){
        if(NullList[i] == null){
          ErrorList.add(MessageList[i]);
          IfTure = false;
        }
      }
      if(!IfTure){
        message += ErrorList[0];
        if(ErrorList.length > 1){
          ErrorList.removeAt(0);
          for( var temp in ErrorList )
            message = message+ '、' +temp;
        }
      }
    }

    List getMessage(){
      return [message,IfTure];
    }

}