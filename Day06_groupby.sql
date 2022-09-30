-- GROUP BY --
/*
GROUP BY cümleciği bir SELECT ifadesinde satırları, sütunları
değerlerine göre özet olarak gruplamak için kullanılır.
GROUP BY cümleciği her grup başına satır döndürür
GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi
aggregate fonksiyonları ile birlikte kullanılır
*/

CREATE TABLE manav (
isim varchar(50), 
urun_adi varchar(50), 
urun_miktari int 
);
    
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', null, 2);

CREATE TABLE personel(
id int PRIMARY KEY,
ad varchar(20),
soyad varchar(20),
yas int,
cinsiyet char,
sehir varchar(20),
ulke varchar(20),
maas int
);

INSERT INTO personel VALUES(100, 'Eymen',  'Bal', '25', 'E', 'Istanbul', 'Turkiye', '20000');
INSERT INTO personel VALUES(101, 'Derya', 'Soylu', '35', 'K', 'Istanbul', 'Turkiye', '25000');
INSERT INTO personel VALUES(102, 'Enes', 'Boz', '55', 'E', 'Istanbul', 'Turkiye', '22000');
INSERT INTO personel VALUES(103, 'Nil', 'Naz', '45', 'K', 'Trabzon', 'Turkiye', '20000');
INSERT INTO personel VALUES(104, 'Ali', 'Can', '28', 'E', 'Ankara', 'Turkiye', '15000');
INSERT INTO personel VALUES(105, 'Yusuf', 'Cengiz', '46', 'E', 'Bolu', 'Turkiye', '30000');
INSERT INTO personel VALUES(106, 'Ahmet', 'Aslan', '38', 'E', 'Adana', 'Turkiye', '28000');
INSERT INTO personel VALUES(107, 'Mehmet', 'Aslan', '29', 'E', 'Gaziantep', 'Turkiye', '21000');
INSERT INTO personel VALUES(108, 'Sena', 'Yavuz', '49', 'K', 'New York', 'USA', '40000');
INSERT INTO personel VALUES(109, 'Zehra', 'Amber', '52', 'K', 'New York', 'USA', '45000');
INSERT INTO personel VALUES(110, 'Fatma', 'Nur', '33', 'K', 'Berlin', 'Almanya', '35000');
INSERT INTO personel VALUES(111, 'Mustafa', 'Bay', '44', 'E', 'Paris', 'Fransa', '34000');
INSERT INTO personel VALUES(112, 'Murat', 'Kerem', '28', 'E', 'Istanbul', 'Turkiye', '29000');
INSERT INTO personel VALUES(113, 'Sinan', 'Ay', '45', 'E', 'Izmir', 'Turkiye', '19000');
INSERT INTO personel VALUES(114, 'Figen', 'Bal', '55', 'K', 'Istanbul', 'Turkiye', '25000');
INSERT INTO personel VALUES(115, 'Serkan', 'Bayram', '36', 'E', 'Londra', 'Ingiltere', '50000');
INSERT INTO personel VALUES(116, 'Hakan', 'Bacak', '29', 'E', 'Londra', 'Ingiltere', '55000');
INSERT INTO personel VALUES(117, 'Zafer', 'Yanak', '47', 'E', 'Berlin', 'Almanya', '42000');
INSERT INTO personel VALUES(118, 'Birol', 'Kara', '37', 'E', 'Paris', 'Fransa', '41000');
INSERT INTO personel VALUES(119, 'Ayten', 'Tan', '32', 'K', 'Roma', 'Italya', '39000');

SELECT * FROM manav;
SELECT * FROM personel;

-- kisi ismine göre satılan toplam meyve miktarlarını gösteren sorguyu yazınız.
SELECT isim,SUM(urun_miktari) AS toplam_urun FROM manav GROUP BY isim;

-- satılan meyve türüne (urun_adi) göre urun alan kişi sayısını gösteren
-- sorguyu yazınız. NULL olarak girilen meyveyi listelemesin.
SELECT urun_adi, COUNT(isim) AS kisi_sayisi 
FROM manav WHERE urun_adi IS NOT NULL GROUP BY urun_adi;

-- satılan meyve türüne (urun_adi) göre satılan (urun_miktari)MIN ve 
-- MAX urun miktarlarini, MAX urun miktarina göre sıralayarak listeyen sorguyu yazınız.
SELECT urun_adi, MIN(urun_miktari) AS min_urun_miktari, 
MAX(urun_miktari) AS max_urun_miktari FROM manav
WHERE urun_adi IS NOT null
GROUP BY urun_adi 
ORDER BY max_urun_miktari;

-- kisi ismine ve urun adına göre satılan ürünlerin toplamını gruplandıran
-- ve isime göre ters sırasıda listeyen sorguyu yazınız.
SELECT isim, urun_adi, SUM(urun_miktari) AS toplam_urun FROM manav
GROUP BY isim, urun_adi 
ORDER BY isim DESC;

-- personelin calıştığı ülkeleri listeleyiniz
SELECT ulke FROM personel GROUP BY ulke;

-- Ülkelere göre ortalama maaşları listeleyiniz
SELECT ulke, ROUND(AVG(maas),2) AS ortalama_maas FROM personel GROUP BY ulke;

-- Maas ortalamasını bayanlar ve baylar olarak sorgulayınız
SELECT cinsiyet,ROUND(AVG(maas),2) AS ortalama_maas FROM personel GROUP BY cinsiyet;

-- Personelin, ulkelere göre ve şehirlere göre gruplayarak sorgulayın
SELECT ulke,sehir FROM personel GROUP BY ulke,sehir;

-- Personelin, ulkelere göre ve şehirler göre calışan sayısını sorgulayın.
SELECT ulke,sehir, COUNT(sehir) AS calisan_sayisi FROM personel GROUP BY ulke,sehir;

-- Her ulke için bay ve bayan çalışan sayısı ve yaş ortalamasını sorgulayınız.
SELECT ulke,cinsiyet, COUNT(*) AS calisan_sayisi, ROUND(AVG(yas)) AS yas_ortalamasi FROM personel GROUP BY ulke,cinsiyet;

-- Her ulke için bay ve bayan çalışan sayısı ve yaş ortalamasını  ve maası 30000 den büyük olanları sorgulayınız.
SELECT ulke,cinsiyet, ROUND(AVG(yas)) AS yas_ortalamasi, COUNT(*) AS calisan_sayisi FROM personel 
WHERE maas>30000 GROUP BY ulke,cinsiyet;

-- Her ulke için; bay ve bayan çalışan sayısı, yaş ortalamasını, maaşı 30000 den büyük olanları
-- ve ortalama yaşı büyükten küçüğe doğru sıralayınız.
SELECT ulke,cinsiyet, ROUND(AVG(yas)) AS yas_ortalamasi, COUNT(*) AS calisan_sayisi FROM personel 
WHERE maas>30000 GROUP BY ulke,cinsiyet ORDER BY yas_ortalamasi DESC;