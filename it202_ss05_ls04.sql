CREATE DATABASE ss05_ls04;
USE ss05_ls04;

-- 1. Đề xuất Đa giải pháp:
-- Giải pháp 1: Sử dụng liên tiếp các toán tử = kết hợp với logic OR.
-- SELECT * FROM Orders 
-- WHERE cancel_reason = 'KHACH_HUY' 
--    OR cancel_reason = 'QUAN_DONG_CUA' 
--    OR cancel_reason = 'KHONG_CO_TAI_XE' 
--    OR cancel_reason = 'BOM_HANG';

-- Giải pháp 2: Sử dụng toán tử tập hợp IN (...).
-- SELECT * FROM Orders 
-- WHERE cancel_reason IN ('KHACH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG');

-- 2.Viết ra câu truy vấn SQL của giải pháp bạn đánh giá là tốt nhất.
SELECT * FROM Orders 
WHERE cancel_reason IN ('KHACH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG') 
OR cancel_reason IS NULL