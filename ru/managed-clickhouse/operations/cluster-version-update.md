# Изменение версии {{ CH }}

Вы можете изменить версию {{ CH }}, которую использует кластер, на любую из [поддерживаемых {{ mch-name }} версий](../concepts/update-policy.md#versioning-policy), но при этом запрещен переход:

* с версии 22.0 и выше на версию ниже 22.0;
* на версию ниже {{ mch-ck-version }}, если кластер создан с поддержкой {{ CK }}.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Список доступных версий

{% list tabs %}

- Консоль управления

    Посмотреть список доступных версий можно на экране создания или изменения кластера в [консоли управления]({{ link-console-main }}):

    ![ch-versions](../../_assets/mdb/clickhouse-version.png)

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список доступных версий, выполните команду:

    ```bash
    yc managed-clickhouse version list
    ```

- API

    Чтобы посмотреть список доступных версий, воспользуйтесь методом REST API [list](../api-ref/Versions/list.md) для ресурса [Versions](../api-ref/Versions/index.md) или вызовом gRPC API [VersionsService/List](../api-ref/grpc/versions_service.md#List).

{% endlist %}

## Перед изменением версии {#before-update}

Перед изменением версии {{ CH }} убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите [историю изменений]({{ ch.docs }}/whats-new/changelog/index/) {{ CH }} и проверьте, какие из обновлений могут влиять на работу приложений.
1. Попробуйте изменить версию на тестовом кластере (его можно развернуть, например, из резервной копии основного кластера). Обратите внимание, что при развертывании кластера из резервной копии восстановятся только таблицы на движке MergeTree.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед изменением версии.

## Изменить версию {#start-update}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) откройте страницу сервиса **{{ mch-name }}** в каталоге, где нужно изменить версию {{ CH }}.
    1. В списке кластеров выберите тот, который нужно изменить.
    1. Нажмите кнопку **Изменить кластер**.
    1. В блоке **Базовые параметры** в поле **Версия** выберите нужную версию.
    1. Нажмите кнопку **Сохранить изменения**.

    После того, как изменение версии запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите список ваших кластеров {{ CH }}:

        ```bash
        {{ yc-mdb-ch }} cluster list

        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih8iti42mh | clickhouse691 | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```

    1. Получите информацию о нужном кластере и проверьте версию {{ CH }} в вашем кластере, указанную в свойстве `config.version`:

        ```bash
        {{ yc-mdb-ch }} cluster get c9q8p8j2gaih8iti42mh
        id: c9q8p8j2gaih8iti42mh
        folder_id: b1gqs1teo2q2a4vnmi2t
        created_at: "2019-04-23T12:44:17.929853Z"
        name: clickhouse691
        environment: PRODUCTION
        monitoring:
        - name: Console
            description: Console charts
            link: {{ link-console-main }}/folders/b1gqs1teo2q2a4vnmi2t/managed-clickhouse/cluster/c9q8p8j2gaih8iti42mh?section=monitoring
        config:
            version: "19.1"
            ...
        ```

    1. Запустите изменение версии {{ CH }}:

        ```bash
        {{ yc-mdb-ch }} cluster update --id c9q8p8j2gaih8iti42mh --version 19.4
        ```

    После того как изменение версии запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте к описанию кластера {{ mch-name }} поле `version` или измените его значение, если оно уже существует:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
          ...
          version = "<версия ClickHouse>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_clickhouse_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- API

    Чтобы изменить версию, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужное значение в параметре `configSpec.clickhouse.config.version`.
    * Список настроек, которые необходимо изменить (в данном случае — `configSpec.clickhouse.config.version`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
