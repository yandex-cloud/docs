---
title: Изменение каталога {{ TR }}
description: Следуя этой инструкции, вы измените параметры каталога в кластере {{ mtr-name }}.
---

# Изменение каталога {{ TR }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Нажмите на имя нужного кластера.
    1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
    1. В строке с нужным каталогом {{ TR }} нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.common.edit }}**.
    1. Измените параметры каталога {{ TR }} и нажмите кнопку **{{ ui-key.yacloud.common.update }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для изменения каталога {{ TR }}:

        ```bash
        {{ yc-mdb-tr }} catalog update --help
        ```

    1. Посмотрите описание команды CLI для изменения каталога {{ TR }} c конкретным коннектором:

        ```bash
        {{ yc-mdb-tr }} catalog update <тип_коннектора> --help
        ```

    1. Чтобы изменить каталог, выполните команду:

        ```bash
        {{ yc-mdb-tr }} catalog update <тип_коннектора> <имя_каталога_{{ TR }}> \
            --new-name <новое_имя_каталога_{{ TR }}>
        ```

        Имя каталога {{ TR }} можно запросить со [списком каталогов {{ TR }} в кластере](catalog-list#list-catalogs.md).

        В команде также можно передать настройки каталога {{ TR }}, которые зависят от типа коннектора. [Подробнее о настройках для разных типов коннекторов](catalog-create.md#catalog-settings).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените настройки каталога {{ TR }} в блоке `yandex_trino_catalog`:

        ```hcl
        resource "yandex_trino_catalog" "<имя_каталога_{{ TR }}>" {
          ...
          <тип_коннектора> = {
            <настройки_каталога_{{ TR }}>
          }
        }
        ```

        [Подробнее о настройках каталога {{ TR }}](catalog-create.md#catalog-settings) для разных типов коннекторов.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Catalog.Update](../api-ref/Catalog/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-trino }}/managed-trino/v1/clusters/<идентификатор_кластера>/catalogs/<идентификатор_каталога_{{ TR }}>' \
            --data '{
                      "updateMask": "catalog.name,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_1>,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_2>,...,catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_N>",
                      "catalog": {
                        "name": "<новое_имя_каталога_{{ TR }}>",
                        "connector": {
                          "<тип_коннектора>": {
                            <изменяемые_настройки_каталога_{{ TR }}>
                          }
                        }
                      }
                    }'
        ```

        Где `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        [Подробнее о настройках каталога {{ TR }}](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Catalog/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [CatalogService.Update](../api-ref/grpc/Catalog/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/trino/v1/catalog_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "catalog_id": "<идентификатор_каталога_{{ TR }}>",
                  "update_mask": {
                    "paths": [
                      "catalog.name",
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_1>",
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_2>",
                      ...
                      "catalog.connector.<тип_коннектора>.<путь_к_настройке>.<настройка_N>"
                    ]
                  },
                  "catalog": {
                    "name": "<новое_имя_каталога_{{ TR }}>",
                    "connector": {
                      "<тип_коннектора>": {
                        <изменяемые_настройки_каталога_{{ TR }}>
                      }
                    }
                  }
                }' \
            {{ api-host-trino }}:{{ port-https }} \
            yandex.cloud.trino.v1.CatalogService.Update
        ```

        Где `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        [Подробнее о настройках каталога {{ TR }}](#catalog-settings) для разных типов коннекторов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), идентификатор каталога — со [списком каталогов {{ TR }} в кластере](catalog-list.md).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Catalog/update.md#yandex.cloud.operation.Operation).

{% endlist %}