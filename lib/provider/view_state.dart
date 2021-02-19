
/// 页面状态类型
enum ViewState {
  idle,
  busy, //加载中
  empty, //无数据
  error, //加载失败
  unAuthorized, //未登录
}

/// 错误类型
enum ErrorType {
  defaultError,
  networkError,
}

class ViewStateError {
  ErrorType errorType;
  String message;
  String errorMessage;

  ViewStateError(this.errorType, {this.message, this.errorMessage}) {
    errorType ??= ErrorType.defaultError;
    message ??= errorMessage;
  }

  get isNetworkError => errorType == ErrorType.networkError;

  @override
  String toString() {
    return 'ViewStateError{errorType: $errorType, message: $message, errorMessage: $errorMessage}';
  }
}
