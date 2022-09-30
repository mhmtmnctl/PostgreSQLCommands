-- ORDER BY --
-- ORDER BY cümleciği bir sorgu deyimi içerisinde belli bir sütuna göre
-- sıralama yapmak için kullanılır

CREATE TABLE kisiler 
(
id int PRIMARY KEY,
ssn CHAR(9) ,
isim VARCHAR(50), 
soyisim VARCHAR(50), 
maas int,
adres VARCHAR(50) 
);
    
INSERT INTO kisiler VALUES(1, 123456789, 'Ali','Can', 3000,'Istanbul');
INSERT INTO kisiler VALUES(2, 234567890, 'Veli','Cem', 2890,'Ankara');
INSERT INTO kisiler VALUES(3, 345678901, 'Mine','Bulut',4200,'Adiyaman');
INSERT INTO kisiler VALUES(4, 256789012, 'Mahmut','Bulut',3150,'Adana');
INSERT INTO kisiler VALUES (5, 344678901, 'Mine','Yasa', 5000,'Ankara');
INSERT INTO kisiler VALUES (6, 345458901, 'Veli','Yilmaz',7000,'Istanbul');
INSERT INTO kisiler VALUES(7,113456789, 'Ali','Can', 3000,'Istanbul');
INSERT INTO kisiler VALUES(8,224567890, 'Veli','Cem', 2890,'Ankara');
INSERT INTO kisiler VALUES(9,335678901, 'Mine','Bulut',4200,'Ankara');
INSERT INTO kisiler VALUES(10,446789012, 'Mahmut','Bulut',3150,'Istanbul');
INSERT INTO kisiler VALUES (11,554678901, 'Mine','Yasa', 5000,'Ankara');
INSERT INTO kisiler VALUES (12,665458901, 'Veli','Yilmaz',7000,'Istanbul');

-- kisiler tablosunu adres'e göre sıralayarak sorgulayınız.
SELECT * FROM kisiler ORDER BY adres;
SELECT * FROM kisiler ORDER BY adres ASC; 
-- ASCENDING (ASC) yazmasak da sıralı verir.

--kisiler tablosunu adres'e göre tersten sıralayarak sorgulayınız.
SELECT * FROM kisiler ORDER BY adres DESC;

--Kisiler tablosunda maaşı büyükten küçüğe sıralayınız
SELECT * FROM kisiler ORDER BY maas DESC;

-- ismi Mine olanları, maas a göre AZALAN sırada sorgulayınız
SELECT * FROM kisiler WHERE isim = 'Mine' ORDER BY maas DESC;

-- soyismi 'i Bulut olanları maas sıralı olarak sorgulayınız.
SELECT * FROM kisiler WHERE soyisim = 'Bulut' ORDER BY maas ASC;