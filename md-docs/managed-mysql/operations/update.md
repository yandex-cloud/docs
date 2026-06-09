# Изменение настроек кластера {{ MY }}

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Изменить настройки {{ MY }}](#change-mysql-config).

    {% note warning %}

    Вы не можете менять настройки {{ MY }} с помощью команд SQL.

    {% endnote %}

* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Вручную переключить хост-мастер](#start-manual-failover).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности](#change-sg-set).

Если при изменении настроек кластера из двух и более хостов требуется перезапуск хостов, то на время обновления хоста-мастера его роль переходит к одной из реплик. После завершения обновления мастером становится хост с наибольшим [приоритетом мастера](../concepts/replication.md#master-failover). Если в кластере есть несколько хостов с максимальным приоритетом, выбирается хост с наименьшим отставанием от мастера.

{% note tip %}

Чтобы после обновления хост-мастер сохранил роль мастера, задайте для него наибольший приоритет мастера. Задать приоритет мастера можно при [создании кластера](cluster-create.md) или [изменении настроек хоста](hosts.md#update).

{% endnote %}

Подробнее о других изменениях кластера:

* [{#T}](cluster-version-update.md).
* [Миграция хостов кластера в другую зону доступности](host-migration.md).

## Изменить класс хостов {#change-resource-preset}

Выбор [класса хостов](../concepts/instance-types.md) в кластерах {{ mmy-short-name }} ограничен квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% note info %}

Некоторые настройки {{ MY }} [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов каждый хост по очереди будет остановлен и обновлен. Остановленный хост будет недоступен несколько минут. На время обновления хоста-мастера его роль перейдет к одной из реплик. После завершения обновления мастером станет хост с наибольшим [приоритетом мастера](../concepts/replication.md#master-failover).
* Кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, если потребуется миграция данных на другой физический сервер.
* Подключение по [особому FQDN](connect/fqdn.md#fqdn-master) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ MY }}, в блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить класс хостов для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-my }} resource-preset list
     ```

     Результат:

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера>
        --resource-preset <идентификатор_класса>
      ```

      {{ mmy-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `resource_preset_id` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          resource_preset_id = "<класс_хоста>"
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
    
    * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
    * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
    * удаление кластера — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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

      * `configSpec.resources.resourcePresetId` — новый класс хостов.

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
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `config_spec.resources.resource_preset_id` — новый класс хостов.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для облака и убедитесь, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** в строке **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.hdd.size }}** или **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.ssd.size }}** есть квота на объем хранилищ.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

      * Выберите [тип диска](../concepts/storage.md).
      * Укажите нужный размер диска.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Укажите [тип диска](../concepts/storage.md) и нужный размер хранилища в команде изменения кластера (размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
        --disk-type <тип_диска> \
        --disk-size <размер_хранилища_ГБ>
      ```

- {{ TF }} {#tf}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Измените значения параметров `disk_type_id` и `disk_size` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          disk_type_id = "<тип_диска>"
          disk_size    = <размер_хранилища_ГБ>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% note warning "Ограничения по времени" %}
  
  Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
  
  * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
  * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
  * удаление кластера — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.resources.diskTypeId,configSpec.resources.diskSize",
                    "configSpec": {
                      "resources": {
                        "diskTypeId": "<тип_диска>",
                        "diskSize": "<размер_хранилища_в_байтах>"
                      }
                    }
                  }'
      ```

      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

      * `configSpec.resources` — параметры хранилища:

          * `diskTypeId` — [тип диска](../concepts/storage.md).
          * `diskSize` — новый размер хранилища в байтах.

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
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.resources.disk_type_id",
                    "config_spec.resources.disk_size"
                  ]
                },
                "config_spec": {
                  "resources": {
                    "disk_type_id": "<тип_диска>",
                    "disk_size": "<размер_хранилища_в_байтах>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

      * `config_spec.resources` — параметры хранилища:

          * `disk_type_id` — [тип диска](../concepts/storage.md).
          * `disk_size` — новый размер хранилища в байтах.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить настройки {{ MY }} {#change-mysql-config}

{% note info %}

Некоторые настройки {{ MY }} [зависят от выбранного класса хостов](../concepts/settings-list.md#settings-instance-dependent).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings), нажав на кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings):

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Установите нужные значения параметров.

     Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `mysql_config_5_7`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:

     ```bash
     {{ yc-mdb-my }} cluster update-config <имя_кластера>
       --set log_min_duration_statement=100,<имя_параметра>=<значение>,...
     ```

     {{ mmy-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Добавьте или измените в описании кластера {{ mmy-name }} параметры [настроек СУБД](../concepts/settings-list.md) в блоке `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        mysql_config = {
          <имя_настройки_{{ MY }}> = <значение>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

  {% note warning "Ограничения по времени" %}
  
  Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
  
  * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
  * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
  * удаление кластера — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data '{
                    "updateMask": "configSpec.mysqlConfig_<версия_{{ MY }}>",
                    "configSpec": {
                      "mysqlConfig_<версия_{{ MY }}>": {
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

          В данном случае передается только один параметр.

      * `configSpec.mysqlConfig_<версия_{{ MY }}>` — набор настроек {{ MY }}. Укажите каждую настройку на отдельной строке через запятую.

          Список версий {{ MY }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterRequest). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

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
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "update_mask": {
                  "paths": [
                    "config_spec.mysql_config_<версия_{{ MY }}>"
                  ]
                },
                "config_spec": {
                  "mysql_config_<версия_{{ MY }}>": {
                    "<настройка_1>": "<значение_1>",
                    "<настройка_2>": "<значение_2>",
                    ...
                    "<настройка_N>": "<значение_N>"
                  }
                }
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `configSpec.mysqlConfig_<версия_{{ MY }}>` — набор настроек {{ MY }}. Укажите каждую настройку на отдельной строке через запятую.

          Список версий {{ MY }}, доступных для параметра, см. в [описании метода](../api-ref/Cluster/update.md#yandex.cloud.mdb.mysql.v1.UpdateClusterReques). Описание и возможные значения настроек см. в разделе [{#T}](../concepts/settings-list.md#dbms-cluster-settings).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

Подробнее об изменении настроек {{ MY }} см. в разделе [Вопросы и ответы](../qa/configuring.md).

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Измените дополнительные настройки кластера:

     - **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**
       
       * Выберите опцию **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** и укажите процент **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}**, при достижении которого хранилище будет увеличено в следующее [окно обслуживания](../concepts/maintenance.md#maintenance-window).
             
       * Выберите опцию **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** и укажите процент **{{ ui-key.yacloud.mdb.cluster.field_threshold-value }}**, при достижении которого хранилище будет увеличено незамедлительно.
       
       * В поле **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** укажите максимальный размер хранилища, который может быть достигнут при автоматическом увеличении.
       
       {% note warning %}
             
       * Автоматическое увеличение размера хранилища не поддерживается на выделенных хостах.
       * Если выбрано увеличение размера хранилища в окно обслуживания, настройте расписание [окна обслуживания](../concepts/maintenance.md#maintenance-window).
       
       {% endnote %}
       
       [Подробнее об автоматическом увеличении размера хранилища](../concepts/storage.md#disk-size-autoscaling).

     - **{{ ui-key.yacloud.mdb.forms.backup-window-start }}** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
     
     - **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}**
     
       Автоматические резервные копии будут храниться указанное количество дней.
     
     - **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
       * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
       * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и интервал времени по UTC. Например, можно выбрать время, когда кластер наименее загружен.
       
       Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     - **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../datalens/concepts/index.md).
       
       Подробнее о настройке подключения см. в разделе [Подключение к {{ datalens-name }}](datalens-connect.md).
     
     
     - **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.
     
     
     - **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — разрешает выполнять YQL-запросы к базам данных кластера из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.
     
     
     - **{{ ui-key.yacloud.mdb.forms.field_diagnostics-enabled }}** — включите эту опцию, чтобы воспользоваться инструментом [Диагностика производительности](performance-diagnostics.md) в кластере.
     
     - **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — управляет защитой кластера от непреднамеренного удаления.
     
         Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --backup-window-start <время_начала_резервного_копирования> \
          --backup-retain-period-days=<срок_хранения_копий> \
          --datalens-access=<true_или_false> \
          --websql-access=<true_или_false> \
          --yandexquery-access=<true_или_false> \
          --disk-size-autoscaling disk-size-limit=<максимальный_размер_хранилища_в_ГБ>,`
                                 `planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                 `emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах> \
          --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
          --deletion-protection \
          --performance-diagnostics enabled=true,`
                                   `sessions-sampling-interval=<интервал_сбора_сессий>,`
                                   `statements-sampling-interval=<интервал_сбора_запросов>
        ```


    Вы можете изменить следующие настройки:

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    * `--backup-retain-period-days` — срок хранения автоматических резервных копий (в днях). Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

    * `--datalens-access` — разрешает доступ к кластеру из {{ datalens-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).

    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

    * `--yandexquery-access` — разрешает выполнять YQL-запросы к базам данных кластера из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.


    * `--disk-size-autoscaling` — настройки [автоматического увеличения размера хранилища](../concepts/storage.md#disk-size-autoscaling):
      * `planned-usage-threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
               
        Допустимые значения: от `0` до `100`.
    
      * `emergency-usage-threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
               
        Допустимые значения: от `0` до `100`. 
    
      * `disk-size-limit` — максимальный размер хранилища после увеличения, в гигабайтах. 
    
      {% note warning %}
      
      * Автоматическое увеличение размера хранилища не поддерживается на выделенных хостах.
      * При использовании параметра `planned-usage-threshold` необходимо задать окно технического обслуживания в настройке `--maintenance-window`.
            
      * Если заданы оба порога, значение `emergency-usage-threshold` должно быть больше `planned-usage-threshold`.
    
      {% endnote %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
        
              > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

    * `performance-diagnostics` — активация сбора статистики для [диагностики производительности кластера](performance-diagnostics.md). Допустимые значения параметров `sessions-sampling-interval` и `statements-sampling-interval` — от `1` до `86400` секунд.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        backup_window_start {
          hours   = <час>
          minutes = <минута>
        }
        ...
      }
      ```

      Где:

      * `hours` — час начала резервного копирования.
      * `minutes` — минута начала резервного копирования.

  1. Чтобы изменить срок хранения резервных копий, укажите в описании кластера параметр `backup_retain_period_days`:

      ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          backup_retain_period_days = <срок_хранения_копий>
          ...
        }
      ```

      Где `backup_retain_period_days` — срок хранения автоматических резервных копий в днях. Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  1. Чтобы разрешить [доступ из {{ datalens-name }}](datalens-connect.md) и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, добавьте к описанию кластера блок `access`:
     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
       ...
       access {
         data_lens = <true_или_false>
         web_sql   = <true_или_false>
       }
       ...
     }
     ```

  1. Чтобы настроить [автоматическое увеличение размера хранилища](../concepts/storage.md#disk-size-autoscaling), добавьте к описанию кластера блок `disk_size_autoscaling`:
     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
       ...
       disk_size_autoscaling {
         disk_size_limit           = <максимальный_размер_хранилища_в_ГиБ>
         emergency_usage_threshold = <порог_для_незамедлительного_увеличения_в_процентах>
         planned_usage_threshold   = <порог_для_планового_увеличения_в_процентах>
       }
       ...
     }
     ```
     
     Где:
              
     * `disk_size_limit` — максимальный размер хранилища после увеличения, в гибибайтах. 
     
     * `emergency_usage_threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                
       Допустимые значения: от `0` до `100`.
       
     * `planned_usage_threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                
       Допустимые значения: от `0` до `100`.
     
     {% note warning %}
       
     * Автоматическое увеличение размера хранилища не поддерживается на выделенных хостах.
     
     * При использовании параметра `planned_usage_threshold` необходимо задать окно технического обслуживания в блоке `maintenance_window`.
             
     * Если заданы оба порога, значение `emergency_usage_threshold` должно быть больше `planned_usage_threshold`.
     
     {% endnote %}

  1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
     
     ```hcl
     resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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
     * `hour` — порядковый номер часового интервала по UTC для типа `WEEKLY`: от `1` до `24`.
     
       > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защитить_кластер_от_удаления>
      }
      ```

      Где `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

      Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. Чтобы активировать сбор статистики для [диагностики производительности кластера](performance-diagnostics.md), добавьте к описанию кластера {{ mmy-name }} блок `performance_diagnostics`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<название_кластера>" {
        ...
        performance_diagnostics {
          enabled = true
          sessions_sampling_interval = <интервал_сбора_сессий>
          statements_sampling_interval = <интервал_сбора_запросов>
        }
        ...
      }
      ```

      Допустимые значения параметров `sessions_sampling_interval` и `statements_sampling_interval` — от `1` до `86400` секунд.

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% note warning "Ограничения по времени" %}
  
  Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
  
  * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
  * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
  * удаление кластера — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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
          "updateMask": "configSpec.backupWindowStart,configSpec.backupRetainPeriodDays,configSpec.access,configSpec.performanceDiagnostics,maintenanceWindow,deletionProtection",
          "configSpec": {
              "backupWindowStart": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
              },
              "backupRetainPeriodDays": "<количество_дней>",
              "access": {
                  "dataLens": <разрешить_доступ_из_{{ datalens-name }}>,
                  "webSql": <разрешить_доступ_из_{{ websql-name }}>,
                  "yandexQuery": <разрешить_доступ_из_Yandex_Query>
              },
              "performanceDiagnostics": {
                  "enabled": <активировать_сбор_статистики>,
                  "sessionsSamplingInterval": "<интервал_сбора_сессий>",
                  "statementsSamplingInterval": "<интервал_сбора_запросов>"
              },
              "diskSizeAutoscaling": {
                  "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                  "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                  "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
              }
          },
          "maintenanceWindow": {
              "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
              }
          },
          "deletionProtection": <защитить_кластер_от_удаления>
      }
      ```


      Где:

      * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
      * `configSpec` — настройки кластера:

          * `backupWindowStart` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов;
              * `minutes` — от `0` до `59` минут;
              * `seconds` — от `0` до `59` секунд;
              * `nanos` — от `0` до `999999999` наносекунд.

          * `backupRetainPeriodDays` — сколько дней хранить резервную копию кластера: от `7` до `60` дней.

          * `access` — настройки доступа к кластеру из сервисов {{ yandex-cloud }}:

            * `dataLens` — доступ из {{ datalens-name }}. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).
            * `webSql` — [выполнение SQL-запросов](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.
            * `yandexQuery` — выполнение YQL-запросов к базам данных кластера из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).


            Возможные значения настроек: `true` или `false`.

          * `performanceDiagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

              * `enabled` — активация сбора статистики: `true` или `false`;
              * `sessionsSamplingInterval` — интервал сбора сессий: от `1` до `86400` секунд;
              * `statementsSamplingInterval` — интервал сбора запросов: от `1` до `86400` секунд.
          
          * `diskSizeAutoscaling` — настройки [автоматического увеличения размера хранилища](../concepts/storage.md#disk-size-autoscaling):
            * `plannedUsageThreshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                     
              Допустимые значения: от `0` до `100`.
          
            * `emergencyUsageThreshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                     
              Допустимые значения: от `0` до `100`. 
          
            * `diskSizeLimit` — максимальный размер хранилища после увеличения, в байтах. 
          
            {% note warning %}
            
            * Автоматическое увеличение размера хранилища не поддерживается на выделенных хостах.
            * При использовании параметра `plannedUsageThreshold` необходимо задать окно технического обслуживания в настройке `maintenanceWindow`.
                  
            * Если заданы оба порога, значение `emergencyUsageThreshold` должно быть больше `plannedUsageThreshold`.
          
            {% endnote %}

      * `maintenanceWindow` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из параметров:
      
        * `anytime` (по умолчанию) — техническое обслуживание происходит в любое время.
        * `weeklyMaintenanceWindow` — техническое обслуживание происходит по расписанию:
      
          * `day` — день недели в формате `DDD`. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
          * `hour` — час дня по UTC в формате `HH`. Допустимые значения: от `1` до `24`.

      * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`.

          Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
          --data "@body.json"
      ```

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
                  "config_spec.backup_window_start",
                  "config_spec.backup_retain_period_days",
                  "config_spec.access",
                  "config_spec.performance_diagnostics",
                  "maintenance_window",
                  "deletion_protection"
              ]
          },
          "config_spec": {
              "backup_window_start": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
              },
              "backup_retain_period_days": "<количество_дней>",
              "access": {
                  "data_lens": <разрешить_доступ_из_{{ datalens-name }}>,
                  "web_sql": <разрешить_доступ_из_{{ websql-name }}>,
                  "yandex_query": <разрешить_доступ_из_Yandex_Query>
              },
              "performance_diagnostics": {
                  "enabled": <активировать_сбор_статистики>,
                  "sessions_sampling_interval": "<интервал_сбора_сессий>",
                  "statements_sampling_interval": "<интервал_сбора_запросов>"
              },
              "disk_size_autoscaling": {
                  "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                  "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                  "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
              }
          },
          "maintenance_window": {
              "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня>"
              }
          },
          "deletion_protection": <защитить_кластер_от_удаления>
      }
      ```


      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.
      * `config_spec` — настройки кластера:

          * `backup_window_start` — настройки окна [резервного копирования](../concepts/backup.md).

              В параметре укажите время, когда начинать резервное копирование:

              * `hours` — от `0` до `23` часов;
              * `minutes` — от `0` до `59` минут;
              * `seconds` — от `0` до `59` секунд;
              * `nanos` — от `0` до `999999999` наносекунд.

          * `backup_retain_period_days` — сколько дней хранить резервную копию кластера: от `7` до `60` дней.

          * `access` — настройки доступа к кластеру из сервисов {{ yandex-cloud }}:

              * `data_lens` — доступ из {{ datalens-name }}. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).
              * `web_sql` — [выполнение SQL-запросов](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.
              * `yandex_query` — выполнение YQL-запросов к базам данных кластера из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).


              Возможные значения настроек: `true` или `false`.

          * `performance_diagnostics` — настройки для [сбора статистики](performance-diagnostics.md#activate-stats-collector):

              * `enabled` — активация сбора статистики: `true` или `false`;
              * `sessions_sampling_interval` — интервал сбора сессий: от `1` до `86400` секунд;
              * `statements_sampling_interval` — интервал сбора запросов: от `1` до `86400` секунд.

          * `disk_size_autoscaling` — настройки [автоматического увеличения размера хранилища](../concepts/storage.md#disk-size-autoscaling):
                   
            * `planned_usage_threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                     
              Допустимые значения: от `0` до `100`.
          
            * `emergency_usage_threshold` (опционально) — порог заполнения хранилища в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                     
              Допустимые значения: от `0` до `100`.
          
            * `disk_size_limit` — максимальный размер хранилища после увеличения, в байтах. 
          
            {% note warning %}
            
            * Автоматическое увеличение размера хранилища не поддерживается на выделенных хостах.
            * При использовании параметра `planned_usage_threshold` необходимо задать окно технического обслуживания в настройке `maintenance_window`.
                  
            * Если заданы оба порога, значение `emergency_usage_threshold` должно быть больше `planned_usage_threshold`.
          
            {% endnote %}

      * `maintenance_window` — настройки окна [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Передайте один из параметров:
      
        * `anytime` (по умолчанию) — техническое обслуживание происходит в любое время.
        * `weekly_maintenance_window` — техническое обслуживание происходит по расписанию:
      
          * `day` — день недели в формате `DDD`. Допустимые значения: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
          * `hour` — час дня по UTC в формате `HH`. Допустимые значения: от `1` до `24`.

      * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

          Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


### {{ connection-manager-name }} {#conn-man}

Если в кластере не включена интеграция с сервисом {{ connection-manager-name }}, включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. Она доступна только в [консоли управления]({{ link-console-main }}).

Для каждого пользователя БД будут созданы:

* [Подключение](../../metadata-hub/concepts/connection-manager.md) {{ connection-manager-name }} с информацией о соединении с БД.

* [Секрет {{ lockbox-name }}](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя. Хранение паролей в сервисе {{ lockbox-name }} обеспечивает их безопасность.

  Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

  Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md).

  {% note info %}

  Использование сервиса {{ connection-manager-name }} и секретов, созданных с его помощью, не тарифицируется.

  {% endnote %}


## Вручную переключить хост-мастер {#start-manual-failover}

В [высокодоступном кластере {{ mmy-name }}](../concepts/high-availability.md) из нескольких хостов вы можете переключить роль мастера с текущего хоста-мастера на одну из реплик. После этой операции текущий хост-мастер станет хостом-репликой для нового мастера.

Особенности переключения мастера в {{ mmy-name }}:

* Нельзя сделать мастером каскадную реплику.
* Если явно не указать имя хоста-реплики, мастер переключится на реплику с наибольшим приоритетом или наименьшим отставанием.

Подробнее см. в разделе [Репликация](../concepts/replication.md).

Чтобы переключить мастер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![icon-hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
  1. Нажмите кнопку ![icon-autofailover.svg](../../_assets/console-icons/shuffle.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.button_manual-failover }}**.
      * Чтобы переключить мастер на одну из реплик, оставьте включенной опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}**.
      * Чтобы переключить мастер на конкретную реплику, выключите опцию **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_auto }}** и затем выберите нужную реплику из выпадающего списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-confirm-switch-master_button }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  {{ yc-mdb-my }} cluster start-failover <имя_или_идентификатор_кластера> \
      --host <имя_хоста-реплики>
  ```

  Имя хоста-реплики можно запросить со [списком хостов в кластере](hosts.md#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Воспользуйтесь методом [Cluster.StartFailover](../api-ref/Cluster/startFailover.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:startFailover' \
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
  1. Воспользуйтесь вызовом [ClusterService.StartFailover](../api-ref/grpc/Cluster/startFailover.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "host_name": "<FQDN_хоста>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.mysql.v1.ClusterService.StartFailover
     ```

     Где `host_name` — [FQDN реплики](connect/fqdn.md), которая становится мастером.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/startFailover.md#yandex.cloud.operation.Operation).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mmy-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
    
    * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
    * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
    * удаление кластера — 15 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

  1. Воспользуйтесь методом [Cluster.move](../api-ref/Cluster/move.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>:move' \
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
  1. Воспользуйтесь вызовом [ClusterService/Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "destination_folder_id": "<идентификатор_каталога>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Move
      ```

      Где `destination_folder_id` — идентификатор каталога, куда перемещается кластер. Идентификатор можно получить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `security_group_ids`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        security_group_ids = [<список_идентификаторов_групп_безопасности>]
      }
      ```

  1. Проверьте корректность настроек.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% note warning "Ограничения по времени" %}
  
  Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mmy-name }}:
  
  * создание кластера, в том числе путем восстановления из резервной копии, — 15 минут;
  * изменение кластера, в том числе обновление версии {{ MY }}, — 60 минут;
  * удаление кластера — 15 минут.
  
  Операции, длящиеся дольше указанного времени, прерываются.
  
  {% cut "Как изменить эти ограничения?" %}
  
  Добавьте к описанию кластера блок `timeouts`, например:
  
  ```hcl
  resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
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

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      {% note warning %}
      
      Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
      
      {% endnote %}

      ```bash
      curl \
          --request PATCH \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-mysql/v1/clusters/<идентификатор_кластера>' \
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
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

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
          -proto ~/cloudapi/yandex/cloud/mdb/mysql/v1/cluster_service.proto \
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
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.mysql.v1.ClusterService.Update
      ```

      Где:

      * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

          В данном случае передается только один параметр.

      * `security_group_ids` — новый список [групп безопасности](../concepts/network.md#security-groups), представленный в виде элементов массива.

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configure-security-groups) для подключения к кластеру.

{% endnote %}