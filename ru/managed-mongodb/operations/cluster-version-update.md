# Обновление версии {{ MG }}

Вы можете обновить кластер {{ mmg-name }} только на следующую версию относительно текущей, например, с версии 4.2 на 4.4. Обновление до более поздних версий производится поэтапно. Например, обновление версии {{ MG }} с 4.2 до 6.0 выполняется в такой последовательности: 4.2 → 4.4 → 5.0 → 6.0.


{% note alert %}

После обновления невозможно вернуть кластер к предыдущей версии.

{% endnote %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://docs.mongodb.com/manual/release-notes/) {{ MG }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.

## Обновить кластер {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Выберите нужный кластер в списке и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

  1. Получите список ваших кластеров {{ MG }} командой:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию {{ MG }}, указанную в свойстве `config.version`:

     ```bash
     {{ yc-mdb-mg }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление {{ MG }}:

     ```bash
     {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
        --mongodb-version=<номер_новой_версии>
     ```

     После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

  1. После обновления все возможности MongoDB, у которых нет обратной совместимости с прежней версией, выключаются. Чтобы снять это ограничение, выполните команду:

     ```bash
     {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
        --feature-compatibility-version=<номер_новой_версии>
     ```

     Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
    1. Добавьте к описанию кластера {{ mmg-name }} поле `version` или измените его значение, если оно уже существует:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           version = "<версия_{{ MG }}>"
         }
       }
       ```

    1. Проверьте корректность настроек.
  
         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

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
         --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
         --data '{
                  "updateMask": "configSpec.version",
                  "configSpec": {
                    "version": "<новая_версия_{{ MG }}>"
                  }
                }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

         В данном случае передается один параметр.

      * `configSpec.version` — новая версия {{ MG }}.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

   1. После обновления все возможности {{ MG }}, у которых нет обратной совместимости с прежней версией, выключаются. Чтобы снять это ограничение, выполните еще один запрос и передайте номер новой версии {{ MG }} в свойстве `configSpec.featureCompatibilityVersion`.

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
         --data '{
                  "updateMask": "configSpec.featureCompatibilityVersion",
                  "configSpec": {
                    "featureCompatibilityVersion": "<новая_версия_{{ MG }}>"
                  }
                }'
      ```

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
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.version"
                    ]
                  },  
                  "config_spec": {
                    "version": "<версия_{{ MG }}>"
                  }
               }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается один параметр.

        * `version` — новая версия {{ MG }}.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

    1. После обновления все возможности {{ MG }}, у которых нет обратной совместимости с прежней версией, выключаются. Чтобы снять это ограничение, выполните еще один запрос и передайте номер новой версии {{ MG }} в свойстве `config_spec.feature_compatibility_version`.

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/mongodb/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.feature_compatibility_version"
                    ]
                  },  
                  "config_spec": {
                    "feature_compatibility_version": "<новая_версия_{{ MG }}>"
                  }
               }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```    

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 5.0 до версии 6.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы узнать идентификатор кластера, получите список всех кластеров в каталоге:

      ```bash
      {{ yc-mdb-mg }} cluster list
      ```

      Результат:

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере `c9qut3k64b2o********`, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster get c9qut3k64b2o********
      ```

      Результат:

      ```text
      id: c9qut3k64b2o********
      folder_id: b1g0itj57rbj********
      created_at: "2019-07-16T09:43:50.393231Z"
      name: mongodb406
      environment: PRODUCTION
      monitoring:
      - name: Console
        description: Console charts
        link: {{ link-console-main }}/folders/b1g0itj57rbj********/managed-mongodb/cluster/c9qut3k64b2o********?section=monitoring
      config:
        version: "5.0"
        feature_compatibility_version: "5.0"
        ...
      ```

   1. Чтобы обновить кластер `c9qutgkd4b2o********` до версии 6.0, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --mongodb-version=6.0
      ```

   1. Чтобы включить все возможности версии 6.0 в кластере `c9qutgkd4b2o********`, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --feature-compatibility-version=6.0
      ```

{% endlist %}
