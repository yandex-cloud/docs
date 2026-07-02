[Документация Yandex Cloud](../../index.md) > [Yandex Key Management Service](../index.md) > [Концепции](index.md) > Квоты и лимиты

# Квоты и лимиты в Key Management Service

В сервисе Key Management Service действуют следующие ограничения:

* [_Квоты_](https://console.yandex.cloud/cloud?section=quotas) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.
* _Лимиты_ — технические ограничения, обусловленные особенностями архитектуры Yandex Cloud. Изменить лимиты невозможно.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение](https://console.yandex.cloud/cloud?section=quotas).
* Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [Cloud Quota Manager](../../quota-manager/quickstart.md).

#### Квоты {#kms-quotas}

#|
|| Вид ограничения | Значение ||
|| Количество [симметричных ключей](key.md)
`kms.keys.count` | 100 ||
|| Количество асимметричных ключей [шифрования](asymmetric-encryption-key.md)
`kms.asymmetricEncryptionKeys.count` | 100 ||
|| Количество асимметричных ключей [подписи](asymmetric-signature-key.md)
`kms.asymmetricSignatureKeys.count`| 100 ||
|#


#### Лимиты {#kms-limits}

Вид ограничения | Значение
----- | -----
Количество версий у одного ключа | 100
Максимальный объем данных для шифрования [encrypt](../api-ref/SymmetricCrypto/encrypt.md)-операцией | 32 КБ