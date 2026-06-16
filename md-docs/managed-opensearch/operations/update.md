# Изменение настроек кластера OpenSearch

После создания кластера вы можете изменить:

* [сервисный аккаунт](#change-service-account);
* [пароль пользователя](#change-admin-password) `admin`;
* [настройки OpenSearch](#change-opensearch-config);
* [дополнительные настройки кластера](#change-additional-settings);
* [группы безопасности](#change-sg-set).

Помимо этого вы можете:

* [обновить версию OpenSearch](cluster-version-update.md);
* [изменить конфигурацию групп хостов](host-groups.md#update-host-group);
* [переместить группы хостов в другую зону доступности](host-migration.md).


## Изменить сервисный аккаунт {#change-service-account}


Для привязки сервисного аккаунта к кластеру Managed Service for OpenSearch [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.


{% note warning %}

Если для доступа к объектам из Object Storage в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.

{% endnote %}

О настройке сервисного аккаунта читайте в разделе [Настройка доступа к Object Storage](s3-access.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить сервисный аккаунт, привязанный к кластеру Managed Service for OpenSearch:

    1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
    1. В поле **Сервисный аккаунт** выберите аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта в разделе [Настройка доступа к Object Storage](s3-access.md).
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить сервисный аккаунт, привязанный к кластеру Managed Service for OpenSearch, выполните команду:

    ```bash
    yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
       --service-account-name <имя_сервисного_аккаунта>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Подробнее о настройке сервисного аккаунта в разделе [Настройка доступа к Object Storage](s3-access.md).

- Terraform {#tf}

    Чтобы изменить сервисный аккаунт, привязанный к кластеру Managed Service for OpenSearch:

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера Managed Service for OpenSearch в [документации провайдера Terraform](../../terraform/resources/mdb_opensearch_cluster.md).

    1. Укажите в поле `service_account_id` идентификатор сервисного аккаунта:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
        ```

        Подробнее о настройке сервисного аккаунта в разделе [Настройка доступа к Object Storage](s3-access.md).

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "serviceAccountId",
                        "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `serviceAccountId` — идентификатор сервисного аккаунта, используемого для работы с кластером.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "service_account_id"
                        ]
                    },
                    "service_account_id": "<идентификатор_сервисного_аккаунта>"
                }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `service_account_id` — идентификатор сервисного аккаунта, используемого для работы с кластером.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить пароль пользователя admin {#change-admin-password}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
    1. В поле **Пароль пользователя admin** укажите новый пароль.

        Пароль должен содержать 3 из 4 групп символов:
        
          * строчные буквы латинского алфавита;
          * заглавные буквы латинского алфавита;
          * цифры;
          * специальные символы.
        
        Длина пароля — от 10 до 72 символов.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить пароль пользователя `admin` для кластера, укажите новый пароль одним из возможных способов:

    * Ввод пароля открытым текстом (менее безопасный способ).

        ```bash
        yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
           --admin-password <новый_пароль>
        ```

        Пароль должен содержать 3 из 4 групп символов:
        
          * строчные буквы латинского алфавита;
          * заглавные буквы латинского алфавита;
          * цифры;
          * специальные символы.
        
        Длина пароля — от 10 до 72 символов.

    * Автоматическая генерация пароля. Сгенерированный пароль будет выведен в консоль.

        ```bash
        yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
           --generate-admin-password
        ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера Managed Service for OpenSearch в [документации провайдера Terraform](../../terraform/resources/mdb_opensearch_cluster.md).

    1. Измените в описании кластера значение поля `admin_password` в блоке `config`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            config {
                admin_password = "<новый_пароль_пользователя-администратора>"
            }
        }
        ```

        Пароль должен содержать 3 из 4 групп символов:
        
          * строчные буквы латинского алфавита;
          * заглавные буквы латинского алфавита;
          * цифры;
          * специальные символы.
        
        Длина пароля — от 10 до 72 символов.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.adminPassword",
                        "configSpec": {
                            "adminPassword": "<новый_пароль>"
                        }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `configSpec.adminPassword` — новый пароль пользователя `admin`.

            Пароль должен содержать 3 из 4 групп символов:
            
              * строчные буквы латинского алфавита;
              * заглавные буквы латинского алфавита;
              * цифры;
              * специальные символы.
            
            Длина пароля — от 10 до 72 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.admin_password"
                        ]
                    },
                    "config_spec": {
                        "admin_password": "<новый_пароль>"
                    }
                }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.admin_password` — новый пароль пользователя `admin`.

            Пароль должен содержать 3 из 4 групп символов:
            
              * строчные буквы латинского алфавита;
              * заглавные буквы латинского алфавита;
              * цифры;
              * специальные символы.
            
            Длина пароля — от 10 до 72 символов.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки OpenSearch {#change-opensearch-config}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Выполните команду и передайте в ней список настроек, которые хотите изменить:

    ```bash
    yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
       --max-clause-count <количество_булевых_выражений> \
       --fielddata-cache-size <объем_кучи_JVM> \
       --reindex-remote-whitelist <адрес_хоста>:<порт>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Настройки в команде:

    * `--max-clause-count` — максимально допустимое количество булевых выражений (boolean clauses) в запросе. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/query-dsl/compound/bool/).
    * `--fielddata-cache-size` — объем кучи JVM, который выделен для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
    * `--reindex-remote-whitelist` — список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите значение параметра в формате `<адрес_хоста>:<порт>`. Если нужно указать несколько хостов, перечислите значения через запятую. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.opensearchSpec.opensearchConfig_2.maxClauseCount,configSpec.opensearchSpec.opensearchConfig_2.fielddataCacheSize,configSpec.opensearchSpec.opensearchConfig_2.reindexRemoteWhitelist",
                        "configSpec": {
                            "opensearchSpec": {
                                "opensearchConfig_2": {
                                    "maxClauseCount": "<количество_булевых_выражений>",
                                    "fielddataCacheSize": "<объем_кучи_JVM>",
                                    "reindexRemoteWhitelist": "<адрес_хоста>:9200"
                                }
                            }
                        }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `configSpec.opensearchSpec.opensearchConfig_2` — настройки OpenSearch:

            * `maxClauseCount` — новое максимально допустимое количество булевых выражений. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/query-dsl/compound/bool/).

            * `fielddataCacheSize` — новый объем кучи JVM, выделенный для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/install-and-configure/configuring-opensearch/).

            * `reindexRemoteWhitelist` — новый список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите [FQDN хоста](connect/fqdn.md) и через двоеточие порт 9200. Чтобы указать несколько хостов, перечислите их через запятую, указанную после порта. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.opensearch_spec.opensearch_config_2.max_clause_count",
                            "config_spec.opensearch_spec.opensearch_config_2.fielddata_cache_size",
                            "config_spec.opensearch_spec.opensearch_config_2.reindex_remote_whitelist"
                        ]
                    },
                    "config_spec": {
                        "opensearch_spec": {
                            "opensearch_config_2": {
                                "max_clause_count": "<количество_булевых_выражений>",
                                "fielddata_cache_size": "<объем_кучи_JVM>",
                                "reindex_remote_whitelist": "<адрес_хоста>:9200"
                            }
                        }
                    }
                }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `config_spec.opensearch_spec.opensearch_config_2` — настройки OpenSearch:

            * `max_clause_count` — новое максимально допустимое количество булевых выражений. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/query-dsl/compound/bool/).

            * `fielddata_cache_size` — новый объем кучи JVM, выделенный для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/install-and-configure/configuring-opensearch/).

            * `reindex_remote_whitelist` — новый список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите [FQDN хоста](connect/fqdn.md) и через двоеточие порт 9200. Чтобы указать несколько хостов, перечислите их через запятую, указанную после порта. Подробнее в [документации OpenSearch](https://opensearch.org/docs/latest/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * **Обслуживание** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **В любое время** (по умолчанию).
            * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **По расписанию** и укажите день недели и интервал времени по UTC. Например, можно выбрать время, когда кластер наименее загружен.
            
            Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.


        * **Защита от удаления** — управляет защитой кластера от непреднамеренного удаления.

            Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Выполните команду и передайте в ней список настроек, которые хотите изменить:

    ```bash
    yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
       --maintenance schedule=<тип_технического_обслуживания>,`
                    `weekday=<день_недели>,`
                    `hour=<час_дня> \
       --delete-protection \
       --data-transfer-access=<разрешить_доступ_из_Data_Transfer> \
       --serverless-access=<разрешить_доступ_из_Serverless_Containers>
    ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Настройки в команде:

    * `--maintenance` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        * Чтобы разрешить проведение технического обслуживания в любое время, укажите `--maintenance schedule=anytime`.
        * Чтобы указать предпочтительное время начала обслуживания, укажите `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время.

            Возможные значения параметра `weekday`: `mon`, `tue`, `wed`, `thu`, `fry`, `sat`, `sun`. В параметре `hour` укажите, во сколько должно завершиться техническое обслуживание. Например, если указать `14`, техническое обслуживание будет проходить с 13:00 до 14:00 по UTC.

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.


    * `--serverless-access` — доступ из [Yandex Serverless Containers](../../serverless-containers/index.md): `true` или `false`.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера Managed Service for OpenSearch в [документации провайдера Terraform](../../terraform/resources/mdb_opensearch_cluster.md).

    1. Чтобы изменить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), укажите настройки в параметре `maintenance_window`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            maintenance_window {
                type = "<частота_технического_обслуживания>"
                hour = <час_дня>
                day  = "<день_недели>"
            }
        }
        ```

        Укажите в параметрах:

        * `type` — значение `ANYTIME`, чтобы разрешить проведение технического обслуживания в любое время, или `WEEKLY`, чтобы проводить техническое обслуживание каждую неделю.
        * `hour` — час дня по UTC, когда завершается техническое обслуживание. Например, если указать `14`, техническое обслуживание будет проходить с 13:00 до 14:00 по UTC.
        * `day` — день недели, когда проводится техническое обслуживание. Доступные значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            deletion_protection = <защитить_кластер_от_удаления>
        }
        ```

        Где `deletion_protection` — защита кластера от непреднамеренного удаления.

        Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "configSpec.access,deletionProtection,maintenanceWindow",
                        "configSpec": {
                            "access": {
                                "dataTransfer": <разрешить_доступ_из_Data_Transfer>,
                                "serverless": <разрешить_доступ_из_Serverless_Containers>
                            }
                        },
                        "deletionProtection": <защитить_кластер_от_удаления>,
                        "maintenanceWindow": {
                            "weeklyMaintenanceWindow": {
                                "day": "<день_недели>",
                                "hour": "<час>"
                            }
                        }
                    }'
        ```


        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        
        * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

            * `dataTransfer` — [Yandex Data Transfer](../../data-transfer/index.md);
            * `serverless` — [Yandex Serverless Containers](../../serverless-containers/index.md).

            Возможные значения настроек: `true` или `false`.


        * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.

        * `maintenanceWindow.weeklyMaintenanceWindow` — расписание окна технического обслуживания:

            * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
            * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        
        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "config_spec.access",
                            "deletion_protection",
                            "maintenance_window"
                        ]
                    },
                    "config_spec": {
                        "access": {
                            "data_transfer": <разрешить_доступ_из_Data_Transfer>,
                            "serverless": <разрешить_доступ_из_Serverless_Containers>
                        }
                    },
                    "deletion_protection": <защитить_кластер_от_удаления>,
                    "maintenance_window": {
                        "weekly_maintenance_window": {
                            "day": "<день_недели>",
                            "hour": "<час>"
                        }
                    }
                }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```


        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        
        * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

            * `data_transfer` — [Yandex Data Transfer](../../data-transfer/index.md);
            * `serverless` — [Yandex Serverless Containers](../../serverless-containers/index.md).

            Возможные значения настроек: `true` или `false`.


        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

            Включенная защита кластера от удаления не помешает удалить пользователя или подключиться к кластеру вручную и удалить данные.

        * `maintenance_window.weekly_maintenance_window` — расписание окна технического обслуживания:

            * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
            * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

После того как вы назначите другие [группы безопасности](../concepts/network.md#security-groups), может потребоваться их [дополнительная настройка](connect/fqdn.md#security-groups) для подключения к кластеру.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога.
    1. Перейдите в сервис **Managed Service for&nbsp;OpenSearch**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.
    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить список групп безопасности для кластера, укажите нужные группы безопасности в команде:

    ```bash
    yc managed-opensearch cluster update <имя_или_идентификатор_кластера> \
       --security-group-ids <список_идентификаторов_групп_безопасности>
    ```

    Если нужно указать несколько групп, перечислите их через запятую.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        Полный список доступных для изменения полей конфигурации кластера Managed Service for OpenSearch в [документации провайдера Terraform](../../terraform/resources/mdb_opensearch_cluster.md).

    1. В поле `security_group_ids` перечислите через запятую идентификаторы групп безопасности:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
            ...
            security_group_ids = [ "<группы_безопасности>" ]
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://mdb.api.cloud.yandex.net/managed-opensearch/v1/clusters/<идентификатор_кластера>' \
            --data '{
                        "updateMask": "securityGroupIds",
                        "securityGroupIds": [
                            "<идентификатор_группы_безопасности_1>",
                            "<идентификатор_группы_безопасности_2>",
                            ...
                            "<идентификатор_группы_безопасности_N>"
                        ]
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае передается только один параметр.

        * `securityGroupIds` — идентификаторы групп безопасности.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
        {% cut "Формат перечисления настроек" %}
        
        ```yaml
        "update_mask": {
            "paths": [
                "<настройка_1>",
                "<настройка_2>",
                ...
                "<настройка_N>"
            ]
        }
        ```
        
        {% endcut %}
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<идентификатор_кластера>",
                    "update_mask": {
                        "paths": [
                            "security_group_ids"
                        ]
                    },
                    "security_group_ids": [
                        "<идентификатор_группы_безопасности_1>",
                        "<идентификатор_группы_безопасности_2>",
                        ...
                        "<идентификатор_группы_безопасности_N>"
                    ]
                }' \
        mdb.api.cloud.yandex.net:443 \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае передается только один параметр.

        * `security_group_ids` — идентификаторы групп безопасности.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}