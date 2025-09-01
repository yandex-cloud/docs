{% list tabs %}

- {{ mmg-name }}
    
    1. [Создайте базу данных](../../../../storedoc/operations/databases.md#add-db).
    1. [Создайте пользователя](../../../../storedoc/operations/cluster-users.md#adduser) с ролью [`readWrite`](../../../../storedoc/concepts/users-and-roles.md#readWrite) на созданную базу.
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике {{ mmg-full-name }}:
        1. Следуя [инструкции](../../../../storedoc/tutorials/sharding.md), создайте и настройте в базе-приемнике пустые шардированные коллекции.
        
           Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Если шардирование происходит по ключу, отличному от `_id` (используется по умолчанию), [назначьте пользователю роль](../../../../storedoc/operations/cluster-users.md#updateuser) `mdbShardingManager`.
        
        1. При [создании эндпоинта для приемника](../../../../data-transfer/operations/endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           {% include [MongoDB endpoint DROP clean policy warning](../../note-mongodb-clean-policy.md) %}

       Подробнее о шардировании см. в [документации {{ MG }}](https://docs.mongodb.com/manual/sharding/).

- {{ MG }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Убедитесь, что версия {{ MG }} на приемнике не ниже, чем на источнике.
    
    1. {% include [mondodb cluster requirement](../../mongodb-cluster-requirement.md) %}
    
    1. [Настройте кластер-приемник](https://docs.mongodb.com/manual/core/security-mongodb-configuration/), чтобы к нему можно было подключиться из интернета:
        
        1. Измените в конфигурационном файле значение настройки `net.bindIp` со `127.0.0.1` на `0.0.0.0`:
        
            ```yaml
            # network interfaces
            net:
              port: 27017
              bindIp: 0.0.0.0
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
    
    1. Если кластер-приемник не использует репликацию, включите ее:
        
        1. Добавьте в конфигурационный файл `/etc/mongod.conf` настройки репликации:
        
            ```yaml
            replication:
              replSetName: <имя_набора_реплик>
            ```
        
        1. Перезапустите сервис `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
        
        1. Подключитесь к {{ MG }} и инициализируйте набор реплик командой:
        
            ```javascript
            rs.initiate({
                _id: "<имя_набора_реплик>",
                members: [{
                    _id: 0,
                    host: "<IP-адрес_который_слушает_Yandex_StoreDoc>:<порт>"
                }]
            });
            ```
    
    1. Подключитесь к кластеру и создайте базу-приемник:
    
        ```javascript
        use <имя_базы>
        ```
    
    1. Создайте пользователя с правами `readWrite` на базу-приемник:
    
        ```javascript
        use admin;
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-приемника>",
                    role: "readWrite"
                }
            ]
        });
        ```
    
       После старта трансфер подключится к приемнику от имени этого пользователя.
    
    1. Чтобы шардировать переносимые коллекции в кластере-приемнике:
        
        1. Подготовьте базу данных и создайте в ней пустые коллекции с теми же именами, что и на источнике.
        
           Сервис {{ data-transfer-name }} не шардирует переносимые коллекции автоматически. Шардирование больших коллекций может занять продолжительное время и снизить скорость трансфера.
        
        1. Включите шардирование для базы-приемника:
        
            ```javascript
            sh.enableSharding("<имя_базы-приемника>")
            ```
        
        1. Задайте шардирование для каждой коллекции с учетом ее пространства имен:
        
            ```javascript
            sh.shardCollection("<имя_базы-приемника>.<имя_коллекции>", { <имя_поля>: <1|"hashed">, ... });
            ```
        
           Описание функции `shardCollection()` см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#mongodb-method-sh.shardCollection).
        
        1. Чтобы убедиться в том, что шардирование настроено и включено, получите список доступных шардов:
        
            ```javascript
            sh.status()
            ```
        
        1. Если для шардирования используется ключ, отличный от `_id` (значение по умолчанию), назначьте системную роль `clusterManager` пользователю, от имени которого сервис {{ data-transfer-name }} будет подключаться к кластеру-приемнику:
        
            ```javascript
            use admin;
            db.grantRolesToUser("<имя_пользователя>", ["clusterManager"]);
            ```
        
        1. При [создании эндпоинта для приемника](../../../../data-transfer/operations/endpoint/target/mongodb.md) выберите политику очистки `DISABLED` или `TRUNCATE`.
        
           {% include [MongoDB endpoint DROP clean policy warning](../../note-mongodb-clean-policy.md) %}

       Подробнее о шардировании см. в [документации {{ MG }}](https://docs.mongodb.com/basics/sharding/).

{% endlist %}
