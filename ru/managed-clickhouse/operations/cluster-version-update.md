# Изменение версии {{ CH }}

Вы можете изменить версию {{ CH }}, которую использует кластер, на любую из [поддерживаемых {{ mch-name }} версий](../concepts/update-policy.md#versioning-policy).

## Список доступных версий

{% list tabs %}

- Консоль управления

    Посмотреть список доступных версий можно на экране создания или изменения кластера в консоли управления:

    ![ch-versions](../../_assets/mdb/clickhouse-version.png)

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список доступных версий, выполните команду:
    ```
    yc managed-clickhouse version list
    ```

- API

    Посмотреть список доступных версий можно с помощью метода API [list](../api-ref/Versions/list.md).

{% endlist %}

## Перед изменением версии {#before-update}

{% note warning %}

Если кластер использует [гибридное хранилище](../concepts/storage.md#hybrid-storage-features), то минимальный номер версии, на который можно изменить версию кластера — {{ mch-hs-version }}.

{% endnote %}

Перед изменением версии {{ CH }} убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите [историю изменений](https://clickhouse.tech/docs/ru/whats-new/changelog/) {{ CH }} и проверьте, какие из обновлений могут влиять на работу приложений.
1. Попробуйте изменить версию на тестовом кластере (его можно развернуть, например, из резервной копии основного кластера). Обратите внимание, что при развертывании кластера из резервной копии восстановятся только таблицы на движке MergeTree.
1. [Создайте резервную копию](cluster-backups.md#create-backup) основного кластера непосредственно перед изменением версии.

## Изменить версию {#start-update}

Чтобы изменить версию {{ CH }}:

{% list tabs %}

- Консоль управления
  
    1. Откройте страницу сервиса **{{ mch-name }}** в каталоге, где нужно изменить версию {{ CH }}.
    1. В списке кластеров выберите тот, который нужно изменить.
    1. Нажмите кнопку **Изменить кластер**.
    1. В поле **Версия** выберите нужную версию.
    1. Нажмите кнопку **Сохранить изменения**.

    После того, как изменение версии запущено, кластер переходит в статус `UPDATING`. Дождитесь окончания операции и проверьте версию кластера.
  
- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
    1. Получите список ваших кластеров {{ CH }}:
        ```
        $ yc managed-clickhouse cluster list
        +----------------------+---------------+---------------------+--------+---------+
        |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
        +----------------------+---------------+---------------------+--------+---------+
        | c9q8p8j2gaih8iti42mh | clickhouse691 | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
        +----------------------+---------------+---------------------+--------+---------+
        ```
    1. Получите информацию о нужном кластере и проверьте версию {{ CH }} в вашем кластере, указанную в свойстве `config.version`:
        ```
        $ yc managed-clickhouse cluster get c9q8p8j2gaih8iti42mh
        id: c9q8p8j2gaih8iti42mh
        folder_id: b1gqs1teo2q2a4vnmi2t
        created_at: "2019-04-23T12:44:17.929853Z"
        name: clickhouse691
        environment: PRODUCTION
        monitoring:
        - name: Console
            description: Console charts
            link: https://console.cloud.yandex.ru/folders/b1gqs1teo2q2a4vnmi2t/managed-clickhouse/cluster/c9q8p8j2gaih8iti42mh?section=monitoring
        config:
            version: "19.1"
            ...
        ```
    1. Запустите изменение версии {{ CH }}:
        ```
        $ yc managed-clickhouse cluster update --id c9q8p8j2gaih8iti42mh --version 19.4
        ```
    После того, как изменение версии запущено, кластер переходит в статус `UPDATING`. Дождитесь окончания операции и проверьте версию кластера.
  
- API

    Изменить версию {{ CH }} для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.clickhouse.config.version`.
  
{% endlist %}
