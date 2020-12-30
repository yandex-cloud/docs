# Обновление версии {{ MG }}

Вы можете обновить кластер {{ mmg-name }} до версий 4.0, 4.2 или 4.4.

Обновление доступно только на следующую версию относительно текущей, т.е.:

- с версии 3.6 на версию 4.0;
- с версии 4.0 на версию 4.2;
- с версии 4.2 на версию 4.4.

Обновление до версий, которые не являются следующими относительно текущей версии, должно производиться в несколько этапов. Например, для обновления версии кластера с 4.0 до 4.4 его необходимо выполнить в такой последовательности: 4.0 → 4.2 → 4.4.

## Перед обновлением {#before-update}

Перед обновлением кластера убедитесь, что это не нарушит работу ваших приложений:

1. Посмотрите историю изменений для версий [4.0](https://docs.mongodb.com/v4.0/release-notes/4.0/), [4.2](https://docs.mongodb.com/v4.0/release-notes/4.2/) или [4.4](https://docs.mongodb.com/v4.4/release-notes/) {{ MG }} и проверьте, не повлияют ли какие-то изменения на работу приложений.
1. Попробуйте обновить тестовый кластер (его можно [развернуть](cluster-backups.md#restore), например, из резервной копии основного кластера).
1. [Выполните резервное копирование](cluster-backups.md#create-backup) основного кластера непосредственно перед обновлением.

## Обновить кластер {#start-update}

Чтобы обновить кластер {{ mmg-name }}:

{% list tabs %}

- Консоль управления

  1. Откройте страницу сервиса **{{ mmg-name }}** в каталоге, где находится обновляемый кластер.
  1. Выберите нужный кластер в списке и нажмите кнопку **Изменить кластер**.
  1. В поле **Версия** выберите пункт *4.0* , *4.2* или *4.4*.
  1. Нажмите кнопку **Сохранить изменения**.

  После запуска обновления кластер переходит в статус `UPDATING`. Дождитесь окончания операции и проверьте версию кластера.

- CLI

  1. Получите список ваших кластеров {{ MG }} командой:

     ```
     yc managed-mongodb cluster list
     ```

  1. Получите информацию о нужном кластере и проверьте версию {{ MG }}, указанную в свойстве `config.version`:

     ```
     yc managed-mongodb cluster get <id кластера>
     ```

  1. Запустите обновление {{ MG }}:

     ```
     yc managed-mongodb cluster update <id кластера> --mongodb-version=<номер новой версии>
     ```

     После того, как обновление запущено, кластер переходит в статус `UPDATING`. Дождитесь окончания операции и проверьте версию кластера.

  1. После обновления все возможности MongoDB, у которых нет обратной совместимости с прежней версией, выключены. Чтобы снять это ограничение, выполните команду:

     ```
     yc managed-mongodb cluster update <id кластера> --feature-compatibility-version=<номер новой версии>
     ```     

     Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

- API

  Обновить версию {{ MG }} для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в свойстве `configSpec.version`.

  После обновления все возможности MongoDB, у которых нет обратной совместимости с прежней версией, выключены. Чтобы снять это ограничение, используйте метод API [update](../api-ref/Cluster/update.md): передайте в запросе номер новой версии в свойстве `configSpec.featureCompatibilityVersion`.

  Подробнее об обратной совместимости читайте в [документации MongoDB](https://docs.mongodb.com/manual/reference/command/setFeatureCompatibilityVersion/).

{% endlist %}


## Примеры {#examples}

Допустим, нужно обновить кластер с версии 3.6 до версии 4.0.

{% list tabs %}

- CLI

   1. Чтобы получить список кластеров и узнать идентификатор кластера, выполните команду:

      ```
      $ yc managed-mongodb cluster list
      +----------------------+---------------+---------------------+--------+---------+
      |          ID          |     NAME      |     CREATED AT      | HEALTH | STATUS  |
      +----------------------+---------------+---------------------+--------+---------+
      | c9q8p8j2gaih8iti42mh |   mongodb406  | 2019-04-23 12:44:17 | ALIVE  | RUNNING |
      +----------------------+---------------+---------------------+--------+---------+
      ```

   1. Чтобы получить информацию о кластере `c9qut3k64b2o9umqogr7`, выполните команду:

      ```
      $ yc managed-mongodb cluster get c9qut3k64b2o9umqogr7
        id: c9qut3k64b2o9umqogr7
        folder_id: b1g0itj57rbjk9thrinv
        created_at: "2019-07-16T09:43:50.393231Z"
        name: mongodb406
        environment: PRODUCTION
        monitoring:
        - name: Console
          description: Console charts
          link: https://console.cloud.yandex.ru/folders/b1g0itj57rbjk9thrinv/managed-mongodb/cluster/c9qut3k64b2o9umqogr7?section=monitoring
        config:
          version: "3.6"
          feature_compatibility_version: "3.6"
          ...
      ```
   1. Для обновления кластера `c9qutgkd4b2o9umqog97` до версии 4.0, выполните команду:

      ```
      $ yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --mongodb-version=4.0
      ```

   1. Чтобы включить все возможности версии 4.0 в кластере `c9qutgkd4b2o9umqog97`, выполните команду:

      ```
      $ yc managed-mongodb cluster update c9qutgkd4b2o9umqog97 --feature-compatibility-version=4.0
      ```  

{% endlist %}
