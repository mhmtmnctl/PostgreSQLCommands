-- SELECT - SIMILAR TO - REGEX(Regular Expressions) --
/*
SIMILAR TO : Daha karmaşık pattern(kalıp) ile sorgulama işlemi için SIMILAR TO kullanilabilir
Sadece PostgreSQL de kullanılır. Büyük küçük harf önemlidir.

REGEX : Herhangi bir kod, metin içerisinde istenen yazı veya kod parçasının aranıp bulunmasını sağlayan
kendine ait bir söz dizimi olan bir yapıdır.MySQL de(REGEXP_LIKE) olarak kullanılır
PostgreSQL'de "~" karakteri ile kullanılır.
*/
CREATE TABLE kelimeler(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1005, 'hct', 3);
INSERT INTO kelimeler VALUES (1006, 'adem', 4);
INSERT INTO kelimeler VALUES (1007, 'selim', 5);
INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hip', 3);
INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);

   
SELECT * FROM kelimeler;  

-- İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
-- Veya işlemi için | karakteri kullanılır
--SIMILAR TO ile
SELECT * FROM kelimeler WHERE kelime SIMILAR TO '%(at|ot|Ot|oT|At|aT|OT)%';

--LIKE ile
SELECT * FROM kelimeler WHERE kelime ILIKE '%at%' OR kelime ILIKE '%ot%';
SELECT * FROM kelimeler WHERE kelime ~~* '%at' OR kelime ~~* '%ot';

--REGEX ile
SELECT * FROM kelimeler WHERE kelime ~* 'ot' OR kelime ~* 'at';
-- ~ -> case sensitive
-- ~* -> case insensitive

-- : 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
--SIMILAR TO ile
SELECT * FROM kelimeler WHERE kelime SIMILAR TO 'ho%|hi%';

--LIKE ile
SELECT * FROM kelimeler WHERE kelime ~~* '%ho' OR kelime ~~* '%ho';

--REGEX ile
SELECT * FROM kelimeler WHERE kelime ~* 'h[oi(.*)]';
--Regex'te ".(nokta)" bir karakteri temsil eder.
--Regex'te 2. karakter için köşeli parantez kullanılır.
-- * hepsi anlamında kullanılır


--Sonu 't' veya 'm' ile bitenleri listeleyeniz
--SIMILAR TO ile
SELECT * FROM kelimeler WHERE kelime SIMILAR TO '%t|%m';
--REGEX ile
SELECT * FROM kelimeler WHERE kelime ~* '(.*)[tm]$';
--$ karakteri bitişi gösterir


-- h ile başlayıp t ile biten 3 harfli kelimeleri listeleyiniz
--SIMILAR TO ile
SELECT * FROM kelimeler WHERE kelime SIMILAR TO 'h[a-z,A-Z,0-9]t';
--LIKE ile
SELECT * FROM kelimeler WHERE kelime ~~* 'h_t';
--REGEX ile
SELECT * FROM kelimeler WHERE kelime ~* 'h[a-z,A-Z,0-9]t';


--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye 
--herhangi bir karakter olan “kelime" değerlerini çağırın.
--SIMILAR TO ile
SELECT kelime FROM kelimeler WHERE kelime SIMILAR TO 'h[a-e]%t';
--REGEX ile
SELECT kelime FROM kelimeler WHERE kelime ~* 'h[a-e](.*)t';


--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
SELECT kelime FROM kelimeler WHERE kelime SIMILAR TO 's% |a%| y%';
SELECT kelime FROM kelimeler WHERE kelime ~ '^[say](.*)';
-- ^ : başlangıcı temsil eder.

--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
SELECT kelime FROM kelimeler WHERE kelime ~ '(.*)[maf]$';

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
--REGEX ile
SELECT * FROM kelimeler WHERE kelime ~ '^[h][a,i]t$';
--SIMILAR TO ile
SELECT * FROM kelimeler WHERE kelime SIMILAR TO 'h[a|i]t';

--İlk harfi 'b' den ‘s' ye bir karakter olan ve 
--ikinci harfi herhangi bir karakter olup üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.
SELECT kelime FROM kelimeler WHERE kelime ~ '^[b-s].l(.*)';

--içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
SELECT * FROM kelimeler WHERE kelime ~ '(.*)oo(.*)';
SELECT kelime FROM kelimeler WHERE kelime SIMILAR TO '%[o][o]%';
SELECT kelime FROM kelimeler WHERE kelime SIMILAR TO '%[o]{2}%';
--Süslü parantez içinde belirttiğimiz rakam bir önceki
--köşeli parantez içindeki ifadenin kaç tane olacağını belirtir

--içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
SELECT kelime FROM kelimeler WHERE kelime SIMILAR TO '%[o]{4}%';

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
SELECT kelime FROM kelimeler WHERE kelime ~ '^[a|s|y](.*)[m|f]$';
