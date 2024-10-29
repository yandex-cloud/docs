# Обновление версии {{ MY }}

Вы можете обновить кластер {{ mmy-name }} до любой поддерживаемой версии: минорной или мажорной.

В однохостовых кластерах на обновление выводится единственный хост-мастер. Во время обновления такие кластеры недоступны для чтения и записи, в отличие от кластеров из двух и более хостов.

В многохостовых кластерах обновление проводится в следующем порядке:

1. Хосты-реплики последовательно выводятся на обновление и отключаются. Порядок реплик в очереди определяется случайным образом. После обновления реплики возвращаются в работу.
1. Мастер закрывается на запись. Среди реплик [выбирается новый мастер](../concepts/replication.md#master-failover), который открывается для записи. В результате кластер обновляется с минимальным временем простоя.
1. Исходный мастер отключается, обновляется и возвращается в роли реплики. Обратно мастер не переключается.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

{% note alert %}

* После обновления СУБД вернуть кластер к предыдущей версии невозможно.
* Успешность обновления версии {{ MY }} зависит от многих факторов, в том числе от настроек кластера и данных, хранящихся в базах. Рекомендуется сначала [обновить тестовый кластер](#before-update), который использует те же данные и настройки.
* Обновляйте кластер в период низкой нагрузки на него.

{% endnote %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://docs.percona.com/percona-server/8.0/release-notes/release-notes_index.html) {{ MY }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера. Для тестового кластера используйте окружение `PRESTABLE`.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.
1. Так как кластер из трех и более хостов является отказоустойчивым, убедитесь, что в основном и тестовом кластере есть хотя бы два хоста-реплики и один хост-мастер. При необходимости [добавьте хосты](hosts.md#add).

## Обновить версию {{ MY }} {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
   1. Выберите нужный кластер в списке и нажмите кнопку ![image](../../_assets/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
   1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
   1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

   После запуска обновления кластер переходит в статус **Updating**. Дождитесь окончания операции и проверьте версию кластера.

   Время обновления зависит от многих факторов, например от объема данных или количества баз данных в кластере. Обновление обычно занимает несколько минут, для больших БД — от 10 минут.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы обновить версию {{ MY }}:

   1. Получите список ваших кластеров {{ MY }} командой:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

   1. Получите информацию о нужном кластере и проверьте версию {{ MY }}, указанную в свойстве `config.version`:

      ```bash
      {{ yc-mdb-my }} cluster get <имя_или_идентификатор_кластера>
      ```

   1. Запустите обновление {{ MY }}:

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
         --mysql-version <номер_новой_версии>
      ```

   Время обновления зависит от многих факторов, например от объема данных или количества баз данных в кластере. Обновление обычно занимает несколько минут, для больших БД — от 10 минут.

- {{ TF }} {#tf}

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

   1. Добавьте поле `version` в ресурс `yandex_mdb_mysql_cluster` или измените значение поля, если оно уже существует:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
         ...
         version = "<версия_{{ MY }}>"
         ...
      }
      ```

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

   {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- REST API {#api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
         --data '{
                   "updateMask": "configSpec.version",
                   "configSpec": {
                     "version": "<версия_{{ MY }}>"
                   }
                 }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

         В данном случае передается только один параметр.

      * `configSpec.version` — новая версия {{ MY }}.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

   1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
   1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

      ```bash
      grpcurl \
         -format json \
         -import-path ~/cloudapi/ \
         -import-path ~/cloudapi/third_party/googleapis/ \
         -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
         -rpc-header "Authorization: Bearer $IAM_TOKEN" \
         -d '{
               "cluster_id": "<идентификатор_кластера>",
               "update_mask": {
                 "paths": [
                   "config_spec.version"
                 ]
               },
               "config_spec": {
                 "version": "<версия_{{ MY }}>"
               }
             }' \
         {{ api-host-mdb }}:{{ port-https }} \
         yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

         В данном случае передается только один параметр.

      * `config_spec.version` — новая версия {{ MY }}.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

   1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

Время обновления зависит от многих факторов, например от объема данных или количества баз данных в кластере. Обновление обычно занимает несколько минут, для больших БД — от 10 минут.

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 5.7 до версии 8.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

      ```bash
      {{ yc-mdb-my }} cluster list
      ```

      Пример результата:

      ```text
      +----------------------+------------+---------------------+--------+---------+
      |          ID          |    NAME    |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |  mysql406  | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере с именем `mysql406`, выполните команду:

      ```bash
      {{ yc-mdb-my }} cluster get mysql406
      ```

      Пример результата:

      ```text
        id: c9q8p8j2gaih********
        ...
        config:
          version: "5.7"
          ...
      ```

   1. Чтобы обновить кластер `mysql406` до версии 8.0, выполните команду:

      ```bash
      {{ yc-mdb-my }} cluster update mysql406 --mysql-version 8.0
      ```

- {{ TF }} {#tf}

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
   1. В поле `version` в ресурсе `yandex_mdb_mysql_cluster` укажите значение `8.0`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
         ...
         version = "8.0"
         ...
      }
      ```

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
