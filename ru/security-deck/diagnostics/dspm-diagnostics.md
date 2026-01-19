---
title: Какие ошибки возникают при работе с модулем контроля данных (DSPM) в {{ sd-full-name }}
description: Из статьи вы узнаете, какие бывают ошибки в работе модуля контроля данных (DSPM).
---

# Диагностика ошибок в работе модуля контроля данных (DSPM)

## Unable to list dataSource `Id` {#unable-to-list-datasource}
Не удалось получить содержимое источника данных. Возможно, он был удален во время сканирования.


## Error while listing bucket `bucket-name`. Not found {#bucket-not-found}
Бакет существовал во время обнаружения ресурсов, но был удален к моменту начала сканирования или во время сканирования.


## Error while listing bucket `bucket-name`. Permission denied {#unable-to-access-bucket}
У сервисного аккаунта, от имени которого выполняется сканирование, нет доступа к указанному бакету. Убедитесь, что аккаунту назначены [необходимые роли](../security/dspm-roles.md) и доступ к бакету не ограничен [политиками доступа](../../storage/security/policy.md).


## Error while listing folder, cloud or organization {#access-error}
У сервисного аккаунта, от имени которого выполняется сканирование, нет доступа к каталогу, облаку или организации. Убедитесь, что аккаунту назначены [необходимые роли](../../storage/security/index.md#service-roles).


## Failed to list resources {#unable-to-list-resources}
Сканирование пользовательских ресурсов для указанного пользователя не будет выполнено, так как для [тарифа]({{ link-yandex }}/support/yandex-360/business/purchase/{{ lang }}/plans/payment-plans-ru) {{ yandex-360 }} Минимальный эта функциональность недоступна.


## Error while listing user disk `user-name`. Unauthenticated {#wrong-credentials}
Указаны неверные OAuth-токен или `client secret` для подключения к Яндекс Диску. Проверьте параметры подключения источника данных.


## Error while listing user disk `user-name`. Internal {#unable-to-list-datasource}
{{ yandex-360 }} не позволяет подключаться к диску администратора организации.


## Failed to list user {#user-not-found}
Не удалось найти пользователя. Убедитесь, что пользователь уже входил в Яндекс Диск.


## Failed to list mailbox {#mailbox-not-found}
Не удалось найти почтовый ящик пользователя. Убедитесь, что пользователь уже входил в Яндекс Почту.


## Failed to list virtual disk {#unable-to-access-disk}
Не удалось получить содержимое общего диска. Проверьте параметры подключения источника данных.


## Failed to process parsing of data stream. It was skipped {#unable-to-parse-file}
Не удалось распознать содержимое файла.


## Failed to process parsing data stream. Unsupported format {#data-stream-process-error}
Сканирование указанных типов файлов не поддерживается. Подробнее о поддерживаемых областях сканирования читайте в разделе [Источник данных](../concepts/dspm.md#data-source).


## File contains unsupported image types {#unsupported-image-types}
Сканирование указанных типов изображений не поддерживается. Подробнее о поддерживаемых областях сканирования читайте в разделе [Источник данных](../concepts/dspm.md#data-source).


