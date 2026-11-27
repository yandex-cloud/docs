[Документация Yandex Cloud](../../index.md) > [Yandex Monitoring](../index.md) > [Справочник метрик](index.md) > Key Management Service

# Метрики Yandex Key Management Service

В этом разделе описаны метрики сервиса [Key Management Service](../../kms/index.md), поставляемые в Monitoring.

Метрики сервиса Key Management Service автоматически передаются в [Monium](../../monium/metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находятся ключи.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../../monium/operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы вводите запрос в Monium в [разделе метрик](../../monium/metrics/metric-explorer.md#add-graph) или при создании алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.

Имя метрики пишется в метку `name`.

Идентификатор сервиса — `kms`.

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

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.