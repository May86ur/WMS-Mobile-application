getFloatValue(dynamic data) {
  try {
    var val = double.parse(data.toString());
    return val;
  } catch (_) {
    return 0.0;
  }
}

getBoolValue(dynamic data) {
  try {
    var val = int.parse(data.toString());
    return val == 1;
  } catch (_) {
    return false;
  }
}

convertBartoMeter(dynamic data) {
  try {
    if (data == null) {
      return '0.0';
    } else {
      var converted = data * 10.2;
      return converted.toStringAsFixed(2);
    }
  } catch (_) {}
  return '0.0';
}
