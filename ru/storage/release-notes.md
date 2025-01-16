---
title: История изменений в {{ objstorage-full-name }}
description: В разделе представлена история изменений сервиса {{ objstorage-name }}.
---

# История изменений в {{ objstorage-full-name }}

## IV квартал 2024 {#q4-2024}

* Анонсировано прекращение поддержки протокола TLS версий 1.0 и 1.1 с 1 июля 2025 года. Подробнее см. на странице [{#T}](./concepts/tls.md).
* В [{{ yandex-cloud }} CLI](../cli/quickstart.md) добавлена группа команд [yc storage s3api](../cli/cli-ref/storage/cli-ref/s3api/index.md) для работы с [объектами](./concepts/object.md).

## III квартал 2024 {#q3-2024}

* Добавлена поддержка доступа к сервису с помощью [временных ключей {{ sts-name }}](./operations/buckets/create-sts-key.md).
* Реализована функциональность прямого доступа к бакетам из облачных сетей с помощью [сервисного подключения {{ vpc-full-name }}](./operations/buckets/access-via-vpc.md) без использования доступа в интернет. В [политику доступа (bucket policy)](./security/policy.md) добавлено специальное условие `yc:private-endpoint-id` для осуществления доступа к бакету только по внутренним IP-адресам {{ vpc-short-name }}.

## II квартал 2024 {#q2-2024}

Улучшен дизайн консоли управления: настройки бакета теперь сгруппированы на вкладках ![image](../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** и ![image](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.

## I квартал 2024 {#q1-2024}

* Улучшена работа с [жизненными циклами](./concepts/lifecycles.md) объектов в бакете:
  * добавлена поддержка новых фильтров для группировки объектов: [метки объекта](./concepts/tags.md#object-tags) и оператор `AND`.
  * работа с новыми фильтрами реализована в консоли управления, YC CLI, {{ TF }} и с помощью [инструментов](./tools/) с поддержкой S3 API.
* Поддержана работа с [метками бакета](./concepts/tags.md#bucket-tags) в консоли управления, YC CLI и {{ TF }}.
* Реализована возможность добавлять [группы пользователей](../organization/concepts/groups.md) {{ org-full-name }} в [список управления доступом (ACL)](./security/acl.md) и [политику доступа (bucket policy)](./security/policy.md) в консоли управления, YC CLI и {{ TF }}.
* Улучшена работа в консоли управления:
  * добавлен фильтр по префиксу в списке объектов бакета;
  * добавлена возможность скачивания объектов из списка.
