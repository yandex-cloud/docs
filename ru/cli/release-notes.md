---
title: Список релизов CLI
description: На странице представлены релизы CLI, а также изменения в каждом из них.
---

# Релизы CLI

## Текущая версия {#latest-release}

### Версия 0.159.0 (18.08.25) {#version0.159.0}

####  Изменения в сервисах {{ yandex-cloud }}

##### {{ mmg-name }}
Добавлен вывод `priority` и `hidden` в `yc managed-mongodb hosts list`.

##### {{ compute-name }}
Добавлены команды для управления пулами зарезервированных VM:
* `compute reserved-instance-pool list-instances`;
* `compute reserved-instance-pool list-operations`.

##### {{ compute-name }}
Расширены команды для управления пулами зарезервированных VM:
* `compute reserved-instance-pool create`;
* `compute reserved-instance-pool update`.

##### {{ er-name }}
* Исправлена работа флага `--deletion-protection` в команде `yc serverless eventrouter connector update`.

##### {{ org-name }}
* Исправлено отображение timestamp в листинге доменов SAML-федераций.

## Предыдущие релизы {#previous-release}

### Версия 0.158.0 (11.08.25) {#version0.158.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ mos-name }}
В команду `yc managed-opensearch` добавлена поддержка `ExtensionService`.

##### {{ alb-name }}

В команду `yc apploadbalancer disable-zones` добавлена возможность управлять временем отключения зоны.

##### {{ alb-name }}
* В команды управления маршрутами добавлен параметр `disable_security_profile`:
  * `yc application-load-balancer virtual-host append-http-route`;
  * `yc application-load-balancer virtual-host prepend-http-route`;
  * `yc application-load-balancer virtual-host insert-http-route`;
  * `yc application-load-balancer virtual-host update-http-route`;
  * `yc application-load-balancer virtual-host append-grpc-route`;
  * `yc application-load-balancer virtual-host prepend-grpc-route`;
  * `yc application-load-balancer virtual-host insert-grpc-route`;
  * `yc application-load-balancer virtual-host update-grpc-route`.

### Версия 0.157.0 (04.08.25) {#version0.157.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ cloud-desktop-name }}
В команду `desktops group update` добавлен флаг `--update-policy` (значение по умолчанию — `manual`).

##### {{ org-name }}
Добавлены команды для управления доменами SAML-федераций:
* `yc organization-manager federation saml get-domain`;
* `yc organization-manager federation saml list-domains`;
* `yc organization-manager federation saml add-domain`;
* `yc organization-manager federation saml validate-domain`;
* `yc organization-manager federation saml delete-domain`.

##### {{ compute-name }}
* Добавлена сортировка списка подкоманд в `yc compute`.
* Добавлены команды `yc compute maintenance`:
  * `yc compute maintenance get`;
  * `yc compute maintenance list`;
  * `yc compute maintenance reschedule`.

##### {{ objstorage-name }}
Удалены параметры `--sse-c`, `--sse-c-key`, `--sse-c-copy-source` и `--sse-c-copy-source-keys` команды `yc storage cp`.

##### {{ er-name }}
Для команды `serverless eventrouter connector create message-queue` значения по умолчанию следующих параметров приведены в соответствие с аналогичным методом API:
* `--visibility-timeout`;
* `--polling-timeout`;
* `--batch-size`.

### Версия 0.156.0 (28.07.25) {#version0.156.0}

####  Изменения в сервисах {{ yandex-cloud }}

##### {{ managed-k8s-name }}

* В команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update` добавлен параметр `--master-scale-policy`, который позволяет управлять вычислительными ресурсами мастеров кластера.
* В вывод команды `yc managed-kubernetes cluster get` добавлено поле `scale_policy` для получения конфигурации вычислительных ресурсов мастеров кластера.
* Добавлены команды `yc managed-kubernetes resource-preset get` и `yc managed-kubernetes resource-preset list` для получения возможных конфигураций вычислительных ресурсов для мастеров кластера.

### Версия 0.155.0 (23.07.25) {#version0.155.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ compute-name }}

В командах `yc compute instance create` и `yc compute instance update` исправлено описание для параметра `--memory`.

##### {{ backup-name }}

В команду `yc backup provider activate` добавлен запрос подтверждения для активации провайдера и флаг `--force` для выполнения команды без подтверждения.

##### {{ mkf-name }}

В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлен флаг `--kafka-ui-enabled` для включения Kafka UI в кластере.

##### {{ dataproc-name }}

В команды `yc dataproc cluster create` и `yc dataproc cluster update` добавлены параметры для указания сервисного аккаунта для управления группой ВМ, на которых размещаются хосты кластера:
* `--autoscaling-service-account-id`;
* `--autoscaling-service-account-name`.

##### {{ mch-name }}

В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster restore` добавлены параметры:
* `--maintenance-window` — для указания окна обслуживания кластера;
* `--disk-encryption-key-id` — для указания ключа шифрования дисков.

##### {{ mos-name }}

* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster update` добавлены параметры для управления созданием снапшотов кластера:
    * `--snapshot-schedule`;
    * `--snapshot-day`;
    * `--snapshot-hour`;
    * `--snapshot-minute`;
    * `--snapshot-max-age-days`.
* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### {{ mmy-name }}

* В команды `yc managed-mysql cluster create` и `yc managed-mysql cluster update` добавлен параметр `--yandexquery-access` для включения доступа к кластеру из {{ yq-full-name }}.
* В команды `yc managed-mysql cluster create` и `yc managed-mysql cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### {{ metastore-name }}

В команды `yc managed-metastore cluster create` и `yc managed-metastore cluster update` добавлен параметр `--version` для поддержки версионирования кластера.

##### {{ mpg-name }}

В команды `yc managed-postgresql cluster create` и `yc managed-postgresql cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### {{ mmg-name }}

В команды `yc managed-mongodb cluster create` и `yc managed-mongodb cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### {{ mrd-name }}

В команды `yc managed-redis cluster create` и `yc managed-redis cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

### Версия 0.154.0 (09.07.25) {#version0.154.0}

#### {{ alb-name }}

Добавлены команды для управления маршрутизацией трафика в зонах доступности балансировщиков:
* `yc alb load-balancer disable-zones`
* `yc alb load-balancer enable-zones`

#### {{ cloud-desktop-name }}

Флаг `--id` теперь не является обязательным для команды `yc desktop update-properties`.

#### {{ mch-name }}

Добавлены параметры для управления автоматическим расширения диска. Команды, в которых можно задавать новые параметры:
* `yc clickhouse cluster create`
* `yc clickhouse cluster update`
* `yc clickhouse restore`
* `yc clickhouse shards add`
* `yc clickhouse shard update`

#### {{ mgl-name }}

Добавлена команда для изменения инстанса `yc managed-gitlab instance update`.

#### {{ mgp-name }}

Добавлена команда для подключения пользователей с IAM-аутентификацией `yc managed-greenplum connect`.

#### {{ mmy-name }}

Добавлен флаг `--disk-size-autoscaling` в команду `yc managed-mysql cluster update`.

#### {{ mos-name }}

Добавлены команды для включения и выключения кластера:
* `yc managed-opensearch cluster start`
* `yc managed-opensearch cluster stop`

#### {{ network-load-balancer-name }}

Переименованы команды для начала и отмены блокировки зон балансировщика:
* `yc load-balancer network-load-balancer disable-zones`
* `yc load-balancer network-load-balancer enable-zones`

### Версия 0.153.0 (30.06.25) {#version0.153.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ cloud-desktop-name }}

В команде `desktops update group` изменен тип флага `--disk-size` для загрузочного (boot) и рабочего (data) дисков на `byteSize`.

### Версия 0.152.0 (25.06.25) {#version0.152.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ alb-name }} {#version-0.152-alb}

В командах `yc application-load-balancer load-balancer start-zonal-shift` и `yc application-load-balancer load-balancer cancel-zonal-shift` для старта и отмены Zonal Shift на балансировщике разрешено указывать список зон.

##### {{ cloud-desktop-name }} {#version-0.152-desktop}

* Добавлена команда `yc desktops group update` для обновления информации о группе рабочих столов.
* В команду `yc desktops group create` добавлены параметры `max-group-size`, `hot-standby`, `user-account-id`.

##### {{ network-load-balancer-name }} {#version-0.152-nlb}

Добавлены команды для старта и отмены блокировки зон балансировщика:
* `yc load-balancer network-load-balancer start-zonal-shift`
* `yc load-balancer network-load-balancer cancel-zonal-shift`

##### {{ metastore-full-name }} {#version-0.152-metastore}

Добавлены команды для управления кластерами {{ metastore-name }}:
* `yc managed-metastore cluster get`
* `yc managed-metastore cluster list`
* `yc managed-metastore cluster create`
* `yc managed-metastore cluster update`
* `yc managed-metastore cluster delete`
* `yc managed-metastore cluster start`
* `yc managed-metastore cluster stop`
* `yc managed-metastore cluster import-data`
* `yc managed-metastore cluster export-data`
* `yc managed-metastore cluster list-operations`

##### Сервисы управляемых баз данных {#version-0.152-managed-db}

**{{ mpg-name }}**

Устаревший аргумент `version` параметра `extension` в команде `postgresql database` больше не существует.

### Версия 0.151.0 (19.06.25) {#version0.151.0}

#### Изменения в сервисах {{ yandex-cloud }}

##### {{ alb-name }}

* Добавлено поле `regex_rewrite`, которое позволяет модифицировать параметры HTTP-запросов с помощью регулярных выражений на виртуальных хостах. Поддержка поля добавлена в следующие команды:
  * `yc application-load-balancer virtual-host append-http-route`
  * `yc application-load-balancer virtual-host prepend-http-route`
  * `yc application-load-balancer virtual-host insert-http-route`
  * `yc application-load-balancer virtual-host update-http-route`

##### {{ cloud-desktop-name }}

* Добавлена команда `yc desktops image update` для обновления информации об образе.
* Добавлена команда `yc desktops desktop update-properties` для обновления информации о рабочем столе.
* Добавлена команда `yc desktops desktop start` для запуска рабочего стола.
* Добавлена команда `yc desktops desktop stop` для остановки рабочего стола.
* Добавлена команда `yc desktops desktop update` для синхронизации рабочего стола с конфигурацией группы.
* Добавлена команда `yc desktops group update` для обновления группы рабочих столов.

##### {{ managed-k8s-name }}

* Добавлены команды для управления правами доступа к кластерам {{ managed-k8s-name }}:
  * `yc managed-kubernetes cluster list-access-bindings`
  * `yc managed-kubernetes cluster set-access-bindings`
  * `yc managed-kubernetes cluster add-access-binding`
  * `yc managed-kubernetes cluster remove-access-binding`

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлена команда `yc managed-clickhouse cluster update-external-dictionary`, позволяющая редактировать созданные в кластере словари.
* В команде `yc managed-clickhouse cluster list-logs` у параметра `--service-type` появилось новое возможное значение: `clickhouse-keeper`.

**{{ mkf-name }}**

* В параметре `--permission` у ключа `role` появились новые возможные значения: `topic_producer`, `topic_consumer`, `schema_reader`, `schema_writer`. Применимо к следующим командам:
  * `yc managed-kafka user create`
  * `yc managed-kafka user update`
  * `yc managed-kafka user grant-permission`
  * `yc managed-kafka user revoke-permission`

**{{ mtr-name }}**

* Добавлены команды для работы с каталогами {{ mtr-full-name }}:
  * `yc managed-trino catalog create`
  * `yc managed-trino catalog delete`
  * `yc managed-trino catalog get`  
  * `yc managed-trino catalog list`
  * `yc managed-trino catalog update`

### Версия 0.150.0 (02.06.25) {#version0.150.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ baremetal-name }}
* Добавлены группы команд для работы с сервисом {{ baremetal-name }}:
  * `yc baremetal boot-image`
  * `yc baremetal configuration`
  * `yc baremetal private-subnet`
  * `yc baremetal public-subnet`
  * `yc baremetal hardware-pool`
  * `yc baremetal server`
  * `yc baremetal vrf`
  * `yc baremetal zone`

##### {{ compute-name }}
* В команду `yc compute snapshot-schedule update` добавлены параметры `--snapshot-description` и `--snapshot-labels`, с помощью которых можно задать описание и метки снимкам дисков, создаваемым по расписанию.
* Добавлены команды для редактирования меток снимков дисков, создаваемых по расписанию:
  * `yc compute snapshot-schedule add-snapshot-labels`
  * `yc compute snapshot-schedule remove-snapshot-labels`

##### {{ dataproc-name }}
* В команду `yc dataproc cluster create` добавлен параметр `--oslogin` для включения доступа по OS Login на кластере.

##### {{ mgl-name }}
* Добавлены команды для управления инстансами {{ mgl-name }}:
  * `yc managed-gitlab instance get`
  * `yc managed-gitlab instance list`
  * `yc managed-gitlab instance create`
  * `yc managed-gitlab instance stop`
  * `yc managed-gitlab instance start`
  * `yc managed-gitlab instance delete`

##### {{ objstorage-name }}
* Добавлены команды для работы с ACL бакетов и объектов:
  * `yc storage s3api get-bucket-acl`
  * `yc storage s3api put-bucket-acl`
  * `yc storage s3api get-object-acl`
  * `yc storage s3api put-object-acl`

##### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**
* В командах `yc mysql users create` и `yc mysql users update` обновлено поведение параметра `--permissions`.

**{{ mtr-name }}**
* Добавлены команды для управления кластерами {{ mtr-name }}:
  * `yc managed-trino cluster get`
  * `yc managed-trino cluster list`
  * `yc managed-trino cluster create`
  * `yc managed-trino cluster update`
  * `yc managed-trino cluster delete`
  * `yc managed-trino cluster start`
  * `yc managed-trino cluster stop`
  * `yc managed-trino cluster list-operations`

### Версия 0.149.0 (20.05.25) {#version0.149.0}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.149.0-services}

##### {{ mkf-name }}

* В командах `yc kafka cluster create` и `yc kafka cluster update` удален параметр `--log-preallocate` для управления соответствующей настройкой брокера Apache Kafka.
* В командах `yc kafka topic create` и `yc kafka topic update` удален параметр `--preallocate` для управления соответствующей настройкой топика Apache Kafka.

##### {{ mch-name }}

Добавлены команды для управления расширениями:
* `yc managed-clickhouse extension list`
* `yc managed-clickhouse extension get`
* `yc managed-clickhouse cluster add-extension`
* `yc managed-clickhouse cluster update-extension`
* `yc managed-clickhouse cluster get-extension`
* `yc managed-clickhouse cluster list-extensions`
* `yc managed-clickhouse cluster remove-extension`

### Версия 0.148.0 (30.04.25) {#version0.148.0}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.148.0-services}

##### {{ compute-name }}

* В команде создания снапшотов по расписанию добавлена возможность задать описание и метки для снапшотов:
  
  ```bash
  yc compute snapshot-schedule create --snapshot-description --snapshot-labels
  ```

##### {{ iam-name }}
* Добавлена команда `yc iam whoami` для получения информации о своем аккаунте.

##### {{ mos-name }}

Исправлено сообщение об ошибке, которое появлялось после успешного окончания операции перезапуска кластера OpenSearch или смены мастера.

##### {{ mpg-name }}
Добавлены команды для управления пользователями в ресурсных группах в {{ GP }}:
  * `yc managed-greenplum user create`;
  * `yc managed-greenplum user get`;
  * `yc managed-greenplum user list`;
  * `yc managed-greenplum user update`;
  * `yc managed-greenplum`.

##### {{ er-name }}
* Добавлена команда `yc serverless eventrouter connector create event-service` для создания коннектора типа `event_service` для отправки сообщений в шину через gRPC.
* Добавлена команда `yc serverless eventrouter send-event` для отправки сообщений в шину через gRPC для коннектора типа `event_service`.

##### {{ objstorage-name }}

* Исправлена ошибка, при которой в некоторых случаях при выполнении команды `yc storage s3 cp` бакет считался пустым, и копирование не выполнялось.

* В конфигурацию CLI добавлены параметры для настройки команды `yc storage s3 cp`:
  * `s3.max-queue-size` — максимальное количество задач в очереди. Значение по умолчанию — `1000`.
  * `s3.max-concurrent-requests` — максимальное количество одновременных запросов. Значение по умолчанию — `10`.
  * `s3.multipart-threshold` — пороговый размер объекта, при превышении которого будет использоваться составная (multipart) загрузка.  Значение по умолчанию — `8MB`.
  * `s3.multipart-chunksize` — размер частей, на которые будет делиться объект при составной (multipart) загрузке. Значение по умолчанию — `8MB`.

   Чтобы задать эти параметры, используйте команду `yc config set <параметр> <значение>`.

##### {{ mpg-name }}

В команде `yc managed-greenplum cluster update` исправлена поддержка флага `--log-enabled` для {{ cloud-logging-name }}.

### Версия 0.147.0 (21.04.25) {#version0.147.0}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.147.0-services}

##### Сервисы управляемых баз данных {#managed-db}

* В команды `yc managed-kafka cluster create`, `yc managed-kafka cluster update` добавлен параметр `--rest-api-enabled` для включения REST API на кластере.

* В команде `yc managed-mysql cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием {{ connection-manager-full-name }}.

* В команде `yc managed-postgresql cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием {{ connection-manager-full-name }}.

* В команде `yc managed-clickhouse cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием {{ connection-manager-full-name }}.

* В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster restore` добавлен параметр `--shard`, позволяющий задать один или несколько шардов. Пример: `yc managed-clickhouse cluster create ... --shard name=shard1,weight=100 --shard name=shard2,weight=200 ...`

* В команде `yc managed-clickhouse shard add` поддержан повторяемый композитный параметр `--shard`:
  * Будет создано столько шардов, сколько раз встретился параметр `--shard`.
  * Для каждого шарда необходимо указать имя, также можно задать вес: `yc managed-clickhouse shard add --shard name=myshard,weight=200`.
  * Параметр `--shard` несовместим с параметрами `--name` и `--weight`, как и с заданием имени шарда через позиционный аргумент.

* Ускорено удаление нескольких шардов через `yc managed-clickhouse shards delete`.

* В команду `yc managed-clickhouse cluster add-external-dictionary` добавлены следующие параметры:
  * `--layout-allow-read-expired-keys `
  * `--layout-max-update-queue-size`
  * `--layout-update-queue-push-timeout-milliseconds`
  * `--layout-query-wait-timeout-milliseconds`
  * `--layout-max-threads-for-updates`
  * `--layout-initial-array-size`
  * `--layout-access-to-key-from-attributes`
  
##### {{ alb-name }} {#alb}

* Добавлены команды для работы c механизмом ручного переключения зоны доступности на балансировщике:
  * `yc application-load-balancer load-balancer start-zonal-shift`
  * `yc application-load-balancer load-balancer cancel-zonal-shift`

* Добавлен параметр `--allow-zonal-shift`, который размечает балансировщик как способный работать в режиме отказа одной зоны доступности:
  * `yc application-load-balancer load-balancer create`
  * `yc application-load-balancer load-balancer update`

##### {{ iam-name }} {#iam}

Добавлены команды для управления доступом к федерациям сервисных аккаунтов:
* `yc iam workload-identity oidc federation list-access-bindings`
* `yc iam workload-identity oidc federation set-access-bindings`
* `yc iam workload-identity oidc federation add-access-binding`
* `yc iam workload-identity oidc federation remove-access-binding`

##### {{ ydb-name }} {#ydb}

В команде `yc ydb database backup` поддержан аргумент storage-class для указания типа хранилища

##### {{ compute-name }} {#compute}

Добавлены команды для привязки инстансов к пулам зарезервированных ВМ.

##### {{ objstorage-name }} {#storage}

* Добавлена команда `yc storage s3 cp` для копирования объектов между файловой системой и объектным хранилищем или между бакетами объектного хранилища.
* Добавлена команда `yc storage s3 mv` для перемещения объектов между файловой системой и объектным хранилищем или между бакетами объектного хранилища.
* Добавлена команда `yc storage s3 rm` для удаления объектов в бакете.


### Версия 0.146.1 (03.04.25) {#version0.146.1}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.146.1-services}

##### {{ compute-name }} {#compute}

* Добавлены команды для управления пулами зарезервированных ВМ:
  * `yc compute reserved-instance-pool get`;
  * `yc compute reserved-instance-pool list`;
  * `yc compute reserved-instance-pool create`;
  * `yc compute reserved-instance-pool update`;
  * `yc compute reserved-instance-pool delete`.

### Версия 0.146.0 (02.04.25) {#version0.146.0}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.146.0-services}

##### {{ at-name }} {#audit-trails}

* В командах `yc audit-trails trail create` и `yc audit-trails trail update` больше не проверяются параметры `--filter-from-*`. В следующем релизе эти параметры будут удалены.

##### {{ interconnect-name }} {#interconnect}

* В команде `yc cic trunk-connection update` удалены параметры `--capacity` и `--pop`.
 
##### {{ iam-name }} {#iam}

* В команде `yc iam api-key create` параметр `--scope` помечен как **DEPRECATED**.

##### {{ objstorage-name }} {#storage}

* Добавлена команда `yc storage s3api list-objects` для получения списка объектов в бакете.

##### Сервисы управляемых баз данных {#managed-db}

* Добавлен флаг `--generate-password` для автоматической генерации пароля с использованием {{ connection-manager-name }} в команды:
  * `yc managed-clickhouse user create`, `yc managed-clickhouse user update`;
  * `yc managed-mysql user create`, `yc managed-mysql user update`;
  * `yc managed-postgresql user create`, `yc managed-postgresql user update`.

**{{ mkf-name }}**

* В командах `yc managed-kafka user create` и `yc managed-kafka user update` в параметре `--permission` для ключа `role` добавилось новое возможное значение `topic_admin`.

**{{ mgp-name }}**

* Для команды `yc managed-greenplum cluster create` исправлена версия по умолчанию с 6.19 на 6.25.

**{{ mos-name }}**

* Добавлена команда `yc managed-opensearch cluster restart-opensearch` для перезапуска сервиса на хосте, указанном в параметре `--host`.
* Добавлена команда `yc managed-opensearch cluster switch-master` для переключения текущего мастера.
  * В параметре `--from-hosts host,[host...]` можно указать список хостов, с которых должен быть переключен мастер. Если мастер уже не находится ни на одном из указанных хостов, никаких изменений не произойдет.
  * Если параметр `--from-hosts` отсутствует, мастер будет переключен с хоста, на котором он находится в данный момент.

**{{ ydb-name }}**

* В команды `yc ydb database create` и `yc ydb database update` добавлены параметры `--security-group-name` и `--security-group-id`.

### Версия 0.145.0 (18.03.25) {#version0.145.0}

#### Изменения в сервисах {{ yandex-cloud }} {#version0.145.0-services}

##### {{ mrd-name }} {#version0.145.0-mrd}

* В команды: `yc managed-redis cluster create`, `yc managed-redis cluster restore`,`yc managed-redis cluster update-config` добавлены параметры:
  * `activedefrag`;
  * `aof-max-size-percent`.

* Параметр `--persistence-mode` теперь может принимать значение `ON_REPLICAS` в командах:
  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.

##### {{ mos-name }} {#version0.145.0-mos}

* Добавлена поддержка типа дисков `local-ssd`.
* Добавлена возможность автоматического назначения подсетей при создании кластера или добавлении группы хостов.

##### {{ quota-manager-name }} {#version0.145.0-quota-manager}

* Добавлена группа команд `yc quota-manager quota-limit` для просмотра лимитов квот:
  * `yc quota-manager quota-limit get` — вывести значение определенной квоты;
  * `yc quota-manager quota-limit list` — вывести список квот для определенного сервиса;
  * `yc quota-manager quota-limit list-service` — вывести список сервисов, для которых есть квоты.

##### {{ interconnect-name }} {#version0.145.0-cic}

* Добавлены команды для управления TrunkConnection:
  * `yc cic trunk-connection create`;
  * `yc cic trunk-connection update`;
  * `yc cic trunk-connection delete`;
  * `yc cic trunk-connection add-labels`;
  * `yc cic trunk-connection remove-labels`;
  * `yc cic trunk-connection list-operations`.

* Добавлены команды для управления PrivateConnection:
  * `yc cic private-connection create`;
  * `yc cic private-connection update`;
  * `yc cic private-connection delete`;
  * `yc cic private-connection add-labels`;
  * `yc cic private-connection remove-labels`;
  * `yc cic private-connection upsert-static-route`;
  * `yc cic private-connection remove-static-route`;
  * `yc cic private-connection list-operations`.

##### {{ cr-name }} {#version0.145.0-cloudrouter}

* Добавлены команды для управления RoutingInstance:
  * `yc cloudrouter routing-instance create`;
  * `yc cloudrouter routing-instance update`;
  * `yc cloudrouter routing-instance delete`;
  * `yc cloudrouter routing-instance add-labels`;
  * `yc cloudrouter routing-instance remove-labels`;
  * `yc cloudrouter routing-instance upsert-prefixes`;
  * `yc cloudrouter routing-instance remove-prefixes`;
  * `yc cloudrouter routing-instance add-private-connection`;
  * `yc cloudrouter routing-instance remove-private-connection`;
  * `yc cloudrouter routing-instance list-operations`.

##### {{ network-load-balancer-name }} {#version0.145.0-nlb}

* Для команды `yc network-load-balancer update` исправлена ошибка в обработчике флага `--allow-zonal-shift`.

### Версия 0.144.0 (27.02.25) {#version0.144.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ mrd-name }}

* Добавлены команды для вывода, чтения, создания, редактирования и удаления пользователей:
  * `yc managed-redis user list`;
  * `yc managed-redis user get`;
  * `yc managed-redis user create`;
  * `yc managed-redis user update`;
  * `yc managed-redis user delete`.

* Параметр `--auth-sentinel`, который позволяет авторизоваться в {{ RD }} Sentinel, добавлен в команды:

  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.

* Параметр `--user`, который позволяет добавить пользователей в {{ RD }}, добавлен в команду `yc managed-redis cluster create`.

* Параметр `--zset-max-listpack-values` добавлен в команды:
  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update-config`.

##### {{ resmgr-name }} {#resmgr}

* В команду `yc resource-manager cloud create` добавлен опциональный параметр `--organization-id`.

##### {{ backup-name }} {#backup}

* Добавлена команда `backup backup batch-delete` для удаления всех бэкапов в архиве и удаления самого архива. Архив можно указать параметром `--archive-id` или параметрами `--instance-id` и `--policy-id`.

##### {{ yc-mdb-gp }}

* Для команды `yc managed-greenplum cluster update-config` изменен список поддерживаемых версий Greenplum®:

  * удалена поддержка версий 6.17 и 6.19;
  * добавлена поддержка версии 6.25+.

* Для команд `yc managed-greenplum cluster create/update/restore` добавлен параметр `--service-account`. Параметр позволяет указать сервисный аккаунт для доступа к ресурсам {{ yandex-cloud }} в пользовательском облаке. Например, к {{ cloud-logging-name }}.

* Для команд `yc managed-greenplum cluster create/update` добавлены параметры:

  * `--log-enabled` — включить поставку логов в {{ cloud-logging-name }};
  * `--log-folder-id <folder_id>` и `--log-group-id <log_group_id>` — указать каталог и группу для поставки логов в {{ cloud-logging-name }};
  * `--log-command-center-enabled` — включить поставку логов из Command Center;
  * `--log-greenplum-enabled` — включить поставку логов из Greenplum®;
  * `--log-pooler-enabled` — включить поставку логов из пулера Odyssey®.

##### {{ network-load-balancer-name }}

* Для команд `yc network-load-balancer create/update` добавлен параметр `--allow-zonal-shift`, который позволяет балансировщику работать в режиме отказа одной зоны доступности (AZ).

### Версия 0.143.0 (11.02.25) {#version0.143.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ objstorage-name }}

* В команду `yc storage bucket update` добавлен параметр для указания [сервисного подключения](../vpc/concepts/private-endpoint.md) {{ vpc-full-name }}, из которого будет разрешен доступ в бакет:
  * `--private-endpoint`, пример: `--enable-private-endpoints true --private-endpoints cba,abc`.

### Версия 0.142.0 (30.01.25) {#version0.142.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ dataproc-name }} {#dataproc}

* В команду `yc dataproc cluster create` добавлен параметр `--environment` для указания окружения, пример: `--environment prestable`.

##### {{ iam-name }} {#iam}

* Добавлена команда `yc iam refresh-token list` для вывода refresh-токенов.
* Добавлена команда `yc iam refresh-token revoke` для отзыва refresh-токенов.

##### {{ objstorage-name }} {#storage}

* Добавлены команды для чтения, изменения и удаления меток объекта:
  * `yc storage s3api get-object-tagging`;
  * `yc storage s3api put-object-tagging`;
  * `yc storage s3api delete-object-tagging`.
 
##### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* В команды `yc managed-mongodb cluster create`, `yc managed-mongodb cluster restore` и `yc managed-mongodb cluster update` добавлен параметр `--websql-access`, который позволяет настроить доступ в {{ MG }} через {{ websql-name }}.

* В команду `yc managed-mongodb cluster restore` добавлены опции, необходимые для восстановления шардированного кластера {{ MG }}.

**{{ mrd-name }}**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore`, `yc managed-redis cluster update-config` добавлен параметр `--backup-retain-period-days`.

### Версия 0.141.0 (16.12.24) {#version0.141.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ sf-name }} {#serverless-functions}

В команду `yc serverless function version create` добавлен параметр `--metadata-options` для указания опций получения метаданных в функции. Пример использования: 

```bash
yc serverless function version create --metadata-options aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled
```

##### {{ serverless-containers-name }} {#serverless-containers}

В команду `yc serverless container revision deploy` добавлен параметр `--metadata-options` для указания опций получения метаданных в
контейнере. Пример использования: 

```bash
yc serverless container revision deploy --metadata-options aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled
```

##### {{ iam-name }}

В команду `yc iam api-key create` добавлен опциональный параметр `--scopes` для указания области действия API-ключа. Если параметр не задан, ключ создается без ограничений. 

Параметр `--scope` будет удален в следующий версии YC CLI.

* Добавлена команда `yc iam api-key update` для редактирования API-ключа. У команды есть следующие параметры:
  * `--description` для изменения описания API-ключа.
  * `--scopes` для изменения областей действия API-ключа.
  * `--expires_at` для изменения срока действия ключа. Если параметр не задан, API-ключ не имеет срока действия.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

В команду `yc managed-greenplum cluster create` добавлен параметр `--cloud-storage`, который позволяет указать параметры работы с облачным хранилищем. Пример включения облачного хранилища: 

```bash 
yc managed-greenplum cluster create --cloud-storage enabled=true
```

### Версия 0.140.0 (29.11.24) {#version0.140.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ alb-name }} {#alb}

* В команды `yc alb backend-group add-http-backend` и `yc alb backend-group update-http-backend` для параметра `--http-healthcheck` добавлено свойство `--expected-statuses`. Оно позволяет указать собственные коды HTTP-статусов, которые будут считаться корректными при проверках состояния бэкенда (HealthCheck).

##### {{ cloud-desktop-name }} {#cloud-desktop}

* В команду `yc desktops desktop create` добавлен параметр `subnet-id`.

##### {{ cloud-registry-name }} {#cloud-registry}

* Добавлены команды `yc cloud-registry artifact get` и `yc cloud-registry artifact delete`, позволяющие управлять артефактами.
* Добавлены команды для управления реестрами: `yc cloud-registry registry [ get | list | create | update | delete | add-labels | remove-labels | list-access-bindings | set-access-bindings | add-access-bindings | remove-access-bindings | list-ip-permissions | set-ip-permissions | add-ip-permissions | remove-ip-permissions ]`.

##### {{ data-transfer-name }} {#data-transfer}

* В команду `yc datatransfer endpoint create <endpoint_type>` для эндпоинтов `postgres-target`, `clickhouse-target`, `mysql-target` и `mongo-target` добавлен параметр `--cleanup-policy`, который позволяет задавать политики очистки приемника при активации и переактивации трансфера (`drop`, `truncate` или `disabled`).

##### {{ iot-name }} {#iot}

* В текстовый формат команд `iot registry list` и `iot device list` добавлена колонка STATUS.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore` и `yc managed-redis cluster update-config` добавлены параметры:
  * `use-luajit`;
  * `io-threads-allowed`.

### Версия 0.139.0 (18.11.24) {#version0.139.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ cloud-desktop-name }} {#cloud-desktop}

* В команду `yc desktops desktop` добавлен параметр `user-account-id`. Удален праметр `subject`.
* Добавлена команда `yc desktops image` для управления образами рабочих столов.

##### {{ container-registry-name }} {#container-registry}

* Исправлена регрессия в Docker Credential helper, приводившая к невозможности выбора профиля не по умолчанию.

##### {{ compute-name }} {#compute}

* В команды `yc compute disk create` и `yc compute instance create` добавлены параметры `kms-key-id` и `kms-key-name` для поддержки шифрования дисков.

##### {{ serverless-containers-name }} {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлен параметр `--runtime`, позволяющий задать режим работы контейнера (`http` или `task`).

### Версия 0.138.0 (06.11.24) {#version0.138.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }} {#compute}

* Команда `yc compute connect-to-serial-port` теперь явно проверяет наличие флагов `serial-port-enable` и `enable-oslogin` в метаданных инстанса.

##### {{ interconnect-name }} {#interconnect}

* Команды `yc cic point-of-presence get` и `yc cic partner get` теперь работают только с ID без параметров.
* Для `trunk-connection`, `private-connection` и `public-connection` в {{ interconnect-name }} и для `routing-instance` в Cloud Router исправлен формат результата команды `list` — удалена часть полей и преобразованы форматы отображения.

### Версия 0.137.0 (01.11.24) {#version0.137.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ interconnect-name }} {#interconnect}

* Исправлена работа команд `get` без параметров в {{ interconnect-name }} и Cloud Router.
* Исправлен формат результатов команд `list` в {{ interconnect-name }} и Cloud Router — теперь возвращается таблица.

##### {{ objstorage-name }} {#object-storage}

* Добавлены команды `yc storage s3api get-object-retention` и `yc storage s3api put-object-retention` для чтения и изменения временной блокировки объекта.
* Добавлены команды `yc storage s3api get-object-legal-hold` и `yc storage s3api put-object-legal-hold` для чтения и изменения бессрочной блокировки объекта.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `17` для параметра `--postgresql-version string`. Оно позволяет создать кластер {{ PG }} версии 17.

### Версия 0.136.0 (21.10.24) {#version0.136.0}

#### Изменения в CLI {#cli}

* В команде `yc init` теперь не предлагается зона `ru-central1-c`, поскольку она больше не используется.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ alb-name }} {#alb}

* В команды `yc application-load-balancer load-balancer add-stream-listener`, `yc application-load-balancer load-balancer update-stream-listener`, `yc application-load-balancer load-balancer add-stream-sni`, `yc application-load-balancer load-balancer update-stream-sni` добавлен параметр `--idle-timeout`, позволяющий указать таймаут неактивности соединения. 

##### {{ er-name }} {#eventrouter}

* Дополнена валидация параметров для команды `yc serverless eventrouter`.
* Исправлена ошибка при работе команды `yc serverless eventrouter put-event`.

##### {{ objstorage-name }} {#object-storage}

* Добавлена возможность проставить `--storage-endpoint` с помощью `yc config set`. Если пользователь не указал явно `--storage-endpoint`, то эндпоинт будет получен из `ApiEndpointService`.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* В команды: `yc managed-redis cluster create`, `yc managed-redis cluster restore`, `yc managed-redis cluster update-config` добавлены параметры:
  * `--lua-time-limit`,
  * `--repl-backlog-size-percent`,
  * `--cluster-require-full-coverage`,
  * `--cluster-allow-reads-when-down`,
  * `--cluster-allow-pubsubshard-when-down`,
  * `--lfu-decay-time`,
  * `--lfu-log-factor`,
  * `--turn-before-switchover`,
  * `--allow-data-loss`.

**{{ yc-mdb-mg }}, {{ yc-mdb-ch }}, {{ yc-mdb-gp }}, {{ yc-mdb-pg }}, {{ yc-mdb-rd }}, {{ yc-mdb-my }}, {{ yc-mdb-kf }}, {{ yc-mdb-es }}, {{ yc-mdb-os }}**

* Уточнено описание параметров `--disk-size`, по умолчанию размер диска передается в ГБ.

### Версия 0.135.0 (07.10.24) {#version0.135.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* Добавлены команды для работы с продуктами {{ marketplace-name }} в кластере {{ managed-k8s-name }}: 
   * `yc managed-kubernetes marketplace helm-release install` — установка Helm-чарта продукта {{ marketplace-name }} в указанный кластер {{ managed-k8s-name }}.
   * `yc managed-kubernetes marketplace helm-release update` — обновление версии Helm-чарта продукта {{ marketplace-name }}.
   * `yc managed-kubernetes marketplace helm-release uninstall` — удаление версии Helm-чарта продукта {{ marketplace-name }}.
   * `yc managed-kubernetes marketplace helm-release get` — получение информации о Helm-чарте продукта {{ marketplace-name }}.
   * `yc managed-kubernetes marketplace helm-release list` — получение списка Helm-чартов {{ marketplace-name }}, установленных в кластере {{ managed-k8s-name }}.

##### {{load-testing-name}}

* В команду `yc loadtesting agent create` добавлены параметры `log-group-id` и `log-group-name` для указания целевой лог-группы для отправки логов агента нагрузочного тестирования.

### Версия 0.134.0 (02.10.24) {#version0.134.0}

#### Изменения в CLI {#cli}

* Добавлен глобальный параметр `--jq`. Используется для фильтрации и преобразования вывода при помощи jq-шаблонов. Примеры:
  * `yc iam role list --jq '.[].id'`
  * `ID="instance_id" yc compute instance list --jq '.[] | select(.id == env.ID)'`

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ objstorage-name }} {#storage}

* Добавлена базовая поддержка операций с объектами через S3 API:
  * `yc storage s3api get-object` — получение объекта из бакета.
  * `yc storage s3api put-object` — загрузка объекта в бакет.
  * `yc storage s3api delete-object` — удаление объекта.
  * `yc storage s3api copy-object` — копирование существующего в бакете объекта.
  * `yc storage s3api head-object` — получение метаданных объекта.
  * `yc storage s3api delete-objects` — удаление группы объектов.

  Чтобы работать с объектами, укажите в конфигурационном файле CLI `~/.config/yandex-cloud/config.yaml` эндпоинт {{ objstorage-name }}:

  ```yaml
  ...
  profiles:
    default:
      ...
      storage-endpoint: https://{{ s3-storage-host }}/
  ```

##### {{ interconnect-name }} {#interconnect}

* Добавлены команды `yc cic point-of-presence get` и `yc cic point-of-presence list` для чтения точек присутствия.
* Добавлены команды `yc cic partner get` и `yc cic partner list` для чтения партнеров {{ interconnect-name }}.
* Добавлены команды `yc cic trunk-connection get` и `yc cic trunk-connection list` для чтения транковых подключений.
* Добавлены команды `yc cic private-connection get` и `yc cic private-connection list` для чтения приватных соединений.
* Добавлены команды `yc cic public-connection get` и `yc cic public-connection list` для чтения публичных соединений.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* В команду `yc desktops group create` добавлен параметр `--image-id`, который позволяет передать идентификатор образа для группы рабочих столов. 

##### {{ backup-name }} {#backup}

* Добавлены следующие команды:
  * `yc backup agent install` — для установки [агента {{ backup-name }}](../backup/concepts/agent.md) и подключения ВМ с установленным {{ oslogin }} к {{ backup-name }}.
  * `yc backup agent reinstall` — для повторной установки агента {{ backup-name }} для ВМ с установленным {{ oslogin }}.
  * `yc backup agent debug-info` — для получения логов установки агента {{ backup-name }} для ВМ с установленным {{ oslogin }}.
  * `yc backup provider activate` — для активации сервиса и подключения к провайдеру резервного копирования.

* При выполнении команд теперь проверяется, активирован ли сервис {{ backup-name }} в каталоге.

##### {{ si-name }} {#serverless-integrations}

* Добавлена поддержка {{ er-full-name }}.

##### {{ iam-name }} {#iam}

* Изменен заголовок в табличном выводе команды `yc iam service accounts list`.

##### {{ org-full-name }} {#organization}

* В вывод команды `yc organization-manager user list --organization-id` добавлено время последней аутентификации пользователя.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* В командах `yc managed-greenplum cluster create` и `yc managed-greenplum cluster restore` добавлена поддержка опций `--master-host-group-ids` и `--segment-host-group-ids` для указания, на какие группы выделенных хостов размещать хосты мастера и сегментов {{ GP }}.

**Managed Service for Redis**

* Добавлена команда `yc managed-redis backup delete` для удаления бэкапов.
* Изменена версия {{ RD }} по умолчанию на 7.2 в связи с окончанием поддержки 6.2 и 7.0.

**{{ mkf-name }}**

* В командах `yc managed-kafka cluster create`, `yc managed-kafka cluster update`, `yc managed-kafka cluster grant-permission`, `yc managed-kafka cluster revoke-permission` расширен параметр `--permission`. Его значение задается в формате `key=value,...`, в качестве `key` теперь можно использовать `allow_host` — хост, с которого действует данное правило для пользователя.

**{{ maf-name }}**

* Исправление ошибок и улучшения работы сервиса {{ maf-name }}.

### Версия 0.133.0 (09.09.24) {#version0.133.0}

#### Изменения в CLI {#cli}

* Исправлена ошибка, приводившая к подмене реальных сообщений об ошибке текстом `ERROR: Failed to retrieve data`. Затронутые проблемой версии: 0.131.0–0.132.1.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ at-name }} {#audit-trails}

* Команды для управления трейлами теперь используют поле `filtering_policy` вместо `filter`. Устаревшее поле все еще может быть доступно с помощью опции `--file` для описания запросов.

##### {{ compute-name }} {#compute}

* В командах `yc compute instance get`, `yc compute image get`, `yc compute disk get` и `yc compute snapshot get` добавлено отображение свойства `hardware_generation`.
* В командах `yc compute image create`, `yc compute disk create` и `yc compute snapshot create` добавлены параметры `--hardware-generation-id` и `--hardware-features`.

##### Сервисы управляемых баз данных {#managed-db}

* Добавлена возможность изменить сеть кластера с помощью параметров `--network-id` и `--network-name` в следующих командах:
  * `yc managed-mongodb cluster update`;
  * `yc managed-clickhouse cluster update`;
  * `yc managed-greenplum cluster update`;
  * `yc managed-postgresql cluster update`;
  * `yc managed-redis cluster update`;
  * `yc managed-mysql cluster update`;
  * `yc managed-kafka cluster update`;
  * `yc managed-elasticsearch cluster update`;
  * `yc managed-opensearch cluster update`.

**{{ mch-name }}**

* Добавлены команды `yc managed-clickhouse cluster [ clear-query-masking-rules | set-query-masking-rules ]` для работы с опцией `query_masking_rules` в {{ CH }}, позволяющей создавать правила для запросов с целью устранения утечки конфиденциальной информации.
* Для команды `yc managed-clickhouse cluster add-external-dictionary` добавлены параметры:
  * `--layout-max-array-size` — определение максимального количества ключей словаря.
  * `--http-header` — добавление HTTP-заголовков у HTTP-источников внешних словарей.
* Для команды `yc managed-clickhouse cluster add-external-dictionary --clickhouse-source` добавлен параметр `--secure` для включения SSL в соединениях.
* Для команды `yc managed-clickhouse cluster add-external-dictionary --mysql-source` добавлены параметры:
  * `--close-connection` — закрытие соединения после каждого запроса.
  * `--share-connection` — возможность использования соединения несколькими запросами.

**Managed Service for Redis**

* В команды `yc managed-redis cluster [ create | update | restore ]` добавлен параметр `--websql-access`, который позволяет установить в {{ RD }} доступ через {{ websql-name }}.

**{{ mgp-name }}**

* В команды `yc managed-greenplum cluster [ create | update | restore ]` добавлен параметр `--yandexquery-access`, разрешающий доступ к кластеру из сервиса {{ yq-full-name }}.
* В команды `yc managed-greenplum cluster [ create | update ]` добавлены параметры `--analyze-and-vacuum`, `--query-killer-idle`, `--query-killer-idle-in-transaction` и `--query-killer-long-running`, позволяющие управлять фоновыми процессами {{ mgp-name }}.

**{{ maf-name }}**

* Добавлены команды для работы с сервисом {{ maf-name }}: `yc managed-airflow cluster [ get | list | delete | list-operations | start | stop | create | update ]`.

### Версия 0.132.1 (28.08.24) {#version0.132.1}

#### Изменения в CLI {#cli}

* Исправлены ошибки в документации флага `--help`.

### Версия 0.132.0 (26.08.24) {#version0.132.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ iam-name }} {#iam}

* Добавлена команда `yc iam revoke-token` для отзыва скомпрометированных токенов.
* Добавлена команда `yc iam api-key list-scopes` для получения списка областей действия, доступных при создании API-ключей.

##### {{ sf-name }} {#cloud-functions}

* В команду `yc serverless function version create` добавлен параметр `--mount` для указания монтируемых ресурсов, таких как бакеты {{ objstorage-name }} и эфемерные диски.
* В команде `yc serverless function version create` параметр `--storage-mounts` помечен как `deprecated`.

##### {{ serverless-containers-name }} {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлен параметр `--mount` для указания монтируемых ресурсов, таких как бакеты {{ objstorage-name }} и эфемерные диски.
* В команде `yc serverless container revision deploy` параметр `--storage-mounts` помечен как `deprecated`.

##### {{ backup-name }} {#backup}

* Добавлен параметр `--type` в команду `backup vm list` для указания типа ресурсов, которые должны возвращаться в списке.

##### {{ vpc-name }} {#vpc}

* Добавлена группа команд `yc vpc private-endpoint` для управления ресурсами VPC Private Endpoint.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* В команды `yc managed-mongodb cluster create` и `yc managed-mongodb cluster update` добавлен параметр `--disk-size-autoscaling` для включения автоматического масштабирования диска.

**Managed Service for Redis**

* В командах `yc managed-redis cluster create` и `yc managed-redis cluster update` для `--disk-size-autoscaling` изменены единицы измерения `disk-size-limit` с байт на гигабайты.

### Версия 0.131.1 (15.08.24) {#version0.131.1}

#### Изменения в CLI {#cli}

* Исправлена проблема в обработке некоторых ошибок, из-за которой в тексте ошибки символ `_` заменялся на `-`.

### Версия 0.131.0 (14.08.24) {#version0.131.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ backup-name }} {#backup}

* Добавлена команда `backup policy execute` для создания резервной копии виртуальной машины согласно указанной политике резервного копирования.

##### {{ iam-name }} {#iam}

* В команды `add-access-binding` и `remove-access-binding` добавлена поддержка опции `--agent`.
* Добавлено дерево команд `yc iam workload-identity` для управления федерацией удостоверений рабочей нагрузки.
* Команды `yc iam service-account list` и `yc iam service-account get` теперь показывают время последней аутентификации сервисного аккаунта.

##### {{ container-registry-name }} {#container-registry}

* В команду `yc container registry create` добавлена опция `--secure` для создания реестра с настройками безопасности.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* Добавлена команда `yc managed-greenplum cluster move` для перемещения кластера в другой каталог.

### Версия 0.130.0 (01.08.24) {#version0.130.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ data-transfer-name }}

* В команду `yc datatransfer endpoint create clickhouse-source` добавлен параметр `--cluster-name`, позволяющий указать имя ClickHouse-кластера для переноса данных.

##### {{ marketplace-name }}

* Добавлена команда `yc marketplace reset-password`, ошибочно не попавшая в прошлый релиз.

##### {{ iam-name }} {#iam}

* Из дерева команд `yc iam service-control` удалены команды `pause` и `resume`.

##### {{ compute-name }}

* В команду `yc compute host-group list-instances` добавлен параметр `--host-id`, позволяющий указать ID хоста в группе хостов для листинга виртуальных машин.

##### {{ load-testing-name }}

* В команду `yc loadtesting agent create` добавлена возможность ожидания подключения созданного агента к сервису {{ load-testing-name }}:
  * флаг `--wait-ready` — не завершать команду, пока агент не перейдет в статус `READY FOR TEST`;
  * параметр `--wait-ready-timeout` — максимальное время ожидания для `--wait-ready` (default: 5m).

#### Изменения в CLI {#cli}

* Протокол авторизации федеративных аккаунтов изменен на Authorization Code Flow с Proof Key for Code Exchange (PKCE).

### Версия 0.129.0 (16.07.24) {#version0.129.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ load-testing-name }}

* В команде `yc loadtesting test get-report-table` исправлена ошибка для тестов без табличного отчета.

##### {{ captcha-name }}

Добавлена поддержка сервиса {{ captcha-name }}:

* Команды группы `yc smartcaptcha captcha` позволяют управлять капчами.

##### {{ sws-name }}

Добавлена поддержка сервиса {{ sws-name }}:

* Команды группы `yc smartwebsecurity security-profile` позволяют управлять профилями безопасности.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* В команды `yc managed-redis cluster create` и `yc managed-redis cluster update` добавлен параметр `--disk-size-autoscaling` для включения автоматического масштабирования диска.

**{{ mch-name }}**

* Добавлены команды для управления правами `yc managed-kafka user grant-permission` и `yc managed-kafka user revoke-permission`.
* Добавлены команды `{{ yc-mdb-ch }} hosts add` и `{{ yc-mdb-ch }} shards add`. Параметр `copy-schema` включен по умолчанию.
* Добавлена команда для удаления бэкапа `yc managed-clickhouse backup delete`.
* В команду `yc managed-kafka cluster update` добавлен параметр `--disk-type`.
* Добавлен параметр `--backup-retain-period-days` для настройки периода хранения автоматических бэкапов.

##### {{ marketplace-name }} {#marketplace}

* Добавлена команда `yc marketplace reset-password` для сброса пароля на виртуальных машинах с установленным агентом для сброса паролей.


### Версия 0.128.0 (02.07.24) {#version0.128.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ api-gw-name }} {#api-gw}

В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлен параметр `--execution-timeout` для указания тайм-аута на максимальное время обработки запроса к API-шлюзу.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлен параметр `--convert-tables-to-replicated` для конвертации таблиц в реплицируемые при добавлении в кластер {{ ZK }}.

**{{ mgp-name }}**

* В команду `yc managed-greenplum cluster expand` добавлены опции `delay-redistribution`, `parallel`, `close-cluster`.

### Версия 0.127.0 (17.06.24) {#version0.127.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ iam-name }} {#iam}

* Добавлены команды для управления метками `yc iam service-account add-labels` и `yc iam service-account remove-labels`.
* В команды `yc iam service-account create` и `yc iam service-account update` добавлен параметр `--labels` — он задает набор меток для БД.

##### {{ org-full-name }} {#organization}

* Добавлены команды для управления метками:
  * `yc organization-manager organization add-labels`,
  * `yc organization-manager organization remove-labels`,
  * `yc organization-manager federation saml add-labels`,
  * `yc organization-manager federation saml remove-labels`.
* В следующие команды добавлен параметр `--labels`, чтобы задавать набор меток для БД:
  * `yc organization-manager organization update`,
  * `yc organization-manager federation saml create`,
  * `yc organization-manager federation saml update`.

#### Сервисы управляемых баз данных {#managed-db}

* В команду `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлена возможность задать параметры для конфигурации `disk-size-autoscaling`.

##### {{ resmgr-name }} {#resmgr}

* Добавлены команды для управления метками `yc resource-manager cloud add-labels` и `yc resource-manager cloud remove-labels`.
* В команду `yc resource-manager cloud update` добавлен параметр `--labels` — он задает набор меток для БД.

##### {{ iot-name }} {#iot}

* Добавлены команды для включения и выключения реестров `yc iot registry enable` и `yc iot registry disable`.

##### {{ sf-name }} {#cloud-functions}

* Для команды `yc serverless function version create` добавлен новый параметр `concurrency`.

### Версия 0.126.0 (04.06.24) {#version0.126.0}

#### Изменения в CLI {#cli}

* В профиль добавлено поле `region`, предназначенное для работы с различными регионами.
* В команду `init` добавлен параметр `--region`, предназначенный для инициализации CLI с определенным регионом.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ resmgr-name }} {#resmgr}

* Добавлена команда `yc resource-manager cloud create` для создания облака.
   * Параметр `--billing-account-id` позволяет автоматически привязать созданное облако к платежному аккаунту.
* Добавлена команда `yc resource-manager cloud delete` для удаления облака.
   * Параметр `--delete-after` позволяет удалить облако через указанное время.
* В команду `yc resource-manager folder delete` добавлен параметр `--delete-after` для отложенного удаления через указанное время.

##### {{ load-testing-name }} {#load-testing}

* В команду `yc loadtesting agent create` добавлен параметр `--platform-id` для создания виртуальной машины на указанной платформе.
* В команду `yc loadtesting test create` добавлены параметры для управления выгрузкой артефактов агента в {{ objstorage-name }}:
  * `--artifacts-output-bucket` для указания имени бакета, в который будут выгружаться артефакты.
  * `--artifacts-make-archive` для определения того, будут ли артефакты выгружаться одним архивом или по отдельности.
  * `--artifacts` для указания конкретных файлов, которые будут выгружены.

##### {{ mos-name }} {#mos}

* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster restore` добавлен опциональный параметр `--keystore-settings`, который позволяет задать содержимое {{ OS }} keystore.
* В команду `yc managed-opensearch cluster update` добавлены опциональные параметры `--set-keystore-settings` и `--remove-keystore-settings`:
   * `--set-keystore-settings` для указания списка записей, которые будут добавлены или заменены. Записи в keystore, которые не указаны в этом параметре, останутся без изменений.
   * `--remove-keystore-settings` для указания списка записей, которые должны быть удалены из keystore.

##### {{ sf-name }} {#cloud-functions}

* В команде `yc serverless function allow-unauthenticated-invoke` устаревшая роль `serverless.functions.invoker` заменена на новую `functions.functionInvoker`.
* Команда `yc serverless function deny-unauthenticated-invoke` теперь удаляет устаревшую роль `serverless.functions.invoker` и новую роль `functions.functionInvoker`.

##### {{ serverless-containers-name }} {#serverless-containers}

* В команде `yc serverless container allow-unauthenticated-invoke` устаревшая роль `serverless.containers.invoker` заменена на новую `serverless-containers.containerInvoker`.
* Команда `yc serverless container deny-unauthenticated-invoke` теперь удаляет устаревшую роль `serverless.containers.invoker` и новую роль `serverless-containers.containerInvoker`.

### Версия 0.125.0 (20.05.24) {#version0.125.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }}
* В команду `yc compute ssh` добавлен флаг `--public-address` для подключения к ВМ по SSH, с использованием только публичного адреса.
* По умолчанию команда `yc compute ssh` будет устанавливать соединение с ВМ через публичный адрес. Если у ВМ нет публичного адреса, то соединение будет устанавливаться через внутренний адрес.

##### {{ iam-name }}

* В команду `yc iam api-key create` добавлены опциональные параметры `--scope` и `--expires_at`:
  * `--scope` — для указания области действия API-ключа — сервисов, в которых его можно использовать. Если параметр не задан, то область действия ключа не ограничена.
  * `--expires_at` — для указания срока действия API-ключа. Если параметр не задан, то ключ не имеет срока действия.

##### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless trigger create`.

  Параметры `--gateway-name`, `--gateway-id` и `--gateway-websocket-broadcast-path` позволяют указать для триггера параметры рассылки сообщений в веб-сокетные соединения {{ api-gw-name }}.

##### {{ org-full-name }} {#organization}

* Добавлена группа команд `yc organization-manager oslogin profile` для управления пользовательскими профилями {{ oslogin }}.
* В командах `yc organization-manager oslogin user-ssh-key create` и `yc organization-manager oslogin user-ssh-key update` исправлен параметр `--expires-at` при указании значения в виде интервала. Например, значение `5h` теперь отсылает к значению в будущем.

### Версия 0.124.0 (22.04.24) {#version0.124.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* Добавлено дерево команд `yc managed-greenplum hba-rules` с командами `get`, `list`, `delete`, `create` и `update`.

**{{ mch-name }}**

* Параметр `--shard-name` команды `yc managed-clickhouse cluster create` помечен как устаревший (deprecated). Рекомендуется использовать аргумент `shard-name` параметра `--host`.

### Версия 0.123.0 (08.04.24) {#version0.123.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Для параметра `--host` команды `yc managed-clickhouse cluster restore` добавлен опциональный аргумент `shard-name`.

**{{ mmg-name }}**

* В команду `yc managed-mongodb hosts add --host` добавлены параметры `hidden`, `priority` и `secondary-delay-secs`.
* Добавлена новая команда `yc managed-mongodb hosts update` для модификации параметров `hidden`, `priority` и `secondary-delay-secs`.

##### {{ sf-name }} {#serverless-functions}

* Изменены лимиты батчинга для команды `yc serverless trigger create`.

##### {{ backup-name }} {#backup}

* В вывод результата команды `backup resource list-tasks` добавлено поле `RESULT CODE`, отображающее код завершения операции с ВМ.

#### Изменения в CLI {#cli}

* В документацию и установочный скрипт внесены исправления, помогающие настроить автодополнение для `yc` в дистрибутивах Linux, основанных на CentOS.

### Версия 0.122.0 (27.03.24) {#version0.122.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ sf-name }} {#serverless-functions}

* В команду `yc serverless function version create` добавлен параметр `--tmpfs-size` для монтирования директории `/tmp` из памяти при выделении функции 1 ГБ памяти или больше.
* Удалена команда `yc serverless trigger create cloud-logs`.

##### {{ data-transfer-name }}

Добавлены следующие команды для создания и изменения эндпоинтов {{ yds-full-name }}:
* `yc datatransfer endpoint create yds-source`;
* `yc datatransfer endpoint create yds-target`;
* `yc datatransfer endpoint update yds-source`;
* `yc datatransfer endpoint update yds-target`.

##### {{ dns-name }} {#dns}

В следующие команды добавлен параметр `--deletion-protection` для защиты зоны DNS от случайного удаления:
* `yc dns zone create`;
* `yc dns zone update`.

##### {{ compute-name }}

* Добавлена команда `yc compute instance attach-network-interface` для добавления сетевого интерфейса в уже существующую ВМ.
* Добавлена команда `yc compute instance detach-network-interface` для удаления сетевого интерфейса из уже существующей ВМ.

### Версия 0.121.0 (12.03.24) {#version0.121.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ mgp-name }} {#mgp}

* Добавлено дерево команд `yc managed-greenplum pxf-datasource` с командами `get`, `list`, `delete`.
* Добавлены деревья команд `yc managed-greenplum pxf-datasource s3` и `yc managed-greenplum pxf-datasource jdbc` с командами `create` и `update`.
* Добавлены параметры `--pxf-connection-timeout`, `--pxf-upload-timeout`, `--pxf-max-threads`, `--pxf-pool-allow-core-thread-timeout`, `--pxf-poll-core-size`, `--pxf-pool-queue-capacity`, `--pxf-pool-max-size`, `--pxf-xmx`, `--pxf-xms` для команды `yc managed-greenplum cluster update`.

##### {{ org-full-name }} {#organization}

* Добавлена группа команд `yc organization-manager oslogin` для управления настройками {{ oslogin }} и пользовательскими SSH-ключами.

##### {{ container-registry-name }} {#container-registry}

* Добавлены поля `origin` и `type` в результат `yc container image list-vulnerabilities`.

##### {{ load-testing-name }} {#load-testing}

* Добавлена команда `yc loadtesting test wait` для ожидания окончания нагрузочного теста.
* В команде `yc loadtesting test create` добавлены флаги `--wait` и `--wait-idle-timeout` для ожидания окончания созданного нагрузочного теста.
* В команду `yc loadtesting test create` добавлены параметры `--configuration agent-by-filter=""` и `--configuration anonymous-agent=true` для выбора агента нагрузочного тестирования по фильтру и выбора анонимного агента соответственно.
* В команду `yc loadtesting agent list` добавлен параметр `--filter` для фильтрации списка агентов.

##### {{ vpc-name }} {#vpc}

* В команду `yc vpc address create` добавлен параметр `--dns-record` для указания DNS-спецификаций адреса.
* В команду `yc vpc address update` добавлены параметры:

  * `--dns-record` для указания DNS-спецификаций адреса;
  * `--clear-dns-records` для удаления всех DNS-спецификаций адреса.

### Версия 0.120.0 (01.03.24) {#version0.120.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }}

* В команде `yc compute connect-to-serial-port` поддержана авторизация через {{ oslogin }}.

##### {{ at-name }}

* Добавлено дерево команд `yc audit-trails trail` с командами `get`, `list`, `create`, `update`, `delete`, `list-operations`, `list-access-bindings`, `set-access-bindigns`, `add-access-binding`, `remove-access-binding` для управления трейлами.

### Версия 0.119.0 (27.02.24) {#version0.119.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ iam-name }} {#iam}

* Добавлено дерево команд `yc iam service-control`с командами `get`, `list`, `enable`, `pause`, `resume`, `disable` для управления доступом сервисов к ресурсам в облаке.

##### {{ compute-name }}

* В командах `yc compute instance create` и `yc compute instance update` добавлена поддержка настроек серийного порта.

### Версия 0.118.0 (14.02.24) {#version0.118.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ mgp-name }}

* Добавлено дерево команд `yc managed-greenplum backups` с командами `get`, `list`, `delete` для управления резервными копиями.
* Добавлена команда `yc managed-greenplum cluster backup` для создания резервной копии.

##### {{ compute-name }}

* В команду `yc compute ssh` добавлен параметр `--identity-file` для подключения к ВМ по SSH с указанием пользовательского ключа.

##### {{ data-transfer-name }}

- Для следующих команд добавлен параметр `--file` для указания YAML-файла для конфигурации запроса:
  * `yc datatransfer transfer create`
  * `yc datatransfer transfer update`
  * `yc datatransfer endpoint create`
  * `yc datatransfer endpoint update`

##### {{ org-full-name }} {#organization}

* Добавлена команда `yc organization-manager federation saml delete-user-accounts` для удаления федеративных пользователей.

##### {{ load-testing-name }}

Добавлена команда `yc loadtesting test get-report-table` для получения табличного отчета по прошедшему нагрузочному тесту.

##### {{ dns-name }} {#dns}

* В команду `yc dns zone list-records` добавлен параметр `--page-token` для включения разбиения на страницы по page-токену.

### Версия 0.117.0 (30.01.24) {#version0.117.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

Для команды `yc managed-greenplum cluster restore` добавлен параметр `restore-only`, который позволяет восстановить только указанные объекты.

##### {{ iot-name }} {#iot}

В команды `yc iot registry create`, `yc iot registry update`, `yc iot broker create` и `yc iot broker update` добавлены параметры:

* `--no-logging` — выключает логирование из реестра или брокера.
* `--log-group-id`, `--log-group-name` — идентификатор или имя лог-группы, в которую будут передаваться логи.
* `--log-folder-id`, `--log-folder-name` — идентификатор или имя каталога, в стандартную лог-группу которого будут передаваться логи.
* `--min-log-level` — минимальный уровень логирования записей.

##### {{ managed-k8s-name }} {#k8s}

В команде `k8s cluster update` исправлена ошибка, возникающая, когда в качестве позиционного аргумента передается `cluster-id`.

### Версия 0.116.0 (15.01.24) {#version0.116.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сети в сервисах бессерверных вычислений {#serverless}

Добавлена группа команд `yc serverless network` для управления сетями, которые используются в сервисах бессерверных вычислений ({{ sf-name }}, {{ serverless-containers-name }} и {{ api-gw-name }}):

  * `yc serverless network get-used` — получение информации о сети, которая подключена к ресурсам сервисов бессерверных вычислений;
  * `yc serverless network list-used` — получение списка сетей, которые подключены к ресурсам сервисов бессерверных вычислений;
  * `yc serverless network list-connections` — получение списка ресурсов сервисов бессерверных вычислений, которые подключены к какой-либо сети из заданной области (сеть, каталог, облако);
  * `yc serverless network trigger-used-cleanup` — инициировать скорейшую очистку сети от системных подсетей, если она больше не используется в сервисах бессерверных вычислений.

##### {{ iam-name }} {#iam}

* В дерево команд `iam`, `resource-manager` и `organization-manager` добавлена поддержка листинга более 1000 ресурсов через параметр `limit`.

##### {{ objstorage-name }}

* В команду `yc storage bucket update` для параметров `--lifecycle-rules/` и `--lifecycle-rules-from-file` добавлена поддержка логического оператора `И` (`andOperation`) для объединения условий в фильтре объектов.
* В команду `yc storage bucket update` добавлен параметр `--encryption key-id=<идентификатор_ключа>` для изменения используемого ключа шифрования, а также параметр `--remove-encryption` для отключения шифрования в бакете.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* В команде `{{ yc-mdb-ch }} cluster update` добавлена возможность указать параметр `cloud-storage-data-cache-max-size` в удобном для чтения формате.

##### {{ cdn-name }} {#cdn}

В команды `yc cdn resource update` и `yc cdn resource create` добавлены параметры для определения опции *ip address acl*:

* `--policy-type` — политика доступа клиентов по IP-адресам. Одно из значений *allow* или *deny*;
* `--acl-excepted-values` — список IP-адресов, доступ по которым будет разрешен или запрещен в зависимости от указанного policy-type.

##### {{ load-testing-name }}

Добавлено дерево команд `yc loadtesting` для управления сервисом нагрузочного тестирования:

* `yc loadtesting agent` — управление агентами нагрузочного тестирования;
* `yc loadtesting test-config` — управление шаблонами конфигураций нагрузочных тестов;
* `yc loadtesting test` — запуск нагрузочных тестов и управление проведенными нагрузочными тестами.

### Версия 0.115.0 (18.12.23) {#version0.115.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* В команды `yc managed-greenplum cluster create` и `yc managed-greenplum cluster update` добавлен параметр `--backup-retain-period-days`.

**{{ mch-name }}**

* Параметр `network-id` для `yc managed-clickhouse cluster restore` теперь опциональный.

##### {{ alb-name }} {#alb}

* В команды `yc alb virtual-host create` и `yc alb virtual-host update` добавлен параметр `--security-profile-id` для указания профиля безопасности из {{ sws-name }}.

##### {{ compute-name }} {#compute}

* Команды `yc compute instance`, `yc compute disk`, `yc compute image`, `yc compute snapshot`, `yc compute snapshot-schedule`, `yc compute placement-group`, `yc compute host-group`, `yc compute disk-placement-group`, `yc compute filesystem`, `yc compute gpu-cluster`: добавлена возможность отображать и управлять правами доступа с помощью `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.
* Добавлена команда `yc compute instance simulate-maintenance-event`.

### Версия 0.114.0 (05.12.23) {#version0.114.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ objstorage-name }}

* Исправлена передача имени бакета в команды `yc storage bucket create`, `yc storage bucket update`, `yc storage bucket set-https`.

#### {{ sf-name }} {#serverless-functions}

В команду `yc serverless function version create` добавлен параметр для указания монтирования бакетов в функцию:

* `--storage-mounts`, пример: `--storage-mounts mount-point=dir,bucket=user-bucket,read-only=false`.

#### {{ serverless-containers-name }} {#serverless-containers}

В команду `yc serverless container revision deploy` добавлен параметр для указания монтирования бакетов в контейнер:

* `--storage-mounts`, пример: `--storage-mounts mount-point-path=/data,bucket=user-bucket,read-only=false`.

##### {{ compute-name }} {#compute}

* В команде `yc compute ssh` все временные сертификаты сохраняются в домашней директории пользователя.
* В команде `yc compute ssh` пользовательские параметры теперь ставятся в конец запускаемой команды `ssh`.
* В команды `yc compute disk relocate` и `yc compute instance relocate` добавлена возможность релокации нереплицируемых дисков с заданными группами размещения и ВМ с такими дисками.
* В команды `yc compute instance create` и `yc compute instance update` добавлены параметры `--maintenance-policy` и `--maintenance-grace-period`.
* Добавлена проверка на одновременное указание параметров `--spread-strategy` и `--partitions` при создании группы размещения.
* Исправлена работа PAGER для справки `help`. Теперь при запуске команды с флагом `--help` открывается окно `less`.

##### {{ cloud-logging-name }} {#cloud-logging}

* Исправлена ошибка, когда при лимите свыше 1000 строк ответ содержал не более 1000 строк.

#### {{ cdn-name }} {#cdn}

В команды `yc cdn resource update` и `yc cdn resource create` добавлены параметры для настройки доступа к ресурсу по защищенному токену (_secure token_):

* `--secure-key` — секретный ключ, который будет применяться для генерации пользовательских ссылок.
* `--enable-ip-url-signing` — опциональный параметр для ограничения доступа к ресурсам по IP-адресу.
* `--clear-secure-key` — параметр для отключения доступа к ресурсу по защищенному токену.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Расширен список выводимых полей в отображении по умолчанию списка шардов и кластеров.
* Добавлены тип и размер резервной копии при выводе списка резервных копий.
* Исправлен баг при попытке восстановить кластер с включенным гибридным хранилищем или SQL Management командой `yc managed-clickhouse cluster restore`.

### Версия 0.113.0 (31.10.23) {#version0.113.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* В команду `yc k8s node-group update` добавлен параметр `--location`. Это параметр позволяет изменить [зону доступности](../overview/concepts/geo-scope.md), в которой развернута группа узлов.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`: флаг `--unmanaged-topics` помечен как `deprecated`. Соответствующее поле больше не отправляется в запросах API, но флаг останется для сохранения обратной совместимости.

**{{ mos-name }}**

* Добавлена группа команд `yc managed-opensearch` для управления базами данных {{ mos-name }}.

**{{ mch-name }}**

* Для команды `yc managed-clickhouse cluster --mongodb-source` добавлена настройка `options`.
* Для команды `yc managed-clickhouse cluster set-compression` добавлена настройка `level`.

##### {{ compute-name }} {#compute}

* Добавлена возможность замены переменных окружения в шаблонах, загружаемых с помощью команды `--metadata-from-file`.

##### {{ vpc-name }} {#vpc}

* Добавлена команда `yc vpc subnet relocate`.

### Версия 0.112.0 (12.10.23) {#version0.112.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

###### {{ compute-name }} {#compute}

* Поддержано подключение к CentOS 7 с помощью команды `yc compute ssh`.
* Добавлены команды `yc compute instance relocate` и `yc compute disk relocate` для перемещения ВМ и дисков между зонами доступности.

### Версия 0.111.0 (21.09.23) {#version0.111.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }} {#compute}

* Поддержан параметр `--network-interface` в команде `yc compute instance relocate`.
* Добавлена группа команд `yc compute ssh` для подключения к ВМ по сертификату, выписанному с помощью {{ oslogin }}, и экспорта этого сертификата. {{ oslogin }} используется для предоставления пользователям доступа к ВМ по SSH через {{ iam-short-name }}.

##### {{ mpg-name }}

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `16` для параметра `--postgresql-version string`. Оно позволяет создать кластер {{ PG }} версии 16.


##### {{ iot-name }} {#iot}

* Добавлена группа команд `yc iot registry yds-export` для управления экспортом сообщений из IoT в Data Streams.



##### {{ cloud-logging-name }} {#cloud-logging}

* Исправлена ошибка вывода `yc logging read` для форматов json и json-rest



##### {{ sf-name }} {#serverless-functions}

В команду `yc serverless function version create` добавлены параметры асинхронного вызова:
* `--async-max-retries` - для указания максимального количества попыток вызова функции
* `--async-service-account-id` - для указания сервисного аккаунта для вызова функции
* `--async-success-ymq-arn` - для указания очереди для успешного результата
* `--async-success-sa-id` - для указания сервисного аккаунта для записи в очередь успешного результата
* `--async-failure-ymq-arn` - для указания очереди для неуспешного результата
* `--async-failure-sa-id` - для указания сервисного аккаунта для записи в очередь неуспешного результата


### Версия 0.110.0 (14.09.23) {#version0.110.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ api-gw-name }} {#api-gw}

* В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры:
  * `--variables` — для указания значений параметров спецификации.
  * `--canary-weight` — для указания доли входящих запросов, обрабатываемых канареечным релизом шлюза.
  * `--canary-variables` — для указания значений параметров спецификации канареечного релиза.

* Добавлена команда `yc serverless api-gateway release-canary` для замены параметров спецификации параметрами канареечного релиза и удаления последнего.

* Добавлена команда `yc serverless api-gateway rollback-canary` для отключения канареечного релиза за счет установки параметру `weight` значения, равного `0`.


##### {{ iam-name }} {#iam}

* Удалены группы команд `yc iam federation` и `yc iam certificate` для управления SAML-совместимыми федерациями на уровне каталога. Для работы с SAML-совместимыми федерациями теперь используйте группу команд `yc organization-manager federation`.


##### {{ ig-name }} {#instance-groups}

Исправлена проблема команды `yc compute instance-group update`, когда не обрабатывалось имя группы ВМ, если для конфигурации использовался файл в формате YAML.

##### {{ compute-name }} {#compute}

* В командах `yc compute instance create` и `yc compute instance update` добавлен параметр `--placement-group-partition` для указания номера раздела в группе размещения (partition).


##### {{ cloud-logging-name }} {#cloud-logging}

* В команде `yc logging read` убрали ограничение для параметра `--limit`. Теперь можно выводить более 1000 записей.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Добавлена возможность создавать шардированный кластер. Если в конфигурации присутствуют соответствующие типы хостов, то кластер будет создан автоматически.
* В команды `yc mongodb cluster create`, `yc mongodb cluster update` и `yc mongodb cluster restore` добавлен параметр `--performance-diagnostics`.

**{{ mpg-name }}**

* Добавлена команда `yc managed-postgresql backup delete` для удаления ручных бэкапов.
* В команду `yc managed-postgresql cluster update` добавлены флаги:
  * `--disk-size-autoscaling` — для управления настройками сервиса автоматического увеличения диска.
  * `--yandexquery-access` — для разрешения доступа к кластеру из сервиса {{ yq-full-name }}.

**{{ mch-name }}**

* В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster update` добавлен флаг `--cloud-storage-prefer-not-to-merge`, позволяющий отключать слияние частей данных в {{ objstorage-name }}.

### Версия 0.109.0 (10.08.23) {#version0.109.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ sf-name }} {#cloud-functions}

* В команду `yc serverless trigger create mail` добавлена возможность настройки бакета для сохранения вложений письма.
* В команды `yc serverless trigger create iot-devices`, `yc serverless trigger create iot-broker`, `yc serverless trigger create object-storage`, `yc serverless trigger create container-registry` и `yc serverless trigger create mail`:
  * Добавлен параметр `--batch-size` для указания размера группы сообщений.
  * Добавлен параметр `--batch-cutoff` для указазания максимального времени формирования группы.
* В команду `yc serverless trigger create logging` добавлен параметр `--stream-names` для фильтрации по имени потока логов.
* Добавлена команда `yc serverless function version delete` для удаления версий функций.

##### {{ kms-name }} {#kms}

* В команды ассиметричного шифрования и подписи `yc kms asymmetric-encryption-crypto decrypt`, `yc kms asymmetric-signature-crypto sign` и `yc kms asymmetric-signature-crypto sign-hash` добавлены параметры `--inform` и `--outform` для указания формата входных и выходных данных.
* В командах подписи `yc kms asymmetric-signature-crypto sign` и `yc kms asymmetric-signature-crypto sign-hash` параметр `--signature-file`, указывающий на файл, в который надо сохранить полученное значение подписи, переименован в `--signature-output-file`.

##### {{ managed-k8s-name }} {#k8s}

* В команду `yc k8s node-group create` добавлен параметр `--gpu-cluster-id` для добавления узла из группы узлов в кластер с GPU.
* В команду `yc k8s node-group create` добавлен параметр `--gpu-environment` для настройки предустановленного окружения для узлов с GPU.

##### {{ compute-name }} {#compute}

* В команду создания группы размещения дисков `yc compute disk-placement-group create` добавлен параметр `--strategy` для указания стартегии размещения. Может принимать значения `SPREAD` или `PARTITION`.
* В команду создания группы размещения дисков `yc compute disk-placement-group create` добавлен параметр `--partition-count`. Задает количество разделов для группы со стратегией `PARTITION`.
* В команду создания диска `yc compute disk create` добавлен параметр `--disk-placement-group-partition` для указания номера раздела в группе размещения.
* Добавлена колонка `PLACEMENT GROUP` в таблице со списком дисков, получаемых командой `yc compute disk list`.
* Добавлена колонка `STRATEGY` в таблице со списком групп размещения дисков, получаемых командой `yc compute disk-placement-group list`.

##### {{ cloud-logging-name }} {#cloud-logging}

* Добавлена группа `yc logging sink`.

##### {{ ig-name }} {#instance-groups}

* Добавлены команды `yc compute instance-group rolling-restart` и `yc compute instance-group rolling-recreate` для перезапуска и пересоздания ВМ в группе с учетом ограничений группы.

##### {{ dns-name }} {#dns}

* Добавлена команда `yc dns zone update-private-networks` для атомарного изменения списка сетей для приватных зон.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Добавлена команда `yc managed-mongodb backup delete` для удаления резервных копий.

### Версия 0.108.1 (06.07.23) {#version0.108.1}

#### Изменения в CLI {#cli}

* Команда `oslogin` временно удалена.

### Версия 0.108.0 (04.07.23) {#version0.108.0}

#### Изменения в CLI {#cli}

* Добавлена команда `oslogin`, предназначенная для получения логина текущего пользователя ОС.
* Отключено отображение глобальных параметров по умолчанию для всех команд при вызове `yc [command] -h`. Для просмотра глобальных параметров используйте команду `yc help [command]`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ kms-name }} {#kms}

* В {{ kms-full-name }} поддержана работа с асимметричными криптографическими ключами. Функционал находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../kms/).

### Версия 0.107.0 (15.06.23) {#version0.107.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }} {#compute}

* В команду `yc compute placement-group create` добавлен параметр `--partitions`, позволяющий указать количество партиций в `partitionPlacementStrategy`.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* Унифицировали конфигурационные параметры кластеров Managed Service for Redis для разных версий {{ RD }}.

**{{ mgp-name }}**

* В команду `yc managed-greenplum cluster restore` добавлен параметр:
  * `--segment-host-count`, позволяющий указать количество хостов с сегментами в восстановленном кластере.
  * `--segment-in-host`, позволяющий указать количество сегментов на хосте в восстановленном кластере.

**{{ mmy-name }}**

* В команду `yc managed-mysql user update` добавлен параметр `--global-permissions`, позволяющий выдать привилегии `FLUSH_OPTIMIZER_COSTS` и `SHOW_ROUTINE`.

### Версия 0.106.0 (19.05.23) {#version0.106.00}

#### Изменения в CLI {#cli}

* В команду `yc organization-manager federation saml` добавлен флаг `--force-authn`.
* Добавлена опция конфигурации `fed-auth-browser-skip` для пропуска подтверждения открытия браузера (нажатия **Enter**) при аутентификации от имени федеративного пользователя. Опция принимает значения `true` и `false`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* В параметр `--master-logging` добавлен флаг `audit-enabled`, позволяющий включать и выключать загрузку логов аудита кластера {{ k8s }} в {{ cloud-logging-full-name }}.

##### {{ backup-name }} {#backup}

* Добавлены команды группы `yc backup` для управления подключением виртуальных машин к {{ backup-full-name }}, их резервными копиями и политиками резервного копирования.

### Версия 0.105.0 (15.05.23) {#version0.105.00}

#### Изменения в CLI {#cli}

* Добавлен параметр `--impersonate-service-account-id` для выполнения действий от имени сервисного аккаунта. В параметре передается идентификатор сервисного аккаунта, тип данных значения — string.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ cloud-logging-name }} {#cloud-logging}

* Исправлена работа команды `yc logging read` при указании флага `--follow`.

##### {{ managed-k8s-name }} {#k8s}

В команду `yc k8s node-group create` добавлен параметр `--container-network-settings` для конфигурации контейнерной сети узлов кластера. В этом параметре в свойстве `pod-mtu` можно передать значение MTU для подов.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Добавлена поддержка {{ KF }} версий 3.x, начиная с 3.3.

### Версия 0.104.0 (19.04.23) {#version0.104.00}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ sf-name }} {#serverless-functions}

* В команду `yc serverless trigger timer create` добавлен параметр `--payload` для привязки пользовательских данных к событию от таймера.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* Группа команд `yc cloud-desktop` переименована в `yc desktops`.
* Добавлена пометка `[PREVIEW]` к группе команд `yc desktops`.
* Добавлена команда `yc desktops desktop restart`, которая позволяет перезагружать рабочий стол.

##### {{ compute-name }} {#compute}

* Исправлен листинг большого количества объектов в каталоге для всех сущностей {{ compute-short-name }}.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

Добавлена команда `yc managed-clickhouse cluster list-external-dictionaries` для листинга списка добавленных внешних словарей.

##### {{ cloud-logging-name }} {#cloud-logging}

* В команду `yc logging read` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc logging read default 1d "level = INFO"`
* В команду `yc logging write` добавлены позиционные параметры `MESSAGE` и `JSON-PAYLOAD`, пример: `yc logging write default test "{\"key\":\"value\"}"`

##### {{ sf-name }} {#functions}

* В команды `yc serverless function logs` и `yc serverless function version logs` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc serverless function logs default 1d "level = INFO"`

##### {{ iot-name }} {#iot}

В команду `yc iot broker logs` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc iot broker logs default 1d "level = INFO"`

### Версия 0.103.0 (15.03.23) {#version0.103.00}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ api-gw-name }} {#api-gw}

В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры:

* `--no-logging` — для выключения логинга из API-шлюза.
* `--log-group-id`, `--log-group-name` — для указания лог-группы, в которую следует отправлять логи.
* `--log-folder-id`, `--log-folder-name` — для отправки логов в стандартную лог-группу заданного каталога.
* `--min-log-level` — для указания минимального уровня логирования записей.



##### {{ compute-name }} {#compute}

* Добавлена группа команд `yc compute gpu-cluster` для управления GPU-кластерами.
* Добавлены параметры `--gpu-cluster-id` и `--gpu-cluster-name` в команду `yc compute instance create` для создания виртуальной машины в GPU-кластере.


### Версия 0.102.0 (09.02.23) {#version0.102.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ ig-name }} {#instance-groups}

Исправлена проблема `update` `instance-group` при указании через `name`.

##### {{ alb-name }} {#alb}

Добавлена поддержка аргументов командной строки для поиска соответствий по регулярному выражению`--regex-path-match` и `--regex-fqmn-match`. Используются аналогично `exact` и `prefix`:
* `yc alb virtual-host insert-http-route --regex-path-match my_cool_regex`
* `yc alb virtual-host insert-grpc-route --regex-fqmn-match my_cool_regex`

Флаг `--rewrite-request-id`, отвечающий за перезапись заголовка `x-request-id` новым значением, добавлен в следующие команды:
* `yc application-load-balancer load-balancer add-listener`
* `yc application-load-balancer load-balancer update-listener`
* `yc application-load-balancer load-balancer add-sni`
* `yc application-load-balancer load-balancer update-sni`


#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

Добавлены новые параметры для команд `yc managed-postgresql user create` и `yc managed-postgresql user update` :
* `--statement-timeout` — позволяет задавать `statement_timeout` в миллисекундах для указанного пользователя.
* `--idle-in-transaction-session-timeout` — позволяет задавать `idle_in_transaction_session_timeout` в миллисекундах для указанного пользователя.
* `--wal-sender-timeout` — позволяет задавать `wal_sender_timeout` в миллисекундах для указанного пользователя.

### Версия 0.101.0 (16.01.23) {#version0.101.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#managed-kubernetes}

В команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update` добавлен параметр `--master-logging` для настройки логирования со следующими свойствами:

* `enabled` — флаг для отправки логов в {{ cloud-logging-name }}.
* `log-group-id` — ID [лог-группы](../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `folder-id` — ID каталога, в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `kube-apiserver-enabled` — флаг для отправки логов `kube-apiserver` в {{ cloud-logging-name }}.
* `cluster-autoscaler-enabled` — флаг для отправки логов `cluster-autoscaler` в {{ cloud-logging-name }}.
* `events-enabled` — флаг для отправки событий {{ k8s }} в {{ cloud-logging-name }}.

Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится кластер, в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

##### {{ network-load-balancer-name }} {#network-load-balancer}

В команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update` добавлен флаг `--deletion-protection` для защиты балансировщика от случайного удаления.



##### {{ serverless-containers-name }} {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:

* `--no-logging` — флаг для выключения логирования из контейнера.
* `--log-group-id`, `--log-group-name` — ID или имя [лог-группы](../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `--log-folder-id`, `--log-folder-name` — ID или имя каталога, в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `--min-log-level` — минимальный уровень логирования.



##### {{ vpc-name }} {#vpc}

В команды `yc vpc address create` и `yc vpc address update` добавлен флаг `--deletion-protection` для защиты статического публичного IP-адреса от случайного удаления.


### Версия 0.100.0 (27.12.22) {#version0.100.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ compute-name }} {#compute}

* В команде `yc compute instance update` добавлена возможность редактирования правил размещения на хостах.



##### {{ serverless-containers-name }} {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:
* `--zone-instances-limit` — максимальное количество экземпляров контейнера в зоне доступности;
* `--zone-requests-limit` — максимальное количество одновременно выполняемых вызовов контейнера в зоне доступности.



##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* Добавлена команда `yc managed-greenplum cluster restore` для восстановления кластера из бэкапа.
* Добавлена команда `yc managed-greenplum cluster list-backups` для просмотра бэкапов кластера.
* В команде `yc managed-greenplum update` появился флаг `--assign-public-ip`, чтобы назначить или отозвать публичный IP-адрес кластера.


### Версия 0.99.0 (01.12.22) {#version0.99.0}

#### Изменения в CLI {#cli}

**{{ objstorage-name }}**

* Добавлена поддержка {{ objstorage-name }} (control plane). Список возможностей:
  * Создание бакетов с возможностью указания класса хранения, максимального размера бакета и ACL.
  * Обновление параметров бакета: `ACL`, `политики`, `настройки вебсайтов`, `CORS`, `флаги анонимного доступа`, `настройки Lifecycle`, `максимальный размер бакета` и `класс хранения`.
  * Удаление бакета.
  * Привязка/отвязка HTTPS-сертификата к бакету.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ alb-name }} {#alb}

* Добавлена команда `yc application-load-balancer load-balancer logging` для настройки логов балансировщика. Параметры команды:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из {{ cloud-logging-name }}.
  * `--enable` и `--disable` — для включения и выключения записи логов балансировщика в лог-группу из {{ cloud-logging-name }}.
  * `--discard` — для задания правил отбрасывания части логов на основе HTTP- или gRPC-кодов.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mes-name }}**

* В команде `{{ yc-mdb-es }} cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**{{ mmg-name }}**

* В команде `{{ yc-mdb-mg }} cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**{{ mmy-name }}**

* В команде `{{ yc-mdb-my }} cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**Managed Service for Redis**

* В команде `{{ yc-mdb-rd }} cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.


**{{ mms-name }}**

* В команде `{{ yc-mdb-ms }} cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.



##### {{ sf-name }} {#serverless-functions}

В команду `yc serverless function version create` добавлены параметры: 
* `--no-logging` — отключает логирование в функции.
* `--log-group-id`, `--log-group-name` — отправляет логи в заданную лог-группу.
* `--log-folder-id`, `--log-folder-name` — отправляет логи в стандартную лог-группу заданного каталога.
* `--min-log-level` — задает минимальный уровень логирования записей.


### Версия 0.98.0 (09.11.22) {#version0.98.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Добавлены команды группы `yc managed-kafka connector-s3-sink`, которые позволяют управлять коннекторами типа S3-Sink, а именно создавать (create) и модифицировать (update) их.

* В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлен параметр для задания и изменения конфигурации Kafka-брокеров — `sasl-enabled-mechanisms`.

* Исправлен баг с изменением поля `properties` у коннекторов.

**{{ mpg-name }}**

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `15` для параметра `--postgresql-version string`. Оно позволяет создать кластер {{ PG }} версии 15.

* Для команды `yc managed-postgresql cluster create` изменено значение по умолчанию для версии создаваемого кластера {{ PG }}. Новое значение по умолчанию — `15`.

* В команду `yc managed-postgresql cluster restore` добавлена возможность восстановления кластера {{ PG }} в заданный каталог.

### Версия 0.97.0 (10.10.22) {#version0.97.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ api-gw-name }} {#api-gw}

* Параметр `domainId` команды `add-domain` больше не поддерживается.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* Добавлена команда `yc managed-greenplum cluster expand`, которая позволяет расширить существующий кластер {{ mgp-name }}. Параметры команды:

  * `--segment-host-count` — количество добавляемых в кластер хостов;
  * `--add-segments-per-host-count` — количество сегментов, добавляемых на каждый хост кластера;
  * `--duration-seconds` — максимальная длительность сеанса распределения данных в секундах.

**{{ mkf-name }}**

* Прекращена поддержка {{ KF }} версий 2.1 и 2.6.

### Версия 0.96.0 (19.09.22) {#version0.96.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ alb-name }} {#alb}

* Добавлена команда `yc application-load-balancer load-balancer autoscale` для управления количеством ресурсных единиц балансировщика.
  В команду есть параметры:
  * `--min-zone-size` — минимальное число ресурсных единиц в одной зоне;
  * `--max-size` — максимальное числа ресурсных единиц во всех зонах суммарно.

* В команду `yc alb load-balancer create` добавлены параметры:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из {{ cloud-logging-name }};
  * `--disable-logging` — для создания балансировщика без записи логов в лог-группу из {{ cloud-logging-name }}.

* В команду `yc alb load-balancer update` добавлены параметры:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из {{ cloud-logging-name }};
  * `--enable-logging` и `--disable-logging` — для включения и выключения записи логов балансировщика в лог-группу из {{ cloud-logging-name }}.

##### {{ compute-name }} {#compute}

* Добавлена группа команд `yc compute snapshot-schedule` для управления снимками диска по расписанию.
* В команду `yc compute instance create` добавлен параметр `--metadata-options` для управления доступом к метаданным ВМ.

###### {{ dns-name }} {#dns}

* Команда `yc dns zone list-records` теперь имеет фильтрацию по имени и типу записи с помощью параметров `--record-name` и `--record-type`.


##### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`: для параметра `--postgresql-version string` добавлены значения `11-1c`, `12-1c`, `13-1c`, `14-1c` для создания кластера {{ PG }} версий 11-1c, 12-1c, 13-1c, 14-1c.


##### {{ iot-name }} {#iot}

* Добавлена группа команд `yc iot broker` для управления MQTT-брокером.

##### {{ sf-name }} {#serverless-functions}

Добавлены команды:

* `yc serverless trigger create iot-broker` — для создания триггеров для MQTT-брокеров.
* `yc serverless trigger create mail` — для создания триггеров для почты.

В команду `yc serverless function version create` добавлен параметр `--secret` для добавления [секретов](../lockbox/) к версии.

##### {{ serverless-containers-name }} {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:
* `--secret` — для добавления секретов к ревизии;
* `--min-instances` — чтобы указать минимальное количество подготовленных экземпляров контейнера.


### Версия 0.95.0 (02.09.22) {#version0.95.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ api-gw-name }} {#api-gw}

* В команду `yc serverless api-gateway add-domain` добавлены параметры:

  * `--domain` — для указания FQDN подключаемого домена из {{ certificate-manager-name }};
  * `--certificate-id` — для указания идентификатора сертификата из {{ certificate-manager-name }}.

  Параметр `--domain-id` считается устаревшим, вместо него рекомендуется использовать параметру `--domain` и `--certificate-id`.

* Добавлена группа команд `yc serverless api-gateway websocket` для работы с соединениями по протоколу WebSocket:

  * `yc serverless api-gateway websocket get` — получение информации о соединении;
  * `yc serverless api-gateway websocket send` — отправка данных в соединении;
  * `yc serverless api-gateway websocket disconnect` — разрыв соединения.



##### {{ certificate-manager-name }} {#certificate-manager}

* В команду `yc certificate-manager certificate content` добавлен параметр `--key-format` для выбора формата приватного ключа: `PKCS1` или `PKCS8`.

##### {{ compute-name }} {#compute}

* В команду `yc compute image create` добавлен параметр `--os-type` для указания типа операционной системы создаваемого образа: `linux` или `windows`.

##### {{ dns-name }} {#dns}

* Команды `yc dns zone add-records`, `yc dns zone update-records`, `yc dns zone delete-records` и `yc dns zone replace-records` теперь возвращают список выполненных изменений.

##### {{ iam-name }} {#iam}

* В группе команд `yc iam federation` исправлена ошибка, возникавшая при указании имени SAML-совместимой федерации как позиционного аргумента.



##### {{ iot-name }} {#iot}

* Команды `yc iot registry logs` и `yc iot device logs` теперь возвращают логи из {{ cloud-logging-name }}. В команды добавлены параметры:

  * `--levels` — для поиска записей с указанными уровнями логирования;
  * `--filter` — для фильтрации записей.

  Подробнее о возможных значениях новых параметров см. в разделе [{#T}](../logging/concepts/filter.md).


##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Добавлена поддержка {{ KF }} версий 3.0, 3.1 и 3.2.

**Managed Service for Redis**

* Прекращена поддержка {{ RD }} версий 5.0 и 6.0.


##### {{ org-full-name }} {#organization}

* В команды из группы `yc organization-manager federation saml` добавлен параметр `--organization-id` для указания идентификатора организации. Исправлена ошибка, возникавшая в этих командах при указании имени SAML-совместимой федерации как позиционного аргумента.
* Добавлена группа команд `yc organization-manager group` для управления [группами пользователей](../organization/operations/manage-groups.md).


### Версия 0.94.0 (16.08.22) {#version0.94.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ cloud-logging-name }} {#cloud-logging}

* В команды `yc logging read` и `yc logging write` добавлен параметр `--stream-name`.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mgp-name }}**

* Добавлена поддержка команд:

  * `yc managed-greenplum cluster update` — позволяет изменять настройки уже созданных кластеров.
  * `yc managed-greenplum cluster update-config` — позволяет изменять параметры конфигурации уже созданных кластеров.


**Managed Service for Redis**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore`,
  `yc managed-redis hosts add`, `yc managed-redis hosts update`, `yc managed-redis shards add` добавлены параметры:

  * `--assign-public-ip=true|false` — привязывает или удаляет публичный IP-адрес хоста.
  * `--replica-priority=50` — выставляет приоритет реплики (только для нешардированного кластера).

**{{ mch-name }}**

* В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster update` добавлены параметры:

  * `--cloud-storage-move-factor` — для указания доли свободного места на локальном диске, при котором начнется перенос данных на {{ objstorage-name }}.
  * `--cloud-storage-data-cache` — для разрешения использования локального кеша для {{ objstorage-name }}.
  * `--cloud-storage-data-cache-max-size` — для указания максимального объема локального кеша для {{ objstorage-name }}.

**{{ mkf-name }}**

* Добавлена группа команд `yc managed-kafka connector`, которая позволяет управлять коннекторами с помощью команд `get`, `list`, `delete`, `pause`, `resume`.
* Добавлена группа команд `yc managed-kafka connector-mirrormaker`, которая позволяет управлять коннекторами типа MirrorMaker с помощью команд `create` и `update`.
* В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлены параметры для задания и изменения конфигурационных настроек хостов-брокеров:
  - `message-max-bytes`
  - `replica-fetch-max-bytes`
  - `offsets-retention-minutes`
  - `ssl-cipher-suites`


##### {{ vpc-name }} {#vpc}

* Добавлена группа команд `yc vpc gateway` для управления шлюзами маршрутизации.
* В команды группы `yc vpc route-table` добавлена возможность указать шлюз в качестве назначения маршрута.


### Версия 0.93.0 (19.07.22) {#version0.93.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* В команде `yc managed-clickhouse cluster restore` следующие аргументы сделаны опциональными:

  * `--name`
  * `--description`
  * `--host`
  * `--user`

  Если эти параметры не были указаны, они будут взяты из исходного кластера.
  Хосты **{{ CH }}** и **{{ ZK }}** будут восстановлены с той же конфигурацией, что и в исходном кластере.
  Хосты **{{ CH }}** будут восстановлены только для тех шардов, чьи бэкапы указаны для восстановления.

**{{ mpg-name }}**

* Команды `yc managed-postgresql database create`, `yc managed-postgresql database list` и `yc managed-postgresql database get`.

  Добавлена поддержка шаблонов при создании базы с помощью `--template-db string`.

**{{ mmg-name }}**

* При создании нового кластера по умолчанию выбирается версия MongoDB 5.0.


##### {{ managed-k8s-name }} {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`:

  * Добавлен параметр `--node-name`, позволяющий указать шаблон именования узлов в группе.

  * Добавлены параметры `--template-labels` и `--template-labels-from-files`, позволяющие указать [ресурсные метки {{ yandex-cloud }}](../resource-manager/concepts/labels.md) для ВМ — узлов группы (не путать с [метками узлов {{ k8s }}](../managed-kubernetes/concepts/index.md#node-labels)).



##### {{ serverless-containers-name }} {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлены параметры `--network-id` и `--network-name`, чтобы указывать сеть, которую будет использовать ревизия контейнера. Также в команду добавлен флаг `--subnets`, позволяющий получить детальный список подсетей.


### Версия 0.92.0 (05.07.22) {#version0.92.0}

#### Изменения в CLI {#cli}

* Исправлена ошибка запуска `yc` при передаче большого количества аргументов.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ certificate-manager-name }} {#certificate-manager}

* В команду `yc certificate-manager certificate create` добавлен флаг `--deletion-protection`, который включает защиту сертификата от удаления.

* В команду `yc certificate-manager certificate request` добавлен флаг `--deletion-protection`, который включает защиту сертификата от удаления.

* В команду `yc certificate-manager certificate update` добавлены флаги, которые включают и отключают защиту сертификата от удаления: `--deletion-protection` и `--no-deletion-protection`.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* В группу команд `yc managed-redis cluster` для `create`, `restore`, `update` добавлены флаги `--client-output-buffer-limit-normal` и `--client-output-buffer-limit-pubsub` (см. описание в redis.conf). 

**{{ mgp-name }}**

Добавлены команды первичной поддержки сервиса {{ mgp-name }}:
* Группа команд `yc managed-greenplum cluster` позволяет управлять кластерами.
* Группа команд `yc managed-greenplum hosts` позволяет управлять хостами.


**{{ mms-name }}**

* Добавлена команда `yc managed-sqlserver hosts update <HOST> --assign-public-ip=true|false`, которая привязывает или удаляет публичный IP-адрес хоста.


### Версия 0.91.0 (12.05.22){#version0.91.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ alb-name }} {#alb}

* В командах `yc alb lb add-location` и `yc alb lb target-states` исправлена ошибка при обработке параметра `--name`. Теперь параметр позволяет корректно искать балансировщик по имени.

##### {{ cloud-desktop-name }} {#cloud-desktop}

* Добавлена группа команд `yc cloud-desktop group`, которые позволяют управлять группами рабочих столов.
* Добавлена группа команд `yc cloud-desktop desktop`, которые позволяют управлять рабочими столами.

##### {{ sf-name }} {#functions}

* В команды `yc serverless function logs` и `yc serverless function version logs` добавлен параметр `--max-response-size`, который ограничивает размер получаемых логов.

##### {{ cloud-logging-name }} {#cloud-logging}

* В команду `yc logging read` добавлен параметр `--max-response-size`, который ограничивает размер получаемых логов.

##### {{ dns-name }} {#dns}

* Добавлена команда `yc dns bind-file migrate-to-terraform`, которая формирует из файла BIND спецификацию для {{ TF }} и печатает ее в стандартный вывод.

##### {{ serverless-containers-name }} {#serverless-containers}

* Добавлена команда `yc serverless containers rollback`, которая откатывает контейнер к указанной ревизии.

##### {{ ydb-name }} {#ydb}

* В группу команд `yc ydb database` добавлены команды `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`, позволяющие устанавливать и просматривать список ролей для баз данных.
* В группу команд `yc ydb backup` добавлены команды `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`, позволяющие устанавливать и просматривать список ролей для бэкапов баз данных.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mes-name }}**

* Добавлены группа команд `yc managed-elasticsearch extension`, которые позволяют управлять пользовательскими расширениями для кластеров.

**{{ mmy-name }}**

* В команду `yc managed-mysql cluster create` добавлен параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
* В команду `yc managed-mysql cluster restore` добавлены:

  * Параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
  * Флаг `--deletion-protection`, позволяющий восстанавливать кластер сразу с включенной защитой от удаления.

**{{ mpg-name }}**

* В команду `yc managed-postgresql cluster create` добавлен параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
* В команду `yc managed-postgresql cluster restore` добавлены:

  * Параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
  * Флаг `--deletion-protection`, позволяющий восстанавливать кластер сразу с включенной защитой от удаления.


**{{ mms-name }}**

* В команды `yc managed-sqlserver create` и `yc managed-sqlserver update` добавлен параметр `--service-account-id` для назначения сервисного аккаунта хостам кластера {{ MS }}.
* Добавлены команды `yc managed-sqlserver database backup-export` и `yc managed-sqlserver database backup-import` для экспорта и импорта бэкапов баз данных в пользовательское хранилище.
* Добавлена команда `yc managed-sqlserver cluster start-failover` для ручного запуска смены мастера в кластере.


**{{ mkf-name }}**

* В команду `yc managed-kafka cluster update` добавлен флаг `--assign-public-ip` для управления публичным доступом к брокерам.

### Версия 0.90.0 (13.04.22) {#version0.90.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ dataproc-name }} {#dataproc}

* В команду `yc dataproc cluster create` добавлен параметр `--initialization-action` для указания скрипта инициализации кластера.

##### {{ compute-name }} {#compute}

* В команду `yc compute instance create` добавлен флаг `--attach-local-disk` для создания инстанса с подключенным к нему локальным диском.

##### {{ alb-name }} {#alb}

* В команды `yc alb backend-group add-stream-backend` и `yc alb backend-group update-stream-backend` добавлен флаг `--enable-proxy-protocol` для включения proxy-протокол для бэкенда.

##### {{ dns-name }} {#dns}

* В команду `yc dns zone update` добавлен флаг `--clear-network-ids` для удаления списка виртуальных сетей, из которых видны записи внутренней DNS-зоны.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* В команду `yc managed-clickhouse cluster restore` добавлен параметр `--folder-id` для указания каталога, в котором будет создан восстановленный кластер.

* В команду `yc managed-clickhouse cluster update` добавлен флаг:


  * `--yandexquery-access` — для разрешения доступа к кластеру из сервиса {{ yq-full-name }}.


**{{ mmy-name }}**


* В команду `yc managed-mysql cluster update` добавлен параметр `--performance-diagnostics`, позволяющий управлять настройками сервиса диагностики производительности.


### Версия 0.89.0 (23.03.22) {#version0.89.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ compute-name }} {#compute}

* Добавлена команда `yc compute filesystem resize` для изменения размера файлового хранилища.
* В команду `yc compute instance update` добавлен флаг `--preemptible`, позволяющий сделать обычную ВМ прерываемой и наоборот.

##### {{ sf-name }} {#functions}

* Команды `yc serverless function logs` и `yc serverless function version logs` теперь возвращают логи из {{ cloud-logging-name }}. В команды добавлены параметры:

  * `--levels` для поиска записей с указанными уровнями логирования;
  * `--filter` для фильтрации записей.

  Подробнее о возможных значениях новых параметров см. в разделе [{#T}](../logging/concepts/filter.md).


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* Параметр `--persistence-mode`, который позволяет выбрать режим персистентности кластера {{ RD }}, добавлен в команды:

  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.
  
  В последнюю команду также добавлен флаг `--force`, обязательный при отключении персистентности кластера.

**{{ mch-name }}**

* Добавлена команда `yc managed-clickhouse hosts update` для редактирования хостов кластера {{ CH }}. У команды есть параметр `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.
* В команду `yc managed-clickhouse cluster create` добавлены флаги `--datatransfer-access` и `--yandexquery-access` для управления доступом к хостам кластера из сервисов {{ data-transfer-name }} и {{ yq-full-name }}, соответственно.
* В команде `yc managed-clickhouse cluster restore` параметр `--backup-id` теперь принимает список значений для восстановления шардированного кластера.

**{{ mmy-name }}**

* В вывод команды `yc managed-mysql hosts list` добавлена колонка `PRIORITY`.
* В команду `yc managed-mysql hosts update` добавлен параметр `--priority` для изменения приоритета хоста при переключении мастера.

### Версия 0.88.0 (16.02.22) {#version0.88.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ data-transfer-name }}

* Добавлена команда `list` для `endpoint` и `transfer`:

  * `yc datatransfer endpoint list`;
  * `yc datatransfer transfer list`;

* Добавлены команды для обновления `endpoint` и `transfer`:

  * `yc datatransfer endpoint update postgres-source`;
  * `yc datatransfer endpoint update postgres-target`;
  * `yc datatransfer endpoint update mysql-source`;
  * `yc datatransfer endpoint update mysql-target`;
  * `yc datatransfer transfer update`;


##### {{ cdn-name }} {#cdn}

* Добавлена возможность делать полную очистку кеша ресурса: `yc cdn cache purge --all`.
* Исправлено создание ресурса, когда источник — бакет или балансер.

##### {{ api-gw-name }} {#api-gw}

* В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры `--network-id` и `--network-name` для указания сети API-шлюза, а также параметры `--subnet-id` и `--subnet-name` для детального списка подсетей.

##### {{ compute-name }} {#compute}

* Добавлены команды `yc compute disk move` и `yc compute instance move` для перемещения дисков и инстансов между каталогами.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mms-name }}**

* В команды `yc managed-sqlserver update`, `yc managed-sqlserver start` добавлен флаг `confirm-payment` для подтверждения согласия с лицензионными платежами.


### Версия 0.87.0 (18.01.22) {#version0.87.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ dataproc-name }} {#dataproc}

* Добавлена команда `yc dataproc job cancel <JOB-ID>|<JOB-NAME>`.

  Теперь можно отменить выполнение незавершенного задания.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mes-name }}**

* В информацию о кластере добавлена информация о текущем окне обслуживания и запланированной операции обслуживания.
* В команду `yc managed-elasticsearch cluster update` добавлены параметры `--maintenance-window-anytime` и `--maintenance-window-weekly` для указания параметров окна обслуживания.
* Добавлена команда `yc managed-elasticsearch cluster reschedule-maintenance` для управления запланированной задачей по обслуживанию кластера.
* Добавлена команда `yc managed-elasticsearch cluster backup` для снятия снапшота с кластера.
* Добавлена команда `yc managed-elasticsearch cluster restore` для восстановления кластера из бэкапа.
* Добавлена команда `yc managed-elasticsearch cluster list-backups` для просмотра бэкапов данного кластера.
* Добавлена команда `yc managed-elasticsearch backup list` для просмотра бэкапов всех кластеров в каталоге.
* Добавлена команда `yc managed-elasticsearch backup get` для просмотра информации о конкретном бэкапе.
* В команды `yc managed-sqlserver cluster create` и `yc managed-sqlserver cluster restore` добавлен параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
* В команду `yc managed-sqlserver cluster restore` добавлен флаг `--deletion-protection`, который позволяет установить защиту от случайного удаления кластера.

### Версия 0.86.0 (15.12.21) {#version0.86.0}


#### Изменения в CLI {#cli}

* Добавлена возможность передачи [IAM-токена](../iam/concepts/authorization/iam-token.md) через переменную окружения `YC_IAM_TOKEN`.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* В команду `yc managed-kafka cluster update` добавлен параметр `--maintenance-window`, позволяющий задать параметры окна обслуживания.
* Добавлена команда `yc managed-kafka cluster reschedule-maintenance`, позволяющая изменить время запуска запланированной задачи по обслуживанию кластера.


##### {{ alb-name }} {#alb}

* В команды `yc application-load-balancer target-group {add,update,remove}-targets` для параметра `--target` добавлен ключ `private-ip-address`, который позволяет не указывать идентификаторы подсетей для адресов из приватных диапазонов.
* Добавлены команды для управления TCP-обработчиками L7-балансировщиков:
  * `yc alb load-balancer add-stream-listener`
  * `yc alb load-balancer update-stream-listener`
  * `yc alb load-balancer add-stream-sni`
  * `yc alb load-balancer update-stream-sni`
* Добавлены синонимы (алиасы) команд для управления обработчиками L7-балансировщиков:
  * `yc alb load-balancer add-listener` — `add-http-listener`
  * `yc alb load-balancer update-listener` — `update-http-listener`
  * `yc alb load-balancer add-sni` — `add-http-sni`
  * `yc alb load-balancer update-sni` — `update-http-sni`
  * `yc alb load-balancer remove-listener` — `remove-http-listener`, `remove-stream-listener`
  * `yc alb load-balancer remove-sni` — `remove-http-sni`, `remove-stream-sni`

##### {{ cdn-name }} {#cdn}

* Добавлены команды для управления ресурсами {{ cdn-name }}:
  * `yc cdn resource create`
  * `yc cdn resource update`

##### {{ cloud-logging-name }} {#cloud-logging}

* В команды `yc logging group {create,update}` добавлен параметр `--data-stream` для поддержки {{ yds-full-name }}.

##### {{ vpc-name }} {#vpc}

* Добавлены команды `yc vpc subnet add-range` и `remove-range` для добавления или удаления диапазонов адресов в подсетях.

##### {{ ydb-name }} {#ydb}

* В команду `yc ydb database create` добавлен параметр `--labels` — он задает набор меток для БД.
* В команду `yc ydb database update` добавлен параметр `--labels` — он меняет весь набор меток для БД.
* Добавлены команды для управления метками `yc ydb database add-labels` и `yc ydb database remove-labels`.


### Версия 0.85.0 (29.11.21) {#version0.85.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Команда `yc managed-kafka cluster update`.

  Добавлен флаг `--version`, позволяющий обновить версию кластера {{ KF }}.


##### {{ managed-k8s-name }} {#k8s}

* Команда `yc k8s cluster update`.

  Добавлен параметр `--node-ipv4-mask-size` — он измеряет размер `CIDR`, выделяемый на каждый узел кластера.

##### {{ alb-name }} {#alb}

* Добавлены команды для работы с Stream бэкендами:
  * Добавление Stream бэкенда: `yc application-load-balancer backend-group add-stream-backend`.
  * Изменение Stream бэкенда: `yc application-load-balancer backend-group update-stream-backend`.
  * Удаление Stream бэкенда: `yc application-load-balancer backend-group delete-stream-backend`.

##### {{ resmgr-name }} {#resmgr}

* Добавлена команда `yc resource-manager folder delete`, которая позволяет удалить каталог.


#### Изменения в CLI {#cli}

Исправлена ошибка в команде `yc init`. Теперь при проверке доступности endpoints не игнорируются настройки proxy.

### Версия 0.84.0 (16.11.21) {#version0.84.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ cdn-name }} {#cdn}

* Добавлена команда `yc cdn resource` для управления ресурсами {{ cdn-name }} (get, list, delete, get-provider-cname).


##### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Добавлена команда `yc managed-kafka cluster move`.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 5.0.
* Добавлена команда `{{ yc-mdb-mg }} hosts restart` для перезагрузки указанных хостов.

**{{ mmy-name }}**

* В вывод команды `yc managed-mysql hosts list` добавлена колонка `BACKUP PRIORITY`.

**{{ mch-name }}**

В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster restore` добавлены новые флаги:
* `--embedded-keeper` — позволяет создать кластер, используя {{ CH }} вместо {{ ZK }}.


##### {{ dataproc-name }} {#dataproc}

* Команда `yc dataproc cluster create`, флаг `--subcluster`.

  Добавлен параметр `assign-public-ip`, позволяющий выделить публичные IP-адреса для всех хостов подкластера.


### Версия 0.83.0 (26.10.21) {#version0.83.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ cdn-name }} {#cdn}

* Добавлены группы команд для поддержки сервиса {{ cdn-full-name }}, который позволяет организовать доставку контента до конечных потребителей с помощью сети распространения контента (Content Delivery Network, CDN):
  * `yc cdn origin` — для управления источниками.
  * `yc cdn origin-group` — для управления группами источников.
  * `yc cdn provider` — для подключения к провайдеру CDN.
  * `yc cdn cache` — для управления кешированием контента CDN-ресурсов.

##### {{ alb-name }} {#alb}

* Добавлены команды `yc application-load-balancer load-balancer start` и `yc application-load-balancer load-balancer stop` для запуска и остановки L7-балансировщика.

##### {{ ydb-name }} {#ydb}

* Добавлены команды `yc ydb database start` и `yc ydb database stop` для запуска и остановки БД.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* В команду `yc managed-redis cluster start-failover` добавлен параметр `--hostnames` для указания хостов кластера (в том числе шардированного), с которых нужно переключить мастер.

**{{ mkf-name }}**

* Добавлена команда `yc managed-kafka cluster list-logs` для получения лога кластера.

**{{ mmy-name }}**

* В команду `yc managed-mysql hosts update` добавлены параметры:
  * `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.
  * `--backup-priority` для изменения приоритета хоста при создании резервных копий кластера.

**{{ mpg-name }}**

* В команду `yc managed-postgresql hosts update` добавлен параметр `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.

### Версия 0.82.0 (23.09.21) {#version0.82.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ compute-name }} {#compute}

* Добавлен флаг `--pooled` в команду `yc compute image create` для создания образа, оптимизированного для развертывания.
* Добавлена группа команд `yc compute filesystem` для управления файловыми хранилищами.
* Добавлены новые команды для подключения и отключения файловых хранилищ от ВМ: `yc compute instance attach-filesystem` и `yc compute instance detach-filesystem`.
* Добавлен параметр `--attach-filesystem` в команду `yc compute instance create` для создания ВМ с подключенным файловым хранилищем.

##### {{ managed-k8s-name }} {#k8s}

* Добавлен параметр `--node-labels` в команду `yc k8s node-group update` — он меняет весь набор меток для узлов группы.
* Добавлена команда `yc k8s node-group add-node-labels` для добавления меток к узлам группы.
* Добавлена команда `yc k8s node-group remove-node-labels` для удаления меток для узлов группы.

##### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create yds` для создания триггеров для {{ yds-name }}.

##### {{ serverless-containers-name }} {#serverless-containers}

* Добавлена группа команд `yc serverless containers` для поддержки сервиса {{ serverless-containers-full-name }} — он позволяет запускать контейнеры без необходимости работы с {{ k8s }} или разворачивания ВМ.

##### {{ vpc-name }} {#vpc}

* Добавлена команда `yc vpc network list-route-tables` для списка таблиц роутинга в сети.
* Добавлена команда `yc vpc network list-security-groups` для списка групп безопасности в сети.

#### {{ dataproc-name }} {#dataproc}

* Добавлен параметр `--log-group-id` в команды `yc dataproc cluster create` и `yc dataproc cluster update` для привязки лог-группы {{ cloud-logging-name }} к кластеру. Чтобы остановить отправку логов кластера в {{ cloud-logging-name }}, укажите пустое значение в качестве идентификатора лог-группы: `--log-group-id=""`.

##### {{ ydb-name }} {#ydb}

* Добавлены параметры для управления лимитами БД в режиме Serverless в команды `yc ydb database create` и `yc ydb database update`:
  * `--sls-storage-size`
  * `--sls-throttling-rcu`
  * `--sls-enable-throttling-rcu`
  * `--sls-provisioned-rcu`


##### Managed Service for Redis

* Значение параметра `--redis-version` по умолчанию в команде `yc managed-redis cluster create` изменено на 6.2.

##### {{ mmy-name }}

* Добавлено отображение настройки `replication source` в команду `yc managed-mysql hosts list`.

##### {{ mpg-name }}

* Добавлено отображение настройки `replication source` в команду `yc managed-postgresql hosts list`.

##### {{ data-transfer-name }}

* Добавлены группы команд `yc datatransfer endpoint` и `yc datatransfer transfer` для управления эндпоинтами и трансферами сервиса {{ data-transfer-full-name }}.

### Версия 0.81.0 (06.09.21) {#version0.81.0}

#### Изменения в CLI {#cli}

* Добавлено описание параметров и команд в автодополнении по умолчанию.
* Команда `yc completion <SHELL>`.

  Добавлен флаг `--without-desc` для отключения описания в автодополнении.
* Поддержано автодополнение параметров: `folder-id`, `folder-name`, `cloud-id`, `format`, `profile`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create billing-budget` для создания триггеров на события от сервиса {{ billing-name }}.
* Добавлены команды для управления подключениями к управляемым БД:
  * `yc serverless mdbproxy update clickhouse`
  * `yc serverless mdbproxy create clickhouse`

##### {{ cloud-logging-name }} {#logging}

* Исключена суб-команда `get-default` из `logging group`.


### Версия 0.80.0 (19.08.21) {#version0.80.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ ig-name }} {#instance-groups}

* Добавлены новые параметры для команды обновления группы ВМ (`yc compute instance-group update`):
  * `--new-name`
  * `--description`
  * `--labels`
  * `--variables`
  * `--service-account-name`
  * `--service-account-id`
  * `--scale-policy-fixed-scale-size`
  * `--scale-policy-auto-scale-min-zone-size`
  * `--scale-policy-auto-scale-max-size`
  * `--template-name`
  * `--template-description`
  * `--template-labels`
  * `--template-metadata`
  * `--template-metadata-files`
  * `--template-memory`
  * `--template-cores`
  * `--template-core-fraction`
  * `--template-gpus`
  * `--template-platform`
  * `--template-placement-group`
  * `--template-service-account`

##### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create logging` для создания триггеров на {{ cloud-logging-name }}.

##### {{ alb-name }} {#alb}

* Добавлены команды для работы с gRPC-маршрутами:
  * `yc application-load-balancer virtual-host append-grpc-route`
  * `yc application-load-balancer virtual-host prepend-grpc-route`
  * `yc application-load-balancer virtual-host insert-grpc-route`
  * `yc application-load-balancer virtual-host remove-grpc-route`
  * `yc application-load-balancer virtual-host update-grpc-route`
* Добавлена команда `yc application-load-balancer virtual-host update-http-route` для обновления HTTP-маршрутов.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}, {{ mes-name }}, {{ mkf-name }}, {{ mmg-name }}, {{ mmy-name }}, {{ mpg-name }}, Managed Service for Redis, {{ mms-name }}**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`.

  Флаг `--deletion-protection` позволяет установить защиту от случайного удаления кластера. Для снятия защиты от удаления укажите `--deletion-protection=false`.

**{{ mmg-name }}**

* Добавлена команда `{{ yc-mdb-mg }} hosts stepdown`.

  Команда переключает выбранный мастер в режим реплики, мастером в этом случае станет доступная реплика.
* Команды `{{ yc-mdb-mg }} cluster get` и `{{ yc-mdb-mg }} cluster update`.

  Добавлено поле `backup-retain-period-days`, показывающее сколько дней хранятся автоматические резервные копии.

**Managed Service for Redis**

* Добавлена поддержка {{ RD }} версии 6.2.

**{{ mmy-name }}**

* Команда `yc managed-mysql hosts update`.

  Добавлена команда`yc managed-mysql hosts update HOST --replication-source HOST` для указания источника репликации каскадной реплики.


**{{ mms-name }}**

* Добавлена команда `yc managed-sqlserver database restore`.

  Команда позволяет восстановить заданную БД на существующем кластере из резервной копии. Возможно восстановление под другим именем.


**{{ mkf-name }}**

* Добавлена поддержка {{ KF }} 2.8.


##### {{ dataproc-name }} {#dataproc}

* Команды `yc dataproc cluster create`, `yc dataproc cluster update`.

  Флаг `--deletion-protection` позволяет установить/убирать для кластера защиту от случайного удаления.

  Для снятия защиты от удаления укажите `--deletion-protection=false`.

##### {{ resmgr-name }} {#resmgr}

* Команда `yc resource-manager cloud list`.

  Добавлено отображение организации облака.

##### {{ org-full-name }} {#organization}

Появилась поддержка сервиса {{ org-full-name }}.

{{ org-name }} — это решение для корпоративных клиентов, с помощью которого можно подключить к вашей организации сервисы {{ yandex-cloud }} и управлять доступом сотрудников к этим сервисам.

Сервис {{ org-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../organization/).

##### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless trigger create`.

  Параметры `--invoke-container-name`, `--invoke-container-id` и `--invoke-container-path` позволяют указать для триггера контейнер {{ serverless-containers-name }}.


### Версия 0.79.0 (13.07.21) {#version0.79.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ cloud-logging-name }} {#logging}

Добавлена поддержка сервиса {{ cloud-logging-full-name }}.

{{ cloud-logging-name }} — сервис для чтения и записи логов сервисов и пользовательских приложений.

Сервис {{ cloud-logging-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее о сервисе читайте в [документации](../logging/).

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless function set-scaling-policy` для задания настроек масштабирования функции.
* Добавлена команда `yc serverless function list-scaling-policies` для просмотра настроек масштабирования функции.
* Добавлена команда `yc serverless function remove-scaling-policy` для удаления настроек масштабирования функции.
* Команда `yc serverless function version create`.

  Исправлена обработка директорий для параметра `--source-path` на Windows.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команда `yc managed-clickhouse cluster update`.

  Добавлен параметр `--cloud-storage` для включения хранения данных в {{ objstorage-name }}.

### Версия 0.78.0 (29.06.21) {#version0.78.0}



#### {{ managed-k8s-name }} {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--network-acceleration-type`, который позволяет указать для группы узлов тип сети: стандартная или программно-ускоренная.

* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--cilium` для создания кластера, который поддерживает туннельный режим и использует Cilium CNI.

#### {{ dataproc-name }} {#dataproc}

* Команда `yc dataproc job create-<JOB-TYPE>`.

  Теперь после запуска задания в терминале отображается лог его выполнения.


### Версия 0.77.0 (07.06.21) {#version0.77.0}


**{{ compute-name }}**

* Команда `yc compute instance`.

  В `network_interface` добавлены ключи `dns-record-spec` и `ipv6-dns-record-spec`.

**{{ api-gw-name }}**

* Добавлена команда `yc serverless api-gateway add-domain` для привязывания домена к API-шлюзу.
* Добавлена команда `yc serverless api-gateway remove-domain` для отсоединения домена от API-шлюза.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mes-name }}**

* Команда `yc managed-elasticsearch cluster list-logs`.

  Добавлен параметр `--service-type` для получения логов Kibana.

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлен параметр `--service-account`.

**{{ mkf-name }}**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.

  Добавлены параметры `--num-partitions` и `--default-replication-factor` для задания и изменения конфигурационных настроек брокеров {{ KF }}.

**Managed Service for Redis**

* Команды `yc managed-redis cluster create\update`.

  Добавлены параметры `--slowlog-log-slower-than`, `--slowlog-max-len`, `--databases` и `--notify-keyspace-events` (см. описание в redis.conf).

### Версия 0.76.0 (19.05.21) {#version0.76.0}

**{{ mpg-name }}**

* Команда `yc managed-postgresql cluster update`.

  Добавлен флаг `--serverless-access` для доступа к хостам кластера {{ mpg-full-name }} из функции {{ sf-full-name }}.


**{{ vpc-name }}**

* Добавлена команда `yc vpc address move` для перемещения адреса между каталогами облака.

**{{ compute-name }}**

* Команда `yc compute instance-group`.

  В вывод групп добавлено отображение статуса группы.


### Версия 0.75.0 (13.04.21) {#version0.75.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ compute-name }} {#compute}

* Команда `yc compute create-with-container`.

  Добавлен параметр `--gpus`, который позволяет создать {{ coi }} с [GPU](../glossary/gpu.md).


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* Команда `yc managed-redis cluster create`.

  Добавлен параметр `--disk-type-id [local-ssd|network-ssd]`, который позволяет выбрать тип диска.

**{{ mmy-name }}**

* Команда `yc managed-mysql cluster list-logs`.

  Теперь логи по умолчанию выводятся в необработанном формате (as is). Чтобы включить старый формат логов, используйте параметр `--format=yaml`.

**{{ mes-name }}**

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлены флаги управления паролем администратора кластера (пользователь `admin`):
  * `--admin-password`, который позволяет вручную задать пароль;
  * `--generate-admin-password`, который позволяет автоматически сгенерировать пароль;
  * `--read-admin-password`, который позволяет задать пароль из файла.
* Удалены команды `yc managed-elasticsearch user`. Управление пользователями теперь доступно нативными средствами {{ ES }} через пользователя `admin`.
* Команда `yc managed-elasticsearch create`.

  Добавлен параметр `--edition [basic|gold|platinum]`, который позволяет указать редакцию {{ ES }} при создании кластера.

**{{ mkf-name }}**

* Команда `yc managed-kafka cluster create`.

  Добавлен параметр `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.


#### {{ dataproc-name }} {#dataproc}

* Команда `yc dataproc cluster create`.

  Добавлен параметр `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.


### Версия 0.74.0 (29.03.21) {#version0.74.0}

* Добавлена поддержка платформ macOS/arm64 (Apple Silicon M1) и linux/arm64.


#### Изменения в сервисах {{ yandex-cloud }}

#### {{ dataproc-name }} {#dataproc}

* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.

  Добавлен параметр `--security-group-ids`, который позволяет установить набор групп безопасности для кластера.


### Версия 0.73.0 (17.03.21) {#version0.73.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ container-registry-name }} {#container-registry}

Добавлены команды управления разрешенными IP-адресами для загрузки и скачивания Docker-образов:
* `yc container registry add-ip-permissions` добавляет IP-адреса.
* `yc container registry list-ip-permissions` позволяет посмотреть IP-адреса.
* `yc container registry set-ip-permissions` устанавливает IP-адреса.
* `yc container registry remove-ip-permissions` удаляет IP-адреса.

#### {{ sf-name }} {#cloud-functions}

* Команда `yc serverless function version create`.

  Добавлены значения по умолчанию для параметров:
  * `--execution-timeout` – три секунды;
  * `--memory` – 128 МБ.
* Команда `yc serverless function version create`.

  Добавлен параметр `--add-service-account` для указания дополнительных сервисных аккаунтов для версии.

#### {{ cloud-logs-name }} {#logs}

* Добавлена команда `yc logs`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Команда `yc managed-kafka cluster create`.

  Для параметров `--disk-size`, `--disk-type`, `--resource-preset`, `--zookeeper-disk-size`, `--zookeeper-disk-type` и `--zookeeper-resource-preset` теперь не указываются значения по умолчанию. Если значения не указаны, будут применяться значения по умолчанию, заданные на сервере.
* Команда `yc managed-kafka cluster create`.

  Добавлен флаг `--unmanaged-topics`, позволяющий включить управление топиками {{ KF }} через AdminAPI.

  Добавлен флаг `--auto-create-topics-enable`, позволяющий включить автоматическое создание топиков {{ KF }}.

* Команда `yc managed-kafka user create`.

  Добавлена роль `admin`, позволяющая включить управление топиками кластера {{ KF }} через AdminAPI.

**Managed Service for Redis**

* Команда `yc managed-redis cluster create`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера {{ RD }}.

* Команда `yc managed-redis cluster restore`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера {{ RD }} из резервной копии.

### Версия 0.72.0 (11.02.21)



#### Изменения в сервисах {{ yandex-cloud }}

#### {{ alb-name }} {#alb}

Добавлена первичная поддержка сервиса {{ alb-full-name }}:
* Команды группы `yc alb backend-group` позволяют управлять группой бэкендов.
* Команды группы `yc alb http-router` позволяют управлять HTTP-роутерами.
* Команды группы `yc alb load-balancer` позволяют управлять L7-балансировщик.
* Команды группы `yc alb target-group` позволяют управлять целевыми группами.
* Команды группы `yc alb virtual-host` позволяют управлять виртуальными хостами.

#### {{ compute-name }} {#compute}

* Команды `yc compute instance|disk|image list` теперь возвращают более 1000 элементов.


### Версия 0.71.0 (03.02.21) {#version0.71.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Добавлен параметр `--placement-group`, позволяющий указать `placement policy group` для группы узлов при создании.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

  Для параметра `--postgresql-version string` добавлено значение `13` для создания кластера {{ PG }} версии 13.

**{{ mmy-name }}**

* Команда `yc managed-mysql cluster update`.

  Добавлен флаг `--mysql-version`, позволяющий обновить версию {{ MY }}-сервера.

**{{ mes-name }}**

* Добавлены команды `yc managed-elasticsearch hosts create` и `yc managed-elasticsearch hosts delete` для добавления и удаления хостов.


**{{ mms-name }}**

Добавлена первичная поддержка сервиса {{ mms-full-name }}:
* Команды группы `yc managed-sqlserver cluster` позволяют управлять кластерами.
* Команды группы `yc managed-sqlserver database` позволяют управлять БД.
* Команды группы `yc managed-sqlserver user` позволяют управлять пользователями.


**{{ mch-name }}**

* Команды `yc managed-clickhouse host add` и `yc managed-clickhouse shards add`.

  Добавлен флаг `--copy-schema`, который позволяет скопировать схему с других хостов {{ CH }}.

### Версия 0.70.0 (22.12.20) {#version0.70.0}


#### Изменения в CLI {#cli}

**Улучшено**

* Команда `yc container registry configure-docker`.

  Добавлен флаг `--disable`, позволяющий отключить интеграцию с Docker Credential Helper.


#### Изменения в сервисах {{ yandex-cloud }}


#### {{ iam-name }} {#iam}

Добавлена команда `yc iam federation list-user-accounts` для листинга пользователей федерации.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}, {{ mpg-name }}, {{ mch-name }}, Managed Service for Redis, {{ mmg-name }}, {{ mkf-name }}**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update` и `yc <имя сервиса управляемой БД> cluster restore`.

  Параметр `--security-group-ids` позволяет установить для кластера набор групп безопасности.

**{{ mkf-name }}**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.

  Добавлены параметры для задания и изменения конфигурационных настроек {{ KF }} брокеров: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, `--log-preallocate`.
* Команды `yc managed-kafka topic create` и `yc managed-kafka topic update`.

  Добавлены параметры для задания и изменения настроек топика: `--cleanup-policy`, `--compression-type`, `--delete-retention-ms`, `--file-delete-delay-ms`, `--flush-messages`, `--flush-ms`, `--min-compaction-lag-ms`, `--retention-bytes`, `--retention-ms`, `--max-message-bytes`, `--min-insync-replicas`, `--segment-bytes`, `--preallocate`.

**{{ mes-name }}**

Добавлена первичная поддержка сервиса {{ mes-name }}:
* Команды группы `yc managed-elasticsearch cluster` позволяют управлять кластерами.
* Команды группы `yc managed-elasticsearch user` позволяют управлять пользователями.

### Версия 0.69.0 (02.12.20) {#version0.69.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ managed-k8s-name }} {#k8s}

* Исправлен парсинг флага `ipv6-address` для сетевой спецификации групп узлов.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

Добавлена первичная поддержка сервиса {{ mkf-name }}:
* Команды группы `yc managed-kafka cluster` позволяют управлять кластерами.
* Команды группы `yc managed-kafka topic` позволяют управлять топиками.
* Команды группы `yc managed-kafka user` позволяют управлять пользователями.

**{{ mmy-name }}**

* Команда `yc managed-mysql user grant-permission`.

  Параметр `--permissions` поддерживает привилегию `REFERENCES`.

**{{ mmy-name }}, {{ mpg-name }}**

* Команда `yc <имя сервиса управляемой БД> cluster update`.

  Добавлен флаг `--websql-access` для управления доступом из [консоли управления]({{ link-console-main }}).

### Версия 0.68.0 (03.11.20) {#version0.68.0}

#### Изменения в сервисах {{ yandex-cloud }}


#### {{ compute-name }} {#compute}

* Добавлена возможность указать размер блока для дисков при создании ВМ.

#### {{ kms-name }} {#kms}

* Команда `yc kms symmetric-key create`.

  Добавлен флаг `--deletion-protection` для включения защиты ключа от удаления.
* Команда `yc kms symmetric-key update`.

  Добавлены флаги для включения и выключения защиты ключа от удаления: `--deletion-protection` и `--no-deletion-protection`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore` и `yc managed-clickhouse cluster update`.

  Добавлены флаги:
  * `--admin-password`, `--generate-admin-password` и `--read-admin-password` — устанавливает пароль пользователя `admin`, который используется при включенном управлении пользователями через SQL.
  * `--enable-sql-database-management` — включает управление БД через SQL.
  * `--enable-sql-user-management` — включает управление пользователями и правами доступа через SQL.

**{{ mmy-name }}**

* Команда `yc managed-mysql user grant-permission`.

  Добавлен параметр `--permissions`, который поддерживает привилегии `ALL_PRIVILEGES` (синоним для `ALL`).


#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены флаги `--cluster-ipv6-range`, `--dual-stack` и `--service-ipv6-range`, которые позволяют создавать кластеры {{ k8s }} с параллельным использованием IPv4 и IPv6.
* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

  Добавлен параметр `--security-group-ids`, который устанавливает для кластера группу безопасности.
* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--network-interface`, который позволяет более детально задавать сетевые спецификации для узлов. Например, управлять настройкой групп безопасности для сетевых интерфейсов и настраивать интерфейсы узлов для параллельного использования IPv4 и IPv6 в кластерах {{ k8s }}.


### Версия 0.67.0 (05.10.20) {#version0.67.0}



#### Изменения в сервисах {{ yandex-cloud }}

#### {{ compute-name }} {#compute}

**Исправлено**

* Исправлена ошибка, при которой не получалось добавить ВМ в существующую группу размещения.

#### {{ container-registry-name }} {#container-registry}

* Добавлены команды `yc container image list-vulnerabilities` и `yc container image scan` для сканирования Docker-образов.


### Версия 0.66.0 (28.09.20) {#version0.66.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ compute-name }} {#compute}

* Добавлена команда `yc compute host-group`, позволяющая управлять выделенными хостами.
* Добавлена команда `yc compute host-type`, позволяющая управлять типами выделенных хостов.
* Добавлена команда `yc compute disk-placement-group`, позволяющая управлять группами нереплицированных дисков.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Команда `yc managed-mongodb cluster restore --help`.

  Добавлен пример использования параметра `--recovery-target-timestamp`.

### Версия 0.65.0 (22.09.20) {#version0.65.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ dataproc-name }} {#dataproc}

Добавлена поддержка функциональности UI Proxy:
* Добавлена команда `yc dataproc cluster list-ui-links`, позволяющая получить список ссылок для доступа к интерфейсам кластера {{ dataproc-name }}.
* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.
  Добавлен параметр `--ui-proxy`, позволяющий включить функциональность UI Proxy для кластера {{ dataproc-full-name }}.
* Команды `yc dataproc cluster create`, `yc dataproc subcluster create`, `yc dataproc subcluster update`.
  Добавлены параметры для автомасштабируемых подкластеров: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration` и `--warmup-duration`.
* Команда `yc dataproc subcluster list`.
  В ответ добавлено поле `instance group id` с идентификаторами групп ВМ автомасштабируемых подкластеров.

#### {{ certificate-manager-name }} {#certificate-manager}

* Добавлена команда `yc certificate-manager certificate content` для получения содержимого сертификата.

  С ее помощью можно загрузить цепочку сертификатов и закрытый ключ для самостоятельного использования в конфигурации веб-сервера на ВМ.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Команды `{{ yc-mdb-mg }} cluster get` и `{{ yc-mdb-mg }} cluster update`.

  Добавлено поле `backup-retain-period-days`, показывающее сколько дней хранятся автоматические резервные копии.
* Команды `{{ yc-mdb-mg }} cluster list-backups` и `{{ yc-mdb-mg }} backup list`.

  Добавлены поля `SIZE` и `TYPE`, содержащие размер и тип резервной копии.
* Команда `{{ yc-mdb-mg }} cluster list-logs`.

  Добавлен параметр `filter` позволяющий фильтровать запрашиваемые записи.

  Если задан параметр `follow`, то значение по умолчанию для параметра `limit` игнорируется. При этом явное указание параметра `limit` ограничивает количество выводимых записей.

### Версия 0.64.0 (08.09.20) {#version0.64.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ compute-name }} {#compute}

* Команда `yc compute instance-group`.

  * Добавлена возможность устанавливать и просматривать список ролей для группы ВМ: `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.
  * Добавлены команды для удаления и остановки ВМ в группе ВМ: `stop-instances`, `delete-instances`.


#### Сервисы управляемых баз данных {#managed-db}

* Команда `yc <имя сервиса управляемой БД> cluster list-logs` для всех управляемых БД использует новые методы [API](../glossary/rest-api.md) `StreamLogs` для стриминга логов.

  Всем командам добавлен флаг `--follow`, позволяющий получать новые записи логов по мере их появления.

**{{ mch-name }}**

* Добавлена команда `yc managed-clickhouse versions list` для получения списка версий, доступных для установки.
* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`.

  Добавлен параметр `--cloud-storage` для включения хранения данных в {{ objstorage-name }}.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 4.4.
* Команды `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster enable-sharding`.

  Для [шардированных](../managed-mongodb/concepts/sharding.md) кластеров появилась возможность задавать тип хоста: `mongoinfra`.


#### {{ certificate-manager-name }} {#certificate-manager}

Появилась поддержка сервиса для управления TLS-сертификатами: {{ certificate-manager-full-name }}.

С помощью {{ certificate-manager-name }} вы можете получать и обновлять TLS-сертификаты от Let's Encrypt®, а также импортировать собственные сертификаты.

Сертификаты можно использовать в сервисах {{ yandex-cloud }} для обеспечения безопасности соединений.

Сервис {{ certificate-manager-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../certificate-manager/).


### Версия 0.63.0 (28.08.20) {#version0.63.0}

#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена проблема с авторизацией для федеративных пользователей при инициализации нового профиля CLI.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ vpc-name }} {#vpc}

* Добавлена группа команд `yc vpc address` для управления [IP-адресами](../vpc/concepts/address.md#public-addresses).


### Версия 0.62.0 (20.08.20) {#version0.62.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless function version create`.
  * Добавлен параметр `--source-version-id` для указания базовой версии функции.
  * Добавлены параметры `--network-id` и `--network-name` для указания сети для версии функции. Детальный список подсетей можно указать с помощью параметров `--subnet-id` и `--subnet-name`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**

* Команда `yc managed-mysql user update`.

  Флаг `--global-permissions` позволяет выдать привилегию `PROCESS`.

**{{ mch-name }}, {{ mmy-name }}, {{ mpg-name }}, Managed Service for Redis, {{ mmg-name }}**

* Команда `yc <имя сервиса управляемой БД> cluster update`.

  Добавлены параметры `--maintenance-window-anytime` и `--maintenance-window-weekly` для указания параметров окон обслуживания. Они будут использованы для планирования времени работ с кластером.
* Добавлена команда `yc <имя сервиса управляемой БД> cluster reschedule-maintenance` для управления запланированной задачей по обслуживанию кластера.

**{{ mmg-name }}**

* Команда `yc managed-mongodb cluster restore`.

  Добавлен параметр `--recovery-target-timestamp` для указания точки восстановления резервной копии.

### Версия 0.61.0 (03.08.20) {#version0.61.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Теперь значение параметра `--version` корректно учитывается при создании регионального кластера.

##### {{ compute-name }} {#compute}

* Команда `yc compute instance update-network-interface`.

  Параметр `--security-group-id` теперь принимает список значений, разделенных запятыми.

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  Добавлен параметр `--coi-spec-file` для передачи [спецификации образа](../cos/concepts/coi-specifications.md#coi-spec-example).

  Добавлен параметр `--coi-spec-file` для передачи спецификации образа.

##### {{ vpc-name }} {#vpc}

* Команды `yc vpc subnet create` и `yc vpc subnet update`.

  Параметры `--domain-name-server` и `--ntp-server` теперь принимают список значений, разделенных запятыми.
* Добавлена команда `yc vpc subnet list-used-addresses`.

  Команда выводит список используемых в подсети адресов.


### Версия 0.60.0 (20.07.20) {#version0.60.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ compute-name }} {#compute}

* Добавлена команда `yc compute instance update-network-interface`.

  Команда позволяет изменять параметры сетевого интерфейса на уже созданных ВМ.

##### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless function logs`.

  Использование флага `--follow` теперь гарантирует получение журналов выполнения самой свежей версии функции с переданным тегом.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update` и `yc managed-clickhouse cluster restore`.

  Добавлен параметр `--service-account` для выбора сервисного аккаунта, привязанного к хостам.
* Добавлены команды для управления группами шардов `yc managed-clickhouse shard-groups`.

### Версия 0.59.0 (02.07.20) {#version0.59.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ api-gw-name }} {#api-gw}

Появилась поддержка сервиса {{ api-gw-full-name }}.

{{ api-gw-name }} — сервис для управления API-шлюзами, поддерживающий спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с другими облачными сервисами.

Сервис {{ api-gw-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее о сервисе читайте в [документации](../api-gateway/).

#### {{ iam-name }} {#iam}

* Командам `yc iam federation create` и `yc iam federation update` добавлены флаги:
  * `--encrypted-assertions` для включения шифрования утверждений SAML;
  * `--case-insensitive-name-ids` для включения нечувствительных к регистру Name IDs пользователей.


### Версия 0.58.0 (16.06.20) {#version0.58.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ sf-name }} {#serverless-functions}

* Добавлены команды для остановки и возобновления работы триггеров `yc serverless trigger pause` и `yc serverless trigger resume`.
* Команда `yc serverless function invoke`.

  Увеличено время ожидания результата вызова функции с 30 секунд до 25 минут.

##### {{ vpc-name }} {#vpc}

* Команды `yc vpc subnet create` и `yc vpc subnet update`.

  Добавлены параметры для настройки опций DHCP: `--domain-name`, `--domain-name-server` и `--ntp-server`.

##### {{ managed-k8s-name }} {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--gpus=GPUS` для указания количества GPU, которые будут на узлах.

##### {{ container-registry-name }} {#container-registry}

* Добавлены команды для управления политиками автоматического удаления Docker-образов `yc container repository lifecycle-policy`.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлены команды для управления метками `yc managed-mysql cluster add-labels` и `yc managed-mysql cluster remove-labels`.

**Managed Service for Redis**

* Добавлена поддержка {{ RD }} версии 6.

### Версия 0.57.0 (26.05.20) {#version0.57.0}


#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена работа Docker Credential helper с HTTPS-адресами. Теперь возможно получить аутентификационные данные для адреса вида `https://{{ registry }}`.


#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create container-registry` создания триггеров для {{ container-registry-full-name }}.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Изменена платформа и количество ядер, используемые по умолчанию при создании группы узлов. Теперь используется платформа Intel Cascade Lake (`standard-v2`) в двухъядерной конфигурации `cores: 2`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлена команда `{{ yc-mdb-ch }} format-schema`.

  Команда дает возможность управления Cap'n Proto и Protobuf схемами в кластере {{ CH }}.

**{{ mmg-name }}**

* Добавлена команда `{{ yc-mdb-mg }} hosts resetup`.

  Команда перезагружает данные на выбранном хосте: сначала удаляет все данные, а затем восстанавливает их из реплики.

### Версия 0.56.0 (23.04.20) {#version0.56.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### Все сервисы {#all}

* В командах `get` и `delete` теперь можно передавать несколько идентификаторов или имен ресурсов.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `yc managed-clickhouse user create` и `yc managed-clickhouse user update`.

  В помощи появилась информация про параметры флага `settings`.

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Команда `yc <имя сервиса управляемой БД> host list`.

  В выводе появился столбец со значениями `assign_public_ip`.

**Managed Service for Redis**

* Команда `yc managed-redis host list`.

  В выводе появились столбцы со значениями `type` и `shard_name`.


##### {{ coi }} {#coi}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  При передаче файла с переменными окружения через параметр `--container-env-file` корректно обрабатываются символы `=` в значениях переменных.


### Версия 0.55.0 (13.04.20) {#version0.55.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Поддержана аутентификация при использовании `http_proxy`.
* Добавлено автодополнение для командной оболочки `zsh`.
* При завершении выполнения операции сочетанием клавиш **Ctrl** + **C** `yc` выводит информацию о запущенной операции.

**Исправлено**

* Исправлено ожидание в 30 секунд, если в используемом профиле не задано свойство `folder-id` или `folder-name`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлен параметр `--node-ipv4-mask-size` для настройки размера `CIDR`, выделяемого на каждый узел кластера.
* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлены параметры `--max-unavailable` и `--max-expansion` для контроля количества удаляемых и создаваемых узлов в процессе обновления группы.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster restore`, `yc <имя сервиса управляемой БД> host add`.

  Добавлено свойство `subnet-name` к параметру `--host` для указания подсети по имени.

**{{ mmg-name }}, {{ mch-name }}, Managed Service for Redis**

* Команда `yc <имя сервиса управляемой БД> cluster list-logs`.

  Добавлено форматирование строчек лога.


#### {{ coi }} {#coi}

* Команда `yc compute instance create-with-container`.

  Добавлена возможность монтирования `docker volumes` в Docker-контейнер, созданный в {{ coi }} с помощью параметров `container-volume-tmpfs` и `container-volume-host-path`.
* Команда `yc compute instance update-container`.

  Добавлена возможность обновления `docker volumes` в Docker-контейнере, созданном в {{ coi }}.


### Версия 0.54.0 (24.03.20) {#version0.54.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Стали более понятными сообщения при ошибках ввода команд и параметров.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены параметры `--kms-key-id` и `--kms-key-name` для создания кластера {{ k8s }} с шифрованием секретов в KMS.


### Версия 0.53.0 (04.03.20) {#version0.53.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске `yc` на ВМ внутри {{ yandex-cloud }}, если в конфиге `yc` не указан `folder-id`, то будет использоваться каталог, в котором создана ВМ.
* Добавлен флаг `--version`, в дополнение к команде `yc version`.

**Исправлено**

* Исправлено обновление через `yc components update` на WSL 1.
* Исправлено аварийное завершение при вызове команды `yc help`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


##### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster get-credentials`.

  Добавлена проверка и выдача предупреждения, если у пользователя установлена утилита `kubectl` версии ниже 1.11, такие версии не поддерживают способ аутентификации, который задается данной командой.


##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} user`.

  Добавлена возможность управлять квотами пользователей.
* Команда `{{ yc-mdb-ch }} cluster`.

  Добавлены флаги `metrica-access`, `datalens-access` и `websql-access` в команды создания, восстановления и редактирования кластеров.
* Добавлены команды `{{ yc-mdb-ch }} ml-model`.

  Позволяет управлять ML моделями в кластере {{ CH }}.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, Managed Service for Redis**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`, `yc <имя сервиса управляемой БД> cluster restore`.

  Добавлен флаг `datalens-access`, регулирующий доступ {{ datalens-full-name }} к кластеру.

### Версия 0.52.1 (21.02.20) {#version0.52.1}

#### Изменения в CLI {#cli}

**Исправлено**

* При установке не пишется WARN о, на самом деле, несуществующей проблеме.

### Версия 0.52.0 (21.02.20) {#version0.52.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске `yc` с флагом `--help` или `-h`, помощь открывается в интерактивном режиме в `less` (`$PAGER`) на linux и macOS, в `more` на windows. Это убирает необходимость отматывать вывод помощи наверх.
* Debug логи выполнения и взаимодействия с API теперь сохраняются не в директорию установки, а в директорию конфигурации `$HOME/.config/yandex-cloud/logs`. Это устраняет проблему, когда `yc`, установленный как отдельный бинарный файл, неожиданно сохранял лог рядом и мог не иметь на это прав.
* Debug логи сохраняются и в случае успешных запросов. В случае обращения в поддержку по поводу проблемы возникшей в процессе выполнения команды `yc`, вероятно, мы сможем помочь быстрее, если вы приложите сохраненный лог.

**Исправлено**
* Во время выполнения команд `yc components ...` не выводится предложение обновиться.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Команда `yc compute instance create`.

  В параметр `--network-interface` добавлено свойство `nat-address`, позволяющее указать создаваемому инстансу конкретный NAT-адрес.
* Добавлены команды `yc compute instance add-one-to-one-nat` и `yc compute instance remove-one-to-one-nat`.

  Команды позволяют управлять NAT на уже созданных инстансах.
* Команды `yc compute instance create` и `yc compute instance update`.

  Добавлен параметр `--network-settings`, с помощью которого можно изменить тип сети на `Software accelerated` и обратно в `Standard`.

#### {{ kms-name }} {#kms}

* Команда `yc kms symmetric-key`.

  Добавлены команды, позволяющие управлять ролями на отдельные ключи: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--enable-network-policy` для создания кластера {{ k8s }} с поддержкой [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
* Команда `yc k8s cluster get-credentials`.

  Добавлен параметр `--context-name`, позволяющий пользователю указать имя создаваемого `context` в `kubeconfig`.

  Имя создаваемого контекста по умолчанию стало более понятным: `yc-<cluster-name>`.

  Выводится пояснение результата выполнения.


### Версия 0.51.0 (12.02.20) {#version0.51.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Команды `yc <сервис> <ресурс> create`.

  Добавлена возможность передавать имя ресурса как аргумент команды. Теперь команды вида `yc <сервис> <ресурс> create --name <имя ресурса>` и `yc <сервис> <ресурс> create <имя ресурса>` равнозначны.

  Например, вместо команды `yc managed-kubernetes cluster create --name my-cluster ...` теперь можно использовать команду `yc managed-kubernetes cluster create my-cluster ...`.
* Команды `yc <сервис> <ресурс> set-access-binding`.

  Добавлено предупреждение, что команда удаляет назначенные роли. Если команда вызвана пользователем напрямую (а не с помощью другой команды или скрипта), будет запрошено подтверждение.

**Исправлено**

* Команда `yc init`.

  Теперь значения параметров `--cloud-id`, `--folder-id` и `--folder-name` учитываются корректно.
* Отключены сообщения о наличии новой версии `yc` при неинтерактивном вызове команды.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ iam-name }} {#iam}

* Добавлены команды для создания и управления SAML-совместимыми федерациями удостоверений и сертификатами к ним: `yc iam federation` и `yc iam certificate`. Подробнее про SAML-совместимые федерации удостоверений можно узнать в [документации](../organization/concepts/add-federation.md).


### Версия 0.50.0 (27.01.20) {#version0.50.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

* Для [ресурсов, на которые можно назначать роли](../iam/concepts/access-control/resources-with-access-control.md).

  Добавлены альтернативы параметру `--subject` для команд управления ролями: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login` и `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Добавлен флаг `--auto-scale`, позволяющий создать группу узлов динамического размера под управлением [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

* Команда `yc compute instance create`.

  При указании флага `--gpus` автоматически выбирается платформа `gpu-standard-v1`.


### Версия 0.49.0 (21.01.20) {#version0.49.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске CLI с флагом `--debug`, строка лога ответа API-вызова теперь выводит не только gRPC-код статуса, но и его описание.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ kms-name }} {#kms}

Появилась поддержка сервиса для управления криптографическими ключами: {{ kms-full-name }}.

{{ kms-name }} позволяет создавать ключи шифрования и организовывать схемы защиты данных в ваших приложениях и сервисах.

Используйте ключи, чтобы защитить секреты, личные данные и другую конфиденциальную информацию, которую вы храните в облаке.

Сервис {{ kms-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../kms/).


### Версия 0.48.0 (27.12.19) {#version0.48.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При обновлении CLI теперь выводится текущая устанавливаемая версия.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ compute-name }} {#compute}

* Добавлена возможность работы с группой размещения `yc compute placement-group --help`.
* Команды `yc compute instance create` и `yc compute instance update`.

  Параметр для указания платформы переименован с `--platform-id` на `--platform`. Старое именование продолжает поддерживаться.
* Команда `yc compute instance create`.

  SSH-ключ, добавленный с помощью параметра `--ssh-key`, записывается в метаданные с ключом `ssh-keys` вместо `ec2-user-data`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**

* Добавлена поддержка создания кластера с версией {{ MY }} 8.0.
* Добавлена команда для ручного переключения мастера для указанного кластера {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.
* Команда `{{ yc-mdb-my }} cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**{{ mpg-name }}**

* Добавлена команда для ручного переключение мастера для указанного кластера {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.
* Команда `{{ yc-mdb-pg }} cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**Managed Service for Redis**

* Команда `{{ yc-mdb-rd }} cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

### Версия 0.47.0 (17.12.19) {#version0.47.0}



#### Изменения в CLI {#cli}

**Улучшено**

* Добавлена возможность [аутентификации с помощью федерации](operations/authentication/federated-user.md) при вызове `yc` в неинтерактивном режиме. Этот режим используется, когда CLI запускается пользователем не напрямую, например в скрипте или в `kubectl`.


### Версия 0.46.0 (13.12.19) {#version0.46.0}



#### Изменения в CLI {#cli}

**Улучшено**

* Для ускорения диагностики проблем авторизации, в журнал отладки запроса пишется CRC32 отправляемого [IAM-токена](../iam/concepts/authorization/iam-token.md).

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create object-storage` для подписки на изменения бакета в {{ objstorage-full-name }}.


### Версия 0.45.0 (03.12.19) {#version0.45.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Увеличено время между повторными попытками подключения в случае недоступности любого ресурса, задействованного в выполнении команды.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ iot-name }} {#iot}

* Добавлены команды для управления паролями: `yc iot registry password` и `yc iot device password`.
* Команды `yc iot registry create` и `yc iot device create`.

  Добавлены флаги для поддержки авторизации по логину и паролю: `--password`, `--read-password` и `--generate-password`.
* Команды `yc iot mqtt publish` и `yc iot mqtt subscribe`.

  Добавлены флаги для поддержки авторизации по логину и паролю: `--username` и `--password`.


### Версия 0.44.0 (19.11.19) {#version0.44.0}


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create timer` для вызова функций по таймеру.


#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена ошибка, которая в редких случаях приводила к попаданию в `stdout` нескольких строк `debug`-лога.

**Улучшено**

* Отключен показ поля `Status.details` для gRPC-ошибок — информация из него дублируется в поле `Status.message`, которое показывается как основное сообщение об ошибке.

### Версия 0.43.1 (14.11.19)



#### Изменения в CLI {#cli}

**Исправлено**

* Для Windows Subsystem for Linux (WSL) при авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../organization/concepts/add-federation.md) теперь корректно происходит переход в браузер.


### Версия 0.43.0 (11.11.19) {#version0.43.0}


#### Изменения в CLI {#cli}

* Добавлена возможность авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../organization/concepts/add-federation.md).

  Для этого выполните команду `yc init --federation-id=<FEDERATION_ID>`, после чего можно использовать CLI для работы от имени пользователя этой федерации.


#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ compute-name }} {#compute}

* Добавлены подробности в лог и в текст об ошибке при [авторизации изнутри ВМ](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (с помощью IAM-токена из метаданных).

* Добавлены подробности в лог и в текст об ошибке при авторизации изнутри ВМ (с помощью IAM-токена из метаданных).


#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Добавлена поддержка создания баз {{ PG }} версии 12.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 4.2.

### Версия 0.42.0 (21.10.19) {#version0.42.0}


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Добавлены команды `yc compute instance-group start`, `yc compute instance-group stop` для запуска и остановки группы ВМ.

#### {{ container-registry-name }} {#container-registry}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  Для значений "always", "never", "on-failure" параметра `--container-restart-policy` добавлено альтернативное написание: "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Удален флаг `--default-gateway-v4-address`.


#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

  Для параметра `--postgresql-version string` добавлено значение `10_1c` для создания кластера {{ PG }} версии 10-1c.

### Версия 0.41.1 (26.09.19) {#version0.41.1}

* Небольшие исправления и обновления.

### Версия 0.41.0 (25.09.19) {#version0.41.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ container-registry-name }} {#container-registry}

* Команда `yc compute instance create-with-container`.

  Из параметра `--create-boot-disk` удалена поддержка свойств `snapshot-*`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены параметры для управления типом мастера: `--regional`, `--region` и `--master-location`.
* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

  Добавлены параметры для управления политикой обслуживания: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.
* Команда `yc managed-kubernetes node-groups update`.

  Добавлены параметры для управления политикой обслуживания: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.


### Версия 0.40.0 (20.09.19) {#version0.40.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ container-registry-name }} {#container-registry}

* Добавлена команда для получения подробной информации о реестре: `yc container registry repository get`.
* Команда `yc container registry repository list`.

  Добавлен вывод уникального идентификатора реестра.


#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> create clusters`.

  Для параметра `--*resource-preset` добавлено значение по умолчанию: s2.micro.

**{{ mmg-name }}**

* Команда `{{ yc-mdb-mg }} create clusters`.

  Для параметра `--mongodb-version` изменено значение по умолчанию: с 3.6 на 4.0.

### Версия 0.39.0 (16.09.19) {#version0.39.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ container-registry-name }} {#container-registry}

* Команда `yc container registry`.

  Добавлена возможность устанавливать и просматривать список ролей для реестра Docker-образов: `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.


#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> users list`.

  При просмотре списка пользователей больше не отображается уникальный идентификатор кластера.

### Версия 0.38.0 (09.09.19) {#version0.38.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Улучшен вывод полей при просмотре списка API-ключей.

### Версия 0.37.0 (06.09.19) {#version0.37.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Добавлена проверка доступности эндпоинтов API {{ iam-full-name }}, {{ resmgr-full-name }}, {{ compute-full-name }}. Если эндпоинт недоступен, выдается ошибка.
* Добавлено отображение деталей ошибок.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ container-registry-name }} {#container-registry}

**Улучшено**

* Добавлена поддержка ОС Windows для работы с Docker Credential helper.
* Добавлена подробная ошибка при использовании `docker login` одновременно с Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

* Добавлены команды для управления метаданными группы ВМ: `yc compute instance-group add-metadata` и `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster update`.

  Добавлены параметры `--node-service-account-id` и `--node-service-account-name`, позволяющие добавить или изменить сервисный аккаунт для узлов у существующего кластера {{ k8s }}.
* Команда `yc managed-kubernetes node-group update`.

  Добавлены параметры для изменения параметров существующей группы узлов: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.
* Добавлены команды для управления метками: `yc managed-kubernetes node-group add-labels` и `yc managed-kubernetes node-group remove-labels`.
* Добавлены команды для управления метаданными группы узлов: `yc managed-kubernetes node-group add-metadata` и `yc managed-kubernetes node-group remove-metadata`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команда `{{ yc-mdb-pg }} cluster update`.

  Добавлен флаг `--connection-pool-discard` для отключения менеджера подключений.
* Команды `{{ yc-mdb-pg }} user create` и `yc managed-postgresql user update`.

  Добавлена возможность указать логин и задать права доступа для пользователя с помощью параметров `--login` и `--grants`.

### Версия 0.36.0 (27.08.19) {#version0.36.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ resmgr-name }} {#resmgr}

* Команда `yc resource-manager cloud update`.

  Добавлена возможность переименовать облако.


### Версия 0.35.1 (16.08.19) {#version0.35.1}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> cluster create`.

  Переименованы типы дисков по умолчанию: `network-nvme` на `network-ssd`, `local-nvme` на `local-ssd`.

### Версия 0.35.0 (09.08.19) {#version0.35.0}

#### Изменения в CLI {#cli}

**Улучшено**

* В сообщение о новой версии CLI добавлена ссылка на документацию с описанием релизов.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команда `{{ yc-mdb-pg }} cluster create`.

  Для параметра `--user` добавлены свойства: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Версия 0.34.0 (26.07.19) {#version0.34.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Redis**

* Команда `{{ yc-mdb-rd }} shards`.

  Добавлена поддержка шардов для кластеров {{ RD }}.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster add-external-dictionary`.

  Добавлена поддержка словарей {{ PG }}. Флаги для работы со словарями: `--postgresql-source`, `--postgresql-source-hosts` и `--postgresql-invalidate-query`.

**{{ mmy-name }}**

* Команда `{{ mmy-name }} cluster update-config --set`.

  Добавлена возможность глобально задать режим SQL с помощью параметра `sql_mode`.

### Версия 0.33.0 (19.07.19) {#version0.33.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Индикатор прогресса выполнения команды изменен с точек на [троббер](https://ru.wikipedia.org/wiki/Троббер).

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `{{ yc-mdb-pg }} user create` и `{{ yc-mdb-pg }} user update`.

  Добавлена настройка параметров пользователя с помощью параметров `--lock_timeout`, `--log_min_duration_statement` и т. д.

### Версия 0.32.0 (05.07.19) {#version0.32.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Команды для отображения списка элементов `yc <сервис> <ресурс> list`.

  Увеличено максимальное число элементов в выводе со 100 до 1000.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Команды `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster update-config`.

  Для [шардированных](../managed-mongodb/concepts/sharding.md) кластеров появилась возможность изменять параметры компонентов `mongos` и `mongocfg`.

### Версия 0.31.0 (01.07.19) {#version0.31.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При использовании CLI на ВМ, запущенной от имени сервисного аккаунта, по умолчанию CLI будет авторизовываться от имени этого сервисного аккаунта.

**Исправлено**

* Попытка получить ресурс, указав его уникальный идентификатор, завершалась с ошибкой, если в конфигурации CLI не был задан параметр `folder-id`.
* Попытка получить каталог, указав его уникальный идентификатор, завершалась с ошибкой, если у пользователя не было роли `viewer` на каталог в {{ yandex-cloud }}.
* Команда `yc init` завершалась с ошибкой, если у пользователя не было роли `viewer` в {{ yandex-cloud }}.

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ network-load-balancer-name }} {#load-balancer}

* Команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update`.

  Для параметра `--listener` появилась возможность задать свойство `target-port`, позволяющее настроить NAT так, чтобы целевые ресурсы принимали трафик на порту, отличном от порта `listener`.


#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `{{ yc-mdb-ch }} user create` и `{{ yc-mdb-ch }} user update`.

  Добавлен параметр `--settings`, позволяющий задать пользовательские настройки.

### Версия 0.30.0 (18.06.19) {#version0.30.0}



#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Команда `yc compute instance update`.

  Добавлены параметры `--service-account-id` и `--service-account-name`, позволяющие добавить или изменить сервисный аккаунт для существующей ВМ.
* Команда `yc compute instance create`.

  Изменено количество ядер, используемое по умолчанию при создании ВМ с платформой Intel Cascade Lake (`standard-v2`). Теперь `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster update`.

  Добавлен флаг `--default-gateway-v4-address`, позволяющий обновить адрес шлюза для существующего {{ k8s }} кластера.


### Версия 0.29.0 (11.06.19) {#version0.29.0}

* Небольшие исправления и обновления.

### Версия 0.28.0 (05.06.19) {#version0.28.0}

#### Изменения в CLI {#cli}

* Добавлено автоматическое повторное подключение в случае недоступности любого ресурса, задействованного в выполнении команды. CLI повторит попытку соединения 5 раз, частота повтора вычисляется с помощью экспоненциального откладывания (exponential backoff).

#### Изменения в сервисах {{ yandex-cloud }} {#services}


#### {{ compute-name }} {#compute-cloud}

* Команда `yc compute instance create`.

  Добавлен параметр `--gpus`, позволяющий указать количество графических процессоров у виртуальной машины.


#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> cluster get`.

  Улучшен вывод информации о кластере.
* Команда `yc <имя сервиса управляемой БД> cluster create`.

  Добавлен параметр `--backup-window-start`, позволяющий при создании кластера настроить время его ежедневного резервного копирования.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster add-zookeeper`.

  Добавлена возможность добавлять хосты {{ ZK }}.
* Команда: `{{ yc-mdb-ch }} shards add`.

  Изменена логика создания шардов:
  * Если не указан параметр `--host`, параметры для шарда копируются из самого старого шарда.
  * Если указан параметр `--host`, требуется введение всех параметров.
  * Если шарды отсутствуют, для создания шарда также требуется введение всех параметров.

{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
