# Изменение настроек PXF

Настройки [PXF](../external-tables.md), которые можно задать средствами {{ yandex-cloud }}, совпадают с настройками в конфигурационном файле {{ GP }} [pxf-application.properties]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/config_files.html#pxfappprops). Он описывает свойства протокола PXF. В кластере {{ GP }} для настроек PXF заданы значения по умолчанию. Чтобы оптимизировать работу с [внешними таблицами](../../concepts/external-tables.md), вы можете изменить настройки PXF с помощью интерфейсов {{ yandex-cloud }} вместо правки файла.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки PXF:

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите на панели слева ![image](../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.greenplum.label_pxf }}**.
    1. Нажмите кнопку ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.greenplum.cluster.pxf.action_edit-settings }}** в верхней части страницы.
    1. Измените настройки:

        * **Connection Timeout** — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на чтение. Диапазон значений: от `5` до `600` секунд. Значение можно указать в разных единицах времени.
        * **Upload Timeout** — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на запись. Диапазон значений: от `5` до `600` секунд. Значение можно указать в разных единицах времени.
        * **Max Threads** — максимальное количество потоков Apache Tomcat®. Диапазон значений: от `1` до `1024`.

            Чтобы предотвратить ситуации, когда запросы зависают или не выполняются из-за перерасхода памяти или некорректной работы сборщика мусора Java, задайте количество потоков Apache Tomcat®. О регулировке числа потоков читайте в документации [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/cfg_mem.html).

        * **Pool Allow Core Thread Timeout** — разрешен ли таймаут для стриминговых потоков ядра приложения (core streaming threads).
        * **Pool Core Size** — количество стриминговых потоков ядра в пуле. Диапазон значений: от `1` до `1024`.
        * **Pool Queue Capacity** — максимальное количество запросов, которое можно добавить в очередь в пул за стриминговыми потоками ядра. Диапазон значений: от нуля и выше. При значении `0` очередь в пул не образуется.
        * **Pool Max Size** — максимально допустимое количество стриминговых потоков ядра. Диапазон значений: от `1` до `1024`.
        * **Xmx** — максимальный размер JVM-кучи для демона PXF. Диапазон значений: от `64` до `16384` МБ. Значение можно указать в разных единицах измерения.
        * **Xms** — изначальный размер JVM-кучи для демона PXF. Диапазон значений: от `64` до `16384` МБ. Значение можно указать в разных единицах измерения.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки PXF:

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Задайте настройки PXF:

        ```bash
        {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
           --pxf-connection-timeout=<таймаут_для_запросов_на_чтение> \
           --pxf-upload-timeout=<таймаут_для_запросов_на_запись> \
           --pxf-max-threads=<максимальное_число_потоков_Apache_Tomcat®> \
           --pxf-pool-allow-core-thread-timeout=<разрешен_ли_таймаут_для_стриминговых_потоков> \
           --pxf-poll-core-size=<количество_стриминговых_потоков> \
           --pxf-pool-queue-capacity=<емкость_очереди_в_пул_за_стриминговыми_потоками> \
           --pxf-pool-max-size=<максимальное_число_стриминговых_потоков> \
           --pxf-xmx=<максимальный_размер_JVM-кучи> \
           --pxf-xms=<изначальный_размер_JVM-кучи>
        ```

        Где:

        * `pxf-connection-timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на чтение (в секундах). Диапазон значений: от `5` до `600`.
        * `pxf-upload-timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на запись (в секундах). Диапазон значений: от `5` до `600`.
        * `pxf-max-threads` — максимальное количество потоков Apache Tomcat®. Диапазон значений: от `1` до `1024`.

            Чтобы предотвратить ситуации, когда запросы зависают или не выполняются из-за перерасхода памяти или некорректной работы сборщика мусора Java, задайте количество потоков Apache Tomcat®. О регулировке числа потоков читайте в документации [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/cfg_mem.html).

        * `pxf-pool-allow-core-thread-timeout` — разрешен ли таймаут для стриминговых потоков ядра приложения (core streaming threads). Значение по умолчанию: `false`.
        * `pxf-poll-core-size` — количество стриминговых потоков ядра в пуле. Диапазон значений: от `1` до `1024`.
        * `pxf-pool-queue-capacity` — максимальное количество запросов, которое можно добавить в очередь в пул за стриминговыми потоками ядра. Диапазон значений: от нуля и выше. При значении `0` очередь в пул не образуется.
        * `pxf-pool-max-size` — максимально допустимое количество стриминговых потоков ядра. Диапазон значений: от `1` до `1024`.
        * `pxf-xmx` — максимальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.
        * `pxf-xms` — изначальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.

        Имя кластера можно [получить со списком кластеров в каталоге](../cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    Чтобы изменить настройки PXF:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](../cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

    1. В описании кластера, в блоке `pxf_config`, задайте настройки PXF:

        ```hcl
        resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
          ...
          pxf_config {
            connection_timeout             = <таймаут_для_запросов_на_чтение>
            upload_timeout                 = <таймаут_для_запросов_на_запись>
            max_threads                    = <максимальное_число_потоков_Apache_Tomcat®>
            pool_allow_core_thread_timeout = <разрешен_ли_таймаут_для_стриминговых_потоков>
            pool_core_size                 = <количество_стриминговых_потоков>
            pool_queue_capacity            = <емкость_очереди_в_пул_за_стриминговыми_потоками>
            pool_max_size                  = <максимальное_число_стриминговых_потоков>
            xmx                            = <максимальный_размер_JVM-кучи>
            xms                            = <изначальный_размер_JVM-кучи>
          }
        }
        ```

        Где:

        * `connection_timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на чтение (в секундах). Диапазон значений: от `5` до `600`.
        * `upload_timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на запись (в секундах). Диапазон значений: от `5` до `600`.
        * `max_threads` — максимальное количество потоков Apache Tomcat®. Диапазон значений: от `1` до `1024`.

            Чтобы предотвратить ситуации, когда запросы зависают или не выполняются из-за перерасхода памяти или некорректной работы сборщика мусора Java, задайте количество потоков Apache Tomcat®. О регулировке числа потоков читайте в документации [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/cfg_mem.html).

        * `pool_allow_core_thread_timeout` — разрешен ли таймаут для стриминговых потоков ядра приложения (core streaming threads). Значение по умолчанию: `false`.
        * `pool_core_size` — количество стриминговых потоков ядра в пуле. Диапазон значений: от `1` до `1024`.
        * `pool_queue_capacity` — максимальное количество запросов, которое можно добавить в очередь в пул за стриминговыми потоками ядра. Диапазон значений: от нуля и выше. При значении `0` очередь в пул не образуется.
        * `pool_max_size` — максимально допустимое количество стриминговых потоков ядра. Диапазон значений: от `1` до `1024`.
        * `xmx` — максимальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.
        * `xms` — изначальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Update](../../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.pxfConfig.connectionTimeout,configSpec.pxfConfig.uploadTimeout,configSpec.pxfConfig.maxThreads,configSpec.pxfConfig.poolAllowCoreThreadTimeout,configSpec.pxfConfig.poolCoreSize,configSpec.pxfConfig.poolQueueCapacity,configSpec.pxfConfig.poolMaxSize,configSpec.pxfConfig.xmx,configSpec.pxfConfig.xms",
                      "configSpec": {
                        "pxfConfig" : {
                          "connectionTimeout": "<таймаут_для_запросов_на_чтение>",
                          "uploadTimeout": "<таймаут_для_запросов_на_запись>",
                          "maxThreads": "<максимальное_число_потоков_Apache_Tomcat®>",
                          "poolAllowCoreThreadTimeout": <разрешен_ли_таймаут_для_стриминговых_потоков>,
                          "poolCoreSize": "<количество_стриминговых_потоков>",
                          "poolQueueCapacity": "<емкость_очереди_в_пул_за_стриминговыми_потоками>",
                          "poolMaxSize": "<максимальное_число_стриминговых_потоков>",
                          "xmx": "<максимальный_размер_JVM-кучи>",
                          "xms": "<изначальный_размер_JVM-кучи>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.
        * `connectionTimeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на чтение (в секундах). Диапазон значений: от `5` до `600`.
        * `uploadTimeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на запись (в секундах). Диапазон значений: от `5` до `600`.
        * `maxThreads` — максимальное количество потоков Apache Tomcat®. Диапазон значений: от `1` до `1024`.

            Чтобы предотвратить ситуации, когда запросы зависают или не выполняются из-за перерасхода памяти или некорректной работы сборщика мусора Java, задайте количество потоков Apache Tomcat®. О регулировке числа потоков читайте в документации [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/cfg_mem.html).

        * `poolAllowCoreThreadTimeout` — разрешен ли таймаут для стриминговых потоков ядра приложения (core streaming threads). Значение по умолчанию: `false`.
        * `poolCoreSize` — количество стриминговых потоков ядра в пуле. Диапазон значений: от `1` до `1024`.
        * `poolQueueCapacity` — максимальное количество запросов, которое можно добавить в очередь в пул за стриминговыми потоками ядра. Диапазон значений: от нуля и выше. При значении `0` очередь в пул не образуется.
        * `poolMaxSize` — максимально допустимое количество стриминговых потоков ядра. Диапазон значений: от `1` до `1024`.
        * `xmx` — максимальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.
        * `xms` — изначальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Update](../../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [ 
                      "config_spec.pxf_config.connection_timeout",
                      "config_spec.pxf_config.upload_timeout",
                      "config_spec.pxf_config.max_threads",
                      "config_spec.pxf_config.pool_allow_core_thread_timeout",
                      "config_spec.pxf_config.pool_core_size",
                      "config_spec.pxf_config.pool_queue_capacity",
                      "config_spec.pxf_config.pool_max_size",
                      "config_spec.pxf_config.xmx",
                      "config_spec.pxf_config.xms"
                    ]
                  },
                  "config_spec": {
                    "pxf_config" : {
                      "connection_timeout": "<таймаут_для_запросов_на_чтение>",
                      "upload_timeout": "<таймаут_для_запросов_на_запись>",
                      "max_threads": "<максимальное_число_потоков_Apache_Tomcat®>",
                      "pool_allow_core_thread_timeout": <разрешен_ли_таймаут_для_стриминговых_потоков>,
                      "pool_core_size": "<количество_стриминговых_потоков>",
                      "pool_queue_capacity": "<емкость_очереди_в_пул_за_стриминговыми_потоками>",
                      "pool_max_size": "<максимальное_число_стриминговых_потоков>",
                      "xmx": "<максимальный_размер_JVM-кучи>",
                      "xms": "<изначальный_размер_JVM-кучи>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в одну строку через запятую.
        * `connection_timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на чтение (в секундах). Диапазон значений: от `5` до `600`.
        * `upload_timeout` — таймаут подключения к серверу Apache Tomcat® во время выполнения запросов на запись (в секундах). Диапазон значений: от `5` до `600`.
        * `max_threads` — максимальное количество потоков Apache Tomcat®. Диапазон значений: от `1` до `1024`.

            Чтобы предотвратить ситуации, когда запросы зависают или не выполняются из-за перерасхода памяти или некорректной работы сборщика мусора Java, задайте количество потоков Apache Tomcat®. О регулировке числа потоков читайте в документации [VMware {{ GP }} Platform Extension Framework]({{ gp.docs.broadcom }}-platform-extension-framework/6-11/gp-pxf/cfg_mem.html).

        * `pool_allow_core_thread_timeout` — разрешен ли таймаут для стриминговых потоков ядра приложения (core streaming threads). Значение по умолчанию: `false`.
        * `pool_core_size` — количество стриминговых потоков ядра в пуле. Диапазон значений: от `1` до `1024`.
        * `pool_queue_capacity` — максимальное количество запросов, которое можно добавить в очередь в пул за стриминговыми потоками ядра. Диапазон значений: от нуля и выше. При значении `0` очередь в пул не образуется.
        * `pool_max_size` — максимально допустимое количество стриминговых потоков ядра. Диапазон значений: от `1` до `1024`.
        * `xmx` — максимальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.
        * `xms` — изначальный размер JVM-кучи для демона PXF (в мегабайтах). Диапазон значений: от `64` до `16384`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
