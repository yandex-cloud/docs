# Релизы YC CLI

## Версия 0.37.0 (06.09.19) {#latest-release}

### Изменения в CLI {#cli}

**Улучшено**

- Добавлена проверка доступности эндпоинтов API {{ iam-short-name }}, {{ resmgr-short-name }}, {{ compute-short-name }}. Если эндпоинт недоступен, выдается ошибка.
- Добавлено отображение деталей ошибок. 

### Изменения в сервисах Облака {#services}

#### {{ container-registry-name }} {#container-registry}

**Улучшено**
 
- Добавлена поддержка ОС Windows для работы с Docker Credential helper.
- Добавлена подробная ошибка при использовании `docker login` одновременно с Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

- Добавлены команды для управления метаданными группы виртуальных машин: `yc compute instance-group add-metadata` и `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster update`.

    Добавлены флаги `--node-service-account-id` и `--node-service-account-name`, позволяющие добавить или изменить сервисный аккаунт для узлов у существующего кластера {{ k8s }}.
    
- Команда `yc managed-kubernetes node-group update`.

    Добавлены флаги для изменения параметров существующей группы узлов: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.

- Добавлены команды для управления метками: `yc managed-kubernetes node-group add-labels` и `yc managed-kubernetes node-group remove-labels`.

- Добавлены команды для управления метаданными группы узлов: `yc managed-kubernetes node-group add-metadata` и `yc managed-kubernetes node-group remove-metadata`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команда `{{ yc-mdb-pg }} cluster update`.

    Добавлен флаг `--connection-pool-discard` для отключения менеджера подключений.
    
- Команды `{{ yc-mdb-pg }} user create` и `yc managed-postgresql user update`. 

    Добавлена возможность указать логин и задать права доступа для пользователя с помощью флагов `--login` и `--grants`.

## Предыдущие релизы {#previous-releases}

### Версия 0.36.0 (27.08.19) {##version0.36.0}

#### Изменения в сервисах Облака {#services}

#### {{ resmgr-name }} {#resmgr}

- Команда `yc resource-manager cloud update`.

    Добавлена возможность переименовать облако.

### Версия 0.35.1 (16.08.19) {#version0.35.1}

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя базы данных> cluster create`.

    Переименованы типы дисков по умолчанию: `network-nvme` на `network-ssd`, `local-nvme` на `local-ssd`.

### Версия 0.35.0 (09.08.19) {#version0.35.0}

#### Изменения в CLI {#cli}

**Улучшено**

- В сообщение о новой версии CLI добавлена ссылка на документацию с описанием релизов.

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команда `{{ yc-mdb-pg }} cluster create`.

    Для флага `--user` добавлены параметры: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Версия 0.34.0 (26.07.19) {#version0.34.0}

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mrd-name }}**

- Команда `{{ yc-mdb-rd }} shards`.

    Добавлена поддержка шардов для Redis-кластеров.
    
**{{ mch-name }}**

- Команда `{{ yc-mdb-ch }} cluster add-external-dictionary`.

    Добавлена поддержка словарей PostgreSQL. Флаги для работы со словарями: `--postgresql-source`, `--postgresql-source-hosts` и `--postgresql-invalidate-query`.

**{{ mmy-name }}**

- Команда `{{ mmy-name }} cluster update-config --set`

    Добавлена возможность глобально задать режим SQL с помощью параметра `sql_mode`. 

### Версия 0.33.0 (19.07.19) {#version0.33.0}

#### Изменения в CLI {#cli}

**Улучшено**

- Индикатор прогресса выполнения команды изменен с точек на [троббер](https://ru.wikipedia.org/wiki/Троббер).

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

- Команды `{{ yc-mdb-pg }} user create` и `{{ yc-mdb-pg }} user update`.

    Добавлена настройка параметров пользователя с помощью флагов `--lock_timeout`, `--log_min_duration_statement` и т. д.

### Версия 0.32.0 (05.07.19) {#version0.32.0}

#### Изменения в CLI {#cli} 

**Улучшено**

- Команды для отображения списка элементов `yc <сервис> <ресурс> list`.

   Увеличено максимальное число элементов в выводе со 100 до 1000.

#### Изменения в сервисах Облака {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

- Команды  `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster update-config`.

    Для [шардированных](../managed-mongodb/concepts/sharding.md) клаcтеров появилась возможность изменять параметры компонентов `mongos` и `mongocfg`.

### Версия 0.31.0 (01.07.19) {#version0.31.0}

#### Изменения в CLI {#cli} 

**Улучшено**

- При использовании CLI на виртуальной машине, запущенной от имени сервисного аккаунта, по умолчанию CLI будет авторизовываться от имени этого сервисного аккаунта.

**Исправлено**
    
- Попытка получить ресурс, указав его уникальный идентификатор, завершалась с ошибкой, если в конфигурации CLI не был задан параметр `folder-id`.

- Попытка получить каталог, указав его уникальный идентификатор, завершалась с ошибкой, если у пользователя не было роли `viewer` на каталог в Облаке.

- Команда `yc init` завершалась с ошибкой, если у пользователя не было роли `viewer` в Облаке.

#### Изменения в сервисах Облака {#services}

#### {{ load-balancer-name }} {#load-balancer}

- Команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update`. 

    Для флага `--listener`  появилась возможность задать параметр `target-port`, позволяющий настроить NAT так, чтобы целевые ресурсы принимали трафик на порту, отличном от порта `listener`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

- Команды `{{ yc-mdb-ch }} user create` и `{{ yc-mdb-ch }} user update`. 

    Добавлен флаг `--settings`, позволяющий задать пользовательские настройки.

### Версия 0.30.0 (18.06.19) {#version0.30.0}

#### Изменения в сервисах Облака {#services}

#### {{ compute-name }} {#compute}

- Команда `yc compute instance update`.

    Добавлены флаги `--service-account-id` и `--service-account-name`, позволяющие добавить или изменить сервисный аккаунт для существующей виртуальной машины.

- Команда `yc compute instance create`.

    Изменено количество ядер, используемое по умолчанию при создании виртуальной машины с платформой Intel Cascade Lake (`standard-v2`). Теперь `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster update`.

    Добавлен флаг `--default-gateway-v4-address`, позволяющий обновить адрес шлюза для существующего {{ k8s }} кластера.

### Версия 0.29.0 (11.06.19) {#version0.29.0}

- Небольшие исправления и обновления.

### Версия 0.28.0 (05.06.19) {#version0.28.0}

#### Изменения в CLI {#cli}

- Добавлено автоматическое повторное подключение в случае недоступности любого ресурса, задействованного в выполнении команды. CLI повторит попытку соединения 5 раз, частота повтора вычисляется с помощью экспоненциального откладывания (exponential backoff).

#### Изменения в сервисах Облака {#services}

####  {{ compute-name }} {#compute-cloud}

- Команда `yc compute instance create`.

    Добавлен флаг `--gpus`, позволяющий указать количество графических процессоров у виртуальной машины.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

- Команда `yc <имя базы данных> cluster get`.

    Улучшен вывод информации о кластере.

- Команда `yc <имя базы данных> cluster create`.

    Добавлен флаг `--backup-window-start`, позволяющий при создании кластера настроить время его ежедневного резервного копирования.

**{{ mch-name }}**

- Команда `{{ yc-mdb-ch }} cluster add-zookeeper`.

    Добавлена возможность добавлять хосты ZooKeeper.

- Команда: `{{ yc-mdb-ch }} shards add`.

    Изменена логика создания шардов:
    - Если не указан флаг `--host`, параметры для шарда копируются из самого старого шарда.
    - Если указан флаг `--host`, требуется введение всех параметров.
    - Если шарды отсутствуют, для создания шарда также требуется введение всех параметров.
