---
title: Стандарт предотвращения атак программ-шифровальщиков
description: В этом разделе приведен список правил контроля, которые входят в стандарт предотвращения атак программ-шифровальщиков.
---

# Стандарт предотвращения атак программ-шифровальщиков

Приведенный набор правил содержит требования безопасности для снижения рисков от атак программ-шифровальщиков (ransomware) в облачной инфраструктуре {{ yandex-cloud }}.

Шифровальщики — один из наиболее распространенных и разрушительных видов кибератак: злоумышленники шифруют данные жертвы и требуют выкуп за их восстановление. В облачных средах атаки шифровальщиков могут затрагивать объектные хранилища, диски виртуальных машин, базы данных и резервные копии.

Выполнение этих требований помогает обеспечить защиту от атак программ-шифровальщиков и минимизировать последствия в случае успешной атаки:

#|
||::{align="center"} Идентификатор требования | Требование | Идентификатор проверки в [модуле {{ cspm-name }}](../cspm.md) ||
||::{align="center"} [IAM3](../../../security/standard/all.md#yandex-id-accounts) | Учетные записи Яндекс ID используются только в исключительных случаях | [cspm.yid.organization](../../rules-reference/cspm.md#yid-organization) ||
||::{align="center"} [IAM9](../../../security/standard/all.md#sa-privileges) | Сервисным аккаунтам назначены минимальные привилегии |
[cspm.access.sa-privileges-org-roles](../../rules-reference/cspm.md#sa-privileges-org-roles)
[cspm.access.sa-privileges-service-roles](../../rules-reference/cspm.md#sa-privileges-service-roles)
||
||::{align="center"} [IAM11](../../../security/standard/all.md#sa-key-rotation) | Выполняется периодическая ротация ключей сервисных аккаунтов | [cspm.iam.sa-key-rotation](../../rules-reference/cspm.md#sa-key-rotation) ||
||::{align="center"} [IAM17](../../../security/standard/all.md#twofa) | Настроена двухфакторная аутентификация для привилегированных аккаунтов | [cspm.access.userpool-mfa](../../rules-reference/cspm.md#userpool-mfa) ||
||::{align="center"} [ENV9](../../../security/standard/all.md#object-lock) | В {{ objstorage-name }} включена функция «Блокировка версии объекта» (object lock) | [cspm.s3.used-object-lock](../../rules-reference/cspm.md#used-object-lock) ||
||::{align="center"} [ENV37](../../../security/standard/all.md#snapshot) | Настроено резервное копирование дисков и баз данных | [cspm.backup.compute-disks](../../rules-reference/cspm.md#compute-disks) ||
||::{align="center"} [IAM26](../../../security/standard/all.md#key-usage-control) | Отслеживается дата последней аутентификации сервисного аккаунта в {{ iam-name }} | [cspm.iam.unused-service-account](../../rules-reference/cspm.md#unused-service-account) ||
|| ^ | Отслеживается дата последнего использования ключей доступа в {{ iam-name }} | [cspm.iam.unused-key](../../rules-reference/cspm.md#unused-key) ||
||::{align="center"} [AUDIT1](../../../security/standard/all.md#audit-trails) | Включен сервис {{ at-full-name }} | [cspm.o11y.audit-trails](../../rules-reference/cspm.md#audit-trails) ||
|#
