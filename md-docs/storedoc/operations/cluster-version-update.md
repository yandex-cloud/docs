# Обновление версии Yandex StoreDoc

Вы можете обновить кластер Yandex StoreDoc только на следующую версию относительно текущей, например, с версии 4.2 на 4.4. Обновление до более поздних версий производится поэтапно. Например, обновление версии Yandex StoreDoc с 4.2 до 8.0 выполняется в такой последовательности: 4.2 → 4.4 → 5.0 → 6.0 → 7.0 → 8.0. Перед каждым этапом обновления кластера необходимо обновлять [версию совместимости кластера](#compatibility-update).


{% note alert %}

После обновления невозможно вернуть кластер к предыдущей версии.

{% endnote %}

## Перед обновлением версии {#before-update}

1. Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в истории изменений MongoDB, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно [развернуть из резервной копии](cluster-backups.md#restore) основного кластера.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением версии.

1. Убедитесь, что [версия совместимости кластера](#compatibility-update) соответствует текущей версии кластера. При необходимости обновите версию совместимости кластера.

## Обновить версию кластера {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
  1. Выберите нужный кластер в списке и нажмите кнопку **Редактировать**.
  1. В поле **Версия** выберите номер новой версии.
  1. Нажмите кнопку **Сохранить изменения**.

  После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

  1. Получите список ваших кластеров Yandex StoreDoc командой:

     ```bash
     yc managed-mongodb cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию Yandex StoreDoc, указанную в свойстве `config.version`:

     ```bash
     yc managed-mongodb cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление Yandex StoreDoc:

     ```bash
     yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
        --mongodb-version=<номер_новой_версии>
     ```

     После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

  1. После обновления все возможности Yandex StoreDoc, у которых нет обратной совместимости с прежней версией, выключаются. Чтобы снять это ограничение, выполните команду:

     ```bash
     yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
        --feature-compatibility-version=<номер_новой_версии>
     ```


- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
    1. Добавьте к описанию кластера Yandex StoreDoc поле `version` или измените его значение, если оно уже существует:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           version = "<версия_Yandex_StoreDoc>"
         }
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
  
   Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

   {% note warning "Ограничения по времени" %}
   
   Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
   
   * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
   * изменение — 60 минут.
   
   Операции, длящиеся дольше указанного времени, прерываются.
   
   {% cut "Как изменить эти ограничения?" %}
   
   Добавьте к описанию кластера блок `timeouts`, например:
   
   ```hcl
   resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
     ...
     timeouts {
       create = "1h30m" # Полтора часа
       update = "2h"    # 2 часа
     }
   }
   ```
   
   {% endcut %}
   
   {% endnote %}

- REST API {#api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

   1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
         --data '{
                  "updateMask": "configSpec.version",
                  "configSpec": {
                    "version": "<новая_версия_Yandex_StoreDoc>"
                  }
                }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

         В данном случае передается один параметр.

      * `configSpec.version` — новая версия Yandex StoreDoc.

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                    "version": "<версия_Yandex_StoreDoc>"
                  }
               }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается один параметр.

        * `version` — новая версия Yandex StoreDoc.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note info %}

После обновления все возможности Yandex StoreDoc, у которых нет обратной совместимости с прежней версией, выключаются. Чтобы снять это ограничение, [обновите версию совместимости кластера](#compatibility-update).

{% endnote %}

## Обновить версию совместимости {#compatibility-update}

Обновление версии совместимости кластера требуется, если вам нужно:
* обновить кластер до новой версии, при этом версия совместимости не соответствует текущей версии кластера;
* сделать доступными новые возможности Yandex StoreDoc после обновления кластера.

Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% note alert %}

После обновления версии совместимости невозможно вернуть кластер к предыдущей версии совместимости.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex StoreDoc**.
  1. Выберите нужный кластер в списке и нажмите кнопку **Редактировать**.
  1. В поле **Версия совместимости** выберите номер нужной версии.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  1. Получите список ваших кластеров Yandex StoreDoc командой:

     ```bash
     yc managed-mongodb cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию Yandex StoreDoc, указанную в свойстве `config.feature_compatibility_version`:

     ```bash
     yc managed-mongodb cluster get <имя_или_идентификатор_кластера>
     ```

  1. Выполните команду изменения кластера, указав новую версию совместимости:

     ```bash
     yc managed-mongodb cluster update <имя_или_идентификатор_кластера> \
        --feature-compatibility-version=<версия_совместимости_Yandex_StoreDoc>
     ```

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.
  
       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).
  
    1. Добавьте к описанию кластера Yandex StoreDoc поле `feature_compatibility_version` или измените его значение, если оно уже существует:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           feature_compatibility_version = "<версия_совместимости_Yandex_StoreDoc>"
         }
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
  
   Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_mongodb_cluster.md).

   {% note warning "Ограничения по времени" %}
   
   Провайдер Terraform ограничивает время на выполнение операций с кластером Yandex StoreDoc:
   
   * создание, в т. ч. путем восстановления из резервной копии, — 30 минут;
   * изменение — 60 минут.
   
   Операции, длящиеся дольше указанного времени, прерываются.
   
   {% cut "Как изменить эти ограничения?" %}
   
   Добавьте к описанию кластера блок `timeouts`, например:
   
   ```hcl
   resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
     ...
     timeouts {
       create = "1h30m" # Полтора часа
       update = "2h"    # 2 часа
     }
   }
   ```
   
   {% endcut %}
   
   {% endnote %}

- REST API {#api}

   1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      ```bash
      export IAM_TOKEN="<IAM-токен>"
      ```

   1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью [cURL](https://curl.se/):

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
         --request PATCH \
         --header "Authorization: Bearer $IAM_TOKEN" \
         --header "Content-Type: application/json" \
         --url 'https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/<идентификатор_кластера>' \
         --data '{
                  "updateMask": "configSpec.featureCompatibilityVersion",
                  "configSpec": {
                    "featureCompatibilityVersion": "<версия_совместимости_Yandex_StoreDoc>"
                  }
                }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

         В данном случае передается один параметр.

      * `configSpec.featureCompatibilityVersion` — новая версия совместимости Yandex StoreDoc.

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

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                    "feature_compatibility_version": "<версия_совместимости_Yandex_StoreDoc>"
                  }
               }' \
            mdb.api.cloud.yandex.net:443 \
            yandex.cloud.mdb.mongodb.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается один параметр.

        * `feature_compatibility_version` — новая версия совместимости Yandex StoreDoc.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 5.0 до версии 6.0.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы узнать идентификатор кластера, получите список всех кластеров в каталоге:

      ```bash
      yc managed-mongodb cluster list
      ```

      Результат:

      ```text
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   storedoc406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере `c9qut3k64b2o********`, выполните команду:

      ```bash
      yc managed-mongodb cluster get c9qut3k64b2o********
      ```

      Результат:

      ```text
      id: c9qut3k64b2o********
      folder_id: b1g0itj57rbj********
      created_at: "2019-07-16T09:43:50.393231Z"
      name: storedoc406
      environment: PRODUCTION
      monitoring:
      - name: Console
        description: Console charts
        link: https://console.yandex.cloud/folders/b1g0itj57rbj********/managed-mongodb/cluster/c9qut3k64b2o********?section=monitoring
      config:
        version: "5.0"
        feature_compatibility_version: "5.0"
        ...
      ```

   1. Чтобы обновить кластер `c9qutgkd4b2o********` до версии 6.0, выполните команду:

      ```bash
      yc managed-mongodb cluster update c9qutgkd4b2o******** \
          --mongodb-version=6.0
      ```

   1. Чтобы включить все возможности версии 6.0 в кластере `c9qutgkd4b2o********`, выполните команду:

      ```bash
      yc managed-mongodb cluster update c9qutgkd4b2o******** \
          --feature-compatibility-version=6.0
      ```

{% endlist %}