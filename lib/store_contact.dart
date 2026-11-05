import 'dart:js_interop';

const storePhone = '05-272-3486';

@JS('window.open')
external JSAny? _openBrowserWindow(
  JSString url,
  JSString target,
  JSString features,
);

void callStore() {
  _openBrowserWindow('tel:052723486'.toJS, '_self'.toJS, ''.toJS);
}
