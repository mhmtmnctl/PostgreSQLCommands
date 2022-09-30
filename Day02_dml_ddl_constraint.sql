--Personel isminde bir tablo olusturalim
CREATE table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)	
);

--Varolan personel tablosundan pers_id,sehir,adres fieldlarina sahip persone_adres adinda yeni bir tablo olusturalim
CREATE table personel_adres
AS
SELECT pers_id,sehir,adres FROM personel;

-- DML --> Data Manipulation Lang.
-- INSERT - UPDATE - DELETE
-- Tabloya veri ekleme, tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar
-- INSERT:
CREATE table student(
id varchar(4),
st_name varchar(30),
age int
);

INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);
--Tabloya parcali veri ekleme
INSERT into student(st_name,age) VALUES ('Murat Can',65);


--DQL --> Data Query Lang.
--SELECT:
SELECT * from student;
SELECT st_name from student;
--SELECT KOMUTU WHERE KOSULU:
SELECT * from student WHERE age>35;


--TCL - Transaction Control Lang.
--Begin - Savepoint - Rollback - Commit
--Transaction veritabani sistemlerinde bir islem basladiginda baslar ve islem bitince sona erer
--Bu islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir

--serial,default kullanimi:
CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
BEGIN;
INSERT INTO ogrenciler2 VALUES (default,'Ali Can','Hasan Can',75.5);
INSERT INTO ogrenciler2 VALUES (default,'Canan Gül','Ayşe Şen',90.5);
SAVEPOINT x;
INSERT INTO ogrenciler2 VALUES (default,'Kemal Can','Ahmet Can',85.5);
INSERT INTO ogrenciler2 VALUES (default,'Ahmet Şen','Ayşe Can',65.5);

ROLLBACK TO x;

SELECT * FROM ogrenciler2;

COMMIT;


--Transaction kullaniminda SERIAL data turu kullanimi tavsiye edilmez.
--savepoint sonra ekledigimiz veride sayac mantigi ile calistigi icin
--sayacta en son hangi sayida kaldiysa oradan devam eder
-- NOT: PostgreSQL de transaction kullanimi icin 'Begin' komutu ile baslariz sonrasinda tekrar yanlis bir veriyi
-- duzeltmek veya bizim icin onemli olan verilerden sonra ekleme yapabilmek icin 'SAVEPOINT savepointadi' 
-- komutunu kullaniriz ve bu savepointe donebilmek icin 'ROLLBACK to savepointadi' komutunu kullaniriz
-- ve rollback calistirildiginda savepoint yazdigimiz satirin ustundeki verileri tabloda bize verir
-- ve son olarak Transaction'i sonlandirmak icin mutlaka 'COMMIT' komutu kullaniriz
-- MySQL'de transaction olmadan da kullanilir


--DML - DELETE -
-- DELETE FROM tablo_adi --> Tablo'nun tum icerigini siler
-- Veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi = veri --> Tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler;

--Soru: id'si 124 olan ogrenciyi siliniz
DELETE FROM ogrenciler WHERE id = 124;

--Soru: ismi Kemal Yasa olan satiri siliniz
DELETE FROM ogrenciler WHERE isim = 'Kemal Yasa';

-- Soru : ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtları silelim
DELETE FROM ogrenciler WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';

--Soru: ismi Ali Can ve id'si 123 olan kaydi siliniz
DELETE FROM ogrenciler WHERE isim = 'ALi Can' AND id = 123;

-- Tablodaki tüm verileri silelim
DELETE FROM ogrenciler

-- DELETE - TRUNCATE --
-- TRUNCATE KOMUTU DELETE komutu gibi bir tablodaki verilerin tamamini siler
-- Ancak, secmeli silme yapamaz
SELECT * FROM ogrenciler;
TRUNCATE TABLE ogrenciler;


-- DDL - Data Definition Lang.
-- CREATE - ALTER - DROP
-- ALTER TABLE --
-- ALTER TABLO tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS islemleri icin kullanilir

--Personel isminde bir tablo olusturalim
CREATE TABLE personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)	
);

SELECT * FROM personel;

-- Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz
ALTER TABLE personel ADD cinsiyet varchar(20), ADD yas int;

-- Personel tablosundan sirket field'ini siliniz
ALTER TABLE personel DROP COLUMN sirket;

-- Personel tablosundaki sehir sutununun adini ulke olarak degistiriniz
ALTER TABLE personel RENAME COLUMN sehir TO ulke;

-- Personel tablosunun adini isciler olarak degistiriniz
ALTER TABLE personel RENAME TO isciler;

SELECT * FROM isciler;

-- DDL - DROP komutu
DROP TABLE isciler; -- tabloyu komple siler

-- CONSTRAINT-- Kisitlamalar
-- PRIMARY KEY --> Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSIZ olmasini saglar (NOT NULL - UNIQUE)
-- FOREIGN KEY --> Baska bir tablodaki Primary Key'i referans gostermek icin kullanilir
-- Boylelikle tablolar arasinda iliski kurmus oluruz
-- UNIQUE --> Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar 
-- NOT NULL --> Bir sutunun NULL icermemesini yani bos olmamasini saglar 
-- NOT NULL kisitlamasi icin CONSTRAINT ismi tanimlanmaz. Bu kisitlama veri turunden hemen sonra yerlestirilir
-- CHECK --> Bir sutuna yerlestirilebilecek deger araligini sinirlamak icin kullanilir.


CREATE TABLE calisanlar(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

CREATE TABLE calisanlar2(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,	
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT ism_unq UNIQUE(isim)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14'); --primary key hicligi bir kez kabul ediyor
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY

SELECT * FROM calisanlar;

-- FOREIGN KEY -- 
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

SELECT * FROM adresler;
