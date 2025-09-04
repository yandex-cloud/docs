{% list tabs %}

- {{ mmg-name }} (Managed Service for MongoDB)


    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ mmg-name }}. Если нагрузка на базы выше 10 000 операций на запись в секунду, создайте несколько эндпоинтов и трансферов. Подробнее см. в разделе [{#T}](../../../../data-transfer/operations/endpoint/source/mongodb.md).
    
    1. [Создайте пользователя](../../../../storedoc/operations/cluster-users.md#adduser) с ролью `readWrite` на каждую базу в источнике, которая будет реплицироваться. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.

- {{ MG }}
    
    1. Оцените общее количество баз данных для трансфера и общую нагрузку на {{ MG }}. Если нагрузка на базы выше 10 000 операций на запись в секунду, создайте несколько эндпоинтов и трансферов. Подробнее см. в разделе [{#T}](../../../../data-transfer/operations/endpoint/source/mongodb.md).
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Убедитесь, что версия {{ MG }} на приемнике не ниже `4.0`.
    
    1. {% include [mondodb cluster requirement](../../mongodb-cluster-requirement.md) %}
    
    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external). Чтобы настроить [кластер-источник](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) для подключения из интернета:
        
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
    
    1. Если кластер-источник не использует репликацию, включите ее:
        
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
    
    1. Создайте пользователя с ролью [`readWrite`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-readWrite) на все базы в источнике, которые будут реплицироваться:
    
        ```javascript
        use admin
        db.createUser({
            user: "<имя_пользователя>",
            pwd: "<пароль>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<имя_базы-источника_1>",
                    role: "readWrite"
                },
                {
                    db: "<имя_базы-источника_2>",
                    role: "readWrite"
                },
                ...
            ]
        });
        ```
    
       После старта трансфер подключится к источнику от имени этого пользователя. Роль `readWrite` нужна для того, чтобы у трансфера было право записи в служебную коллекцию `__data_transfer.__dt_cluster_time`.
    
       {% note info %}
    
       Для версий {{ MG }}, начиная с {{ dt-mg-version }}, достаточно выдать созданному пользователю роль [`read`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-read) на реплицируемые базы.
    
       {% endnote %}
    
    1. При использовании {{ MG }}, начиная с версии {{ dt-mg-version }}, для работы трансфера необходимо, чтобы пользователь обладал правами на чтение коллекции `local.oplog.rs`, а также на запись с чтением коллекции `__data_transfer.__dt_cluster_time`. Чтобы назначить пользователю роль [`clusterAdmin`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterAdmin), предоставляющую такие права, подключитесь к {{ MG }} и выполните команды:
    
        ```js
        use admin;
        db.grantRolesToUser("<имя_пользователя>", ["clusterAdmin"]);
        ```
    
       Для выдачи более гранулярных прав можно назначить роль [`clusterMonitor`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterMonitor), необходимую для чтения коллекции `local.oplog.rs`, а также дать доступ на чтение и запись системной коллекции `__data_transfer.__dt_cluster_time`.

{% endlist %}