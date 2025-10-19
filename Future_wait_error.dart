import 'dart:async';

Future<String> taiThanhCong() async {
  await Future.delayed(Duration(seconds: 5));
  return "Thành công";
}

Future<String> taiThatBai() async {
  await Future.delayed(Duration(seconds: 2)); // Bị lỗi sau 2 giây
  throw Exception('Mất kết nối mạng!');
}

Future<void> main() async {
  print("Bắt đầu chạy...");
  try {
    await Future.wait([
      taiThanhCong(), // Chạy... (sẽ xong sau 5s)
      taiThatBai(),   // Chạy... (sẽ lỗi sau 2s)
    ]);
  } catch (e) {
    // Ngay khi taiThatBai() lỗi (sau 2s), chương trình nhảy
    // ngay vào 'catch' này mà không chờ taiThanhCong() (5s).
    print("ĐÃ XẢY RA LỖI: $e");
  }
}
