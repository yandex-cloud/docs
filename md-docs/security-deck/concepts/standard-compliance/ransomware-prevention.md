[Документация Yandex Cloud](../../../index.md) > [Yandex Security Deck](../../index.md) > [Концепции](../index.md) > [Интерфейс соответствия требованиям](index.md) > Стандарт предотвращения атак программ-шифровальщиков

# Стандарт предотвращения атак программ-шифровальщиков

Приведенный набор правил содержит требования безопасности для снижения рисков от атак программ-шифровальщиков (ransomware) в облачной инфраструктуре Yandex Cloud.

Шифровальщики — один из наиболее распространенных и разрушительных видов кибератак: злоумышленники шифруют данные жертвы и требуют выкуп за их восстановление. В облачных средах атаки шифровальщиков могут затрагивать объектные хранилища, диски виртуальных машин, базы данных и резервные копии.

Выполнение этих требований помогает обеспечить защиту от атак программ-шифровальщиков и минимизировать последствия в случае успешной атаки:

#|
|| Требование | Идентификатор проверки в [модуле CSPM](../cspm.md) ||
|| [Настроена двухфакторная аутентификация для привилегированных аккаунтов](../../../security/standard/all.md#mfa) | [cspm.access.userpool-mfa](../../rules-reference/cspm.md#userpool-mfa) ||
|| [В Object Storage включена функция «Блокировка версии объекта» (object lock)](../../../security/standard/all.md#object-lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
|| [Настроено резервное копирование дисков и баз данных](../../../security/standard/all.md#snapshot) | [cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks) ||
|| [Учетные записи Яндекс ID используются только в исключительных случаях](../../../security/standard/all.md#yandex-id-accounts) | [cspm.yid.organization](../../rules-reference/cspm.md#yid-organization) ||
|| [Сервисным аккаунтам назначены минимальные привилегии](../../../security/standard/all.md#sa-privileges) |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
|| [Отслеживается дата последней аутентификации сервисного аккаунта в Identity and Access Management](../../../security/standard/all.md#track-sa-authentication) | [cspm.iam.unused-service-account](../../rules-reference/cspm.md#unused-service-account) ||
|| [Отслеживается дата последнего использования ключей доступа в Identity and Access Management](../../../security/standard/all.md#track-sa-authentication) | [cspm.iam.unused-key](../../rules-reference/cspm.md#unused-key) ||
|| [Выполняется периодическая ротация ключей сервисных аккаунтов](../../../security/standard/all.md#sa-key-rotation) | [cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#iam-sa-key-rotation) ||
|| [Включен сервис Yandex Audit Trails](../../../security/standard/all.md#audit-trails) | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|#