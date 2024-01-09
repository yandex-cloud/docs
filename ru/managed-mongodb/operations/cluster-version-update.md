# Обновление версии {{ MG }}

Вы можете обновить кластер {{ mmg-name }} в рамках одной мажорной версии. Переход между мажорными версиями (например, 4 → 5) не поддерживается.

Обновление доступно только на следующую версию относительно текущей, например, с версии 4.0 на 4.2. Обновление до более поздних версий производится поэтапно. Например, обновление версии {{ MG }} с 4.0 до 4.4 выполняется в такой последовательности: 4.0 → 4.2 → 4.4.


{% note alert %}

* После обновления невозможно вернуть кластер к предыдущей версии.
* Перед обновлением выполните подготовительные шаги.

{% endnote %}

## Перед обновлением версии {#before-update}

Убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://docs.mongodb.com/manual/release-notes/) {{ MG }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить кластер {#start-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Выберите нужный кластер в списке и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите номер новой версии.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

  После запуска обновления кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

- CLI {#cli}

  1. Получите список ваших кластеров {{ MG }} командой:

     ```bash
     {{ yc-mdb-mg }} cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию {{ MG }}, указанную в свойстве `config.version`:

     ```bash
     {{ yc-mdb-mg }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Запустите обновление {{ MG }}:

     ```bash
     {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
        --mongodb-version=<номер_новой_версии>
     ```

     После того как обновление запущено, кластер переходит в статус **UPDATING**. Дождитесь окончания операции и проверьте версию кластера.

  1. После обновления все возможности MongoDB, у которых нет обратной совместимости с прежней версией, выключены. Чтобы снять это ограничение, выполните команду:

     ```bash
     {{ yc-mdb-mg }} cluster update <имя_или_идентификатор_кластера> \
        --feature-compatibility-version=<номер_новой_версии>
     ```

     Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
       О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Добавьте к описанию кластера {{ mmg-name }} поле `version` или измените его значение, если оно уже существует:
  
       ```hcl
       resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
         ...
         cluster_config {
           version = "<версия_{{ MG }}>"
         }
       }
       ```
  
    1. Проверьте корректность настроек.
  
         {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
         {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
   Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

   {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API {#api}

    Чтобы обновить версию {{ MG }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Версию {{ MG }}, до которой производится обновление, в параметре `configSpec.version`.
    * Список настроек, которые необходимо изменить (в данном случае — `configSpec.version`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

    После обновления все возможности MongoDB, у которых нет обратной совместимости с прежней версией, выключены. Чтобы снять это ограничение, используйте метод API [update](../api-ref/Cluster/update.md): передайте в запросе номер новой версии в свойстве `configSpec.featureCompatibilityVersion`.

    Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% endlist %}

## Примеры {#examples}

Допустим, нужно обновить кластер с версии 4.0 до версии 4.2.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Чтобы узнать идентификатор кластера, получите список всех кластеров в каталоге:

      ```bash
      {{ yc-mdb-mg }} cluster list

      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih******** |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере `c9qut3k64b2o********`, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster get c9qut3k64b2o********
        id: c9qut3k64b2o********
        folder_id: b1g0itj57rbj********
        created_at: "2019-07-16T09:43:50.393231Z"
        name: mongodb406
        environment: PRODUCTION
        monitoring:
        - name: Console
          description: Console charts
          link: {{ link-console-main }}/folders/b1g0itj57rbj********/managed-mongodb/cluster/c9qut3k64b2o********?section=monitoring
        config:
          version: "4.0"
          feature_compatibility_version: "4.0"
          ...
      ```

   1. Для обновления кластера `c9qutgkd4b2o********` до версии 4.2, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --mongodb-version=4.2
      ```

   1. Чтобы включить все возможности версии 4.2 в кластере `c9qutgkd4b2o********`, выполните команду:

      ```bash
      {{ yc-mdb-mg }} cluster update c9qutgkd4b2o******** \
          --feature-compatibility-version=4.2
      ```

{% endlist %}
