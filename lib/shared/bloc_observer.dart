import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver{
  void onCreate(BlocBase bloc){
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }
  void onChange(BlocBase bloc, Change change){
    super.onChange(bloc,change);
    print('onChange -- ${bloc.runtimeType},$change');
  }

  void onError(BlocBase bloc, Object error ,  StackTrace stackTrace){
    print('onError -- ${bloc.runtimeType},$error');

    super.onError(bloc,error,stackTrace);
  }
  void onClose(BlocBase bloc){
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');

  }
}