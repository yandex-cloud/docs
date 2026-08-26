[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Apache Spark™](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Обновление версии Apache Spark™

# Обновление версии Apache Spark™

Вы можете изменить версию Apache Spark™ на любую из [поддерживаемых](#available-versions) в Managed Service for Apache Spark™.

Обновления и исправления внутри одной версии устанавливаются во время технического обслуживания автоматически.

## Получить список доступных версий {#available-versions}

{% note info %}

Если для работы с версиями вы используете окружения, то информация о версии указана в названии базового окружения.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-spark) в сервис **Managed Service for Apache Spark**.
    1. Выберите кластер и нажмите на панели сверху кнопку **Редактировать**. Откроется страница редактирования кластера.
      
        Список доступных версий можно посмотреть в поле **Версия**.

{% endlist %}

## Перед обновлением версии {#before-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://spark.apache.org/news/) Apache Spark™, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию Apache Spark™ на тестовом кластере.

## Обновить версию {#update}

Способ обновления версии Apache Spark™ зависит от того, как в кластере заданы зависимости:

* Если в поле **Способ настройки ПО** выбрано значение **Пакеты вручную**, [измените версию в настройках кластера](#update-with-packages).

  {% note warning %}
  
  Данный способ устарел и скоро будет недоступен. Рекомендуется использовать окружения для работы с различными версиями Apache Spark™.
  
  {% endnote %}
  
* Если в поле **Способ настройки ПО** выбрано значение **Окружение**, выберите базовое окружение (версия Apache Spark™ и Python) или [подключите к кластеру пользовательское окружение с нужной версией](#update-with-environment). Версия Apache Spark™ фиксирована внутри окружения и отдельно в настройках кластера не задается.

### Кластер использует пакеты, добавленные вручную {#update-with-packages}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
    1. [Перейдите](https://console.yandex.cloud/link/managed-spark) в сервис **Managed Service for Apache Spark**.
    1. Выберите кластер и нажмите на панели сверху кнопку **Редактировать**.
    1. В блоке **Дополнительные настройки** перейдите к полю **Способ настройки ПО** → **Пакеты вручную** выберите версию Apache Spark™.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
    
    Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить версию Apache Spark™:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-spark cluster update --help
        ```

    2. Измените версию, выполнив команду:

        ```bash
        yc managed-spark cluster update <имя_или_идентификатор_кластера> \
          --spark-version <версия_Apache_Spark>
        ```

        Имя и идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.   

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Apache Spark™ с планом инфраструктуры.

        Инструкция по созданию файла описана в разделе [Создание кластера](cluster-create.md).
        
    1. Измените в описании кластера значение параметра `spark_version`:
      
        ```hcl
        resource "yandex_spark_cluster" "<имя_кластера>" {
          ...
          config = {
            ...
            spark_version = "<версия_Apache_Spark>"
            ...
          }
          ...
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
              "config_spec.spark_version"
            ]
          },
          "config_spec": {
            "spark_version": "<версия_Apache_Spark>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера.
            
            Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге.

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

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

            {% note warning %}

            При изменении кластера все параметры изменяемого объекта, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `spark_version` — версия Apache Spark™.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          spark.api.cloud.yandex.net:443 \
          yandex.cloud.spark.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

### Кластер использует окружение {#update-with-environment}

Кластер может использовать базовое или пользовательское окружение. 

Базовое окружение содержит только версию Apache Spark™ и версию Python. Его можно выбрать во время [создания](cluster-create.md) или [изменения кластера](cluster-update.md#change-additional-settings).

Пользовательское окружение содержит базовое окружение и список необходимых pip- и deb-пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения. Список пакетов пользователь задает самостоятельно. Список пакетов и версию Apache Spark™ нельзя изменить в уже созданном пользовательском окружении. Чтобы обновить версию Apache Spark™, подготовьте пользовательское окружение с нужной версией и подключите его к кластеру.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Подготовьте окружение с нужной версией Apache Spark™ одним из способов:

        * [Создайте новое окружение](environment-create.md#create-env)
        * [Создайте новое окружение на основе существующего](environment-create.md#create-copy-env)

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог с нужным кластером.
    1. [Перейдите](https://console.yandex.cloud/link/managed-spark) в сервис **Managed Service for Apache Spark**.
    1. Выберите кластер и нажмите на панели сверху кнопку **Редактировать**.
    1. В блоке **Дополнительные настройки** в поле **Способ настройки ПО** → **Окружение** выберите подготовленное окружение.
    1. Нажмите кнопку **Сохранить изменения**.

- gRPC API {#grpc-api}

    1. [Подготовьте окружение](environment-create.md#create-env) с нужной версией Apache Spark™.

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
              "config_spec.environment_id"
            ]
          },
          "config_spec": {
            "environment_id": "<идентификатор_окружения>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters) в каталоге;
        * `environment_id` — идентификатор окружения с нужной версией Apache Spark™. Идентификатор пользовательского окружения можно получить с помощью вызова [EnvironmentService/List](../environment/api-ref/grpc/Environment/list.md), базового окружения — с помощью вызова [EnvironmentService/ListBase](../environment/api-ref/grpc/Environment/listBase.md).

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          spark.api.cloud.yandex.net:443 \
          yandex.cloud.spark.v1.ClusterService.Update \
          < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}