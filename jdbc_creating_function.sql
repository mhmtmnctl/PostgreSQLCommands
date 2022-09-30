--Function oluşturma
--1. Örnek: İki parametre ile çalışıp bu parametreleri toplayarak return yapan bir fonksiyon oluşturun.

CREATE OR REPLACE FUNCTION addf(x NUMERIC, y NUMERIC)
RETURNS NUMERIC 
LANGUAGE plpgsql --procedure language
AS
$$
BEGIN

RETURN x+y; 

END
$$

SELECT * FROM addF(15,25) AS toplam;

CREATE OR REPLACE FUNCTION volumef(r NUMERIC, h NUMERIC)
RETURNS NUMERIC 
LANGUAGE plpgsql 
AS
$$
BEGIN

RETURN 3.14*r*r*h/3;

END
$$

SELECT * FROM volumef(3,4) AS hacim;