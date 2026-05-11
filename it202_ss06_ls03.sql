CREATE DATABASE ss06_ls03;
USE ss06_ls03;

/*
	Phân tích:
    Cần tìm các user_id thỏa mãn đồng thời:
	- Tổng số lần đặt phòng >= 10
	- Số đơn bị hủy (status = 'CANCELLED') > 5
	Dùng:
	- COUNT(*) để đếm tổng đơn của mỗi user
	-SUM(CASE WHEN ... THEN 1 ELSE 0 END) để chỉ đếm các đơn bị hủy
*/
SELECT user_id, COUNT(*) AS 'TOTAL_BOOKING',SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) AS 'CANCELLED_BOOKING'
FROM Bookings
GROUP BY user_id
HAVING COUNT(*) >= 10 AND SUM(CASE WHEN status = 'CANCELLED' THEN 1 ELSE 0 END) > 5;