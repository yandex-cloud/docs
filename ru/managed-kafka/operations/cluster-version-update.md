# Обновление версии {{ KF }}

Вы можете обновить кластер {{ mkf-name }} до любой поддерживаемой версии.

Рекомендуется обновлять на следующую версию относительно текущей, например, с версии 2.8 на 3.0. 
Обновление до более поздних версий следует производить поэтапно. Например, обновление версии {{ KF }} с 2.8 до 3.1 следует выполнять в такой последовательности: 2.8 → 3.0 → 3.1.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [{#T}](../concepts/maintenance.md).

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений — изучите [историю изменений](https://kafka.apache.org/downloads) {{ KF }}.

## Обновить кластер {#start-update}

{% note alert %}

После обновления версии {{ KF }} вернуть кластер к предыдущей версии невозможно.

{% endnote %}

Во время обновления топики могут быть недоступны, если их [фактор репликации](../concepts/settings-list.md#settings-topic-replication-factor) равен единице.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ mkf-short-name }}:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версию в свойстве `config.version`:

        ```bash
        {{ yc-mdb-kf }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Запустите обновление {{ KF }}:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --version=<номер_новой_версии>
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Добавьте в блок `config` нужного кластера {{ mkf-name }} поле `version` (версия {{ KF }}) или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          config {
            version = "<версия>"
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mkf }}).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- API {#api}

    Чтобы обновить кластер, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).
    * Номер версии {{ KF }} в параметре `configSpec.version`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 2.8 до версии 3.0.

{% list tabs group=instructions %}

- CLI {#cli}

    1. Чтобы получить список кластеров и узнать их идентификаторы и имена, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster list
        ```

        ```text
        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih******** |    kafka35    | 2021-10-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```

    1. Чтобы получить информацию о кластере с именем `kafka35`, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster get kafka35
        ```

        ```text
          id: c9q8p8j2gaih********
          ...
          config:
            version: "2.8"
            ...
        ```

    1. Для обновления кластера `kafka35` до версии 3.0 выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update kafka35 --version=3.0
        ```

{% endlist %}
