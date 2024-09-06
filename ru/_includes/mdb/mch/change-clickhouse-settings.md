{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы задать настройки {{ CH }}:

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
   1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
   1. Задайте [настройки {{ CH }}](../../../managed-clickhouse/concepts/settings-list.md#server-level-settings).
   1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

   {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

   Чтобы задать настройки {{ CH }}:

   1. Посмотрите полный список настроек, установленных для кластера:

      ```bash
      {{ yc-mdb-ch }} cluster get <имя_или_идентификатор_кластера> --full
      ```

   1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update-config --help
      ```

   1. Установите нужные значения параметров:

      ```bash
      {{ yc-mdb-ch }} cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра_1>=<значение_1>,...
      ```

- {{ TF }} {#tf}

   Чтобы задать настройки {{ CH }}:

   1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](../../../managed-clickhouse/operations/cluster-create.md).

   1. В описании кластера {{ mch-name }}, в блоке `clickhouse.config`, измените значения параметров:

      ```hcl
      resource "yandex_mdb_clickhouse_cluster" "<имя_кластера>" {
        ...
        clickhouse {
          ...

          config {
            # Общие настройки СУБД
            ...

            merge_tree {
              # Настройки движка MergeTree
              ...
            }

            kafka {
              # Общие настройки получения данных из Apache Kafka
              ...
            }

            kafka_topic {
              # Настройки отдельного топика Apache Kafka
              ...
            }

            rabbit_mq {
              # Настройки получения данных из {{ RMQ }}
              username = "<имя_пользователя>"
              password = "<пароль>"
            }

            compression {
              # Настройки сжатия данных
              method              = "<метод_сжатия>"
              min_part_size       = <размер_куска_данных>
              min_part_size_ratio = <отношение_размеров>
            }

            graphite_rollup {
              # Настройки движка GraphiteMergeTree для прореживания, агрегирования и усреднения (rollup) данных Graphite.
              ...
            }
          }
          ...
        }
        ...
      }
      ```

      Где:
      * `method` — метод сжатия: `LZ4` или `ZSTD`.
      * `min_part_size` — минимальный размер куска данных таблицы в байтах.
      * `min_part_size_ratio` — отношение размера наименьшего куска данных в таблице к полному размеру таблицы.

   1. Проверьте корректность настроек.

      {% include [terraform-validate](../terraform/validate.md) %}

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../terraform/apply.md) %}

   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

   {% include [Terraform timeouts](terraform/timeouts.md) %}

- API {#api}

   Чтобы задать настройки {{ CH }}, воспользуйтесь методом REST API [update](../../../managed-clickhouse/api-ref/Cluster/update.md) для ресурса [Cluster](../../../managed-clickhouse/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../../managed-clickhouse/api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

   * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
   * Нужные значения в параметре `configSpec.clickhouse.config`.
   * Список настроек, которые необходимо изменить, в параметре `updateMask`.

   {% include [Note API updateMask](../../note-api-updatemask.md) %}

{% endlist %}
