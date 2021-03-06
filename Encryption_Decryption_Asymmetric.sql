select * from  [TestTable]



CREATE MASTER KEY ENCRYPTION BY PASSWORD='hrhk@123'
GO

CREATE ASYMMETRIC KEY Asy_key
WITH ALGORITHM=RSA_512
ENCRYPTION BY PASSWORD='hrhk@123';

GO

OPEN ASYMMETRIC KEY  Asy_key
DECRYPTION BY PASSWORD='hrhk@123';
UPDATE [TestTable] SET
EncryptCol=ENCRYPTBYASYMKEY(ASYMKEY_ID('Asy_key'),SecondCol)

CLOSE ASYMMETRIC KEY  Asy_key



---=========================DECRYTION ==============================

SELECT t.FirstCol,t.SecondCol,t.EncryptCol,
 (CONVERT(varchar(256), DECRYPTBYASYMKEY(ASYMKEY_ID('Asy_key'),   t.EncryptCol, N'hrhk@123')))
 AS 'Decrypted Value' FROM [TestTable] t



