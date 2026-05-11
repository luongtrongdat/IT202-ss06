CREATE DATABASE ss06_ls01;
USE ss06_ls01;

/*
	Vấn đề nằm ở bước số 2: Mệnh đề WHERE được thực thi trước khi dữ liệu được gom nhóm (GROUP BY)
*/
SELECT city, SUM(total_price) AS 'TOTAL_PRICE'
FROM Bookings
WHERE status = 'COMPLETED'
GROUP BY city
HAVING SUM(total_price) > 0;