-- AGGREGATE METHOD KUALLANIMI
/*
-Aggregate Methodları (SUM,COUNT,MIN,MAX,AVG)
-Subquery içinde de kullanılır
-Ancak sorgu tek bir değer döndürüyor olmalıdır
SYNTAX: sum() şeklinde olmalı sum () arasında boşluk olmamalı
*/

SELECT * FROM calisanlar2;

--Çalışanlar2 tablosundaki en yüksek maaş değerini listeleyiniz
SELECT MAX(maas) FROM calisanlar2;

--calisanlar2 tablosundaki maaslarin toplamını listeleyiniz
SELECT SUM(maas) FROM calisanlar2;

--calisanlar2 tablosundaki maas ortalamasını listeleyiniz
SELECT AVG(maas) FROM calisanlar2;
SELECT round(AVG(maas),2) FROM calisanlar2;

--calisanlar2 tablosundaki en düşük maaşı listeleyiniz
SELECT MIN(maas) FROM calisanlar2;

--calisanlar2 tablosundaki kaç kişinin maaş aldığını listeleyiniz
SELECT COUNT(maas) FROM calisanlar2;

SELECT * FROM calisanlar2;
SELECT * FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşını listeleyiniz
SELECT marka_isim, calisan_sayisi, (SELECT SUM(maas) FROM calisanlar2 
WHERE marka_isim = isyeri) AS toplam_maas FROM markalar;

-- ALIAS (AS) --> Tabloda geçici isim vermek istersek koşuldan sonra AS sutun_isim olarak kullanılır.

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşını listeleyen bir sorgu yaziniz.
SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM calisanlar2 WHERE marka_isim = isyeri) AS max_maas,
                                   (SELECT MIN(maas) FROM calisanlar2 WHERE marka_isim = isyeri) AS min_maas FROM markalar;
								   
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir sorgu yaziniz.
SELECT marka_id, marka_isim, (SELECT COUNT(sehir) FROM calisanlar2 
							  WHERE marka_isim = isyeri) AS sehir_sayisi FROM markalar;

--Interview Question: En yüksek ikinci maas değerini çağırın.
SELECT MAX(maas) AS en_yuksek_ikinci_maas FROM calisanlar2 
WHERE maas<(SELECT MAX(maas) FROM calisanlar2);

----Interview Question: En düşük ikinci maas değerini çağırın.
SELECT MIN(maas) AS en_dusuk_ikinci_maas FROM calisanlar2 
WHERE maas>(SELECT MIN(maas) FROM calisanlar2);

--En yüksek üçüncü maas değerini bulun
SELECT MAX(maas) AS en_yuksek_ucuncu_maas FROM calisanlar2 
WHERE maas<(SELECT MAX(maas) FROM calisanlar2 WHERE maas<(SELECT MAX(maas) FROM calisanlar2));

--En düşük üçüncü maaş değerini bulunuz (ÖDEV)
SELECT MIN(maas) AS en_dusuk_ucuncu_maas FROM calisanlar2
WHERE maas>(SELECT MIN(maas) FROM calisanlar2 WHERE maas>(SELECT MIN(maas) FROM calisanlar2));