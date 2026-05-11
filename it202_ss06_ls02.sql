CREATE DATABASE ss06_ls02;
USE ss06_ls02;

/*
	Phân tích:
    - GROUP BY tạo ra 1 dòng đại diện cho mỗi nhóm
	- Nhưng room_name lại có nhiều giá trị trong nhóm
	- Nên hệ quản trị không thể xác định chính xác giá trị nào phải hiển thị
	-> Vì vậy MySQL 8.0 báo lỗi ONLY_FULL_GROUP_BY để đảm bảo dữ liệu nhất quán.
*/
SELECT hotel_id, MIN(price_per_night) AS 'MIN_PRICE'
FROM Rooms
GROUP BY hotel_id;