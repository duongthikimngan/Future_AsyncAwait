import 'dart:async';

Future<String> taiFileA() async {
  await Future.delayed(Duration(seconds: 3)); // Mất 3 giây
  return "Nội dung File A";
}

Future<String> taiFileB() async {
  await Future.delayed(Duration(seconds: 1)); // Mất 1 giây
  return "Nội dung File B";
}

Future<void> main() async {
  print("Bắt đầu tải nhiều file...");
  Stopwatch watch = Stopwatch()..start(); // Bấm giờ

  // Chạy cả hai hàm CÙNG LÚC
  List<String> ketQua = await Future.wait([
    taiFileA(),
    taiFileB(),
  ]);

  watch.stop();

  print(ketQua[0]); // Kết quả taiFileA
  print(ketQua[1]); // Kết quả taiFileB
  print("Tổng thời gian: ${watch.elapsedMilliseconds / 1000} giây");
}
