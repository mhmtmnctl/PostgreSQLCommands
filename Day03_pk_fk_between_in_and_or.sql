CREATE TABLE calisanlar
(
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
CONSTRAINT ism_ung UNIQUE(isim)
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
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY

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

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayiz

INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

--Calisanlar id ile adresler tablosundaki adres_id ile eslesenlere bakmak icin 
SELECT * FROM calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;

DROP TABLE calisanlar;
--Parent tabloyu yani primary key olan tabloyu silmek istedigimizde tabloyu silmez
--Once child tabloyu silmemiz gerekir

DELETE FROM calisanlar WHERE id = '10002';--Parent (child'i silmeden silmeye izin vermiyor)

DELETE FROM adresler WHERE adres_id = '10002'; --Child

DROP TABLE calisanlar;

--ON DELETE CASCADE--
--Her defasinda once child tablodaki verileri silmek yerine 
--ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz
--Bunun icin FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmamiz yeterli

CREATE TABLE talebeler(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
ON DELETE CASCADE
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

SELECT * FROM talebeler;
SELECT * FROM notlar;

DELETE FROM notlar WHERE talebe_id = '123';

DELETE FROM talebeler WHERE id = '126';
--ON DELETE CASCADE kullandigimiz icin Parent table'dan direk silebildik 
--Parent table'dan sildigimiz icin child table'dan da silinmis oldu

DELETE FROM talebeler;

DROP table talebeler CASCADE;
--Parent tabloyu kaldirmak istersek Drop table tablo_adi'ndan sonra CASCADE komutunu kullaniriz


--Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz 
--ve veri tipini VARCHAR(30) olarak degistiriniz 
ALTER TABLE talebeler 
ALTER COLUMN isim TYPE VARCHAR(30),
ALTER COLUMN isim SET NOT NULL;

--Talebeler tablosundaki yazili_notu sutununu 60'dan buyuk sayi girilebilsin
ALTER TABLE talebeler
ADD CONSTRAINT sinir CHECK (yazili_notu>60);
--CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabilirsiniz

INSERT INTO talebeler VALUES(128,'Mustafa Can','Hasan',45);
--Yukarida 60'i sinir olarak belirledigimiz icin bunu eklemedi

CREATE TABLE ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

CREATE TABLE ogrenci_adres
AS
SELECT id, adres FROM ogrenciler;

SELECT * FROM ogrenciler;
SELECT * FROM ogrenci_adres;

--Tablodaki bir sutuna PRIMARY KEY ekleme--
ALTER TABLE ogrenciler
ADD PRIMARY KEY (id);

--PRIMARY KEY olusturmada 2.yol--
ALTER TABLE ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY(id);

--PK'den sonra FK atamasi--
ALTER TABLE ogrenci_adres 
ADD FOREIGN KEY (id) REFERENCES ogrenciler;
--Child tabloyu parent tablodan olusturdugumuz icin sutun adi verilmedi(gerek yok)


--PK'yi silme CONSTRAINT silme 
ALTER TABLE ogrenciler DROP CONSTRAINT pk_id;
--FK'yi silme CONSTRAINT silme 
ALTER TABLE ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

--Yazili notu 85'den buyuk olan talebe bilgilerini getirin
SELECT * FROM talebeler WHERE yazili_notu>85;

--Ismi Mustafa Bak olan talebenin tum bilgilerini getirin
SELECT * FROM talebeler WHERE isim = 'Mustafa Bak';

--SELECT komutunda -- BETWEEN koşulu--
--Between belirtiginiz 2 veri arasindaki bilgileri listeler
--Between de belirttigimiz degerler de listelemeye dahildir

CREATE TABLE personel(
id char(4),
isim varchar(50),
maas int
);

INSERT INTO personel VALUES('1001', 'Ali Can', 70000);
INSERT INTO personel VALUES('1002', 'Veli Mert', 85000);
INSERT INTO personel VALUES('1003', 'Ayşe Tan', 65000);
INSERT INTO personel VALUES('1004', 'Derya Soylu', 95000);
INSERT INTO personel VALUES('1005', 'Yavuz Bal', 80000);
INSERT INTO personel VALUES('1006', 'Sena Beyaz', 100000);

/*
  AND (ve): Belirtilen sartlarin her ikisi de gerceklesiyorsa o kayit listelenir
  Bir tanesi gerceklesmezse listelemez
  SELECT * FROM matematik WHERE sinav1>50 AND sinav2>50
  Hem sinav1 hem de sinav2 alani, 50'den buyuk olan kayitlari listeler
  
  OR(veya): Belirtilen sartlardan biri gerceklesirse, kayit listelenir
  SELECT * FROM matematik WHERE sinav1>50 OR sinav2>50
  sinav1 veya sinav2 alani, 50'den buyuk olan kayitlari listeler
*/

SELECT * FROM personel;

--id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz
SELECT * FROM personel WHERE id BETWEEN '1003' AND '1005';

--2.YOL
SELECT * FROM personel WHERE id>='1003' and id<='1005';

--Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz
SELECT * FROM personel WHERE isim BETWEEN 'Derya Soylu' AND 'Yavuz Bal';

--Maasi 70000 veya ismi Sena olan personeli listele
SELECT * FROM personel WHERE maas=70000 OR isim='Sena Beyaz';

--IN: Birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutta yazabilme imkani verir
--Farkli sutunlar icin IN kullanilamaz

--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele 
SELECT * FROM personel WHERE id = '1001' OR id = '1002' OR id = '1004';

--2.yol
SELECT * FROM personel WHERE id IN ('1001','1002','1004');

--Maasi sadece 70000, 10000 olan personeli listele
SELECT * FROM personel WHERE maas IN (70000,100000);

/*
SELECT - LIKE kosulu 
LIKE: Sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ILIKE: Sorgulama yaparken buyuk/kucuk harfe duyarsiz olarak eslestirilir 
LIKE: ~~
ILIKE: ~~*
NOT LIKE: !~~
NOT ILIKE: !~~*

% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir.
*/

--Ismi A harfi ile baslayan personeli listele 
SELECT * FROM personel WHERE isim LIKE 'A%';

--Ismi t harfi ile biten personeli listele 
SELECT * FROM personel WHERE isim LIKE '%t';

--Isminin 2. harfi e olan personeli listeleyiniz
SELECT * FROM personel WHERE isim ILIKE '_e%';
