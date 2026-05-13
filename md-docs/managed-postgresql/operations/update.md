# Изменение настроек кластера PostgreSQL

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Настроить серверы](#change-postgresql-config) согласно [документации PostgreSQL](https://www.postgresql.org/docs/current/runtime-config.html).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Вручную переключить хост-мастер](#start-manual-failover).

* [Переместить кластер](#move-cluster) в другой каталог.


* [Изменить группы безопасности кластера](#change-sg-set).


{% note info %}

Любые изменения возможны только на запущенном кластере.

{% endnote %}

Подробнее о других изменениях кластера:

* [Обновление версии PostgreSQL](cluster-version-update.md).

* [Управление дисковым пространством](storage-space.md).

* [Миграция хостов кластера в другую зону доступности](host-migration.md).

## Изменить класс хостов {#change-resource-preset}

{% note info %}

Некоторые настройки PostgreSQL [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов сменится мастер. Каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.
* Подключение по [особому FQDN](connect/fqdn.md#special-fqdns) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. В блоке **Класс хоста** выберите нужный класс для хостов PostgreSQL.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-postgresql cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     yc managed-postgresql resource-preset list
     ```

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

      ```bash
      yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
          --resource-preset <идентификатор_класса_хостов>
      ```

      Managed Service for PostgreSQL запустит операцию изменения класса хостов для кластера.

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

  1. Измените в описании кластера Managed Service for PostgreSQL значение атрибута `resource_preset_id` в блоке `config.resources`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
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

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
      
      * создание, в том числе путем восстановления из резервной копии, — 30 минут;
      * изменение — 60 минут;
      * удаление — 15 минут.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        timeouts {
          create = "1h30m" # Полтора часа
          update = "2h"    # 2 часа
          delete = "30m"   # 30 минут
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

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.resources.resourcePresetId",
                 "configSpec": {
                   "resources": {
                     "resourcePresetId": "<класс_хостов>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `configSpec.resources.resourcePresetId` — новый [класс хостов](../concepts/instance-types.md).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.resources.resource_preset_id"
               ]
             },
             "config_spec": {
               "resources": {
                 "resource_preset_id": "<класс_хостов>"
               }
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.resources.resource_preset_id` — новый [класс хостов](../concepts/instance-types.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Изменить настройки PostgreSQL {#change-postgresql-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note warning %}

* Вы не можете менять настройки PostgreSQL с помощью команд SQL.
* Некоторые настройки PostgreSQL [зависят от выбранного класса хостов или размера хранилища](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. Измените [настройки PostgreSQL](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки PostgreSQL](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     yc managed-postgresql cluster get <имя_или_идентификатор_кластера> --full
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      yc managed-postgresql cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `postgresqlConfig_<версия_PostgreSQL>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxPreparedTransactions` из запроса к API преобразуется в `max_prepared_transactions` для команды CLI:

      ```bash
      yc managed-postgresql cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра_1>=<значение_1>,<имя_параметра_2>=<значение_2>,...
      ```

      Managed Service for PostgreSQL запустит операцию по изменению настроек кластера.

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Измените в описании кластера Managed Service for PostgreSQL значения параметров в блоке `config.postgresql_config`. Если такого блока нет — создайте его.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          config {
            ...
            postgresql_config = {
              max_connections                   = <максимальное_количество_соединений>
              enable_parallel_hash              = <true_или_false>
              vacuum_cleanup_index_scale_factor = <число_от_0_до_1>
              ...
            }
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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
        
        * создание, в том числе путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут;
        * удаление — 15 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
            delete = "30m"   # 30 минут
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

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.postgresqlConfig_<версия_PostgreSQL>.<настройка_1>,...,configSpec.postgresqlConfig_<версия_PostgreSQL>.<настройка_N>",
                 "configSpec": {
                   "postgresqlConfig_<версия_PostgreSQL>": {
                     "<настройка_1>": "<значение_1>",
                     "<настройка_2>": "<значение_2>",
                     ...
                     "<настройка_N>": "<значение_N>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае перечислите все изменяемые настройки PostgreSQL.

     * `configSpec.postgresqlConfig_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [Настройки на уровне кластера](../concepts/settings-list.md#dbms-cluster-settings).

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.postgresql_config_<версия_PostgreSQL>.<настройка_1>",
                 "config_spec.postgresql_config_<версия_PostgreSQL>.<настройка_2>",
                 ...,
                 "config_spec.postgresql_config_<версия_PostgreSQL>.<настройка_N>"
               ]
             },
             "config_spec": {
               "postgresql_config_<версия_PostgreSQL>": {
                 "<настройка_1>": "<значение_1>",
                 "<настройка_2>": "<значение_2>",
                 ...
                 "<настройка_N>": "<значение_N>"
               }
             }
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае перечислите все изменяемые настройки PostgreSQL.

     * `config_spec.postgresql_config_<версия_PostgreSQL>` — набор настроек PostgreSQL. Укажите каждую настройку на отдельной строке через запятую.

       Список версий PostgreSQL, доступных для параметра, см. в [описании метода](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigSpec). Описание и возможные значения настроек см. в разделе [Настройки на уровне кластера](../concepts/settings-list.md#dbms-cluster-settings).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% note warning %}

Изменение дополнительных настроек приведет к перезапуску кластера. Исключением являются настройки окна обслуживания и защиты от удаления.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  
  
  1. В блоке **Диагностика производительности** включите стандартный или расширенный режим диагностики. Расширенный режим дополнительно включает сбор и анализ планов запросов.
         
     Чтобы использовать инструмент [Диагностика производительности](performance-diagnostics.md), выберите опцию **Сбор статистики** и настройте **Интервал сбора сессий** и **Интервал сбора запросов**. Единицы измерения обеих настроек — секунды.
  

  1. Измените дополнительные настройки кластера:

     - **Начало резервного копирования (UTC)** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
     
     - **Срок хранения автоматических резервных копий, дней** — время, в течение которого нужно хранить созданные автоматически резервные копии. Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — 7 дней. Подробнее см. в разделе [Резервные копии](../concepts/backup.md).
     
         Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней. Оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.
     
         Автоматические резервные копии кластера хранятся заданное количество дней, а созданные вручную — бессрочно. После удаления кластера все копии хранятся 7 дней.
     
     - **Окно обслуживания** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
         * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **произвольное** (по умолчанию).
         * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **по расписанию** и укажите нужные день недели и час дня по UTC. Например, можно выбрать время, когда кластер наименее загружен.
         
         Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     - **Доступ из DataLens** — опция разрешает анализировать данные из кластера в сервисе [Yandex DataLens](../../datalens/concepts/index.md).
     
     
     - **Доступ из WebSQL** — опция разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL.
     
     
     
     
     - **Доступ из Yandex Query** — опция разрешает выполнять YQL-запросы к базам данных кластера из сервиса [Yandex Query](../../query/concepts/index.md).
     
     - **Доступ из Serverless** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).
     
     
     
     - **Режим работы менеджера подключений** — выберите один из [режимов работы менеджера подключений](../concepts/pooling.md).
     
     - **Защита от удаления** — защита от удаления кластера, его баз данных и пользователей.
     
         По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).
         
         Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.
     
         Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        yc managed-postgresql cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время_начала_резервного_копирования> \
            --backup-retain-period-days=<срок_хранения_автоматических_резервных_копий_в_днях> \
            --datalens-access=<разрешить_доступ_из_DataLens> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --websql-access=<разрешить_доступ_из_WebSQL> \
            --deletion-protection \
            --connection-pooling-mode=<режим_работы_менеджера_подключений> \
            --serverless-access=<разрешить_доступ_из_Serverless_Containers> \
            --yandexquery-access=<разрешить_доступ_из_Yandex_Query> \
            --performance-diagnostics enabled=<активировать_сбор_статистики>,`
                                     `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                     `statements-sampling-interval=<интервал_сбора_запросов>
        ```

    Вы можете изменить следующие настройки:

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    * `--backup-retain-period-days` – срок хранения автоматических резервных копий (в днях).

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение к кластеру из DataLens](datalens-connect.md).

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — час дня по UTC: от `1` до `24`.

    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления Yandex Cloud с помощью сервиса Yandex WebSQL. Значение по умолчанию — `false`.
    
    
    * `--serverless-access` — разрешает доступ к кластеру из сервиса [Yandex Cloud Functions](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [Cloud Functions](../../functions/operations/database-connection.md).

    * `--yandexquery-access` — разрешает доступ к кластеру из сервиса [Yandex Query](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и предоставляется по запросу.


    * `--connection-pooling-mode` — указывает [режим работы менеджера подключений](../concepts/pooling.md): `SESSION`, `TRANSACTION` или `STATEMENT`.

    * `--deletion-protection` — защита от удаления кластера, его баз данных и пользователей.

        По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

    
    * `--performance-diagnostics` — настройки [сбора статистики](performance-diagnostics.md#activate-stats-collector):

        * `enabled` — значение `true` активирует сбор статистики. Значение по умолчанию — `false`.
        * `sessions-sampling-interval` — интервал сбора сессий, в секундах. Допустимые значения — от `1` до `86400`.
        * `statements-sampling-interval` — интервал сбора запросов, в секундах. Допустимые значения — от `60` до `86400`.


    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера Managed Service for PostgreSQL блок `config.backup_window_start`.

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          backup_window_start {
            hours   = <час_начала_резервного_копирования>
            minutes = <минута_начала_резервного_копирования>
          }
          ...
        }
      }
      ```

  1. Чтобы разрешить доступ из Yandex DataLens и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью Yandex WebSQL, измените значения соответствующих полей в блоке `config.access`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          access {
            data_lens = <разрешить_доступ_из_DataLens>
            web_sql   = <разрешить_доступ_из_WebSQL>
            ...
        }
        ...
      }
      ```

      Где:

      * `data_lens` — доступ из DataLens: `true` или `false`.
      * `web_sql` — выполнение SQL-запросов из консоли управления с помощью Yandex WebSQL: `true` или `false`.

  1. Чтобы изменить [режим работы менеджера подключений](../concepts/pooling.md), добавьте к описанию кластера Managed Service for PostgreSQL блок `config.pooler_config`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        config {
          pooler_config {
            pool_discard = <сбрасывать_состояния_клиентов_после_каждой_транзакции>
            pooling_mode = "<режим_работы>"
          }
          ...
        }
      }
      ```

      Где:

      * `pool_discard` — определяет, должны ли клиенты терять свое состояние после каждой транзакции: `true` или `false`.
      * `pooling_mode` — режим работы: `SESSION`, `TRANSACTION` или `STATEMENT`.

  1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       maintenance_window {
         type = "<тип_технического_обслуживания>"
         day  = "<день_недели>"
         hour = <час_дня>
       }
       ...
     }
     ```
     
     Где:
     
     * `type` — тип технического обслуживания. Принимает значения:
         * `ANYTIME` — в любое время.
         * `WEEKLY` — по расписанию.
     * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
     * `hour` — час дня по UTC для типа `WEEKLY`: от `1` до `24`.

  
  1. Чтобы настроить сбор статистики, добавьте в блок `config` блок `performance_diagnostics`:
     
     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
       ...
       config {
         ...
         performance_diagnostics {
           enabled                      = <активация_сбора_статистики>
           sessions_sampling_interval   = <интервал_сбора_сессий>
           statements_sampling_interval = <интервал_сбора_запросов>
         }
         ...
       }
       ...
     }
     ```
     
     Где:
     
     * `enabled` — активация сбора статистики: `true` или `false`.
     * `sessions_sampling_interval` — интервал сбора сессий от `5` до `86400` секунд.
     * `statements_sampling_interval` — интервал сбора запросов от `60` до `86400` секунд.


  1. Чтобы включить защиту кластера, его баз данных и пользователей от непреднамеренного удаления, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защитить_кластер_от_удаления>
      }
      ```

      Где `deletion_protection` — защита от удаления кластера, его баз данных и пользователей: `true` или `false`.

      По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

      Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

      Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

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

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
      
      * создание, в том числе путем восстановления из резервной копии, — 30 минут;
      * изменение — 60 минут;
      * удаление — 15 минут.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        timeouts {
          create = "1h30m" # Полтора часа
          update = "2h"    # 2 часа
          delete = "30m"   # 30 минут
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

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     
     ```json
     {
       "updateMask": "configSpec.poolerConfig,configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics.sessionsSamplingInterval,configSpec.performanceDiagnostics.statementsSamplingInterval,maintenanceWindow,deletionProtection",
       "configSpec": {
         "poolerConfig": {
           "poolingMode": "<режим_управления_соединениями>",
           "poolDiscard": <сбрасывать_состояния_клиентов_после_каждой_транзакции>
         },
         "backupWindowStart": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backupRetainPeriodDays": "<количество_дней>",
         "access": {
           "dataLens": <разрешить_доступ_из_DataLens>,
           "webSql": <разрешить_доступ_из_WebSQL>,
           "serverless": <разрешить_доступ_из_Cloud_Functions>,
           "dataTransfer": <разрешить_доступ_из_Data_Transfer>,
           "yandexQuery": <разрешить_доступ_из_Query>
         },
         "performanceDiagnostics": {
           "enabled": <активировать_сбор_статистики>,
           "sessionsSamplingInterval": "<интервал_сбора_сессий>",
           "statementsSamplingInterval": "<интервал_сбора_запросов>"
         }
       },
       "maintenanceWindow": {
         "weeklyMaintenanceWindow": {
           "day": "<день_недели>",
           "hour": "<час>"
         }
       },
       "deletionProtection": <защитить_кластер_от_удаления>
     }
     ```


     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
     * `configSpec` — настройки кластера:

       * `poolerConfig` — настройки менеджера подключений:

         * `poolingMode` — режим работы менеджера подключений. Возможные значения: `SESSION`, `TRANSACTION` и `STATEMENT`. Подробнее о каждом режиме читайте в разделе [Управление соединениями PostgreSQL](../concepts/pooling.md).
         * `poolDiscard` — должны ли клиенты терять свое состояние после каждой транзакции: `true` или `false`. Соответствует параметру [server_reset_query_always](https://www.pgbouncer.org/config.html) для менеджера подключений [PgBouncer](https://www.pgbouncer.org/usage).

       * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

       
       * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

         * `dataLens` — [Yandex DataLens](../../datalens/index.md);
         * `webSql` — [Yandex WebSQL](../../websql/index.md);
         * `serverless` — [Yandex Cloud Functions](../../functions/index.md);
         * `dataTransfer` — [Yandex Data Transfer](../../data-transfer/index.md);
         * `yandexQuery` — [Yandex Query](../../query/index.md).

         Возможные значения настроек: `true` или `false`.


       
       * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

         * `enabled` — активация сбора статистики: `true` или `false`.
         * `sessionsSamplingInterval` — интервал сбора сессий. Возможные значения: от `1` до `86400` секунд.
         * `statementsSamplingInterval` — интервал сбора запросов. Возможные значения: от `60` до `86400` секунд.


     * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenanceWindow` передайте один из двух параметров:

       * `anytime` — техническое обслуживание происходит в любое время.
       * `weeklyMaintenanceWindow` — техническое обслуживание происходит раз в неделю, в указанное время:

         * `day` — день недели в формате `DDD`;
         * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

     * `deletionProtection` — защита от удаления кластера, его баз данных и пользователей: `true` или `false`.

        По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data "@body.json"
     ```

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

     
     ```json
     {
       "cluster_id": "<идентификатор_кластера>",
       "update_mask": {
         "paths": [
           "config_spec.pooler_config",
           "config_spec.backup_window_start",
           "config_spec.backup_retain_period_days",
           "config_spec.access",
           "config_spec.performance_diagnostics.sessions_sampling_interval",
           "config_spec.performance_diagnostics.statements_sampling_interval",
           "maintenance_window",
           "deletion_protection"
         ]
       },
       "config_spec": {
         "pooler_config": {
           "pooling_mode": "<режим_управления_соединениями>",
           "pool_discard": <сбрасывать_состояния_клиентов_после_каждой_транзакции>
         },
         "backup_window_start": {
           "hours": "<часы>",
           "minutes": "<минуты>",
           "seconds": "<секунды>",
           "nanos": "<наносекунды>"
         },
         "backup_retain_period_days": "<количество_дней>",
         "access": {
           "data_lens": <разрешить_доступ_из_DataLens>,
           "web_sql": <разрешить_доступ_из_WebSQL>,
           "serverless": <разрешить_доступ_из_Cloud_Functions>,
           "data_transfer": <разрешить_доступ_из_Data_Transfer>,
           "yandex_query": <разрешить_доступ_из_Query>
         },
         "performance_diagnostics": {
           "enabled": <активировать_сбор_статистики>,
           "sessions_sampling_interval": "<интервал_сбора_сессий>",
           "statements_sampling_interval": "<интервал_сбора_запросов>"
         }
       },
       "maintenance_window": {
         "weekly_maintenance_window": {
           "day": "<день_недели>",
           "hour": "<час>"
         }
       },
       "deletion_protection": <защитить_кластер_от_удаления>
     }
     ```


     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
     * `config_spec` — настройки кластера:

       * `pooler_config` — настройки менеджера подключений:

         * `pooling_mode` — режим работы менеджера подключений. Возможные значения: `SESSION`, `TRANSACTION` и `STATEMENT`. Подробнее о каждом режиме читайте в разделе [Управление соединениями PostgreSQL](../concepts/pooling.md).
         * `pool_discard` — должны ли клиенты терять свое состояние после каждой транзакции: `true` или `false`. Соответствует параметру [server_reset_query_always](https://www.pgbouncer.org/config.html) для менеджера подключений [PgBouncer](https://www.pgbouncer.org/usage).

       * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

         В параметре укажите время, когда начинать резервное копирование. Возможные значения параметров:

         * `hours` — от `0` до `23` часов;
         * `minutes` — от `0` до `59` минут;
         * `seconds` — от `0` до `59` секунд;
         * `nanos` — от `0` до `999999999` наносекунд.

       * `backup_retain_period_days` — сколько дней хранить резервную копию кластера. Возможные значения: от `7` до `60` дней.

       
       * `access` — настройки доступа кластера к следующим сервисам Yandex Cloud:

         * `data_lens` — [Yandex DataLens](../../datalens/index.md);
         * `web_sql` — [Yandex WebSQL](../../websql/index.md);
         * `serverless` — [Yandex Cloud Functions](../../functions/index.md);
         * `data_transfer` — [Yandex Data Transfer](../../data-transfer/index.md);
         * `yandex_query` — [Yandex Query](../../query/index.md).

         Возможные значения настроек: `true` или `false`.


       
       * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

         * `enabled` — активация сбора статистики: `true` или `false`.
         * `sessions_sampling_interval` — интервал сбора сессий. Возможные значения: от `1` до `86400` секунд.
         * `statements_sampling_interval` — интервал сбора запросов. Возможные значения: от `60` до `86400` секунд.


     * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). В `maintenance_window` передайте один из двух параметров:

       * `anytime` — техническое обслуживание происходит в любое время.
       * `weekly_maintenance_window` — техническое обслуживание происходит раз в неделю, в указанное время:

         * `day` — день недели в формате `DDD`;
         * `hour` — час в формате `HH`. Возможные значения: от `1` до `24` часов.

     * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей: `true` или `false`.

        По умолчанию при создании пользователей и БД значение параметра наследуется от кластера. Значение также можно задать вручную, подробнее см. в разделах [Управление пользователями](cluster-users.md) и [Управление БД](databases.md).

        Если параметр изменен на работающем кластере, новое значение унаследуют только пользователи и БД с защитой **Как у кластера**.

        Включенная защита кластера от удаления не помешает подключиться к нему вручную и удалить данные.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d @ \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update \
       < body.json
     ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}


### Connection Manager {#conn-man}

Если в кластере не включена интеграция с сервисом Connection Manager, включите опцию **Использовать Connection Manager**. Она доступна только в [консоли управления](https://console.yandex.cloud).

Для каждого пользователя БД будут созданы:

* [Подключение](../../metadata-hub/concepts/connection-manager.md) Connection Manager с информацией о соединении с БД.

* [Секрет Yandex Lockbox](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя. Хранение паролей в сервисе Yandex Lockbox обеспечивает их безопасность.

Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **Подключения**.

Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в Connection Manager](../../metadata-hub/operations/connection-access.md).

{% note info %}

Использование сервиса Connection Manager и секретов, созданных с его помощью, не тарифицируется.

{% endnote %}


## Вручную переключить хост-мастер {#start-manual-failover}

В отказоустойчивом кластере Managed Service for PostgreSQL из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на одну из реплик. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в Managed Service for PostgreSQL:

* Нельзя сделать мастером реплику, для которой явно указан источник потока репликации.
* Если явно не указать имя хоста-реплики, мастер переключится на одну из кворумных реплик.

Подробнее см. в разделе [Репликация](../concepts/replication.md).

Чтобы переключить мастер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **Хосты**.
  1. Нажмите кнопку ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **Переключить мастер**.
      * Чтобы переключить мастер на одну из кворумных реплик, оставьте опцию **Выбрать хост-мастер автоматически** включенной.
      * Чтобы переключить мастер на конкретную реплику, выключите опцию **Выбрать хост-мастер автоматически** и затем выберите нужную реплику из выпадающего списка.
  1. Нажмите кнопку **Переключить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc managed-postgresql cluster start-failover <имя_или_идентификатор_кластера> \
      --host <имя_хоста-реплики>
  ```

  Имя хоста-реплики можно запросить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    1. Укажите имя хоста-реплики, на которую нужно переключиться, в параметре `host_master_name`.

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          host_master_name = "<имя_хоста-реплики>"
        }
        ```

        Где `host_master_name` — имя хоста-реплики: атрибут `name` соответствующего блока `host`.

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

        {% note warning "Ограничения по времени" %}
        
        Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
        
        * создание, в том числе путем восстановления из резервной копии, — 30 минут;
        * изменение — 60 минут;
        * удаление — 15 минут.
        
        Операции, длящиеся дольше указанного времени, прерываются.
        
        {% cut "Как изменить эти ограничения?" %}
        
        Добавьте к описанию кластера блок `timeouts`, например:
        
        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          timeouts {
            create = "1h30m" # Полтора часа
            update = "2h"    # 2 часа
            delete = "30m"   # 30 минут
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

  1. Воспользуйтесь методом [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:startFailover' \
       --data '{
                 "hostName": "<FQDN_хоста>"
               }'
     ```

     Где `hostName` — [FQDN реплики](connect/fqdn.md), которая становится мастером.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/startFailover.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_name": "<FQDN_хоста>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.StartFailover
     ```

     Где `host_name` — [FQDN реплики](connect/fqdn.md), которая становится мастером.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **Переместить**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **Переместить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        yc managed-postgresql cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        yc managed-postgresql cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform {#tf}

    1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените или добавьте в описании кластера Managed Service for PostgreSQL значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
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

    Подробнее см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

    {% note warning "Ограничения по времени" %}
    
    Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
    
    * создание, в том числе путем восстановления из резервной копии, — 30 минут;
    * изменение — 60 минут;
    * удаление — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
      ...
      timeouts {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
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

  1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>:move' \
       --data '{
                 "destinationFolderId": "<идентификатор_каталога>"
               }'
     ```

     Где `destinationFolderId` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

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
  1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например, с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "destination_folder_id": "<идентификатор_каталога>"
           }' \
       mdb.api.cloud.yandex.net:443 \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Move
     ```

     Где `destination_folder_id` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

После перемещения кластер продолжит использовать облачную сеть из исходного каталога. Если вы хотите разместить кластер в другой облачной сети, воспользуйтесь функцией [восстановления из резервной копии](cluster-backups.md) и укажите необходимую сеть для копии кластера.

Если вы хотите переместить кластер в другую зону доступности, обратитесь к [инструкции](host-migration.md). В результате вы перенесете хосты кластера.


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;PostgreSQL**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **Редактировать** на панели сверху.
  1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      yc managed-postgresql cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      yc managed-postgresql cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
      ```

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл Terraform с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера Managed Service for PostgreSQL см. в [документации провайдера Terraform](../../terraform/resources/mdb_postgresql_cluster.md).

  1. Измените значение параметра `security_group_ids` в описании кластера:

      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        security_group_ids = [ <список_идентификаторов_групп_безопасности> ]
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

      {% note warning "Ограничения по времени" %}
      
      Провайдер Terraform ограничивает время на выполнение операций с кластером Managed Service for PostgreSQL:
      
      * создание, в том числе путем восстановления из резервной копии, — 30 минут;
      * изменение — 60 минут;
      * удаление — 15 минут.
      
      Операции, длящиеся дольше указанного времени, прерываются.
      
      {% cut "Как изменить эти ограничения?" %}
      
      Добавьте к описанию кластера блок `timeouts`, например:
      
      ```hcl
      resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
        ...
        timeouts {
          create = "1h30m" # Полтора часа
          update = "2h"    # 2 часа
          delete = "30m"   # 30 минут
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

  1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью [cURL](https://curl.se/):

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://mdb.api.cloud.yandex.net/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
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

     * `securityGroupIds` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

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
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
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
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `security_group_ids` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.Cluster).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}