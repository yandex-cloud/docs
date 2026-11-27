---
alternate:
  - href: ru/storedoc/operations/delayed-replicas.md
    type: text/markdown
    title: Markdown version
---
# Управление отстающей репликой {{ SD }}

При создании или изменении скрытого хоста вы можете задать время, на которое данные на вторичной реплике отстают от мастера. Такая реплика станет _отстающей_. С нее можно оперативно восстановить данные в случае ошибочного удаления коллекции или базы данных. 

{% note warning %}

В шардированном кластере восстановление данных с отстающей реплики не рекомендуется, так как может привести к несогласованному состоянию кластера. Подробнее в разделе [{#T}](../concepts/replication.md#delayed-replica).

{% endnote %}

## Настроить отставание реплики в существующем кластере {#set-at-update}

В существующем кластере реплику можно сделать отстающей, если скрыть хост и задать время отставания от мастера. При этом в нешардированном кластере или шарде, к которому относится хост, должно остаться не менее трех нескрытых хостов. Также вы можете задать отставание реплики при [добавлении хоста](./hosts.md#add-host).

Если первичную реплику сделать отстающей, будут запущены выборы нового мастера.

О настройке отстающей реплики при создании кластера читайте в разделе [{#T}](cluster-create.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите]({{ link-console-main }}/link/storedoc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_hosts }}**.
    1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного хоста и выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Настройте отставание реплики:

        1. Отметьте хост скрытым.
        1. Задайте значение отставания реплики от мастера в секундах.

           {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-console.md) %}

           {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить отставание реплики, выполните команду:

    
    ```bash
    {{ yc-mdb-mg }} host update \
      --cluster-name <имя_кластера> \
      --host hostname=<имя_хоста>,`
            `hidden=true,`
            `secondary-delay-secs=<отставание_реплики_в_секундах>
    ```


    {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-cli.md) %}

    {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}


- {{ TF }} {#tf}

    Чтобы изменить параметры хоста в кластере:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Инструкция по созданию такого файла приведена в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mmg-name }} приведен в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

    1. Измените в описании кластера {{ mmg-name }} атрибуты блока `host`, соответствующего отстающей реплике.

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          host {
            ...
            host_parameters {
              hidden               = <скрытие_хоста>
              secondary_delay_secs = <отставание_реплики_в_секундах>
            }
          }
        }
        ```

        {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-terraform.md) %}

        {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/<идентификатор_кластера>/hosts:batchUpdate' \
          --data '{
                    "updateHostSpecs": [
                      {
                        "updateMask": "hidden,secondaryDelaySecs",
                        "hostName": "<имя_хоста>",
                        "hidden": true,
                        "secondaryDelaySecs": "<отставание_реплики_в_секундах>"
                      }
                    ]
                  }'
        ```

        {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-rest-api.md) %}

        {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
                "update_host_specs": [
                  {
                    "update_mask": {
                        "paths": [
                          "hidden",
                          "secondary_delay_secs"
                        ]
                    },
                    "host_name": "<имя_хоста>",
                    "hidden": true,
                    "secondary_delay_secs": "<отставание_реплики_в_секундах>"
                  }
                ]
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mongodb.v1.ClusterService.UpdateHosts
        ```

        {% include [mmg-replica-delay](../../_includes/mdb/mmg/replica-delay-values-grpc-api.md) %}

        {% include [delayed-replica-log-size](../../_includes/mdb/mmg/delayed-replica-log-size.md) %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation).

{% endlist %}

## Восстановить данные с отстающей реплики {#restore-data}

Чтобы восстановить данные с отстающей реплики, необходимо выполнить дамп базы данных {{ SD }} и восстановить данные из дампа на мастере. Эти действия могут выполняться:

* С вашего компьютера через интернет, если вы настроили публичный доступ для отстающей реплики. При этом используется только SSL-соединение.

  Перед подключением [получите SSL-сертификат](connect/index.md#get-ssl-cert).

* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [облачной сети](../../vpc/concepts/network.md). Если к отстающей реплике нет публичного доступа, использовать SSL-соединение необязательно.

{% note warning %}

На создание дампа БД может потребоваться время, превышающее отставание реплики. В этом случае ошибочная операция будет применена на отстающей реплике и вы не сможете восстановить данные. Чтобы избежать этого, заранее оцените время на создание дампа и при необходимости увеличьте время отставания реплики.

{% endnote %}

Чтобы восстановить данные с отстающей реплики в нешардированном кластере:

1. Установите `mongodump` и дополнительные утилиты для работы с {{ SD }}. Пример для [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts):

    ```bash
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt update
    sudo apt install mongodb-org-shell mongodb-org-tools
    ```

1. [Получите FQDN хоста](connect/index.md#get-fqdn) для отстающей реплики и мастера.
1. Создайте дамп базы данных:

   {% list tabs group=instructions %}

   - Подключение с SSL {#with-ssl}

       ```bash
       mongodump --host <FQDN_отстающей_реплики> \
                 --port {{ port-mmg }} \
                 --username <имя_пользователя> \
                 --password "<пароль>" \
                 --ssl \
                 --sslCAFile ~/.mongodb/root.crt \
                 --db <имя_БД> \
                 --out ~/db_dump
       ```

   - Подключение без SSL {#without-ssl}

       ```bash
       mongodump --host <FQDN_отстающей_реплики> \
                 --port {{ port-mmg }} \
                 --username <имя_пользователя> \
                 --password "<пароль>" \
                 --db <имя_БД> \
                 --out ~/db_dump
       ```

   {% endlist %}

1. Восстановите ошибочно удаленную или измененную коллекцию базы данных из дампа с помощью утилиты `mongorestore`. Предварительно [добавьте](cluster-users.md#updateuser) пользователю [роль mdbDbAdmin](../concepts/users-and-roles.md#mdbDbAdmin).

   {% list tabs group=instructions %}

   - Подключение с SSL {#with-ssl}

       ```bash
       mongorestore --host <FQDN_мастера> \
                    --port {{ port-mmg }} \
                    --username <имя_пользователя> \
                    --password "<пароль>" \
                    --ssl \
                    --sslCAFile ~/.mongodb/root.crt \
                    --nsInclude '<имя_БД>.<имя_коллекции>' \
                    --authenticationDatabase=<имя_БД> ~/db_dump
       ```

   - Подключение без SSL {#without-ssl}

       ```bash
       mongorestore --host <FQDN_мастера> \
                    --port {{ port-mmg }} \
                    --username <имя_пользователя> \
                    --password "<пароль>" \
                    --nsInclude '<имя_БД>.<имя_коллекции>' \
                    --authenticationDatabase=<имя_БД> ~/db_dump
       ```

   {% endlist %}

   Чтобы восстановить всю базу данных из дампа, выполните следующую команду:

   {% list tabs group=instructions %}

   - Подключение с SSL {#with-ssl}

       ```bash
       mongorestore --host <FQDN_мастера> \
                    --port {{ port-mmg }} \
                    --username <имя_пользователя> \
                    --password "<пароль>" \
                    --ssl \
                    --sslCAFile ~/.mongodb/root.crt
                    --nsInclude '*.*' \
                    --authenticationDatabase=<имя_БД> \
                    --drop ~/db_dump
       ```

   - Подключение без SSL {#without-ssl}

       ```bash
       mongorestore --host <FQDN_мастера> \
                    --port {{ port-mmg }} \
                    --username <имя_пользователя> \
                    --password "<пароль>" \
                    --nsInclude '*.*' \
                    --authenticationDatabase=<имя_БД> \
                    --drop ~/db_dump
       ```

   {% endlist %}

   {% note warning %}

   При восстановлении всей БД записи во всех коллекциях будут восстановлены в состояние на момент отставания.

   {% endnote %}
