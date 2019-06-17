import 'package:redux/redux.dart';
import '../model/user_model.dart';
import '../redux/user_redux.dart';
//创建state
class CPFState{
   User userInfo;
   CPFState({this.userInfo});

}

//创建reducer
CPFState appReducer (CPFState state, action){
  return CPFState(
    userInfo: userReducer(state.userInfo,action),
  );

}