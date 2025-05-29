#### Квоты {#kms-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество [симметричных ключей](../../kms/concepts/key.md)
`kms.keys.count` | 100 ||
|| Количество асимметричных ключей [шифрования](../../kms/concepts/asymmetric-encryption-key.md)
`kms.asymmetricEncryptionKeys.count` | 100 ||
|| Количество асимметричных ключей [подписи](../../kms/concepts/asymmetric-signature-key.md)
`kms.asymmetricSignatureKeys.count`| 100 ||
|#


#### Лимиты {#kms-limits}

Вид ограничения | Значение
----- | -----
Количество версий у одного ключа | 100
Максимальный объем данных для шифрования [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt)-операцией | 32 КБ
