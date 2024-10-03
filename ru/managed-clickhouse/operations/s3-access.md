---
title: Как настроить доступ к {{ objstorage-full-name }} из кластера {{ CH }} в {{ mch-full-name }}
description: Следуя данной инструкции, вы сможете настроить доступ к {{ objstorage-full-name }} из кластера {{ CH }}.
---

# Настройка доступа к {{ objstorage-name }} из кластера {{ CH }}

{{ mch-name }} поддерживает работу с {{ objstorage-full-name }} для:
* подключения [моделей машинного обучения](ml-models.md), [схем формата данных](format-schemas.md) и [собственной геобазы](geobase.md);
* обработки данных, которые находятся в объектном хранилище, если эти данные представлены в любом из [поддерживаемых {{ CH }} форматов]({{ ch.docs }}/interfaces/formats/).

Для доступа к данным в [бакете](../../storage/concepts/bucket.md) {{ objstorage-name }} из кластера настройте беспарольный доступ к бакету с помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

1. [Подключите сервисный аккаунт к кластеру](#connect-service-account).
1. [Настройте права доступа для сервисного аккаунта](#configure-acl).  
1. [Получите ссылку на объект в бакете](#get-link-to-object), которую можно использовать при работе с данными в кластере.

См. также [Примеры работы с объектами](#examples).
   
## Подключить сервисный аккаунт к кластеру {#connect-service-account}

1. При [создании](cluster-create.md) или [изменении](update.md) кластера выберите существующий сервисный аккаунт, либо создайте новый.

1. Убедитесь, что этому аккаунту назначены корректные роли из группы ролей `storage.*`. При необходимости назначьте нужные роли, например, `storage.viewer` и `storage.uploader`.

{% note tip %}

Для связи кластеров {{ mch-name }} с {{ objstorage-name }} рекомендуется использовать специально созданные для этой цели сервисные аккаунты: это позволяет организовать работу с любыми бакетами, в том числе с такими, для которых предоставление публичного доступа нежелательно или невозможно.  

{% endnote %}

## Настроить права доступа {#configure-acl}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный бакет. Если бакета не существует — [создайте](../../storage/operations/buckets/create.md) его и [наполните](../../storage/operations/objects/upload.md) необходимыми данными.

  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.

  1. Настройте [ACL бакета](../../storage/operations/buckets/edit-acl.md) или [ACL объекта](../../storage/operations/objects/edit-acl.md):

      1. В списке бакетов или объектов выберите нужный элемент и нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите **{{ ui-key.yacloud.storage.buckets.button_permissions }}** или **{{ ui-key.yacloud.storage.file.button_permissions }}**.
      1. В выпадающем списке **{{ ui-key.yacloud.component.acl-dialog.label_select-placeholder }}** укажите сервисный аккаунт, [подключенный к кластеру](#connect-service-account).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
      1. Задайте нужные разрешения для сервисного аккаунта из выпадающего списка.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

      {% note info %}

      При необходимости отзовите доступ у одного или нескольких пользователей, нажав кнопку **{{ ui-key.yacloud.component.acl-dialog.button_remove-new }}** в нужной строке.
   
      {% endnote %}

{% endlist %}

## Получить ссылку на объект {#get-link-to-object}

Чтобы работать в {{ mch-name }} с данными объекта в {{ objstorage-name }}, нужно [получить ссылку](../../storage/operations/objects/link-for-download.md) на этот объект в бакете.

Приведите ссылку вида `https://{{ s3-storage-host }}/<имя_бакета>/<имя_объекта>?X-Amz-Algorithm=...` к виду `https://{{ s3-storage-host }}/<имя_бакета>/<имя_объекта>`, удалив все параметры в строке запроса.

{% note info %}

[Подписанные ссылки](../../storage/concepts/pre-signed-urls.md) невозможно использовать для обращения к бакету из кластера.

{% endnote %}

## Примеры работы с объектами {#examples}

[Ссылки на объекты](#get-link-to-object) вида `https://{{ s3-storage-host }}/<имя_бакета>/<имя_объекта>` можно использовать при работе с геометками, схемами, а также при использовании табличной функции `s3` и табличного движка `S3`.

Табличный движок `S3` аналогичен движкам [File]({{ ch.docs }}/engines/table-engines/special/file/) и [URL]({{ ch.docs }}/engines/table-engines/special/url/), за исключением того, что данные хранятся в S3-совместимом хранилище (таком как {{ objstorage-full-name }}), а не на файловой системе или удаленном HTTP/HTTPS сервере. Этот движок позволяет читать и записывать данные в хранилище с использованием стандартных SQL-запросов `SELECT` и `INSERT`. 

Табличная функция `s3` предоставляет ту же самую функциональность, что и движок таблиц `S3`, но при ее использовании не требуется предварительно создавать таблицу.

Например, если в бакете {{ objstorage-name }} в файле `table.tsv` хранятся данные таблицы в формате TSV, то можно создать таблицу или функцию, которая будет работать с этим файлом. Предполагается, что настроен беспарольный доступ и получена ссылка на файл `table.tsv`.

{% list tabs %}

- Таблица S3

  1. Создайте таблицу:
  
     ```sql
     CREATE TABLE test (n Int32) ENGINE = S3('https://{{ s3-storage-host }}/<имя_бакета>/table.tsv', 'TSV');
     ```

  1. Выполните тестовые запросы к таблице:
  
     ```sql
     INSERT INTO test VALUES (1);
     SELECT * FROM test;
  
     ┌─n─┐
     │ 1 │
     └───┘
     ```

- Функция s3

  1. Вставьте данные:
     
     ```sql
     INSERT INTO FUNCTION s3('https://{{ s3-storage-host }}/<имя_бакета>/table.tsv', 'TSV', 'n Int32') VALUES (1);
     ```

  1. Выполните тестовый запрос:
  
     ```sql
     SELECT * FROM s3('https://{{ s3-storage-host }}/<имя_бакета>/table.tsv', 'TSV', 'n Int32');

     ┌─n─┐
     │ 1 │
     └───┘
     ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
