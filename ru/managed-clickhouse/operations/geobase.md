# Подключение собственной геобазы в {{ mch-name }}

Геобаза в {{ CH }} — это текстовые файлы, которые содержат иерархию и имена регионов. Вы можете добавить в {{ CH }} несколько альтернативных геобаз для поддержки разных точек зрения о принадлежности регионов странам. Подробнее читайте в [документации {{ CH }}](https://{{ ch-domain }}/docs/ru/sql-reference/dictionaries/internal-dicts/).

Чтобы подключить к кластеру {{ CH }} собственную геобазу:

1. [Создайте ее](#create).
1. [Загрузите геобазу в {{ objstorage-full-name }}](#upload).
1. [Подключите геобазу к кластеру {{ CH }}](#add).

## Создать геобазу {#create}

1. Создайте файл `regions_hierarchy.txt` с иерархией регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:
   * идентификатор региона (UInt32);
   * идентификатор родительского региона (UInt32);
   * тип региона (UInt8):
        * `1` — континент;
        * `3` — страна;
        * `4` — федеральный округ;
        * `5` — область;
        * `6` — город;
   * население (UInt32) — необязательный столбец.
1. Чтобы добавить альтернативную иерархию регионов, создайте файлы `regions_hierarchy_<суффикс>.txt` с аналогичной структурой. Чтобы затем воспользоваться альтернативной геобазой, передайте этот суффикс при вызове функции. Например:

    * `regionToCountry(RegionID)` — использует словарь по умолчанию: `regions_hierarchy.txt`;
    * `regionToCountry(RegionID, 'alt')` — использует словарь с суффиксом `alt`: `regions_hierarchy_alt.txt`.

1. Создайте файл `regions_names.txt` с именами регионов. Файл должен представлять собой таблицу в [формате TSV](https://ru.wikipedia.org/wiki/TSV) без заголовков и со столбцами:

    * идентификатор региона (UInt32);
    * имя региона (String) — не может содержать символы табуляции или переводы строк, даже экранированные.

1. Чтобы добавить в базу имена регионов на других языках, создайте файлы `regions_names_<код_языка>.txt` с аналогичной структурой. Например, `regions_names_en.txt` для английского языка и `regions_names_tr.txt` для турецкого.
1. Создайте из файлов геобазы архив в формате `tar`, `tar.gz` или `zip`.

## Загрузить геобазу в {{ objstorage-full-name }} {#upload}

{{ mch-short-name }} работает только с геобазами, которые загружены в {{ objstorage-full-name }} и к которым предоставлен доступ на чтение:


1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Загрузите](../../storage/operations/objects/upload.md) архив с геобазой в {{ objstorage-full-name }}.
1. [Подключите сервисный аккаунт к кластеру](s3-access.md#connect-service-account). С помощью [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) вы настроите доступ к архиву геобазы.
1. [Назначьте роль](s3-access.md#configure-acl) `storage.viewer` сервисному аккаунту.
1. В ACL бакета [добавьте разрешение](../../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту.
1. [Получите ссылку](s3-access.md#get-link-to-object) на архив с геобазой.


## Подключить геобазу к кластеру {{ CH }} {#add}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. В поле **Geobase uri** укажите ссылку на архив с геобазой в {{ objstorage-full-name }}.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы подключить геобазу:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update-config --help
        ```

    1. Выполните команду, передав ссылку на архив с подключаемой геобазой в параметре `geobase_uri`:

        ```bash
        {{ yc-mdb-ch }} cluster update-config <имя_или_идентификатор_кластера> \
             --set geobase_uri="<ссылка_на_архив_с_геобазой_в_Object_Storage>"
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте в настройки кластера {{ mch-name }} параметр `geobase_uri` со ссылкой на архив с подключаемой геобазой в {{ objstorage-full-name }}:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
          ...
          clickhouse {
            config {
              geobase_uri = "<ссылка_на_архив_с_геобазой_в_Object_Storage>"
              ...
            }
          ...
          }
        ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.config.geobaseUri",
                      "configSpec": {
                        "clickhouse": {
                          "config": {
                            "geobaseUri": "<ссылка>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `configSpec.clickhouse.config.geobaseUri`.

        * `configSpec.clickhouse.config.geobaseUri` — ссылка на архив с геобазой в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.config.geobase_uri"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "config": {
                        "geobase_uri": "<ссылка>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `config_spec.clickhouse.config.geobase_uri`.

        * `config_spec.clickhouse.config.geobase_uri` — ссылка на архив с геобазой в {{ objstorage-name }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
