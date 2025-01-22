---
title: Как управлять расширениями {{ ES }}
description: Следуя данной инструкции, вы научитесь управлять расширениями {{ ES }}.
---

# Управление расширениями {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Пользовательские расширения — это любые текстовые данные (словари слов, переносов и т. п.), ключи для интеграции с другими кластерами, прочие данные для работы кластера. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/cloud/current/ec-plugins-guide.html).

## Получить список установленных пользовательских расширений {#list}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список расширений кластера, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions list --cluster-id <идентификатор_кластера>
    ```

    Идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить список установленных пользовательских расширений, воспользуйтесь методом REST API [list](../api-ref/Extension/list.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/List](../api-ref/grpc/Extension/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Добавить или обновить пользовательское расширение {#add}

{% note info %}

В качестве расширений поддерживаются только txt-файлы, вложенные в zip-архив.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить или обновить пользовательское расширение, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions create --cluster-id <идентификатор_кластера> \
       --name <имя_расширения> \
       --uri <URI_zip-архива_с_расширением> \
       --disabled
    ```

    В команде укажите параметры:

    * `--cluster-id` — идентификатор кластера. Его можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).
    * `--name` — имя расширения. Если указано ранее добавленное расширение, то оно обновляется:

       * номер версии расширения увеличивается на один;
       * по ссылке в параметре `--uri` загружается новая версия расширения, и ей присваивается новый идентификатор.

    
    * `--uri` — [ссылка](../../storage/operations/objects/link-for-download.md) на zip-архив с файлами расширения в {{ objstorage-full-name }}. Доступ к {{ objstorage-full-name }} [можно настроить](./s3-access.md) с помощью сервисного аккаунта.


    * `--disabled` — статус пользовательского расширения. Чтобы выключить новую версию пользовательского расширения сразу после добавления или обновления, передайте этот параметр. Чтобы включить — не указывайте его. При включении новой версии расширения предыдущая версия будет автоматически выключена.

- API {#api}

    Чтобы добавить или обновить пользовательское расширение, воспользуйтесь методом REST API [create](../api-ref/Extension/create.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Create](../api-ref/grpc/Extension/create.md) и передайте в запросе:
    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Имя расширения в параметре `name`. Если указано ранее добавленное расширение, то оно обновляется:

       * номер версии расширения увеличивается на один;
       * по ссылке в параметре `uri` загружается новая версия расширения, и ей присваивается новый идентификатор.

    
    * [Ссылку](../../storage/operations/objects/link-for-download.md) на zip-архив с файлами расширения в {{ objstorage-full-name }} в параметре `uri`. Доступ к {{ objstorage-full-name }} [можно настроить](./s3-access.md) с помощью сервисного аккаунта.


    * Статус пользовательского расширения в параметре `disabled`. После добавления оно будет выключено при значении `true` и включено при значении `false`. При включении новой версии расширения предыдущая версия будет автоматически выключена.

{% endlist %}

## Включить или выключить пользовательское расширение {#update}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить или выключить пользовательское расширение, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions update <идентификатор_расширения> \
       --cluster-id <идентификатор_кластера> \
       --active
    ```

    Идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор расширения — [со списком расширений в кластере](#list).

    Чтобы включить расширение, передайте параметр `--active`, чтобы выключить — не указывайте его.

- API {#api}

    Чтобы включить или выключить пользовательское расширение, воспользуйтесь методом REST API [update](../api-ref/Extension/update.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Update](../api-ref/grpc/Extension/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Идентификатор пользовательского расширения в параметре `extensionId`. Чтобы узнать идентификатор, [получите список установленных пользовательских расширений](#list).
    * Статус пользовательского расширения в параметре `active`: `true` — включено, `false` — выключено.

{% endlist %}

## Удалить пользовательское расширение {#delete}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить расширение, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions delete <идентификатор_расширения> \
       --cluster-id <идентификатор_кластера>
    ```

    Идентификатор кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор расширения — [со списком расширений в кластере](#list).

- API {#api}

    Чтобы удалить пользовательское расширение, воспользуйтесь методом REST API [delete](../api-ref/Extension/delete.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Delete](../api-ref/grpc/Extension/delete.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
      
    * Идентификатор пользовательского расширения в параметре `extensionId`. Чтобы узнать идентификатор, [получите список установленных пользовательских расширений](#list).

{% endlist %}
