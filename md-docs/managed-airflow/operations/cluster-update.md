[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Airflow™](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Изменение кластера

# Изменение кластера Apache Airflow™

После создания кластера вы можете изменить его основные и дополнительные настройки:

* [имя, описание и метки кластера](#change-basic-settings);
* [сервисный аккаунт](#change-sa);
* [подсети](#change-subnet);
* [группы безопасности](#change-sg);
* [конфигурацию компонентов](#change-configuration);
* [списки pip- и deb-пакетов](#change-dependencies);
* [источник DAG-файлов](#change-dag-source);
* [свойства Apache Airflow™ и использование секретов Yandex Lockbox](#change-airflow-configuration);
* [дополнительные настройки кластера](#change-additional-settings).

Подробнее об [обновлении версии Apache Airflow™ и Python](cluster-version-update.md).

## Изменить имя, описание и метки кластера {#change-basic-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Базовые параметры** измените имя и описание кластера, удалите или добавьте новые метки.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --new-name <новое_имя_кластера> \
       --description <описание_кластера> \
       --labels <список_меток>
     ```

     Где:

     * `--new-name` — имя кластера.

     * `--description` — описание кластера.

     * `--labels` — список меток. Метки задаются в формате `<ключ>=<значение>`.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  {% note alert %}

  Не изменяйте имя кластера и пароль с помощью Terraform. Это приведет к удалению существующего кластера и созданию нового.

  {% endnote %}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       description = "<описание_кластера>"
       labels      = { <список_меток> }
       ...
     }
     ```

     Где:

     * `description` — описание кластера.

     * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "name,description,labels",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": {
            "<ключ>": "<значение>"
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `name` — имя кластера.

        * `description` — описание кластера.

        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "name",
              "description",
              "labels"
            ]
          },
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": {
            "<ключ>": "<значение>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `name` — имя кластера.

        * `description` — описание кластера.

        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить сервисный аккаунт {#change-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Настройки доступа** выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролью `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее в разделе [Имперсонация](../concepts/impersonation.md).

        Для изменения сервисного аккаунта в кластере Managed Service for Apache Airflow™ [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

        {% note warning %}
        
        Если для доступа к объектам из Object Storage в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.
        
        {% endnote %}

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --service-account-id <идентификатор_сервисного_аккаунта>
     ```

     Где:

     * `--service-account-id` — идентификатор сервисного аккаунта.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       service_account_id = "<идентификатор_сервисного_аккаунта>"
       ...
     }
     ```

     Где:

     * `service_account_id` — идентификатор сервисного аккаунта.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "serviceAccountId",
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>"
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `serviceAccountId` — идентификатор сервисного аккаунта с [ролью](../../iam/concepts/access-control/roles.md) `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее в разделе [Имперсонация](../concepts/impersonation.md).

            Для изменения сервисного аккаунта в кластере Managed Service for Apache Airflow™ [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

            {% note warning %}
            
            Если для доступа к объектам из Object Storage в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.
            
            {% endnote %}

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "service_account_id"
            ]
          },
          "service_account_id": "<идентификатор_сервисного_аккаунта>"
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `service_account_id` — идентификатор сервисного аккаунта с [ролью](../../iam/concepts/access-control/roles.md) `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее в разделе [Имперсонация](../concepts/impersonation.md).

            Для изменения сервисного аккаунта в кластере Managed Service for Apache Airflow™ [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

            {% note warning %}
            
            Если для доступа к объектам из Object Storage в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.
            
            {% endnote %}

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить подсети {#change-subnet}

Вы можете изменить подсети кластера даже если он был [остановлен](cluster-stop.md#stop-cluster).

Вы можете выбрать для кластера другие подсети в текущей [облачной сети](../../vpc/concepts/network.md#network).

При изменении подсетей кластер будет перенесен в одну из [зон доступности](../../overview/concepts/geo-scope.md), в которых находятся указанные подсети. Чтобы исключить размещение кластера в исходной зоне, удалите из списка все подсети этой зоны.

Перед изменением подсетей убедитесь, что они соответствуют [требованиям](../concepts/network.md#subnet-requirements). При необходимости [настройте NAT-шлюз](cluster-create.md#nat-routing).

{% note warning %}

При изменении подсетей нельзя одновременно менять другие параметры кластера.

{% endnote %}

Изменить подсети существующего кластера можно в консоли управления или через API.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Сетевые настройки** выберите подсети.

    1. Нажмите кнопку **Сохранить**.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "networkSpec.subnetIds",
          "networkSpec": {
            "subnetIds": [
              "<идентификатор_подсети_1>",
              "<идентификатор_подсети_2>"
            ]
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `networkSpec.subnetIds` — список идентификаторов выбранных подсетей.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "network_spec.subnet_ids"
            ]
          },
          "network_spec": {
            "subnet_ids": [
              "<идентификатор_подсети_1>",
              "<идентификатор_подсети_2>"
            ]
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `network_spec.subnet_ids` — список идентификаторов выбранных подсетей.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

Если вы изменили подсети остановленного кластера, [запустите его](cluster-stop.md#start-cluster).

## Изменить группы безопасности {#change-sg}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Сетевые настройки** выберите [группу безопасности](../concepts/network.md#security-groups) для сетевого трафика кластера или создайте ее.

        Настройки группы безопасности не влияют на доступ к [веб-интерфейсу Apache Airflow™](af-interfaces.md#web-gui).

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --security-group-ids <идентификаторы_групп_безопасности>
     ```

     Где:

     * `--security-group-ids` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       security_group_ids = ["<идентификатор_группы_безопасности>"]
       ...
     }
     ```

     Где:

     * `security_group_ids` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "networkSpec.securityGroupIds",
          "networkSpec": {
            "securityGroupIds": [
              "<идентификатор_группы_безопасности>"
            ]
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `networkSpec.securityGroupIds` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "network_spec.security_group_ids"
            ]
          },
          "network_spec": {
            "security_group_ids": [
              "<идентификатор_группы_безопасности>"
            ]
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `network_spec.security_group_ids` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить конфигурацию компонентов {#change-configuration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоках для настройки [компонентов](../concepts/index.md#components) Managed Service for Apache Airflow™ — **Конфигурация веб-сервера**, **Конфигурация планировщика**, **Конфигурация воркеров**, **Конфигурация DAG-процессора** — укажите количество экземпляров и [конфигурацию вычислительных ресурсов](../concepts/instance-types.md).

        {% note warning %}
               
        Компонент _DAG-процессор_ доступен в версии Apache Airflow™ 3.0 и выше.
               
        {% endnote %}

    1. В блоке **Конфигурация Triggerer** включите или выключите службу Triggerer. Если служба включена, укажите количество экземпляров и ресурсов.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --webserver count=<количество_экземпляров>,resource-preset-id=<идентификатор_ресурсов> \
       --scheduler count=<количество_экземпляров>,resource-preset-id=<идентификатор_ресурсов> \
       --worker min-count=<минимальное_количество_экземпляров>,max-count=<максимальное_количество_экземпляров>,resource-preset-id=<идентификатор_ресурсов> \
       --triggerer count=<количество_экземпляров>,resource-preset-id=<идентификатор_ресурсов> \
       --dag-processor count=<количество_экземпляров>,resource-preset-id=<идентификатор_ресурсов>
     ```

     Где:

     * `--webserver`, `--scheduler`, `--worker`, `--triggerer`, `--dag-processor` — конфигурация [компонентов](../concepts/index.md#components) Managed Service for Apache Airflow™:

         * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
         * `min-count`, `max-count` — минимальное и максимальное количество экземпляров в кластере для воркера.
         * `resource-preset-id` — [идентификатор вычислительных ресурсов](../concepts/instance-types.md) веб-сервера, планировщика, DAG-процессора, воркера и службы Triggerer. Возможные значения:

             * `c1-m2` — 1 vCPU, 2 ГБ RAM.
             * `c1-m4` — 1 vCPU, 4 ГБ RAM.
             * `c2-m4` — 2 vCPU, 4 ГБ RAM.
             * `c2-m8` — 2 vCPU, 8 ГБ RAM.
             * `c4-m8` — 4 vCPU, 8 ГБ RAM.
             * `c4-m16` — 4 vCPU, 16 ГБ RAM.
             * `c8-m16` — 8 vCPU, 16 ГБ RAM.
             * `c8-m32` — 8 vCPU, 32 ГБ RAM.

         {% note warning %}
                
         Компонент _DAG-процессор_ доступен в версии Apache Airflow™ 3.0 и выше.
                
         {% endnote %}

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       webserver = {
         count              = <количество_экземпляров>
         resource_preset_id = "<идентификатор_ресурсов>"
       }

       scheduler = {
         count              = <количество_экземпляров>
         resource_preset_id = "<идентификатор_ресурсов>"
       }

       worker = {
         min_count          = <минимальное_количество_экземпляров>
         max_count          = <максимальное_количество_экземпляров>
         resource_preset_id = "<идентификатор_ресурсов>"
       }

       triggerer = {
         count              = <количество_экземпляров>
         resource_preset_id = "<идентификатор_ресурсов>"
       }

       dag_processor = {
         count              = <количество_экземпляров>
         resource_preset_id = "<идентификатор_ресурсов>"
       }
       ...
     }
     ```

     Где:

     * `webserver`, `scheduler`, `worker`, `triggerer`, `dag_processor` — конфигурация [компонентов](../concepts/index.md#components) Managed Service for Apache Airflow™:

         * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
         * `min_count`, `max_count` — минимальное и максимальное количество экземпляров в кластере для воркера.
         * `resource_preset_id` — идентификатор вычислительных ресурсов веб-сервера, планировщика, DAG-процессора, воркера и Triggerer. Возможные значения:

             * `c1-m2` — 1 vCPU, 2 ГБ RAM.
             * `c1-m4` — 1 vCPU, 4 ГБ RAM.
             * `c2-m4` — 2 vCPU, 4 ГБ RAM.
             * `c2-m8` — 2 vCPU, 8 ГБ RAM.
             * `c4-m8` — 4 vCPU, 8 ГБ RAM.
             * `c4-m16` — 4 vCPU, 16 ГБ RAM.
             * `c8-m16` — 8 vCPU, 16 ГБ RAM.
             * `c8-m32` — 8 vCPU, 32 ГБ RAM.

         {% note warning %}
                
         Компонент _DAG-процессор_ доступен в версии Apache Airflow™ 3.0 и выше.
                
         {% endnote %}

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "configSpec.webserver,configSpec.scheduler,configSpec.worker,configSpec.triggerer,configSpec.dagProcessor",
          "configSpec": {
            "webserver": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "scheduler": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "worker": {
              "minCount": "<минимальное_количество_экземпляров>",
              "maxCount": "<максимальное_количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "triggerer": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "dagProcessor": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `configSpec` — конфигурация кластера:

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dagProcessor` — конфигурация [компонентов](../concepts/index.md#components) Managed Service for Apache Airflow™:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
                * `minCount`, `maxCount` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resourcePresetId` — идентификатор вычислительных ресурсов веб-сервера, планировщика, DAG-процессора, воркера и Triggerer. Возможные значения:

                    * `c1-m2` — 1 vCPU, 2 ГБ RAM.
                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m4` — 2 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m8` — 4 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m16` — 8 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.

                {% note warning %}
                       
                Компонент _DAG-процессор_ доступен в версии Apache Airflow™ 3.0 и выше.
                       
                {% endnote %}

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "config_spec.webserver",
              "config_spec.scheduler",
              "config_spec.worker",
              "config_spec.triggerer",
              "config_spec.dag_processor"
            ]
          },
          "config_spec": {
            "webserver": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "scheduler": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "worker": {
              "min_count": "<минимальное_количество_экземпляров>",
              "max_count": "<максимальное_количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "triggerer": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "dag_processor": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            }
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `config_spec` — конфигурация кластера:

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dag_processor` — конфигурация [компонентов](../concepts/index.md#components) Managed Service for Apache Airflow™:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
                * `min_count`, `max_count` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resource_preset_id` — идентификатор вычислительных ресурсов веб-сервера, планировщика, DAG-процессора, воркера и Triggerer. Возможные значения:

                    * `c1-m2` — 1 vCPU, 2 ГБ RAM.
                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m4` — 2 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m8` — 4 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m16` — 8 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.

                {% note warning %}
                       
                Компонент _DAG-процессор_ доступен в версии Apache Airflow™ 3.0 и выше.
                       
                {% endnote %}

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить списки пакетов {#change-dependencies}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Зависимости** удалите или добавьте названия pip- и deb-пакетов.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --pip-packages <список_pip-пакетов> \
       --deb-packages <список_deb-пакетов>
     ```

     Где:

     * `--deb-packages`, `--pip-packages` — списки deb- и pip-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

         При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

         ```hcl
         --pip-packages "pandas==2.0.2,scikit-learn>=1.0.0,clickhouse-driver~=0.2.0"
         ```

         Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       pip_packages = ["<pip-пакет_1>", "<pip-пакет_2>"]
       deb_packages = ["<deb-пакет_1>", "<deb-пакет_2>"]
       ...
     }
     ```

     Где:

     * `deb_packages`, `pip_packages` — списки deb- и pip-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

         При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

         ```hcl
         pip_packages = ["pandas==2.0.2","scikit-learn>=1.0.0","clickhouse-driver~=0.2.0"]
         ```

         Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "configSpec.dependencies",
          "configSpec": {
            "dependencies": {
              "pipPackages": [
                "<pip-пакет_1>",
                "<pip-пакет_2>"
              ],
              "debPackages": [
                "<deb-пакет_1>",
                "<deb-пакет_2>"
              ]
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `configSpec` — конфигурация кластера:

            * `dependencies` — список пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов:

                * `pipPackages` — список pip-пакетов.
                * `debPackages` — список deb-пакетов.

                При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

                ```bash
                "dependencies": {
                  "pipPackages": [
                    "pandas==2.0.2",
                    "scikit-learn>=1.0.0",
                    "clickhouse-driver~=0.2.0"
                  ]
                }
                ```

                Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "config_spec.dependencies"
            ]
          },
          "config_spec": {
            "dependencies": {
              "pip_packages": [
                "<pip-пакет_1>",
                "<pip-пакет_2>"
              ],
              "deb_packages": [
                "<deb-пакет_1>",
                "<deb-пакет_2>"
              ]
            }
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `config_spec` — конфигурация кластера:

            * `dependencies` — список пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов:

                * `pip_packages` — список pip-пакетов.
                * `deb_packages` — список deb-пакетов.

                При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

                ```bash
                "dependencies": {
                  "pip_packages": [
                    "pandas==2.0.2",
                    "scikit-learn>=1.0.0",
                    "clickhouse-driver~=0.2.0"
                  ]
                }
                ```

                Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить источник DAG-файлов {#change-dag-source}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Хранилище DAG-файлов** выберите **Тип источника данных** и укажите параметры [источника](../concepts/dag-sources.md):

        * **S3** — выберите существующий бакет или создайте новый. В этом бакете будут храниться DAG-файлы.

            Сервисному аккаунту кластера должно быть [предоставлено разрешение](../../storage/operations/buckets/edit-acl.md) `READ` для этого бакета.

        * **Git** — укажите адрес репозитория, рабочую ветку и путь к каталогу с DAG-файлами. Выберите **Способ аутентификации**:

            {% list tabs %}

            - SSH-ключ

                Укажите адрес репозитория в формате `git@<хост>:<путь_к_репозиторию>.git` и вставьте содержимое закрытого ключа в поле **SSH-ключ**.

                При подключении по SSH поддерживаются закрытые ключи `RSA`, `DSA`, `ECDSA`, `Ed25519` в форматах `PKCS#1`, `PKCS#8`, `OpenSSL` и `OpenSSH`. Закрытый ключ не должен быть защищен паролем.

            - Логин и пароль

                Укажите адрес репозитория в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git` и заполните поля **Логин** и **Пароль или токен доступа**. При использовании токена логин зависит от [сервиса и типа токена](../concepts/dag-sources.md#git-token).

            {% endlist %}

            {% note warning %}
            
            Для использования Git-репозитория [настройте доступ в интернет через NAT-шлюз](cluster-create.md#nat-routing) из сети кластера Managed Service for Apache Airflow™. Во время настройки привяжите таблицу маршрутизации с NAT-шлюзом ко всем подсетям кластера.
            
            {% endnote %}

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --dags-bucket <имя_бакета>
     ```

     Где:

     * Тип и параметры [источника](../concepts/dag-sources.md) DAG-файлов:

         * `--dags-bucket` — имя бакета.

         * `--gitsync` — параметры подключения к Git-репозиторию. Общие параметры для обоих способов аутентификации:

           * `branch` — имя ветки в репозитории, например `main`.
           * `subpath` — путь к каталогу с DAG-файлами относительно репозитория в формате `/<путь-к-DAG-файлам>`.

           Остальные параметры зависят от способа аутентификации. Выберите один из способов подключения:

           {% list tabs %}

           - SSH-ключ

               Для подключения по SSH укажите:

               * `repo` — адрес репозитория в формате `git@<хост>:<путь_к_репозиторию>.git`.
               * Один из параметров с закрытым SSH-ключом:

                   * `ssh-key` — содержимое ключа в одну строку с символами переноса строки `\n`.
                   * `ssh-key-path` — путь к файлу с ключом.

               Например, для подключения с ключом из файла передайте:

               ```bash
               --gitsync repo=git@github.com:<имя_пользователя>/<имя_репозитория>.git,`
                         `branch=main,`
                         `subpath=/dags,`
                         `ssh-key-path=<путь_к_файлу_с_ключом>
               ```

               При подключении по SSH поддерживаются закрытые ключи `RSA`, `DSA`, `ECDSA`, `Ed25519` в форматах `PKCS#1`, `PKCS#8`, `OpenSSL` и `OpenSSH`. Закрытый ключ не должен быть защищен паролем.

           - Логин и пароль

               Для подключения по HTTP(S) укажите:

               * `repo` — адрес репозитория в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git`.
               * `username` — имя пользователя. При использовании токена значение зависит от [сервиса и типа токена](../concepts/dag-sources.md#git-token).
               * Один из параметров с паролем или токеном доступа:

                   * `password` — пароль или токен.
                   * `password-path` — путь к файлу с паролем или токеном. Используйте этот параметр, если пароль или токен содержит символы `,`, `{`, `}`, `[` или `]`.

               Например, для подключения по HTTPS с токеном из файла передайте:

               ```bash
               --gitsync repo=https://github.com/<имя_пользователя>/<имя_репозитория>.git,`
                         `branch=main,`
                         `subpath=/dags,`
                         `username=<имя_пользователя>,`
                         `password-path=<путь_к_файлу_с_токеном>
               ```

           {% endlist %}

           {% note warning %}
           
           Для использования Git-репозитория [настройте доступ в интернет через NAT-шлюз](cluster-create.md#nat-routing) из сети кластера Managed Service for Apache Airflow™. Во время настройки привяжите таблицу маршрутизации с NAT-шлюзом ко всем подсетям кластера.
           
           {% endnote %}

         Укажите один из двух параметров: `--dags-bucket` либо `--gitsync`.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       code_sync = {
         s3 = {
           bucket = "<имя_бакета>"
         }
       }
       ...
     }
     ```

     Где:

     * `code_sync` — тип и параметры [источника](../concepts/dag-sources.md) DAG-файлов:

       * `s3.bucket` — имя бакета.

       * `git_sync` — параметры подключения к Git-репозиторию. Общие параметры для обоих способов аутентификации:

         * `branch` — имя ветки в репозитории, например `main`.
         * `sub_path` — путь к каталогу с DAG-файлами относительно репозитория в формате `/<путь-к-DAG-файлам>`.

         Остальные параметры зависят от способа аутентификации. Выберите один из способов подключения:

         {% list tabs %}

         - SSH-ключ

             Для подключения по SSH укажите:

             * `repo` — адрес репозитория в формате `git@<хост>:<путь_к_репозиторию>.git`.
             * `ssh_key` — закрытый SSH-ключ доступа к репозиторию в одну строчку с символами переноса строки `\n` или содержимое файла с ключом, полученное с помощью функции `file()`.

             Например, для подключения с ключом из файла задайте:

             ```hcl
             code_sync = {
               git_sync = {
                 repo     = "git@github.com:<имя_пользователя>/<имя_репозитория>.git"
                 branch   = "main"
                 sub_path = "/dags"
                 ssh_key  = file("<путь_к_файлу_с_ключом>")
               }
             }
             ```

             При подключении по SSH поддерживаются закрытые ключи `RSA`, `DSA`, `ECDSA`, `Ed25519` в форматах `PKCS#1`, `PKCS#8`, `OpenSSL` и `OpenSSH`. Закрытый ключ не должен быть защищен паролем.

         - Логин и пароль

             Для подключения по HTTP(S) укажите:

             * `repo` — адрес репозитория в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git`.
             * `username` — имя пользователя. При использовании токена значение зависит от [сервиса и типа токена](../concepts/dag-sources.md#git-token).
             * `password` — пароль или токен доступа.

             Например, для подключения по HTTPS с токеном из файла задайте:

             ```hcl
             code_sync = {
               git_sync = {
                 repo     = "https://github.com/<имя_пользователя>/<имя_репозитория>.git"
                 branch   = "main"
                 sub_path = "/dags"
                 username = "<имя_пользователя>"
                 password = file("<путь_к_файлу_с_токеном>")
               }
             }
             ```

         {% endlist %}

         {% note warning %}
         
         Для использования Git-репозитория [настройте доступ в интернет через NAT-шлюз](cluster-create.md#nat-routing) из сети кластера Managed Service for Apache Airflow™. Во время настройки привяжите таблицу маршрутизации с NAT-шлюзом ко всем подсетям кластера.
         
         {% endnote %}

       Укажите один из двух блоков: `s3` либо `git_sync`.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "codeSync",
          "codeSync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `codeSync` — тип и параметры [источника](../concepts/dag-sources.md) DAG-файлов.

            * `s3.bucket` — имя бакета.

            * `gitSync` — параметры подключения к Git-репозиторию. Общие параметры для обоих способов аутентификации:

              * `branch` — рабочая ветка.
              * `subPath` — путь к каталогу DAG-файлов в репозитории.

              Остальные параметры зависят от способа аутентификации. Выберите один из способов подключения:

              {% list tabs %}

              - SSH-ключ

                  Для подключения по SSH укажите:

                  * `repo` — адрес репозитория в формате `git@<хост>:<путь_к_репозиторию>.git`.
                  * `sshKey` — закрытый SSH-ключ доступа к репозиторию в одну строку с символами переноса строки `\n`.

                  Пример блока `gitSync` для подключения по SSH:

                  ```json
                  "gitSync": {
                    "repo": "git@github.com:<имя_пользователя>/<имя_репозитория>.git",
                    "branch": "main",
                    "subPath": "/dags",
                    "sshKey": "<закрытый_SSH-ключ>"
                  }
                  ```

                  При подключении по SSH поддерживаются закрытые ключи `RSA`, `DSA`, `ECDSA`, `Ed25519` в форматах `PKCS#1`, `PKCS#8`, `OpenSSL` и `OpenSSH`. Закрытый ключ не должен быть защищен паролем.

              - Логин и пароль

                  Для подключения по HTTP(S) укажите:

                  * `repo` — адрес репозитория в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git`.
                  * `usernameAndPassword` — учетные данные для подключения:

                      * `username` — имя пользователя. При использовании токена значение зависит от [сервиса и типа токена](../concepts/dag-sources.md#git-token).
                      * `password` — пароль или токен доступа.

                  Пример блока `gitSync` для подключения по HTTPS:

                  ```json
                  "gitSync": {
                    "repo": "https://github.com/<имя_пользователя>/<имя_репозитория>.git",
                    "branch": "main",
                    "subPath": "/dags",
                    "usernameAndPassword": {
                      "username": "<имя_пользователя>",
                      "password": "<пароль_или_токен>"
                    }
                  }
                  ```

              {% endlist %}

              {% note warning %}
              
              Для использования Git-репозитория [настройте доступ в интернет через NAT-шлюз](cluster-create.md#nat-routing) из сети кластера Managed Service for Apache Airflow™. Во время настройки привяжите таблицу маршрутизации с NAT-шлюзом ко всем подсетям кластера.
              
              {% endnote %}

            Укажите один из двух параметров: `s3` либо `gitSync`.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "code_sync"
            ]
          },
          "code_sync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `code_sync` — тип и параметры [источника](../concepts/dag-sources.md) DAG-файлов:

            * `s3.bucket` — имя бакета.

            * `git_sync` — параметры подключения к Git-репозиторию. Общие параметры для обоих способов аутентификации:

              * `branch` — рабочая ветка.
              * `sub_path` — путь к каталогу DAG-файлов в репозитории.

              Остальные параметры зависят от способа аутентификации. Выберите один из способов подключения:

              {% list tabs %}

              - SSH-ключ

                  Для подключения по SSH укажите:

                  * `repo` — адрес репозитория в формате `git@<хост>:<путь_к_репозиторию>.git`.
                  * `ssh_key` — закрытый SSH-ключ доступа к репозиторию в одну строчку с символами переноса строки `\n`.

                  Пример блока `git_sync` для подключения по SSH:

                  ```json
                  "git_sync": {
                    "repo": "git@github.com:<имя_пользователя>/<имя_репозитория>.git",
                    "branch": "main",
                    "sub_path": "/dags",
                    "ssh_key": "<закрытый_SSH-ключ>"
                  }
                  ```

                  При подключении по SSH поддерживаются закрытые ключи `RSA`, `DSA`, `ECDSA`, `Ed25519` в форматах `PKCS#1`, `PKCS#8`, `OpenSSL` и `OpenSSH`. Закрытый ключ не должен быть защищен паролем.

              - Логин и пароль

                  Для подключения по HTTP(S) укажите:

                  * `repo` — адрес репозитория в формате `https://<хост>/<путь_к_репозиторию>.git` или `http://<хост>/<путь_к_репозиторию>.git`.
                  * `username_and_password` — учетные данные для подключения:

                      * `username` — имя пользователя. При использовании токена значение зависит от [сервиса и типа токена](../concepts/dag-sources.md#git-token).
                      * `password` — пароль или токен доступа.

                  Пример блока `git_sync` для подключения по HTTPS:

                  ```json
                  "git_sync": {
                    "repo": "https://github.com/<имя_пользователя>/<имя_репозитория>.git",
                    "branch": "main",
                    "sub_path": "/dags",
                    "username_and_password": {
                      "username": "<имя_пользователя>",
                      "password": "<пароль_или_токен>"
                    }
                  }
                  ```

              {% endlist %}

              {% note warning %}
              
              Для использования Git-репозитория [настройте доступ в интернет через NAT-шлюз](cluster-create.md#nat-routing) из сети кластера Managed Service for Apache Airflow™. Во время настройки привяжите таблицу маршрутизации с NAT-шлюзом ко всем подсетям кластера.
              
              {% endnote %}

            Укажите один из двух параметров: `s3` либо `git_sync`.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить свойства Apache Airflow™ {#change-airflow-configuration}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Конфигурация Airflow**:

        * Добавьте, измените или удалите [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`.

            Заполните поля вручную или загрузите конфигурацию из файла (смотрите [пример конфигурационного файла](https://storage.yandexcloud.net/doc-files/managed-airflow/airflow.cfg)).

        * Включите или выключите опцию **Использовать Lockbox Secret Backend**, которая позволяет использовать секреты в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™.

            Чтобы извлечь нужную информацию из секрета, сервисный аккаунт кластера должен иметь [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.
            
            Эту роль можно назначить как [на уровне всего каталога](../../iam/operations/roles/grant.md#cloud-or-folder), так и [на уровне отдельного секрета](../../lockbox/operations/secret-access.md).

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --airflow-config <раздел_конфигурации>.<ключ>=<значение> \
       --lockbox-secrets-backend
     ```

     Где:

     * `--airflow-config` — [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `<раздел_конфигурации>.<ключ>=<значение>`, например:

         ```bash
         --airflow-config core.load_examples=False
         ```

     * `--lockbox-secrets-backend` — включает использование секретов в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       airflow_config = {
         <раздел_конфигурации> = {
           <ключ> = "<значение>"
         }
       }

       lockbox_secrets_backend = {
         enabled = <использование_секретов>
       }
       ...
     }
     ```

     Где:

     * `airflow_config` — [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: раздел конфигурации — `core`, ключ — `load_examples`, значение — `False`.

     * `lockbox_secrets_backend.enabled` — включает использование секретов в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™. Возможные значения: `true` или `false`.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "configSpec.airflow.config,configSpec.lockbox",
          "configSpec": {
            "airflow": {
              "config": {
                "<раздел_конфигурации>.<ключ>": "<значение>"
              }
            },
            "lockbox": {
              "enabled": <использование_секретов>
            }
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `configSpec` — конфигурация кластера:

            * `airflow.config` — [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `lockbox.enabled` — позволяет использовать секреты в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™. Возможные значения: `true` или `false`.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "config_spec.airflow.config",
              "config_spec.lockbox"
            ]
          },
          "config_spec": {
            "airflow": {
              "config": {
                "<раздел_конфигурации>.<ключ>": "<значение>"
              }
            },
            "lockbox": {
              "enabled": <использование_секретов>
            }
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `config_spec` — конфигурация кластера:

            * `airflow.config` — [дополнительные свойства Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `lockbox.enabled` — позволяет использовать секреты в сервисе [Yandex Lockbox](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) Apache Airflow™. Возможные значения: `true` или `false`.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-airflow) в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. В блоке **Дополнительные настройки**:

        * Измените время [технического обслуживания](../concepts/maintenance.md) кластера.
        * Установите или снимите защиту от удаления.

    1. В блоке **Логирование** включите или выключите запись логов. Если логирование включено, укажите, в какую лог-группу будут записываться логи и минимальный уровень логирования. Логи, сгенерированные компонентами Apache Airflow™, будут отправляться в Yandex Cloud Logging.

    1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     yc managed-airflow cluster update --help
     ```

  1. Выполните команду:

     ```bash
     yc managed-airflow cluster update <имя_или_идентификатор_кластера> \
       --maintenance-window type=<тип_технического_обслуживания>,day=<день_недели>,hour=<порядковый_номер_часового_интервала> \
       --deletion-protection \
       --log-enabled \
       --log-folder-id <идентификатор_каталога> \
       --log-min-level <уровень_логирования>
     ```

     Где:

     * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

         * `anytime` (по умолчанию) — в любое время.
         * `weekly` — по расписанию. Для этого значения дополнительно укажите:
         
             * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
             * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
         
               > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

     * `--deletion-protection` — включает защиту кластера от непреднамеренного удаления.

         Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

     * Параметры логирования:

         * `--log-enabled` — включает логирование. Логи, сгенерированные компонентами Apache Airflow™, будут отправляться в Yandex Cloud Logging.
         * `--log-folder-id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
         * `--log-group-id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

             Укажите один из двух параметров: `--log-folder-id` либо `--log-group-id`.

         * `--log-min-level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

     Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

     Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера нужные параметры:

     ```hcl
     resource "yandex_airflow_cluster" "<имя_кластера>" {
       ...
       maintenance_window = {
         type = "<тип_технического_обслуживания>"
         day  = "<день_недели>"
         hour = <порядковый_номер_часового_интервала>
       }

       deletion_protection = <защита_от_удаления>

       logging = {
         enabled   = <использование_логирования>
         folder_id = "<идентификатор_каталога>"
         min_level = "<уровень_логирования>"
       }
       ...
     }
     ```

     Где:

     * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

         * `type` — тип технического обслуживания. Принимает значения:
             * `ANYTIME` — в любое время.
             * `WEEKLY` — по расписанию.
         * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
         * `hour` — порядковый номер часового интервала по UTC для типа `WEEKLY`: от `1` до `24`.

           > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

     * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

         Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

     * `logging` — параметры логирования:

         * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Airflow™, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
         * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
         * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

           Укажите один из двух параметров: `folder_id` либо `log_group_id`.

         * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` и `FATAL`.

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

  Подробнее в [документации провайдера Terraform](../../terraform/resources/airflow_cluster.md).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "maintenanceWindow,deletionProtection,logging",
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<порядковый_номер_часового_интервала>"
            }
          },
          "deletionProtection": <защита_от_удаления>,
          "logging": {
            "enabled": <использование_логирования>,
            "minLevel": "<уровень_логирования>",
            "folderId": "<идентификатор_каталога>"
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

        * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:
          
            * `anytime` — техническое обслуживание проводится в произвольное время.
            * `weeklyMaintenanceWindow` — техническое обслуживание проводится раз в неделю в указанное время:
          
              * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
              * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
          
                > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

        * `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Airflow™, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
            * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folderId` либо `logGroupId`.

    1. Воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>' \
          --data '@body.json'
        ```

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

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

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": {
            "paths": [
              "maintenance_window",
              "deletion_protection",
              "logging"
            ]
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<порядковый_номер_часового_интервала>"
            }
          },
          "deletion_protection": <защита_от_удаления>,
          "logging": {
            "enabled": <использование_логирования>,
            "min_level": "<уровень_логирования>",
            "folder_id": "<идентификатор_каталога>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

        * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из двух параметров:
          
            * `anytime` — техническое обслуживание проводится в произвольное время.
            * `weekly_maintenance_window` — техническое обслуживание проводится раз в неделю в указанное время:
          
              * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`;
              * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
          
                > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами Apache Airflow™, будут отправляться в Yandex Cloud Logging. Возможные значения: `true` или `false`.
            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    1. Воспользуйтесь вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          airflow.api.cloud.yandex.net:443 \
          yandex.cloud.airflow.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}