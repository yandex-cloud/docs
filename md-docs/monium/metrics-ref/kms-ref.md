[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > Key Management Service

# Метрики Yandex Key Management Service

В этом разделе описаны метрики сервиса [Key Management Service](../../kms/index.md), поставляемые в Monium Metrics.

Имя метрики пишется в метку `name`.

Все метрики сервиса Key Management Service имеют общую метку `kms`.

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `asymmetricEncryptionKey.asymmetric_encryption_crypto_operations_rate`<br>`RATE`, операции/с | Скорость выполнения криптографических операций шифрования с использованием асимметричных ключей шифрования. Специальная метка `key` — идентификатор асимметричной [ключевой пары шифрования](../../kms/concepts/asymmetric-encryption-key.md). |
| `asymmetricSignatureKey.asymmetric_signature_crypto_operations_rate`<br>`RATE`, операции/с | Скорость выполнения криптографических операций с электронной подписью. Специальная метка `key` — идентификатор асимметричной [ключевой пары подписи](../../kms/concepts/asymmetric-signature-key.md). |
| `key.active_versions_count`<br>`DGAUGE`, штуки | Количество активных версий симметричного ключа шифрования. Специальная метка `key` — идентификатор [симметричного ключа](../../kms/concepts/key.md) шифрования. |
| `key.crypto_operations_rate`<br>`RATE`, операции/с | Скорость выполнения криптографических операций с использованием симметричных ключей шифрования. Специальная метка `key` — идентификатор [симметричного ключа](../../kms/concepts/key.md) шифрования. |
| `key_asymmetric_encryption_crypto_operations_rate_created`<br>`DGAUGE`, операции | Количество криптографических операций с использованием асимметричных ключей шифрования. Специальная метка `key` — идентификатор асимметричной [ключевой пары шифрования](../../kms/concepts/asymmetric-encryption-key.md). |
| `key_asymmetric_signature_crypto_operations_rate_created`<br>`DGAUGE`, операции | Количество криптографических операций с электронной подписью. Специальная метка `key` — идентификатор асимметричной [ключевой пары подписи](../../kms/concepts/asymmetric-signature-key.md). |
| `key_crypto_operations_rate_created`<br>`DGAUGE`, операции | Количество всех криптографических операций с использованием симметричных ключей, асимметричных ключевых пар шифрования и электронных подписей. Специальная метка `key` — идентификатор ключа. |