CREATE TABLE sirketler
(
	sirket_id int,
	sirket_isim VARCHAR(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');
CREATE TABLE siparisler
(
	siparis_id int,
	sirket_id int,
	siparis_tarihi DATE
);
INSERT INTO siparisler VALUES(11, 101, '2022-04-17');
INSERT INTO siparisler VALUES(22, 102, '2022-04-18');
INSERT INTO siparisler VALUES(33, 103, '2022-04-19');
INSERT INTO siparisler VALUES(44, 104, '2022-04-20');
INSERT INTO siparisler VALUES(55, 105, '2022-04-21');

SELECT * FROM sirketler;
SELECT * FROM siparisler;

-- SORU1: Iki Tabloda sirket_id’si ayni olanlarin; sirket_ismi, siparis_id ve
-- siparis_tarihleri listeleyen bir sorgu yaziniz.
SELECT A.sirket_id,A.sirket_isim,B.siparis_tarihi,B.siparis_id 
FROM siparisler AS B
INNER JOIN sirketler AS A
ON A.sirket_id = B.sirket_id;


--SORU2: sirketler tablosundaki tum sirketleri(yani isimleri) ve bu sirketlere ait olan
--siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
-- 1. yol left join
SELECT A.sirket_id, A.sirket_isim ,B.siparis_tarihi, B.siparis_id 
FROM sirketler AS A
LEFT JOIN siparisler AS B
ON A.sirket_id = B.sirket_id;

-- 2. yol right join
SELECT A.sirket_id, A.sirket_isim, B.siparis_tarihi, B.siparis_id 
FROM siparisler AS B
RIGHT JOIN sirketler AS A
ON A.sirket_id = B.sirket_id;

--3. yol full join- union 
SELECT A.sirket_id, A.sirket_isim, B.siparis_tarihi, B.siparis_id 
FROM siparisler AS B
RIGHT JOIN sirketler AS A
ON A.sirket_id = B.sirket_id;
UNION
SELECT A.sirket_id, A.sirket_isim ,B.siparis_tarihi, B.siparis_id 
FROM sirketler AS A
LEFT JOIN siparisler AS B
ON A.sirket_id = B.sirket_id;


-- SORU3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile
-- bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
-- 1. yol left join
------ buraya eklenecek
SELECT  A.sirket_id, B.sirket_isim, A.siparis_tarihi, A.siparis_id 
FULL JOIN sirketler AS B
ON A.sirket_id = B.sirket_id;

