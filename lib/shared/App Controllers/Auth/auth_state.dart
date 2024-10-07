part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

///login

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}

///Sign Up
class SignUpLoadingState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpErrorState extends AuthState {}

///Forget Pass
class ForgetPassLoadingState extends AuthState {}

class ForgetPassSuccessState extends AuthState {}

class ForgetPassErrorState extends AuthState {}

///Reset Pass
class ResetPassLoadingState extends AuthState {}

class ResetPassSuccessState extends AuthState {}

class ResetPassErrorState extends AuthState {}
