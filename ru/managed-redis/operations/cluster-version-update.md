# Обновление версии {{ VLK }}

Вы можете обновить кластер {{ mrd-name }} до любой поддерживаемой версии.


## Поддерживаемые версии {#version-supported}

Каждая версия {{ VLK }}, поддержка которой была включена в {{ mrd-name }}, остается доступной, пока она поддерживается производителем. Как правило, это 24 месяца с даты выпуска версии. Подробнее см. в [документации {{ VLK }}](https://valkey.io/topics/releases/).


### Узнать доступные версии {{ VLK }} {#version-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Откройте список в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

    {% note info %}

    Чтобы указать номер версии в CLI, {{ TF }} и API, добавьте к нему постфикс `-valkey` (например, `{{ versions.cli.previous }}`).

    {% endnote %}

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://docs.redis.com/latest/rs/release-notes/) {{ VLK }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера, если версия {{ VLK }} в резервной копии [поддерживается](#version-supported) в {{ mrd-name }}.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.

## Обновить кластер {#start-update}

{% note alert %}

* После обновления СУБД до выбранной версии вернуть кластер к предыдущей версии невозможно.
* Успешность обновления версии {{ VLK }} зависит от многих факторов, в том числе от настроек кластера и данных, хранящихся в базах. Рекомендуется сначала [обновить тестовый кластер](#before-update), который использует те же данные и настройки.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с кластером, который нужно обновить.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер в списке и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите новую версию.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  После запуска обновления кластер переходит в статус **Updating**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Получите список ваших кластеров {{ VLK }} командой:

     ```bash
     {{ yc-mdb-rd }} cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию {{ VLK }}, указанную в свойстве `config.version`:

     ```bash
     {{ yc-mdb-rd }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление {{ VLK }}:

     ```bash
     {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
       --redis-version <номер_новой_версии>
     ```

     После запуска обновления кластер переходит в статус **Updating**. Дождитесь окончания операции и проверьте версию кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. В блоке `config` измените параметр `version` на номер версии {{ VLK }}, до которой хотите обновиться:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
            ...
            config {
                version  = "<номер_новой_версии>"
                ...
            }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

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
            --url 'https://{{ api-host-mdb }}/managed-redis/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.version",
                      "configSpec": {
                        "version": "<версия_{{ VLK }}>"
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `configSpec.version` — новая версия {{ VLK }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

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
            -proto ~/cloudapi/yandex/cloud/mdb/redis/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ "config_spec.version" ]
                  },
                  "config_spec": {
                    "version": "<версия_{{ VLK }}>"
                  } 
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.redis.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.version` — новая версия {{ VLK }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии {{ versions.console.previous }} до версии {{ versions.console.latest }}.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы получить список кластеров и узнать их имена и идентификаторы, выполните команду:

      ```bash
      {{ yc-mdb-rd }} cluster list
      ```

	  Результат:
	  
      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   redis406    | 2022-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере с именем `redis406`, выполните команду:

      ```bash
      {{ yc-mdb-rd }} cluster get redis406
      ```

      Результат:

      ```text
      id: c9q8p8j2gaih********
      ...
      config:
        version: {{ versions.cli.previous }}
        ...
      ```

   1. Для обновления кластера с именем `redis406` до версии `{{ versions.console.latest }}`, выполните команду:

      ```bash
      {{ yc-mdb-rd }} cluster update redis406 --redis-version {{ versions.cli.latest }}
      ```

{% endlist %}
