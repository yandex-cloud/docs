# Обновление версии {{ PG }}

Вы можете обновить кластер {{ mpg-name }} до версии 16 или ниже.

{% note info %}

Обновление обычной версии кластера до версий для «1С:Предприятие» (например, с версии 14 на версию 14-1с) недоступно.

{% endnote %}

Обновление доступно только на следующую версию относительно текущей, например, с версии 14 на 15. Обновление до более поздних версий производится поэтапно. Например, обновление версии {{ PG }} с 13 до 15 выполняется в такой последовательности: 13 → 14 → 15.

{% note warning %}

Обновление до версии 17 возможно только при помощи {{ data-transfer-full-name }}. Для этого [создайте кластер](cluster-create.md#create-cluster) с новой версией и [перенесите в него данные](../tutorials/data-migration.md#data-transfer) из кластера, который хотите обновить.

{% endnote %}

В однохостовых кластерах на обновление выводится единственный хост-мастер. Во время обновления такие кластеры будут недоступными на чтение и запись.

В многохостовых кластерах обновление проводится в следующем порядке:

1. Мастер выводится на обновление. В это время реплики работают в режиме чтения, [переключения ролей](../concepts/replication.md#replication-auto) не происходит. После обновления мастер не возвращается в работу, пока не обновятся все хосты-реплики, и временно недоступен даже для чтения.
1. Хосты-реплики последовательно выводятся на обновление. Порядок реплик в очереди определяется случайным образом. После обновления реплики возвращаются в работу в режиме чтения.

    Кластер из двух хостов на время обновления реплики будет недоступным. В кластере из трех и более хостов всегда будет доступна для чтения хотя бы одна реплика.

1. Мастер возвращается в работу.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://www.postgresql.org/docs/release/) {{ PG }}, как обновления могут повлиять на работу ваших приложений или установленных [расширений](./extensions/cluster-extensions.md).
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть](cluster-backups.md#restore) из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить кластер {#start-update}

{% note alert %}

* После обновления СУБД вернуть кластер к предыдущей версии невозможно.
* Успешность обновления версии {{ PG }} зависит от многих факторов, в том числе от настроек кластера и данных, хранящихся в базах. Рекомендуется сначала [обновить тестовый кластер](#before-update), который использует те же данные и настройки.

{% endnote %}

### Обновить кластер до версии {{ PG }} 17 {#update-to-v17}

1. [Создайте кластер](cluster-create.md#create-cluster) с версией {{ PG }} 17.
1. При помощи {{ data-transfer-name }} [перенесите в него данные](../tutorials/data-migration.md#data-transfer) из кластера, который хотите обновить.

### Обновить кластер до версии {{ PG }} 16 или ниже {#update-to-v16-or-lower}

{% list tabs group=instructions %}

- Консоль управления {#console}  

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Выберите нужный кластер в списке и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы обновить кластер до версии {{ PG }} 15 или ниже:

  1. Получите список ваших кластеров {{ PG }} командой:

     ```bash
     {{ yc-mdb-pg }} cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию {{ PG }}, указанную в свойстве `config.version`:

     ```bash
     {{ yc-mdb-pg }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление {{ PG }}:

     ```bash
     {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
        --postgresql-version <номер_новой_версии>
     ```

- {{ TF }} {#tf}    

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

       Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Добавьте в блок `cluster_config` нужного кластера {{ mpg-name }} поле `version` или измените его значение, если оно уже существует:

       ```hcl
       resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           version = "<версия_{{ PG }}>"
         }
       }
       ```

    1. Проверьте корректность настроек.

         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

         {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

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
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.version",
                 "configSpec": {
                   "version": "<версия_{{ PG }}>"
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `configSpec.version` — новая версия {{ PG }}.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.version"
               ]
             },
             "config_spec": {
               "version": "<версия_{{ PG }}>"
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.version` — новая версия {{ PG }}.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

Время обновления кластера зависит от размера базы данных.

{% note tip %}

Если с переходом на версию 16 возникнут проблемы, обратитесь в [техническую поддержку](../../support/overview.md).

{% endnote %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 14 до версии 15.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

      ```bash
      {{ yc-mdb-pg }} cluster list
      ```

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   postgre406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере с именем `postgre406`, выполните команду:

      ```bash
      {{ yc-mdb-pg }} cluster get postgre406
      ```

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "14"
          ...
      ```

   1. Для обновления кластера `postgre406` до версии 15, выполните команду:

      ```bash
      {{ yc-mdb-pg }} cluster update postgre406 --postgresql-version 15
      ```

{% endlist %}

