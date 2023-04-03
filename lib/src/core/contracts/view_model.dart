abstract class ViewModelBase<T> {
  ViewModelBase(
      {this.isLoading = false,
      this.isSuccess = true,
      this.message,
      this.data});

  final bool isLoading;
  final bool isSuccess;
  final String? message;
  final T? data;
}
