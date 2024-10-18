
 import '../../domain/entities/auth_entitiy.dart';

class AuthState {}
final class SignSuccess extends AuthState{}
final class AuthInitial extends AuthState {}
final class SignInLoading extends AuthState {}
final class SignInSuccess extends SignSuccess {
  final AuthEntity authEntity;
  SignInSuccess({required this.authEntity});
}
final class SignInFailure extends AuthState {
  final String message;
  SignInFailure({required this.message});
}

 final class SignUpLoading extends AuthState {}
 final class SignUpSuccess extends AuthState {
   final AuthEntity authEntity;
   SignUpSuccess({required this.authEntity});
 }
 final class SignUpFailure extends AuthState {
   final String message;
   SignUpFailure({required this.message});
 }
 final class GoogleLoading extends AuthState {}
 final class GoogleSuccess extends SignSuccess {
   final AuthEntity authEntity;
   GoogleSuccess({required this.authEntity});
 }
 final class GoogleFailure extends AuthState {
   final String message;
   GoogleFailure({required this.message});
 }



final class SignedOutLoading extends AuthState {}
final class SignedOutSuccess extends AuthState {}
final class SignedOutFailure extends AuthState {
  final String message;
  SignedOutFailure({required this.message});
}


final class CheckAuth extends AuthState {}
final class ResetPasswordLoading extends AuthState {}
final class ResetPasswordSuccess extends AuthState {}
final class ResetPasswordFailure extends AuthState {
  final String message;
  ResetPasswordFailure({required this.message});
}

