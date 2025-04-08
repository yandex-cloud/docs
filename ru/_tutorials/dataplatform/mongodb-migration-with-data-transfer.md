# Миграция коллекций из {{ MG }} в {{ mmg-name }}


Чтобы перенести коллекции, хранящиеся в стороннем кластере {{ MG }}, в кластер {{ mmg-name }}, нужно непосредственно перенести данные, запретить запись в старые базы данных и переключить нагрузку на кластер в {{ yandex-cloud }}.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за кластер-приемник {{ mmg-name }}: использование вычислительных ресурсов, выделенных хостам, и дискового пространства (см. [тарифы {{ MG }}](../../managed-mongodb/pricing.md)).
* Плата за каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).
* Плата за использование публичных IP-адресов, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

Убедитесь, что к хостам кластера-источника можно подключиться из интернета.

## Миграция данных с использованием сервиса {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [MMG collections migration with Data Transfer](datatransfer/managed-mongodb.md) %}

## Пример миграции коллекции {#example}

1. [Настройте кластер-источник](#source-setup).
1. [Создайте и настройте кластер-приемник](#target-setup).
1. [Настройте эндпоинты и трансфер](#prepare-endpoints-transfer).
1. [Перенесите данные](#transfer).
1. [Удалите созданные ресурсы](#clear-out).

### Настройте кластер-источник {#source-setup}
  
1. Подключитесь к хосту `mongos` кластера-источника {{ MG }} с помощью [утилиты mongosh](https://docs.mongodb.com/mongodb-shell).
1. Создайте базу данных `db1`.
1. Создайте пользователя с правами владельца базы данных `db1` и авторизуйтесь под его именем:

    ```javascript
    use admin
    db.createUser({
      user: "user1",
      pwd: passwordPrompt(),
      roles: [
          {
              role: "dbOwner",
              db: "db1"
          }
      ]
    })

    db.auth("user1")
    ```

1. Заполните коллекцию `collection1` в базе `db1` случайными значениями. В коллекцию будет вставлено 200 000 записей:
  
    ```javascript
    use db1
    function randomName() {
      // Base 36 uses letters and digits to represent a number:
      return (Math.random()+1).toString(36).substring(2);
    }

    var day = 1000 * 60 * 60 * 24;
    function randomDate () {
      return new Date(Date.now() - (Math.floor(Math.random() * day)));
    }

    for (var i = 1; i <= 200000; ++i) {
      db.collection1.insertOne({
       name: randomName(),
       creationDate: randomDate(),
       uid: i
      });
    }
    ```

### Создайте и настройте кластер-приемник {#target-setup}

{% list tabs group=cluster %}

- Нешардированный кластер-приемник {#non-sharded}

  1. [Создайте кластер](../../managed-mongodb/operations/cluster-create.md) {{ mmg-name }} любой подходящей конфигурации.
  1. [Создайте базу данных](../../managed-mongodb/operations/databases.md#add-db) `db1`.
  1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) `user_transfer` с ролью [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) на созданную базу.
  
- Шардированный кластер-приемник {#sharded}

  1. [Создайте кластер](../../managed-mongodb/operations/cluster-create.md) {{ mmg-name }} любой подходящей конфигурации. В кластере должно быть не менее двух хостов.
  1. [Включите шардирование](../../managed-mongodb/operations/shards.md).
  1. [Создайте базу данных](../../managed-mongodb/operations/databases.md#add-db) `db1`.
  1. [Создайте пользователя](../../managed-mongodb/operations/cluster-users.md#adduser) `user_transfer` с ролью [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) на созданную базу и ролью [`mdbShardingManager`](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) на служебную базу `admin`.
  1. Следуя [инструкции](../../managed-mongodb/tutorials/sharding.md), создайте и настройте в базе `db1` пустую шардированную коллекцию `collection1`.

{% endlist %}

### Настройте эндпоинты и трансфер {#prepare-endpoints-transfer}

{% list tabs group=cluster %}

- Нешардированный кластер-приемник {#non-sharded}

  1. [Создайте эндпоинт для кластера-источника](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}** — загрузите файл сертификата, если при подключении к кластеру-источнику требуется шифрование.
        * **Список хостов** — укажите FQDN хостов кластера-источника.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}** — укажите порт для подключения к хостам.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя `user1`.
  1. [Создайте эндпоинт для кластера-приемника](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}** — `Кластер MDB`.
        * Укажите идентификатор кластера-приемника.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `user_transfer`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя `user_transfer`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}`.
  1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create):
     * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}** — {{ dt-type-copy-repl }}.
     * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}** — выберите созданный эндпоинт для кластера-источника.
     * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}** — выберите созданный эндпоинт для кластера-приемника.

- Шардированный кластер-приемник {#sharded}

  1. [Создайте эндпоинт для кластера-источника](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnectionType.on_premise.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.ca_certificate.title }}** — загрузите файл сертификата, если при подключении к кластеру-источнику требуется шифрование.
        * **Список хостов** — укажите FQDN хостов кластера-источника.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}** — укажите порт для подключения к хостам.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}** — `db1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `user1`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя `user1`.
  1. [Создайте эндпоинт для кластера-приемника](../../data-transfer/operations/endpoint/index.md#create):
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ MG }}`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.connection.title }}** — `Кластер MDB`.
         * Укажите идентификатор кластера-приемника.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}** — `user_transfer`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}** — укажите пароль пользователя `user_transfer`.
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoTarget.cleanup_policy.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}`.
  1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create):
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.Transfer.type.title }}** — {{ dt-type-copy-repl }}.
      * **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}** — выберите созданный эндпоинт для кластера-источника.
      * **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}** — выберите созданный эндпоинт для кластера-приемника.

{% endlist %}

### Перенесите данные {#transfer}

{% list tabs group=cluster %}

- Нешардированный кластер-приемник {#non-sharded}

  1. [Активируйте](../../data-transfer/operations/transfer.md#activate) созданный трансфер.
  1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
  1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
  1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
  1. [Подключитесь](../../managed-mongodb/operations/connect/index.md) к кластеру-приемнику.
  1. Проверьте, что коллекция `collection1` перенесена и количество документов в ней равно 200 000, как в кластере-источнике:
  
     ```javascript
     use db1
     db.collection1.countDocuments()
     ```

     ```text
     200000
     ```

- Шардированный кластер-приемник {#sharded}

  1. [Активируйте](../../data-transfer/operations/transfer.md#activate) созданный трансфер.
  1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
  1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
  1. На странице [мониторинга трансфера](../../data-transfer/operations/monitoring.md) дождитесь снижения до нуля характеристики **Maximum data transfer delay**. Это значит, что на кластер-приемник перенесены все изменения, произошедшие в кластере-источнике после завершения копирования данных.
  1. [Подключитесь](../../managed-mongodb/operations/connect/index.md) к кластеру-приемнику.
  1. Проверьте, что коллекция `collection1` перенесена, количество документов в ней равно 200 000, как в кластере-источнике, и документы распределены по шардам:
       
      ```javascript
      use db1
      db.collection1.countDocuments()
      ```

      ```text
      200000
      ```

      ```javascript
      db.collection1.getShardDistribution()
      ```

      ```text
      Shard rs01 at rs01/<хост_1>
      {
        data: '7.05MiB',
        docs: 99752,
        chunks: 2,
        'estimated data per chunk': '3.52MiB',
        'estimated docs per chunk': 49876
      }
      ---
      Shard rs02 at rs02/<хост_2>
      {
        data: '7.08MiB',
        docs: 100248,
        chunks: 2,
        'estimated data per chunk': '3.54MiB',
        'estimated docs per chunk': 50124
      }
      ---
      ...
      ```

{% endlist %}

### Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) трансфер и дождитесь его перехода в статус {{ dt-status-stopped }}.

    Подробнее о жизненном цикле трансфера читайте в [документации {{ data-transfer-full-name }}](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Удалите](../../data-transfer/operations/transfer.md#delete) остановленный трансфер.
1. [Удалите эндпоинты для источника и приемника](../../data-transfer/operations/endpoint/index.md#delete).
1. [Удалите созданный кластер {{ mmg-name }}](../../managed-mongodb/operations/cluster-delete.md).
