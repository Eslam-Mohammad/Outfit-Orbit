
 class AuthState {}

final class AuthInitial extends AuthState {}
final class SignUploading extends AuthState {}
final class SignUpSuccess extends AuthState {}
final class SignUpFailed extends AuthState {
  final String message;
  SignUpFailed({required this.message});
}



final class SignInLoading extends AuthState {}
final class SignInSuccess extends AuthState {}
final class SignInFailed extends AuthState {
  final String message;
  SignInFailed({required this.message});
}

final class CheckAuth extends AuthState {}
final class ResetPasswordLoading extends AuthState {}
final class ResetPasswordSuccess extends AuthState {}
final class ResetPasswordFailed extends AuthState {
  final String message;
  ResetPasswordFailed({required this.message});
}

