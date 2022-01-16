USE HowKteam
GO
-- Bài 9 : Truy vấn kết hợp điều kiện

-- cau truc truy van
SELECT *FROM DBO.DETAI  -- LAY HET DU LIEU TRONG BANG
-- LAY MA DE TAI + TEN BO MON
SELECT TENDT, MACD FROM DBO.DETAI
-- doi ten cot
SELECT MABM AS "BOMOM", TENBM AS "TENBOMON" FROM dbo.BOMON
-- truy van 2 bang mot luc
SELECT *FROM GIAOVIEN

-- XUAT RA MA GIAO VIEN+ TEN +TEN BO MON DAY
SELECT GV.MAGV, GV.HOTEN, BM.TENBM FROM dbo.GIAOVIEN AS "GV", dbo.BOMON AS "BM"
--bt
--lay ra MAGV,TEN GV, TENKHOA cuar gv do lam viec : goi y bo mon nam trong khoa
SELECT GV.MAGV, GV.HOTEN, khoas.TENKHOA FROM DBO.GIAOVIEN AS GV, DBO.KHOA AS "khoas", DBO.BOMON AS BM
WHERE GV.MABM = BM.MABM AND BM.MAKHOA = khoas.MAKHOA

SELECT GV.HOTEN FROM GIAOVIEN as "GV"
WHERE YEAR(GETDATE() - YEAR(NGSINH)) < 40

SELECT GV.HOTEN, GV.NGSINH,  YEAR(GETDATE()) - YEAR(NGSINH) AS 'age'  FROM GIAOVIEN as "GV"
WHERE YEAR(GETDATE()) - YEAR(NGSINH) > 40

-- lay ra gv truong bo mon
SELECT GV.* FROM GIAOVIEN AS GV, BOMON AS BM
WHERE GV.MAGV = BM.TRUONGBM

-- dem so luong giao vien
SELECT COUNT(GV.NGUON) AS 'HO TEN'FROM DBO.GIAOVIEN AS GV


-- COUNT(*) DEM SO LUONG CUA TAT CA RECORD
-- COUNT(TEN TRUONG NAO DO ) -> DEM SO LUONG TEN TRUONG 

--DEM SO LUONG NGUOI THAN CO MA GIAO VIEN 007

SELECT COUNT(*) AS 'so LUONG NGUON THAN' 
FROM dbo.GIAOVIEN AS GV, dbo.NGUOITHAN AS NT
WHERE GV.MAGV = '007' 
AND GV.MAGV = NT.MAGV

-- LAY RA TEN GIAO VIEN VA TEN DE TAI NGUOI DO THAM GIA
SELECT GV.MAGV, GV.HOTEN, DT.TENDT, TG.MADT FROM DBO.GIAOVIEN AS GV, DBO.DETAI AS DT, DBO.THAMGIADT AS TG
WHERE GV.MAGV = TG.MAGV
AND DT.MADT = TG.MADT 

-- LAY RA TEN GIAO VIEN VA TEN DE TAI NGUOI DO THAM GIA KHI MA GV THAM GIA NHIEU HON  1 DE TAI -> DOI BAI TRUY VAN LONG
SELECT GV.MAGV, GV.HOTEN, DT.TENDT, TG.MADT FROM DBO.GIAOVIEN AS GV, DBO.DETAI AS DT, DBO.THAMGIADT AS TG
WHERE GV.MAGV = TG.MAGV
AND DT.MADT = TG.MADT 




-- giai cau hoi cua bai 9
-- xuat ra thong tin giao vien va giao vien quan li cuaguoi do
SELECT *FROM dbo.GIAOVIEN AS GV1, dbo.GIAOVIEN AS GV2
WHERE GV1.GVQLCM = GV2.MAGV
-- XUAT RA SOP LUONG GIAO VIEN KHOA CNTT
SELECT COUNT(*) AS 'SLGV CNTT' FROM DBO.KHOA AS K, DBO.GIAOVIEN AS GV, DBO.BOMON AS BM
WHERE GV.MABM = BM.MABM
AND BM.MAKHOA = K.MAKHOA
AND K.MAKHOA = 'CNTT'

-- XUAT RA THONG TIN GIAO VIEN VA DE TAI NGUOI DO THAM GIA HI MA KET QUA DAT.
SELECT GV.HOTEN FROM DBO.GIAOVIEN AS GV, DBO.THAMGIADT AS TG 
WHERE GV.MAGV = TG.MAGV
AND TG.KETQUA = N'Đạt'


-- -----------------------------------------------------------------------------------------------------------------
-- BAI 10 : Tìm kiến gần đúng
     -- XUAT RA THONG TIN GIAO VIEN MA TEN BAT DAU CO CHU 'H' THI sử dụng từ khoa LIKE ~ TÌM KIẾM GẦN ĐÙNG
SELECT *FROM DBO.GIAOVIEN AS GV
WHERE GV.HOTEN like 'l%'

-- XUAT RA THONG TIN GIAO VIEN KET THÚC BẰNG 'N'
SELECT *FROM DBO.GIAOVIEN AS GV
WHERE GV.HOTEN like '%H'

-- XUAT RA THONG TIN GIAO VIEN CO TON TAI CHU 'N;
SELECT *FROM DBO.GIAOVIEN AS GV
WHERE GV.HOTEN like '%N%'

-- ----------------------------------------------------------------------------------------------------------------- 

-- BAI 11 : INNER JOIN
   -- inner Join kieu cu -> co the sau nay khong con duoc ho tro
   -- Moi join deu can dieu kien 
SELECT *FROM 
dbo.BOMON, dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM

   -- jnner join -> ket hop hai bang lai va lay cac truong thoa man dieu kien
SELECT *FROM 
dbo.GIAOVIEN INNER JOIN DBO.BOMON
ON BOMON.MABM = GIAOVIEN.MABM

-- -----------------------------------------------------------------------------------------------------------------


--BAI 12 : SQL FULL OUTER JOIN Keyword
    -- KHI KET HOP 2 TRUONG ma khong co du lieu giong nhau thi se de la null
    -- Gom 2 bang lai, theo dieu kien, ben nao khong co thi de null
SELECT *FROM 
dbo.GIAOVIEN FULL OUTER JOIN dbo.BOMON
ON BOMON.MABM = GIAOVIEN.MABM


-- -------------------------------------------CROSS JOIN----------------------------------------------------------------------
    -- la to hop cua moi record cua bang A voi all reacord cua bang B va khong can dieu kien
SELECT *FROM dbo.BOMON CROSS JOIN dbo.GIAOVIEN



-- -----------------------------------------------------------------------------------------------------------------
--Bai 13 : Left-Right Join
SELECT *FROM dbo.BOMON  JOIN dbo.GIAOVIEN
ON BOMON.MABM = GIAOVIEN.MABM

-- Left Join -> bang ben phai nhap vao bang ben trai
-- record nao ben phai khong co thi  null
-- record nao ben trai khong co thi khong dien vao
SELECT *FROM dbo.BOMON LEFT JOIN dbo.GIAOVIEN
ON BOMON.MABM = GIAOVIEN.MABM

--Right Join
SELECT *FROM dbo.BOMON RIGHT JOIN dbo.GIAOVIEN
ON BOMON.MABM = GIAOVIEN.MABM

 
-- -----------------------------------------------------------------------------------------------------------------
 -- Bài 14: Union
 --Đôi khi, bạn có thể cần kết hợp dữ liệu mà chúng có cấu trúc giống nhau từ nhiều bảng thành một khi truy vấn.
 --Các bảng này có khi trong cùng một CSDL, có khi ở các CSDL khác nhau, thậm chí là ở các server khác nhau.
 --Thực hiện nhiệm vụ này có toán tử UNION và UNION ALL
   --UNION kết hợp lại nhưng loại bỏ trùng nhau
   --UNION ALL kết hợp lại nhưng không loại bỏ trùng nhau
   --UNION dùng để kết hợp các kết quả của các câu SELECT lại với nhau. Các câu SELECT cần có số cột giống nhau, cột tương ứng theo thứ tự phải cùng kiểu dữ liệu
 Select GV.MAGV FROM dbo.GIAOVIEN AS GV
 UNION 
 SELECT NT.MAGV FROM dbo.NGUOITHAN AS NT

 Select GV.MAGV FROM dbo.GIAOVIEN AS GV
 WHERE GV.LUONG > 2000
 UNION 
 SELECT NT.MAGV FROM dbo.NGUOITHAN AS NT
 WHERE NT.PHAI = N'Nữ'
 
-- -----------------------------------------------------------------------------------------------------------------
  -- Bài 15: Select Into
  -- Tao ra mot bang moi tu tu du lieu da co san, ->back up duoc du lieu
  -- tao ra bang moi tu mot hoac nhieu bang co san
  -- Lay het du lieu cua bang GV dua vao bang moi TableA
  -- Bang nay co record tuong ung nhu bang GV
 SELECT * INTO TableA 
 FROM dbo.GIAOVIEN

SELECT *FROM TableA
SELECT *FROM GIAOVIEN

 -- TAO RA bang table B co cot du lieu la HoTen tuong ung nhu GiaoVien
 -- du lieu tu bang Tableb lay ra tu GIAOVIEN
 SELECT HoTen INTO Tableb
 FROM dbo.GIAOVIEN 

 SELECT *FROM dbo.Tableb

  -- TAO RA bang table B co cot du lieu la HoTen tuong ung nhu GiaoVien
  -- khi ma luong > 2000
 -- du lieu tu bang Tableb lay ra tu GIAOVIEN
 SELECT HoTen INTO TableC
 FROM dbo.GIAOVIEN 
 where LUONG > 2000

 SELECT *FROM TableC



 -- TAO RA BANG MOI TU NHIEU BANG
 SELECT MAGV, HOTEN, TENBM INTO GVbackup
 FROM dbo.GIAOVIEN, dbo.BOMON
 WHERE GIAOVIEN.MABM = BOMON.MABM

 SELECT *FROM GVbackup

 -- TAO RA BANG MOI Y CHANG NHUNG KHONG CO DU LIEU
 SELECT *INTO  GVB
 FROM dbo.GIAOVIEN
 WHERE 6 > 9

 SELECT *FROM GVB



 -- -----------------------------------------------------------------------------------------------------------------
 --  Bài 16: Insert into Select 
 -- INSERT INTO SELECT COPPY DU LIEU VAO BANG DA TON TAI
SELECT * INTO CLONEGV1
FROM DBO.GIAOVIEN
WHERE 1 = 0

SELECT *FROM CLONEGV1

INSERT INTO  CLONEGV1
SELECT *FROM DBO.GIAOVIEN


 -- -----------------------------------------------------------------------------------------------------------------
 --  Bài 17: Truy vấn lồng

 -- kiem tra giao vien co ma 001 co phai la giao vien quan li bo mon hay khong
 -- LAY RA DANH SACH CAC MA GIAO VIEN QLBM
 -- KIEM TRA MAGV CO TON TAI TRONG DANH SACH DO HAY KHONG

 SELECT *FROM GIAOVIEN
 WHERE MAGV = '001'
 -- 001 co ton tai trong danh sach
 AND MAGV  IN 
 (
   SELECT GV.GVQLCM FROM GIAOVIEN AS GV
 )

-- TRUY VAN LONG TRONG FROM
SELECT *FROM 
DBO.GIAOVIEN , (SELECT *FROM DBO.DETAI) AS DT


--CAU 1:  XUAT RA DANH SACH GIAO VIEN THAM GIA NHIEU HOWN MOT DE TAI
-- LAY RA TAT CA THONG TIN CUA GIAO VIEN
SELECT *FROM THAMGIADT
SELECT *FROM GIAOVIEN AS GV
-- KHI MA SO LUONG DE TAI GIAO VIEN DO THAM GIA LON HON 1
WHERE 1 < 
(
    SELECT COUNT(*) FROM THAMGIADT
    WHERE MAGV = GV.MAGV
)

SELECT *FROM THAMGIADT


-- CAU 2: XUAT RA THONG TIN CUA KHOA CO NHIEU HON 2 GIAO VIEN
 SELECT *FROM KHOA AS K
 WHERE 2 < 
 (
   SELECT COUNT(*) FROM BOMON AS BM, GIAOVIEN AS GV
   WHERE K.MAKHOA = BM.MAKHOA
   AND   BM.MABM = GV.MABM
 )


-- sort DECREEMENT
SELECT GV.MAGV FROM GIAOVIEN AS GV
ORDER BY GV.MAGV DESC

/*
BAI TAP
  1. XUAT RA THONG TIN GIAO VIEN CO HON 2 NGUOI THAN
  2. XUAT RA danh sach cac giao vien lon tuoi hon 50% cac giao vien trong truong

*/


 -- -----------------------------------------------------------------------------------------------------------------
--  Bài 18: Group by| HowKteam
-- xuat ra danh sach ten bo mon va so luong giao vien cua bo mon do


SELECT BOMON.TENBM,PHONG, COUNT(*) as "count" FROM dbo.BOMON , dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY TENBM, PHONG

-- lay ra danh sach giao vien co luong > luong tb cua giao vien
-- solution : lay ra tong luong giao vien -> tinh trung binh
SELECT *FROM dbo.GIAOVIEN
WHERE LUONG  > (SELECT SUM(GIAOVIEN."LUONG") AS "SALARY" FROM DBO.GIAOVIEN) /  (SELECT COUNT(*) FROM DBO.GIAOVIEN)

-- CACH 2
SELECT *FROM GIAOVIEN
WHERE LUONG > (SELECT AVG(LUONG) FROM GIAOVIEN)

-- XUAT RA TEN GIAO VIEN VA SO LUONG DE TAI GIAO VIEN DA LAM
SELECT *FROM dbo.DETAI
SELECT *FROM THAMGIADT

SELECT HOTEN, COUNT(*) AS "SUM" FROM GIAOVIEN, THAMGIADT
WHERE GIAOVIEN.MAGV = THAMGIADT.MAGV
GROUP BY GIAOVIEN.MAGV, HOTEN



/*
BAI TAP
1. Xuat ra giao vien va so luong nguoi than cua giao vien do
*/
SELECT GIAOVIEN.HOTEN, COUNT(*) from NGUOITHAN, GIAOVIEN
WHERE GIAOVIEN.MAGV = NGUOITHAN.MAGV
GROUP BY GIAOVIEN.HOTEN, NGUOITHAN.MAGV

/*
2. Xuat ra giao vien va so luong de tai da hoan thanh va giao vien do tham gia
*/
SELECT HOTEN, COUNT(*) AS "HOAN THANH" FROM THAMGIADT, GIAOVIEN
WHERE GIAOVIEN.MAGV = THAMGIADT.MAGV AND KETQUA = N'Đạt'
GROUP BY HOTEN, KETQUA
-- NOTE : cột hiển thị phải là thuộc tính nằm trong group by hoặc là Agreeate Funtion
/*
  Agreeate Funtion

  AVG()   - Return a average value
  COUNT() - Return the number of rows
  FIRST() - Return the first value
  LAST()  - Return the last value
  MAX()   - Return the largest value
  MIN()   - Return the smallest value
  ROUND() - Return a numeric filed to the number of decimal specifiel
  SUM()   - Return the sum
*/

/*
Function 	Description
ASCII	() 	      Return the ASCII code value of a character
CHAR	() 	      Convert an ASCII value to a character
CHARINDEX		()   Search for a substring inside a string starting from a specified location and return the position of the substring.
CONCAT	() 	    Join two or more strings into one string
CONCAT_WS	() 	  Concatenate multiple strings with a separator into a single string
DIFFERENCE	() 	Compare the SOUNDEX() values of two strings
FORMAT	()     	Return a value formatted with the specified format and optional culture
LEFT	() 	      Extract a given a number of characters from a character string starting from the left
LEN	() 	        Return a number of characters of a character string
LOWER	() 	      Convert a string to lowercase
LTRIM	() 	      Return a new string from a specified string after removing all leading blanks
NCHAR  	()      Return the Unicode character with the specified integer code, as defined by the Unicode standard
PATINDEX	() 	  Returns the starting position of the first occurrence of a pattern in a string.
QUOTENAME	() 	  Returns a Unicode string with the delimiters added to make the input string a valid delimited identifier
REPLACE	() 	    Replace all occurrences of a substring, within a string, with another substring
REPLICAT	() E	  Return a string repeated a specified number of times
REVERSE		()      Return the reverse order of a character string
RIGHT	() 	        Extract a given a number of characters from a character string starting from the right
RTRIM	() 	         Return a new string from a specified string after removing all trailing blanks
SOUNDEX	() 	      Return a four-character (SOUNDEX) code of a string based on how it is spoken
SPACE	() 	         Returns a string of repeated spaces.
STR	()              Returns character data converted from numeric data.
STRING_AGG	() 	  Concatenate rows of strings with a specified separator into a new string
STRING_ESCAPE	() 	Escapes special characters in a string and returns a new string with escaped characters
STRING_SPLIT	() 	A table-valued function that splits a string into rows of substrings based on a specified separator.
STUFF	() 	        Delete a part of a string and then insert another substring into the string starting at a specified position.
SUBSTRING	() 	    Extract a substring within a string starting from a specified location with a specified length
TRANSLATE	() 	    Replace several single-characters, one-to-one translation in one operation.
TRIM	() 	        Return a new string from a specified string after removing all leading and trailing blanks
UNICODE	() 	      Returns the integer value, as defined by the Unicode standard, of a character.
UPPER	()        Convert a string to uppercase
*/





 -- -----------------------------------------------------------------------------------------------------------------
                          -- Bài 19: Group by - Having
-- xuat ra so luong giao vien trong tung bo mon ma giao vien > 2
-- HAVING giong nhu Where nhung gianh cho Group By 
SELECT BOMON.MABM, COUNT(*) FROM DBO.BOMON, DBO.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY DBO.BOMON.MABM
HAVING COUNT(*) > 2

-- Xuat ra muc luong va tong tuoi cua giao vien nhan muc luong do
-- va co nguoi than
-- va tuoi phai lon hon tuoi trung binh
SELECT LUONG, SUM(YEAR(GETDATE()) - YEAR(GIAOVIEN.NGSINH)) FROM GIAOVIEN, NGUOITHAN
WHERE GIAOVIEN.MAGV = NGUOITHAN.MAGV
AND GIAOVIEN.MAGV IN (SELECT MAGV FROM NGUOITHAN)
GROUP BY LUONG 
HAVING YEAR(GETDATE() - YEAR(GIAOVIEN.NGSINH)) > 
(
  (SELECT SUM(YEAR(GETDATE()) - YEAR(GIAOVIEN.NGSINH)) FROM GIAOVIEN)
  / (SELECT COUNT(*) FROM GIAOVIEN)
)


-- -----------------------------------------------------------------------------------------------------------------
                                  -- Bài 20: Auto Increament|


CREATE TABLE TestAuto
(
   ID INT PRIMARY KEY IDENTITY, -- tụ tăng trường này, phải là số        
   Name NVARCHAR(100)
)
GO

INSERT INTO dbo.TestAuto(Name) 
VALUES(N'O')

INSERT INTO TestAuto(Name) 
VALUES(N'O')

INSERT INTO TestAuto(Name) 
VALUES(N'O')

INSERT INTO TestAuto(Name) 
VALUES(N'O')

INSERT INTO TestAuto(Name) 
VALUES(N'O')

SELECT *from TestAuto
DROP TABLE TestAuto


-- -----------------------------------------------------------------------------------------------------------------
--  Bài 21: View
-- view là bảng ảo
-- cập nhập dữ liệu liệu theo bảng và view truy cấp tới, mỗi khi lấy view ra sài.
-- Tao bang luu ten giao vien, bo mon va luong
SELECT HOTEN, TENBM, LUONG INTO LUONGGIAOVIEN FROM GIAOVIEN,  BOMON
WHERE GIAOVIEN.MABM = BOMON.MABM

SELECT *FROM LUONGGIAOVIEN

UPDATE DBO.GIAOVIEN SET LUONG = 9000
WHERE MAGV = '006'

SELECT *FROM GIAOVIEN

-- create view
CREATE VIEW TestView AS 
SELECT *FROM DBO.GIAOVIEN

SELECT *FROM TestView

UPDATE DBO.GIAOVIEN SET LUONG = 999000
WHERE MAGV = '006'


SELECT *FROM TestView

DROP VIEW TestView

-- update view
ALTER VIEW TestView AS
SELECT HOTEN FROM GIAOVIEN 

SELECT *FROM TestView

-- CUSTOMVIEW CO DAU
CREATE view [Giáo dục miễn phí] as     
SELECT *FROM DBO.KHOA

SELECT *FROM dbo.[Giáo dục miễn phí]