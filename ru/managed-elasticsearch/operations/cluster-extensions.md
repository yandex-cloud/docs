# Управление расширениями {{ ES }}

Пользовательские расширения — это любые текстовые данные (словари слов, переносов и т. п.), ключи для интеграции с другими кластерами, прочие данные для работы кластера. Подробнее см. в [документации {{ ES }}](https://www.elastic.co/guide/en/cloud/current/ec-plugins-guide.html).

## Получить список установленных пользовательских расширений {#list}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список расширений кластера, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions list <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Чтобы получить список установленных пользовательских расширений, воспользуйтесь методом REST API [list](../api-ref/Extension/list.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/List](../api-ref/grpc/extension_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

{% endlist %}

## Добавить пользовательское расширение {#add}

{% note info %}

В качестве расширений поддерживаются только txt-файлы, вложенные в zip-архив.

{% endnote %}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы добавить расширение в кластер, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions create <идентификатор или имя кластера> \
       --name <имя расширения> \
       --uri <URI zip-архива с расширением>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор расширения — [со списком расширений в кластере](#list).

    
    Чтобы получить ссылку на zip-архив с файлами расширения в {{ objstorage-full-name }}, [воспользуйтесь инструкцией](../../storage/operations/objects/link-for-download.md). Доступ к {{ objstorage-full-name }} [можно настроить](./s3-access.md) с помощью сервисного аккаунта.


- API
    
    Чтобы добавить пользовательское расширение, воспользуйтесь методом REST API [create](../api-ref/Extension/create.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Create](../api-ref/grpc/extension_service.md#Create) и передайте в запросе:
    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Имя расширения в параметре `name`.

    
    * [Ссылку](../../storage/operations/objects/link-for-download.md) на zip-архив с файлами расширения в {{ objstorage-full-name }} в параметре `uri`. Доступ к {{ objstorage-full-name }} [можно настроить](./s3-access.md) с помощью сервисного аккаунта.


    * Статус пользовательского расширения в параметре `disabled`. После добавления оно будет выключено при значении `true` и включено при значении `false`.

{% endlist %}

## Включить или выключить пользовательское расширение {#update}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить или выключить расширение, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions update <идентификатор расширения> \
       <идентификатор или имя кластера> \
       --active <статус расширения: true|false>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор расширения — [со списком расширений в кластере](#list).

    Чтобы включить пользовательское расширение, передайте в параметре `--active` значение `true`, чтобы выключить — `false`.

- API

    Чтобы включить или выключить пользовательское расширение, воспользуйтесь методом REST API [update](../api-ref/Extension/update.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Update](../api-ref/grpc/extension_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Идентификатор пользовательского расширения в параметре `extensionId`. Чтобы узнать идентификатор, [получите список установленных пользовательских расширений](#list).
    * Статус пользовательского расширения в параметре `active`: `true` — включено, `false` — выключено.
    * Список полей конфигурации расширения, которые необходимо изменить, в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить пользовательское расширение {#delete}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить расширение, выполните команду:

    ```bash
    {{ yc-mdb-es }} extensions delete <идентификатор расширения> \
       <идентификатор или имя кластера>
    ```

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор расширения — [со списком расширений в кластере](#list).

- API

    Чтобы удалить пользовательское расширение, воспользуйтесь методом REST API [delete](../api-ref/Extension/delete.md) для ресурса [Extension](../api-ref/Extension/index.md) или вызовом gRPC API [ExtensionService/Delete](../api-ref/grpc/extension_service.md#Delete) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}
      
    * Идентификатор пользовательского расширения в параметре `extensionId`. Чтобы узнать идентификатор, [получите список установленных пользовательских расширений](#list).

{% endlist %}
