# Управление коннекторами

[Коннектор](../concepts/connectors.md) управляет процессом переноса топиков {{ KF }} в другой кластер или другую систему хранения данных.

Вы можете:

* [получить список коннекторов](#list);
* [получить детальную информацию о коннекторе](#get);
* [создать коннектор](#create) нужного типа:
    * [MirrorMaker](#settings-mm2);
    * [S3 Sink](#settings-s3).
* [изменить коннектор](#update);
* [приостановить коннектор](#pause);
* [возобновить работу коннектора](#resume);
* [импортировать коннектор в {{ TF }}](#import);
* [удалить коннектор](#delete).

## Получить список коннекторов {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы запросить список коннекторов кластера, выполните команду:

    ```bash
    {{ yc-mdb-kf }} connector list --cluster-name=<имя_кластера>
    ```

    Результат:

    ```text
    +--------------+-----------+
    |     NAME     | TASKS MAX |
    +--------------+-----------+
    | connector559 |         1 |
    | ...          |           |
    +--------------+-----------+
    ```

    Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить список коннекторов, воспользуйтесь методом REST API [list](../api-ref/Connector/list.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/List](../api-ref/grpc/Connector/list.md) и передайте в запросе идентификатор кластера в параметре `clusterId`.

    Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Получить детальную информацию о коннекторе {#get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. Нажмите на имя нужного коннектора.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить детальную информацию о коннекторе, выполните команду:

    ```bash
    {{ yc-mdb-kf }} connector get <имя_коннектора>\
       --cluster-name=<имя_кластера>
    ```

    Результат:

    ```text
    name: connector785
    tasks_max: "1"
    cluster_id: c9qbkmoiimsl********
    ...
    ```

    Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы получить детальную информацию о коннекторе, воспользуйтесь методом REST API [get](../api-ref/Connector/get.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Get](../api-ref/grpc/Connector/get.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, получите [список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя коннектора в параметре `connectorName`. Чтобы узнать имя, получите [список коннекторов в кластере](#list).

{% endlist %}

## Создать коннектор {#create}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.kafka.button_create-connector }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** укажите:

        * Имя коннектора.
        * Лимит задач — количество одновременно работающих процессов. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации.

    1. В блоке **{{ ui-key.yacloud.kafka.section_properties }}** укажите свойства коннектора в формате:

        ```text
        <ключ>:<значение>
        ```

        При этом ключ может быть как простой строкой, так и содержать префикс, указывающий на принадлежность к источнику или приемнику (псевдоним кластера в конфигурации коннектора):

        ```text
        <псевдоним_кластера>.<тело_ключа>:<значение>
        ```

    1. Выберите тип коннектора — [MirrorMaker](#settings-mm2) или [S3 Sink](#settings-s3) — и задайте его конфигурацию.

        Подробнее о поддерживаемых типах коннекторов см. в разделе [{#T}](../concepts/connectors.md).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать коннектор [MirrorMaker](#settings-mm2):

  1. Посмотрите описание команды CLI для создания коннектора:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create --help
      ```

  1. Создайте коннектор:

      ```bash
      {{ yc-mdb-kf }} connector-mirrormaker create <имя_коннектора> \
         --cluster-name=<имя_кластера> \
         --direction=<направление_коннектора> \
         --tasks-max=<лимит_задач> \
         --properties=<дополнительные_свойства> \
         --replication-factor=<фактор_репликации> \
         --topics=<шаблон_для_топиков> \
         --this-cluster-alias=<префикс_для_обозначения_этого_кластера> \
         --external-cluster alias=<префикс_для_обозначения_внешнего_кластера>,`
                           `bootstrap-servers=<список_FQDN_хостов-брокеров>,`
                           `security-protocol=<протокол_безопасности>,`
                           `sasl-mechanism=<механизм_шифрования>,`
                           `sasl-username=<имя_пользователя>,`
                           `sasl-password=<пароль_пользователя>,`
                           `ssl-truststore-certificates=<сертификаты_в_формате_PEM>
      ```

      {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

      Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

      Параметр `--direction` принимает значение:

       * `egress` — если текущий кластер является кластером-источником.
       * `ingress` — если текущий кластер является кластером-приемником.

  Чтобы создать коннектор [S3 Sink](#settings-s3):

  1. Посмотрите описание команды CLI для создания коннектора:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create --help
      ```

  1. Создайте коннектор:

      ```bash
      {{ yc-mdb-kf }} connector-s3-sink create <имя_коннектора> \
         --cluster-name=<имя_кластера> \
         --tasks-max=<лимит_задач> \
         --properties=<дополнительные_свойства> \
         --topics=<шаблон_для_топиков> \
         --file-compression-type=<кодек_сжатия> \
         --file-max-records=<максимальное_количество_сообщений_в_файле> \
         --bucket-name=<имя_бакета> \
         --access-key-id=<идентификатор_AWS-совместимого_статического_ключа> \
         --secret-access-key=<содержимое_AWS-совместимого_статического_ключа> \
         --storage-endpoint=<эндпоинт_S3-совместимого_хранилища> \
         --region=<регион_S3-совместимого_хранилища>
      ```

     Имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Ознакомьтесь со списком настроек коннекторов [MirrorMaker](#settings-mm2) и [S3 Sink](#settings-s3).

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы создать коннектор MirrorMaker, добавьте ресурс `yandex_mdb_kafka_connector` с блоком настроек `connector_config_mirrormaker`:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_коннектора>"
          tasks_max  = <лимит_задач>
          properties = {
            <дополнительные_свойства>
          }
          connector_config_mirrormaker {
            topics             = "<шаблон_для_топиков>"
            replication_factor = <фактор_репликации>
            source_cluster {
              alias = "<префикс_для_обозначения_кластера>"
              external_cluster {
                bootstrap_servers           = "<список_FQDN_хостов-брокеров>"
                sasl_username               = "<имя_пользователя>"
                sasl_password               = "<пароль_пользователя>"
                sasl_mechanism              = "<механизм_шифрования>"
                security_protocol           = "<протокол_безопасности>"
                ssl-truststore-certificates = "<содержимое_PEM-сертификата>"
              }
            }
            target_cluster {
              alias = "<префикс_для_обозначения_кластера>"
              this_cluster {}
            }
          }
        }
        ```

        {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    1. Чтобы создать коннектор S3 Sink, добавьте ресурс `yandex_mdb_kafka_connector` с блоком настроек `connector_config_s3_sink`:

        ```hcl
        resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
          cluster_id = "<идентификатор_кластера>"
          name       = "<имя_коннектора>"
          tasks_max  = <лимит_задач>
          properties = {
            <дополнительные_свойства>
          }
          connector_config_s3_sink {
            topics                = "<шаблон_для_топиков>"
            file_compression_type = "<кодек_сжатия>"
            file_max_records      = <максимальное_количество_сообщений_в_файле>
            s3_connection {
              bucket_name = "<имя_бакета>"
              external_s3 {
                endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
              }
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

    Чтобы создать коннектор, воспользуйтесь методом API [create](../api-ref/Connector/create.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Create](../api-ref/grpc/Connector/create.md) и передайте в запросе:

    * Идентификатор кластера, в котором нужно создать коннектор, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки коннектора [MirrorMaker](#settings-mm2) или [S3 Sink](#settings-s3) в параметре `connectorSpec`.

{% endlist %}

### MirrorMaker {#settings-mm2}

Укажите параметры коннектора MirrorMaker:

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
  * **{{ ui-key.yacloud.kafka.label_replication-factor }}** — количество копий топика, хранящихся в кластере.
  * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-source-cluster }}** укажите параметры для подключения к кластеру-источнику:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}** — префикс для обозначения кластера-источника в настройках коннектора.

      {% note info %}

      Топики в кластере-приемнике будут созданы с указанным префиксом.

      {% endnote %}

    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}** — выберите опцию для использования текущего кластера в качестве источника.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}** — список FQDN хостов-брокеров кластера-источника с номерами портов для подключения, разделенный запятыми. Например: `broker1.example.com:9091,broker2.example.com`.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}** — имя пользователя для подключения коннектора к кластеру-источнику.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}** — пароль пользователя для подключения коннектора к кластеру-источнику.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}** — выберите механизм шифрования имени и пароля.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}** — выберите протокол подключения коннектора:
      * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
      * `SSL`, `SASL_SSL` – для подключений с SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}** — загрузите PEM-сертификат для доступа к внешнему кластеру.

  * В блоке **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-target-cluster }}** укажите параметры для подключения к кластеру-приемнику:
    * **{{ ui-key.yacloud.kafka.field_connector-alias }}** — префикс для обозначения кластера-приемника в настройках коннектора.
    * **{{ ui-key.yacloud.kafka.label_connector-this-cluster }}** — выберите опцию для использования текущего кластера в качестве приемника.
    * **{{ ui-key.yacloud.kafka.field_connector-bootstrap-servers }}** — список FQDN хостов-брокеров кластера-приемника с номерами портов для подключения, разделенный запятыми.

       {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

    * **{{ ui-key.yacloud.kafka.field_connector-sasl-username }}** — имя пользователя для подключения коннектора к кластеру-приемнику.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-password }}** — пароль пользователя для подключения коннектора к кластеру-приемнику.
    * **{{ ui-key.yacloud.kafka.field_connector-sasl-mechanism }}** — выберите механизм шифрования имени и пароля.
    * **{{ ui-key.yacloud.kafka.field_connector-security-protocol }}** — выберите протокол подключения коннектора:
      * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
      * `SSL`, `SASL_SSL` – для подключений с SSL.
    * **{{ ui-key.yacloud.kafka.field_connector-ssl-truststore-certificates }}** — загрузите PEM-сертификат для доступа к внешнему кластеру.

  * Чтобы задать значения дополнительных настроек, не указанных в этом списке, создайте необходимые ключи и задайте их значения в блоке **{{ ui-key.yacloud.kafka.section_properties }}** при [создании](#create) или [изменении](#update) коннектора. Примеры ключей:

    * `key.converter`
    * `value.converter`

    Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

- CLI {#cli}

    * `--cluster-name` — имя кластера.
    * `--direction` — направление коннектора:

        * `ingress` — если кластер является приемником.
        * `egress` — если кластер является источником.

    * `--tasks-max` — количество одновременно работающих процессов. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации.
    * `--properties` — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

        * `key.converter`
        * `value.converter`

        Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

    * `--replication-factor` — количество копий топика, хранящихся в кластере.
    * `--topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `--this-cluster-alias` — префикс для обозначения этого кластера в настройках коннектора.
    * `--external-cluster` — параметры внешнего кластера:

        * `alias` — префикс для обозначения внешнего кластера в настройках коннектора.
        * `bootstrap-servers` — список FQDN хостов-брокеров внешнего кластера с номерами портов для подключения, разделенный запятыми.

           {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

        * `security-protocol` — протокол подключения коннектора:

            * `plaintext`, `sasl_plaintext` – для подключений без SSL;
            * `ssl`, `sasl_ssl` – для подключений с SSL.

        * `sasl-mechanism` — механизм шифрования имени и пароля.
        * `sasl-username` — имя пользователя для подключения коннектора к внешнему кластеру.
        * `sasl-password` — пароль пользователя для подключения коннектора к внешнему кластеру.
        * `ssl-truststore-certificates` — список сертификатов в формате PEM.

- {{ TF }} {#tf}

    * **properties** — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

        * `key.converter`
        * `value.converter`

      Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

    * **topics** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * **replication_factor** — количество копий топика, хранящихся в кластере.
    * **source_cluster** и **target_cluster** — параметры для подключения к кластеру-источнику и кластеру-приемнику:
        * **alias** — префикс для обозначения кластера в настройках коннектора.

            {% note info %}

            Топики в кластере-приемнике будут созданы с указанным префиксом.

            {% endnote %}

        * **this_cluster** — опция для использования текущего кластера в качестве источника или приемника.
        * **external_cluster** — параметры для подключения к внешнему кластеру:
            * **bootstrap_servers** — список FQDN хостов-брокеров кластера с номерами портов для подключения, разделенный запятыми.

               {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * **sasl_username** — имя пользователя для подключения коннектора к кластеру.
            * **sasl_password** — пароль пользователя для подключения коннектора к кластеру.
            * **sasl_mechanism** — механизм шифрования имени и пароля.
            * **security_protocol** — протокол подключения коннектора:
                * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
                * `SSL`, `SASL_SSL` – для подключений с SSL.
            * **ssl_truststore_certificates** — содержимое PEM-сертификата.

- API {#api}

    {% note info %}

    Названия параметров приведены для REST API, а в скобках — для gRPC API, если название отличается.

    {% endnote %}

    Настройки коннектора MirrorMaker задаются в параметре `connectorConfigMirrormaker` (`connector_config_mirrormaker`):

    * `sourceCluster` (`source_cluster`) и `targetCluster` (`target_cluster`) — параметры для подключения к кластеру-источнику и кластеру-приемнику:

        * `alias` — префикс для обозначения кластера в настройках коннектора.

            {% note info %}

            Топики в кластере-приемнике будут созданы с указанным префиксом.

            {% endnote %}

        * `thisCluster` (`this_cluster`) — опция для использования текущего кластера в качестве источника или приемника.

        * `externalCluster` (`external_cluster`) — параметры для подключения к внешнему кластеру:

            * `bootstrapServers` (`bootstrap_servers`) — список FQDN хостов-брокеров кластера с номерами портов для подключения, разделенный запятыми.

                {% include [fqdn](../../_includes/mdb/mkf/fqdn-host.md) %}

            * `saslUsername` (`sasl_username`) — имя пользователя для подключения коннектора к кластеру.
            * `saslPassword` (`sasl_password`) — пароль пользователя для подключения коннектора к кластеру.
            * `saslMechanism` (`sasl_mechanism`) — механизм шифрования имени и пароля.
            * `securityProtocol` (`security_protocol`) — протокол подключения коннектора:
                * `PLAINTEXT`, `SASL_PLAINTEXT` – для подключений без SSL;
                * `SSL`, `SASL_SSL` – для подключений с SSL.
            * `sslTruststoreCertificates` (`ssl_truststore_certificates`) — содержимое PEM-сертификата.

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `replicationFactor` (`replication_factor`) — количество копий топика, хранящихся в кластере.

{% endlist %}

### S3 Sink {#settings-s3}

Укажите параметры коннектора S3 Sink:

{% list tabs group=instructions %}

- Консоль управления {#console}

  * **{{ ui-key.yacloud.kafka.field_connector-config-mirror-maker-topics }}** — шаблон для отбора экспортируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
  * **{{ ui-key.yacloud.kafka.field_connector-compression-type }}** — выберите кодек для сжатия сообщений:

      * `none` (по умолчанию) — сжатие отсутствует;
      * `gzip` — кодек [gzip](https://www.gzip.org/);
      * `snappy` — кодек [snappy](https://github.com/google/snappy);
      * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

      После создания кластера данный параметр нельзя изменить.

  * (Опционально) **{{ ui-key.yacloud.kafka.field_connector-file-max-records }}** — максимальное количество записей, которое может быть записано в один файл, размещенный в [S3-совместимом хранилище](../../glossary/s3.md).
  * В блоке **{{ ui-key.yacloud.kafka.field_connector-s3-connection }}** укажите параметры подключения к хранилищу:
      * **{{ ui-key.yacloud.kafka.field_connector-bucket-name }}** — имя бакета хранилища.
      * **{{ ui-key.yacloud.kafka.field_connector-endpoint }}** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища).
      * (Опционально) **{{ ui-key.yacloud.kafka.field_connector-region }}** — название региона. Значение по умолчанию — `us-east-1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


      * (Опционально) **{{ ui-key.yacloud.kafka.field_connector-access-key-id }}**, **{{ ui-key.yacloud.kafka.field_connector-secret-access-key }}** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


  * Чтобы задать значения дополнительных настроек, не указанных в этом списке, создайте необходимые ключи и задайте их значения в блоке **{{ ui-key.yacloud.kafka.section_properties }}** при [создании](#create) или [изменении](#update) коннектора. Примеры ключей:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      Список всех настроек коннектора см. в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

- CLI {#cli}

    * `--cluster-name` — имя кластера.
    * `--tasks-max` — количество одновременно работающих процессов. Рекомендуется указывать не менее `2` для равномерного распределения нагрузки репликации.
    * `--properties` — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

      * `key.converter`
      * `value.converter`
      * `value.converter.schemas.enable`
      * `format.output.type`

      Список всех настроек коннектора см. в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

    * `--topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `--file-compression-type` — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * `--file-max-records` — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.
    * `--bucket-name` — имя бакета в S3-совместимом хранилище, в который будет производиться запись.
    * `--storage-endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `{{ s3-storage-host }}`.
    * `--region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `us-east-1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


    * `--access-key-id`, `--secret-access-key` — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


- {{ TF }} {#tf}

    * **properties** — список дополнительных настроек коннектора в формате `<ключ>:<значение>`, разделенный запятыми. Примеры ключей:

        * `key.converter`
        * `value.converter`
        * `value.converter.schemas.enable`
        * `format.output.type`

      Список всех настроек коннектора см. в [документации коннектора](https://github.com/aiven/s3-connector-for-apache-kafka). Список общих настроек коннекторов см. в [документации {{ KF }}](https://kafka.apache.org/documentation/#connectconfigs).

    * **topics** — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * **file_compression_type** — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * **file_max_records** — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.
    * **s3_connection** — параметры для подключения к S3-совместимому хранилищу:

        * **bucket_name** — имя бакета, в который будет производиться запись.
        * **external_s3** — параметры для подключения к внешнему S3-совместимому хранилищу:

            * **endpoint** — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `{{ s3-storage-host }}`.
            * **region** — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `us-east-1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


            * **access_key_id**, **secret_access_key** — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


- API {#api}

    {% note info %}

    Названия параметров приведены для REST API, а в скобках — для gRPC API, если название отличается.

    {% endnote %}

    Настройки коннектора S3 Sink задаются в параметре `connectorConfigS3Sink` (`connector_config_s3_sink`):

    * `topics` — шаблон для отбора реплицируемых топиков, имена топиков перечисляются через запятую или символ `|`. Можно использовать выражение `.*`, например `analysis.*`. Для переноса всех топиков укажите `.*`.
    * `fileCompressionType` (`file_compression_type`) — кодек для сжатия сообщений. После создания кластера данный параметр нельзя изменить. Допустимые значения:

        * `none` (по умолчанию) — сжатие отсутствует;
        * `gzip` — кодек [gzip](https://www.gzip.org/);
        * `snappy` — кодек [snappy](https://github.com/google/snappy);
        * `zstd` — кодек [zstd](https://facebook.github.io/zstd/).

    * `fileMaxRecords` (`file_max_records`) — максимальное количество записей, которое может быть записано в один файл, размещенный в S3-совместимом хранилище.
    * `s3Connection` (`s3_connection`) — параметры для подключения к S3-совместимому хранилищу:
        * `bucketName` (`bucket_name`) — имя бакета, в который будет производиться запись.
        * `externalS3` (`external_s3`) — параметры внешнего хранилища:
            * `endpoint` — эндпоинт для доступа к хранилищу (его необходимо узнать у провайдера хранилища). Пример: `{{ s3-storage-host }}`.
            * `region` — регион, в котором находится бакет S3-совместимого хранилища. Значение по умолчанию — `us-east-1`. [Список доступных регионов](https://docs.aws.amazon.com/AWSJavaSDK/latest/javadoc/com/amazonaws/regions/Regions.html).


            * `accessKeyId` (`access_key_id`), `secretAccessKey` (`secret_access_key`) — [идентификатор и содержимое AWS-совместимого ключа](../../iam/concepts/authorization/access-key.md).


{% endlist %}

## Изменить коннектор {#update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. В строке с нужным коннектором нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.kafka.button_edit-connector }}**.
    1. Внесите необходимые изменения в свойства коннектора.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить коннектор [MirrorMaker](#settings-mm2):

    1. Посмотрите описание команды CLI для изменения коннектора:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update --help
        ```

    1. Запустите операцию, например, изменения лимита задач:

        ```bash
        {{ yc-mdb-kf }} connector-mirrormaker update <имя_коннектора> \
           --cluster-name=<имя_кластера> \
           --direction=<направление_коннектора> \
           --tasks-max=<новый_лимит_задач>
        ```

        Где `--direction` — направление коннектора: `ingress` или `egres`.

        Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    Чтобы изменить коннектор [S3 Sink](#settings-s3):

    1. Посмотрите описание команды CLI для изменения коннектора:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update --help
        ```

    1. Запустите операцию, например, изменения лимита задач:

        ```bash
        {{ yc-mdb-kf }} connector-s3-sink update <имя_коннектора> \
           --cluster-name=<имя_кластера> \
           --tasks-max=<новый_лимит_задач>
        ```

        Имя коннектора можно запросить со [списком коннекторов в кластере](#list), имя кластера — со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Ознакомьтесь со списком настроек коннекторов [MirrorMaker](#settings-mm2) и [S3 Sink](#settings-s3).

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметров в описании ресурса `yandex_mdb_kafka_connector`:

        * Для коннектора MirrorMaker:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<имя_коннектора>" {
              cluster_id = "<идентификатор_кластера>"
              name       = "<имя_коннектора>"
              tasks_max  = <лимит_задач>
              properties = {
                <дополнительные_свойства>
              }
              connector_config_mirrormaker {
                topics             = "<шаблон_для_топиков>"
                replication_factor = <фактор_репликации>
                source_cluster {
                  alias = "<префикс_для_обозначения_кластера>"
                  external_cluster {
                    bootstrap_servers           = "<список_FQDN_хостов-брокеров>"
                    sasl_username               = "<имя_пользователя>"
                    sasl_password               = "<пароль_пользователя>"
                    sasl_mechanism              = "<механизм_шифрования>"
                    security_protocol           = "<протокол_безопасности>"
                    ssl-truststore-certificates = "<содержимое_PEM-сертификата>"
                  }
                }
                target_cluster {
                  alias = "<префикс_для_обозначения_кластера>"
                  this_cluster {}
                }
              }
            }
            ```

        * Для коннектора S3 Sink:

            ```hcl
            resource "yandex_mdb_kafka_connector" "<имя_S3_Sink_коннектора>" {
              cluster_id = "<идентификатор_кластера>"
              name       = "<имя_S3_Sink_коннектора>"
              tasks_max  = <лимит_задач>
              properties = {
                <дополнительные_свойства>
             }
              connector_config_s3_sink {
                topics                = "<шаблон_для_топиков>"
                file_max_records      = <максимальное_количество_сообщений_в_файле>
                s3_connection {
                  bucket_name = "<имя_бакета>"
                  external_s3 {
                    endpoint          = "<эндпоинт_S3-совместимого_хранилища>"
                    access_key_id     = "<идентификатор_AWS-совместимого_статического_ключа>"
                    secret_access_key = "<содержимое_AWS-совместимого_статического_ключа>"
                  }
                }
              }
            }
            ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

    Чтобы изменить коннектор, воспользуйтесь методом REST API [update](../api-ref/Connector/update.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Update](../api-ref/grpc/Connector/update.md) и передайте в запросе:

    * Идентификатор кластера, в котором нужно изменить коннектор, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройки коннектора [MirrorMaker](#settings-mm2) или [S3 Sink](#settings-s3) в параметре `connectorSpec`.

{% endlist %}

## Приостановить коннектор {#pause}

В процессе приостановки коннектора:

* разрывается подключение к приемнику;
* удаляются данные из служебных топиков коннектора.

Чтобы приостановить коннектор:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **{{ ui-key.yacloud.compute.groups.popup-confirm_button_pause }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы приостановить работу коннектора, выполните команду:

    ```bash
    {{ yc-mdb-kf }} connector pause <имя_коннектора> \
       --cluster-name=<имя_кластера>
    ```

- API {#api}

    Чтобы приостановить работу коннектора, воспользуйтесь методом REST API [pause](../api-ref/Connector/pause.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Pause](../api-ref/grpc/Connector/pause.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя коннектора в параметре `connectorName`. Чтобы узнать имя, [получите список коннекторов в кластере](#list-connectors).

{% endlist %}

## Возобновить работу коннектора {#resume}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **{{ ui-key.yacloud.compute.groups.popup-confirm_button_resume }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы возобновить работу коннектора, выполните команду:

    ```bash
    {{ yc-mdb-kf }} connector resume <имя_коннектора> \
       --cluster-name=<имя_кластера>
    ```

- API {#api}

    Чтобы возобновить работу коннектора, воспользуйтесь методом REST API [resume](../api-ref/Connector/resume.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Resume](../api-ref/grpc/Connector/resume.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя коннектора в параметре `connectorName`. Чтобы узнать имя, [получите список коннекторов в кластере](#list-connectors).

{% endlist %}

## Импортировать коннектор в {{ TF }} {#import}

С помощью импорта вы можете передать существующие коннекторы под управление {{ TF }}.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. Укажите в конфигурационном файле {{ TF }} коннектор, который необходимо импортировать:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_коннектора>" {}
        ```

    1. Выполните команду для импорта коннектора:

        ```hcl
        terraform import yandex_mdb_kafka_connector.<имя_коннектора> <идентификатор_кластера>:<имя_коннектора>
        ```

        Подробнее об импорте коннекторов см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect#import).

{% endlist %}

## Удалить коннектор {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. Выберите нужный кластер и перейдите на вкладку **{{ ui-key.yacloud.kafka.label_connectors }}**.
    1. Нажмите на значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) рядом с именем нужного коннектора и выберите пункт **{{ ui-key.yacloud.common.delete }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить коннектор, выполните команду:

    ```bash
    {{ yc-mdb-kf }} connector delete <имя_коннектора> \
       --cluster-name <имя_кластера>
    ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Удалите ресурс `yandex_mdb_kafka_connector` с описанием нужного коннектора.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_connect).

- API {#api}

    Чтобы удалить коннектор, воспользуйтесь методом REST API [delete](../api-ref/Connector/delete.md) для ресурса [Connector](../api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Delete](../api-ref/grpc/Connector/delete.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Имя коннектора в параметре `connectorName`. Чтобы узнать имя, [получите список коннекторов в кластере](#list-connectors).

{% endlist %}
