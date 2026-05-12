CREATE DATABASE ss06_ls04;
USE ss06_ls04;

/*
	Phân tích:
    1. Đề xuất Đa giải pháp (Luồng tư duy):
	- Hướng tiếp cận 1 (Lọc Trễ - Bad Practice): Không sử dụng mệnh đề WHERE. 
    Gom nhóm (GROUP BY) toàn bộ dữ liệu của khách sạn (kể cả đơn Hủy, đơn Lỗi), 
    sau đó dùng mệnh đề HAVING để kết hợp hàm tính toán và kiểm tra trạng thái thành công.
	- Hướng tiếp cận 2 (Lọc Sớm - Clean Code): Sử dụng mệnh đề WHERE để loại bỏ các đơn Hủy/Lỗi ngay từ đầu, 
    sau đó mới GROUP BY và dùng HAVING để kiểm tra điều kiện số lượng (>= 50) và doanh thu trung bình (> 3.000.000).
    2. Bảng so sánh
    TIÊU CHÍ             | CÁCH 1: CHỈ DÙNG HAVING             | CÁCH 2: DÙNG WHERE + HAVING (TỐI ƯU)
	---------------------|-------------------------------------|--------------------------------------
	Dữ liệu nạp vào  	 | Toàn bộ bảng (Bao gồm cả đơn lỗi,   | Chỉ nạp các dòng 'COMPLETED'. Loại bỏ
	   GROUP BY          | hủy, rác...).                       | dữ liệu thừa ngay từ đầu.
	---------------------|-------------------------------------|--------------------------------------
	Gánh nặng CPU  	     | Phải tính COUNT, AVG cho cả triệu   | Chỉ tính toán trên tập dữ liệu "sạch" 
						 | dòng đơn hàng không hợp lệ.         | đã được thu nhỏ.
	---------------------|-------------------------------------|--------------------------------------
	Chiếm dụng RAM       | RAM phải lưu trữ rất nhiều Groups   | Tiết kiệm RAM vì số lượng dòng và 
						 | tạm thời (Internal Temp Tables).    | số nhóm (Groups) ít hơn hẳn.
	---------------------|-------------------------------------|--------------------------------------
	Tốc độ xử lý         | Chậm (High Latency) do xử lý dữ     | Nhanh (Low Latency) nhờ tận dụng 
						 | liệu dư thừa quá lớn.               | Index trên cột 'status'.
	---------------------|-------------------------------------|--------------------------------------
*/
SELECT hotel_id, COUNT(*) AS 'TOTAL_COMPLETE', AVG(total_price) AS 'TOTAL_PRICE'
FROM Bookings
WHERE status = 'COMPLETED'
GROUP BY hotel_id
HAVING TOTAL_COMPLETE >= 50 AND TOTAL_PRICE > 3000000;
