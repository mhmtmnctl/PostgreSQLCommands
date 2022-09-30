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

-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
SELECT * FROM personel WHERE isim ~~* 'a%n';

-- ikinci karakteri 'a' ve dördüncü karakteri 'u' olan personel isimlerini listeleyiniz
SELECT isim FROM personel WHERE isim ILIKE '_a_u%';

-- İçinde 'e' ve 'r' bulunan personel isimlerini listeleyiniz
SELECT isim FROM personel WHERE isim ~~* '%e%' AND isim ~~* '%r%';

-- 2. harfi e olup diğer harflerinde y olan personeli listeleyiniz
SELECT * FROM  personel WHERE isim LIKE '_e%y%';

-- a harfi olmayan personeli listeleyin
SELECT * FROM personel WHERE isim NOT ILIKE '%a%';

-- 1. harfi A ve 7. harfi a olan personeli listeleyin
SELECT * FROM personel WHERE isim LIKE 'A_____a%';

--Sondan ikinci karakteri 'r' olan "isim" değerlerini listeleyiniz.
SELECT isim FROM personel WHERE isim LIKE '%r_';