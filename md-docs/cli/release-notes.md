# Релизы CLI

## Текущая версия {#latest-release}

### Версия 1.15.0 (30.06.26) {#v-1-15-0}

#### Managed Service for ClickHouse® {#v-1-15-0-mch-name}

* Добавлена команда `yc managed-clickhouse connect` для подключения к кластерам Managed Service for ClickHouse® от имени IAM-пользователя.
* В команду `yc managed-clickhouse user create` добавлен параметр для создания пользователей с IAM-аутентификацией.
* Для внешних словарей добавлены типы размещения `ssd_cache` и `complex_key_ssd_cache` в команды:
  * `yc managed-clickhouse cluster add-external-dictionary`;
  * `yc managed-clickhouse cluster update-external-dictionary`.
* Исправлено создание однохостового кластера без сервиса координации в команде `yc managed-clickhouse cluster create`.

#### Managed Service for MySQL® {#v-1-15-0-mmy-name}

Добавлена группа команд `yc managed-mysql backup-retention-policy` для управления LTR-политиками:
* `yc managed-mysql backup-retention-policy create`;
* `yc managed-mysql backup-retention-policy list`;
* `yc managed-mysql backup-retention-policy list-by-folder`;
* `yc managed-mysql backup-retention-policy delete`.

#### Cloud Registry {#v-1-15-0-cloud-registry-name}

Добавлена ветка команд `yc cloud-registry v1` на новом синтаксисе CLI.

#### Smart Web Security {#v-1-15-0-sws-name}

Добавлены команды для управления списками адресов, профилями ARL, WAF-профилями и наборами правил WAF:
* `yc smartwebsecurity match-list`;
* `yc smartwebsecurity advanced-rate-limiter`;
* `yc smartwebsecurity waf`.

#### Object Storage {#v-1-15-0-objstorage-name}

Исправлено определение типа содержимого в команде `yc storage s3 cp`.

#### Load Testing {#v-1-15-0-load-testing-name}

Удалена группа команд `yc loadtesting`, так как сервис Load Testing прекращает работу.

## Предыдущие релизы {#previous-release}

### Версия 1.14.0 (18.06.26) {#v-1-14-0}

#### Yandex Managed Service for Valkey™ {#v-1-14-0-mrd-name}

Добавлена группа команд `yc managed-redis backup-retention-policy` для управления LTR-политиками:
* `yc managed-redis backup-retention-policy create`;
* `yc managed-redis backup-retention-policy list`;
* `yc managed-redis backup-retention-policy delete`.

#### Yandex StoreDoc {#v-1-14-0-mmg-name}

Добавлена группа команд `yc managed-mongodb backup-retention-policy` для управления LTR-политиками:
* `yc managed-mongodb backup-retention-policy create`;
* `yc managed-mongodb backup-retention-policy list`;
* `yc managed-mongodb backup-retention-policy delete`.

#### Cloud Registry {#v-1-14-0-cloud-registry-name}

Добавлена команда вызова инструментов для работы с debian-реестрами `yc cloud-registry tools debian reindex-packages`.

#### BareMetal {#v-1-14-0-baremetal-name}

Добавлена ветка команд сервиса на новом синтаксисе `yc baremetal v2`.

#### Managed Service for Trino {#v-1-14-0-mtr-name}

Добавлен параметр `--retry-policy-exchange-manager-s3-bucket` в команды для использования S3-бакета в качестве хранилища Exchange Manager:
* `yc managed-trino cluster create`;
* `yc managed-trino cluster update`.

#### Yandex MPP Analytics for PostgreSQL {#v-1-14-0-mgp-name}

Добавлена поддержка Apache Cloudberry в команду обновления конфигурации СУБД `yc managed-greenplum cluster update-config`.

### Версия 1.13.0 (09.06.26) {#v-1-13-0}

#### Изменения в системных командах CLI {#v-1-13-0-yc}

* Добавлено удаление старого профиля при реинициализации `yc init`.

#### Yandex Managed Service for Valkey™ {#v-1-13-0-mrd-name}

Добавлен параметр `--databases` в команды для добавления/обновления пользователей в Valkey ACL:
* `yc managed-redis user create`;
* `yc managed-redis user update`.

#### Managed Service for OpenSearch {#v-1-13-0-mos-name}

Добавлены новые флаги для гранулярного управления событиями, которые отображаются в аудитных логах:
* `--compliance-enabled`;
* `--log-request-body`;
* `--log-search-queries`;
* `--log-data-modifications`;
* `--log-index-metadata-access`;
* `--log-monitoring-checks`;
* `--log-index-maintenance`;
* `--log-backup-operations`.

### Версия 1.12.0 (04.06.26) {#v-1-12-0}

#### Изменения в системных командах CLI {#v-1-12-0-yc}

* Добавлено удаление кешированных учетных данных при повторной инициализации профиля в `yc init`.
* OAuth-токены больше не принимаются в команде `yc init` без параметров.

#### Cloud Interconnect {#v-1-12-0-interconnect-name}

* Версия v1 для сервиса `cic` используется по умолчанию. 
* Изменены параметры команд `yc cic`:
  * В команды `list` добавлены параметры `--filter`, `--page-token` и `--folder-id`:
    * `yc cic partner list`;
    * `yc cic point-of-presence list`;
    * `yc cic private-connection list`;
    * `yc cic private-connection list-operations`;
    * `yc cic public-connection list`;
    * `yc cic public-connection list-operations`;
    * `yc cic trunk-connection list`;
    * `yc cic trunk-connection list-operations`;
    * `yc cic trunk-connection list-private-connections`;
    * `yc cic trunk-connection list-public-connections`.

  * В команды `get` добавлен параметр `--id`:
    * `yc cic partner get`;
    * `yc cic point-of-presence get`.

  * В командах `batch-get` вместо параметров `--id` и `--name` используются `--private-connection-ids` и `--trunk-connection-ids`:
    * `yc cic private-connection batch-get`;
    * `yc cic trunk-connection batch-get`.

  * В командах `move` удален параметр `--destination-folder-name`:
    * `yc cic private-connection move`;
    * `yc cic public-connection move`;
    * `yc cic trunk-connection move`.

  * В команды `update` добавлен параметр `--update-mask`:
    * `yc cic private-connection update`;
    * `yc cic trunk-connection update`.

#### Cloud Router {#v-1-12-0-cr-name}

* Версия v1 для сервиса `cloud-router` используется по умолчанию.

* Изменены параметры команд:  
  * `yc cloud-router routing-instance list` — добавлены `--filter`, `--page-token` и `--folder-id`;
  * `yc cloud-router routing-instance list-operations` — добавлен `--page-token`;
  * `yc cloud-router routing-instance move` — удален `--destination-folder-name`;
  * `yc cloud-router routing-instance update` — добавлен `--update-mask`;
  * `yc cloud-router routing-instance update-prefix-mask` — изменен тип `--new-mask` с `int32` на `int64`.

#### Managed Service for MySQL® {#v-1-12-0-managed-mysql}

* Поддержаны ресурсные группы для Apache Cloudberry™. Добавлены новые параметры `--cpu-max-percent`, `--cpu-weight`, `--memory-quota`, `--min-cost` и `--io-limit` для команд:

* Добавлен параметр `--deletion-protection` для защиты от удаления пользователей MySQL® для следующих команд:
  * `yc managed-mysql user create`;
  * `yc managed-mysql user update`.

#### Yandex MPP Analytics for PostgreSQL {#v-1-12-0-mgp-name}

Добавлена поддержка ресурс-групп Apache Cloudberry: новые параметры `--cpu-max-percent`, `--cpu-weight`, `--memory-quota`, `--min-cost`, `--io-limit` для команд:
  * `yc managed-greenplum resource-groups create`;
  * `yc managed-greenplum resource-groups update`.

### Версия 1.11.0 (28.05.26) {#v-1-11-0}

#### Cloud Interconnect {#v-1-11-0-cic-name}

* Добавлена команда `yc cic v1 private-connection batch-get` для получения списка приватных соединений по списку идентификаторов.

#### Virtual Private Cloud {#v-1-11-0-vpc-name}

* Добавлен параметр `--service-name` в команду `yc vpc private-endpoint create`.

### Версия 1.10.0 (25.05.26) {#v-1-10-0}

#### Managed Service for OpenSearch {#v-1-10-0-mos-name}

* Добавлена поддержка ролей `WARM` и `INGEST` для групп хостов.

### Версия 1.9.0 (21.05.26) {#v-1-9-0}

#### Cloud DNS {#v-1-9-0-dns-name}

* Добавлена группа команд `yc dns inbound-endpoint` для управления inbound endpoint:
  * `yc dns inbound-endpoint get`;
  * `yc dns inbound-endpoint list`;
  * `yc dns inbound-endpoint create`;
  * `yc dns inbound-endpoint update`;
  * `yc dns inbound-endpoint delete`;
  * `yc dns inbound-endpoint add-labels`;
  * `yc dns inbound-endpoint remove-labels`;
  * `yc dns inbound-endpoint list-access-bindings`;
  * `yc dns inbound-endpoint set-access-bindings`;
  * `yc dns inbound-endpoint add-access-binding`;
  * `yc dns inbound-endpoint remove-access-binding`;
  * `yc dns inbound-endpoint list-operations`.

### Версия 1.8.1 (20.05.26) {#v-1-8-1}

#### Smart Web Security {#v-1-8-1-sws-name}

* Добавлена группа команд `yc sws waf waf-profile` для управления WAF-профилями (create, get, list, update, delete) в syntax-2 CLI:
  * `yc sws waf waf-profile create`;
  * `yc sws waf waf-profile get`;
  * `yc sws waf waf-profile list`;
  * `yc sws waf waf-profile update`;
  * `yc sws waf waf-profile delete`.

#### Yandex Managed Service for Valkey™ {#v-1-8-1-mrd-name}

* Добавлен параметр `failover-type` для команды `start-failover`%
  * `yc redis cluster start-failover`.

#### Managed Service for PostgreSQL {#v-1-8-1-managed-postgresql}

* Добавлены параметры для настройки `folder-id` для создания соединений и их секретов в интеграции Connection Manager для Managed Service for PostgreSQL:
  * `yc managed-postgresql cluster create`;
  * `yc managed-postgresql cluster restore`;
  * `yc managed-postgresql cluster update`;
  * `yc managed-postgresql user create`.

* При детальном выводе одного пользователя удалено устаревшее поле `connection_manager` и добавлено заменяющее его u`ser_connection_manager`:
  * `yc managed-postgresql user get`;
  * `yc managed-postgresql user list`;
  * `yc managed-postgresql user create`.

* Прекращена поддержка устаревших версий PostgreSQL (13, 13-1c):
  * `yc managed-postgresql cluster update`;
  * `yc managed-postgresql cluster create`.

### Версия 1.8.0 (18.05.26) {#v-1-8-0}

#### Изменения в системных командах CLI {#v-1-8-0-yc}

* В `yc` добавлены деревья команд версий `v0` и `v1` на уровне сервиса. В поддереве `v1` используется новый интерфейс CLI. Деревья `v1` доступны для сервисов `yc cic`, `yc cloudrouter`, `yc smartcaptcha` и `yc smartwebsecurity`.
* Флаг `--syntax` удален и больше не поддерживается. Для выбора интерфейса используйте версии `v0` и `v1`, а также настройку в конфигурации `services.<service>.version`.

#### Yandex MPP Analytics for PostgreSQL {#v-1-8-0-mgp-name}

* Добавлен флаг `--port` для указания конкретного порта запуска прокси для Yandex MPP Analytics for PostgreSQL:
  * `yc managed-greenplum connect`.

#### Managed Service for PostgreSQL {#v-1-8-0-mpg-name}

* Добавлен флаг `--port` для указания конкретного порта запуска прокси для Managed Service for PostgreSQL:
  * `yc managed-postgresql connect`.

#### Cloud Interconnect {#v-1-8-0-cic-name}

* Добавлены поля `name`, `url`, `pop_ids` в вывод следующих команд:
  * `yc cic partner get`;
  * `yc cic partner list`.

#### Cloud Functions {#v-1-8-0-sf-name}

* В команде `yc serverless function version create` параметры `--subnet-id` и `--subnet-name` помечены как **DEPRECATED**. Для указания доступа к сети используйте только `--network-id` или `--network-name`.

#### Serverless Containers {#v-1-8-0-serverless-containers-name}

* Параметр `--subnets` помечен как **DEPRECATED**, для указания доступа к сети используйте только `--network-id` или `--network-name`:
  * `yc serverless container revision deploy`.

### Версия 1.7.0 (12.05.26) {#v-1-7-0}

#### BareMetal {#v-1-7-0-baremetal-name}

Добавлены параметры `--network-interface-id` и `--configuration-network-interface-id` в команды:
* `yc baremetal server create`;
* `yc baremetal server update`.

#### Cloud DNS {#v-1-7-0-dns-name}

Исправлено описание команд:
* `yc dns zone create`;
* `yc dns firewall create`.

#### Cloud Router {#v-1-7-0-cloudrouter-name}

Команды сервиса `yc cloudrouter` доступны в новом синтаксисе. Для вызова используйте `yc --syntax=2 cloudrouter ...` либо задайте `default-syntax: 2` или `services.cloudrouter.syntax: 2` в профиле:
  * `yc cloudrouter routing-instance add-private-connection`;
  * `yc cloudrouter routing-instance create`;
  * `yc cloudrouter routing-instance delete`;
  * `yc cloudrouter routing-instance get`;
  * `yc cloudrouter routing-instance get-by-cic-private-connection-id`;
  * `yc cloudrouter routing-instance get-by-vpc-network-id`;
  * `yc cloudrouter routing-instance list`;
  * `yc cloudrouter routing-instance list-operations`;
  * `yc cloudrouter routing-instance move`;
  * `yc cloudrouter routing-instance move-prefix`;
  * `yc cloudrouter routing-instance remove-prefixes`;
  * `yc cloudrouter routing-instance remove-private-connection`;
  * `yc cloudrouter routing-instance update`;
  * `yc cloudrouter routing-instance update-networks`;
  * `yc cloudrouter routing-instance update-prefix-mask`;
  * `yc cloudrouter routing-instance upsert-prefixes`.

#### Yandex MPP Analytics for PostgreSQL {#v-1-7-0-mgp-name}

В команде `yc managed-greenplum cluster create` удалена зависимость от версии Greenplum®.

#### Application Load Balancer {#v-1-7-0-alb-name}

Добавлен параметр `--external-address` в команды:
  * `yc application-load-balancer target-group create`;
  * `yc application-load-balancer target-group update`;
  * `yc application-load-balancer target-group add-targets`.

#### Managed Service for ClickHouse® {#v-1-7-0-mch-name}

Добавлены параметры `--performance-diagnostics-enabled` и `--performance-diagnostics-processes-refresh-interval` в команды:
  * `yc managed-clickhouse cluster create`;
  * `yc managed-clickhouse cluster update`;
  * `yc managed-clickhouse cluster restore`.

#### Cloud Interconnect {#v-1-7-0-cic-name}

* Добавлен параметр `--trunk-connection-id` в команды:
  * `yc cic get`;
  * `yc cic listoperations`.

* Удален параметр `--private-connection-id` в командах:
  * `yc cic get`;
  * `yc cic listoperations`.

* Удалено поле `cloud_bgp_asn` параметра `--ipv4-peering` в командах:
  * `yc cic private-connection create`;
  * `yc cic private-connection update`.

* В вывод команд `yc cic point-of-presence get` и `yc cic point-of-presence list` добавлены поля `name`, `address` и `connection points` с дополнительной информацией о точках присутствия.

* Изменен вывод команд:
  * `yc cic get`;
  * `yc cic list`.

* Команды сервиса `yc cic` доступны в новом синтаксисе. Для вызова используйте `yc --syntax=2 cic ...` либо задайте `default-syntax: 2` или `services.cic.syntax: 2` в профиле:
  * `yc cic partner get`;
  * `yc cic partner list`;
  * `yc cic point-of-presence get`;
  * `yc cic point-of-presence list`;
  * `yc cic private-connection create`;
  * `yc cic private-connection delete`;
  * `yc cic private-connection get`;
  * `yc cic private-connection list`;
  * `yc cic private-connection list-operations`;
  * `yc cic private-connection move`;
  * `yc cic private-connection remove-static-route`;
  * `yc cic private-connection update`;
  * `yc cic private-connection upsert-static-route`;
  * `yc cic public-connection get`;
  * `yc cic public-connection list`;
  * `yc cic public-connection move`;
  * `yc cic trunk-connection delete`;
  * `yc cic trunk-connection get`;
  * `yc cic trunk-connection list`;
  * `yc cic trunk-connection list-operations`;
  * `yc cic trunk-connection list-private-connections`;
  * `yc cic trunk-connection list-public-connections`;
  * `yc cic trunk-connection move`;
  * `yc cic trunk-connection update`.

### Версия 1.6.0 (27.04.26) {#v-1-6-0}

#### Cloud Registry {#v-1-6-0-cloud-registry-name}

Добавлена команда `yc cloud-registry registry lifecycle-policy dry-run` для симуляции выполнения политики жизненного цикла.

#### Identity and Access Management {#v-1-6-0-iam-name}

В вывод команды `yc iam api-key list` добавлено поле `MASKED KEY`, содержащее последние 6 символов секретной части ключа.

### Версия 1.5.0 (23.04.26) {#v-1-5-0}

#### Изменения в системных командах CLI {#v-1-5-0-yc}

* В командах CLI появилось версионирование. Оно реализовано посервисно в виде дерева дочерних команд c номером версии, например `yc compute v0`.

#### Cloud Interconnect {#v-1-5-0-cic-name}

* Удален параметр `--region` в командах:
  * `yc cic private-connection create`;
  * `yc cic private-connection update`;
  * `yc cic trunk-connection update`.

* Удален параметр `--point_of_presence_id` в команде `yc cic trunk-connection update`.

* Удалено значение `cloud-bgp-asn` параметра `--ipv4-peering` в командах:
  * `yc cic private-connection create`;
  * `yc cic private-connection update`.


#### Cloud Router {#v-1-5-0-cr-name}

* Удален параметр `--region` в командах:
  * `yc cloudrouter routing-instance create`;
  * `yc cloudrouter routing-instance update`.

#### Managed Service for Apache Kafka® {#v-1-5-0-mkf-name}

* Добавлен параметр `--transactional-id-expiration-ms` в команды:
  * `yc kafka cluster create`;
  * `yc kafka cluster update`.

### Версия 1.4.0 (20.04.26) {#v-1-4-0}

#### Cloud Registry {#v-1-4-0-cloud-registry-name}

* Добавлена команда `yc cloud-registry artifact get-by-path` для получения артефакта по его пути в реестре.

* Добавлены команды для управления политиками сканирований реестров в Cloud Registry:
  * `yc cloud-registry registry scan-policy get`;
  * `yc cloud-registry registry scan-policy get-by-registry`;
  * `yc cloud-registry registry scan-policy create`;
  * `yc cloud-registry registry scan-policy upd`.

### Версия 1.3.0 (16.04.26) {#v-1-3-0}

#### Managed Service for OpenSearch {#v-1-3-0-mos-name}

* Добавлены команды для управления плагинами:
  * `yc managed-opensearch plugins add`;
  * `yc managed-opensearch plugins delete`.

#### Application Load Balancer {#v-1-3-0-alb-name}

* Добавлен параметр `--preserve-http1-header-casing` для сохранения регистра HTTP/1-заголовков для определенного обработчика в команды:
  * `yc application-load-balancer add-listener`;
  * `yc application-load-balancer add-http-listener`;
  * `yc application-load-balancer update-listener`;
  * `yc application-load-balancer update-http-listener`;
  * `yc application-load-balancer add-sni`;
  * `yc application-load-balancer add-http-sni`;
  * `yc application-load-balancer update-sni`;
  * `yc application-load-balancer update-http-sni`.

#### Cloud Quota Manager {#v-1-3-0-quota-manager-name}

* В команде `yc quota-manager quota-request list` изменен способ вывода на постраничную загрузку.

#### Yandex Identity Hub {#v-1-3-0-org-name}

* В командах `yc organization-manager idp user list`, `yc organization-manager idp userpool list` и `yc organization-manager idp userpool domain list` изменен способ вывода на постраничную загрузку.
* Добавлен параметр `--password-blacklist-check-common` для установки ограничений на использование пользователями утекших паролей в команды:
  * `yc organization-manager idp userpool create`;
  * `yc organization-manager idp userpool update`.

#### Managed Service for MySQL® {#v-1-3-0-mmy-name}

* В команду `yc managed-mysql cluster create` добавлена поддержка версии MySQL 8.4.

#### Cloud DNS {#v-1-3-0-Cloud DNS}

* Добавлены команды для работы с DNS Firewall:
  * `yc dns firewall get`;
  * `yc dns firewall list`;
  * `yc dns firewall create`;
  * `yc dns firewall move`;
  * `yc dns firewall update`;
  * `yc dns firewall delete`;
  * `yc dns firewall add-labels`;
  * `yc dns firewall remove-labels`;
  * `yc dns firewall list-access-bindings`;
  * `yc dns firewall set-access-bindings`;
  * `yc dns firewall add-access-binding`;
  * `yc dns firewall remove-access-binding`;
  * `yc dns firewall list-operations`.

#### Cloud Interconnect {#v-1-3-0-cic-name}

* Удалена команда `yc cic trunk-connection create`.

#### Managed Service for ClickHouse® {#v-1-3-0-mch-name}

* В команду `yc managed-clickhouse cluster restore` добавлены параметры `--include-patterns` и `--exclude-patterns` для частичного восстановления кластера.

### Версия 1.2.0 (13.04.26) {#v-1-2-0}

#### Managed Service for Apache Kafka® {#v-1-2-0-mkf-name}

* Добавлены команды для управления коннектором Iceberg Sink:
  * `yc managed-kafka connector-iceberg-sink create`;
  * `yc managed-kafka connector-iceberg-sink update`.

#### Yandex Identity Hub {#v-1-2-0-org-name}

* Добавлены команды для управления метками групп организации:
  * `yc organization-manager group add-labels`;
  * `yc organization-manager group remove-labels`.
* В команды `yc organization-manager group create` и `yc organization-manager group update` добавлен параметр `--labels` для управления метками групп организации.

#### Virtual Private Cloud {#v-1-2-0-vpc-name}

* В команде `yc vpc security-group` удалена проверка длины CIDR-блоков.

#### Managed Service for ClickHouse® {#v-1-2-0-mch}

* В команде `yc managed-clickhouse cluster add-zookeeper` параметр `--convert-tables-to-replicated` включен по умолчанию. 

#### Managed Service for MySQL® {#v-1-2-0-mmy}

* Добавлен новый режим работы прокси `--daemon` для `yc managed-mysql connect`.

### Версия 1.1.0 (06.04.26) {#v-1-1-0}

#### Cloud Functions {#v-1-1-0-sf-name}

* В команду `yc serverless trigger create` для запуска Workflows по событию триггера добавлены параметры `--start-workflow-id`, `--start-workflow-name`, `--start-workflow-service-account-id` и `--start-workflow-service-account-name` :
  * `yc serverless trigger create timer`;
  * `yc serverless trigger create message-queue`;
  * `yc serverless trigger create object-storage`;
  * `yc serverless trigger create conteiner-registry`;
  * `yc serverless trigger create logging`;
  * `yc serverless trigger create billing-budget`;
  * `yc serverless trigger create yds`;
  * `yc serverless trigger create mail`.

#### Сервисы управляемых баз данных {#v-1-1-0-managed-db}

Добавлен параметр конфигурации `idle_session_timeout`.

#### Managed Service for Kubernetes {#v-1-1-0-managed-k8s-name}

* В команды `yc managed-kubernetes marketplace helm-release install` и `yc managed-kubernetes marketplace helm-release update` добавлены параметры `--value` и `--value-from-file` для передачи значений Helm Release; параметр `--values` помечен устаревшим:
  * `yc managed-kubernetes marketplace helm-release install --value --value-from-file`;
  * `yc managed-kubernetes marketplace helm-release update --value --value-from-file`.

* В команду `yc managed-kubernetes marketplace helm-release install` добавлены параметры `--name` и `--namespace`: `yc managed-kubernetes marketplace helm-release install --name --namespace`.

* В команды `yc managed-kubernetes marketplace helm-release install` и `yc managed-kubernetes marketplace helm-release update` добавлены примеры передачи сложных значений (списков, объектов) через `--value` и `--value-from-file`:
  * `yc managed-kubernetes marketplace helm-release install`;
  * `yc managed-kubernetes marketplace helm-release update`.

### Версия 1.0.0 (02.04.26) {#version1.0.0}

#### Изменения в системных командах CLI {#yc-1.0.0}

* Отключен gRPC Service Discovery для ускорения работы CLI у пользователей с большим количеством поисковых доменов в Cloud DNS.

#### Изменения в сервисах Yandex Cloud {#services-1.0.0}

##### Compute Cloud {#compute-1.0.0}

В команды `yc compute instance create` и `yc compute instance update` добавлен параметр `--metadata-options` для получения метаданных IMDSv2 экземпляра, например `--metadata-options aws-v2-http-endpoint=enabled,aws-v2-http-token=enabled`.

##### Managed Service for ClickHouse® {#mch-1.0.0}

Опция `--copy-schema` форсированно включена и объявлена `deprecated` в команде `yc managed-clickhouse host add`.

##### Managed Service for OpenSearch {#mos-1.0.0}

Добавлена возможность изменения `disk-type-id` в команде `yc managed-opensearch node-group update`.

##### SmartCaptcha {#captcha-1.0.0}

Команды `yc smartcaptcha` переведены на новый синтаксис. Для использования старого синтаксиса используйте параметр `--syntax=1` при выполнении команд:
* `yc smartcaptcha captcha create`;
* `yc smartcaptcha captcha delete`;
* `yc smartcaptcha captcha get`;
* `yc smartcaptcha captcha get-secret-key`;
* `yc smartcaptcha captcha list`;
* `yc smartcaptcha captcha update`.

##### Smart Web Security {#sws-1.0.0}

* Команды `yc smartwebsecurity` переведены на новый синтаксис. Для использования старого синтаксиса используйте параметр `--syntax=1` при выполнении команд:
  * `yc smartwebsecurity security-profile create`;
  * `yc smartwebsecurity security-profile delete`;
  * `yc smartwebsecurity security-profile get`;
  * `yc smartwebsecurity security-profile list`;
  * `yc smartwebsecurity security-profile update`.
* Изменен вывод команды `yc smartwebsecurity get`.

##### Yandex MetaData Hub {#metadata-hub-1.0.0}

Добавлены параметры `--warehouse-bucket` и `--warehouse-path` для настройки бакета Object Storage, который будет использоваться в качестве хранилища данных Hive Metastore (`warehouse`):
* `yc managed-metastore cluster create --warehouse-bucket --warehouse-path`;
* `yc managed-metastore cluster update --warehouse-bucket --warehouse-path`.

### Версия 0.204.0 (30.03.26) {#version0.204.0}

#### Изменения в сервисах Yandex Cloud {#services-0.204.0}

##### Yandex Identity Hub {#organizations-0.204.0}

Добавлены команды для просмотра и обновления списка пользователей и групп, к которым не применяется политика MFA:
* `yc organization-manager mfa-enforcement list-excluded-audience`;
* `yc organization-manager mfa-enforcement update-excluded-audience`.

### Версия 0.203.0 (26.03.26) {#version0.203.0}

#### Изменения в CLI {#cli-0.203.0}

* Исправлена ошибка при инициализации CLI, связанная с лимитом количества облаков и каталогов.

#### Изменения в сервисах Yandex Cloud {#services-0.203.0}

##### BareMetal {#baremetal-0.203.0}

Добавлены параметры для выбора метода аллокации CIDR-блока при создании публичной подсети:
* `yc baremetal public-subnet create --cidr-auto-allocation`;
* `yc baremetal public-subnet create --cidr-manual-allocation`.

### Версия 0.202.0 (23.03.26) {#version0.202.0}

#### Изменения в сервисах Yandex Cloud {#services-0.202.0}

##### Managed Service for ClickHouse® {#mch-0.202.0}

Добавлен параметр `--allow-host-recreation` для пересоздания хостов в следующие команды:
* `yc managed-clickhouse cluster update`;
* `yc managed-clickhouse shard update`.

### Версия 0.201.0 (19.03.26) {#version0.201.0}

#### Изменения в сервисах Yandex Cloud

##### BareMetal

Добавлена команда `yc baremetal vrf update` для управления статическими маршрутами VRF.

### Версия 0.200.0 (18.03.26) {#version0.200.0}

#### Изменения в сервисах Yandex Cloud

##### Cloud Interconnect

Добавлены команды для получения списков приватных и публичных соединений в указанном транковом подключении:
* `yc cic trunk-connection list-private-connections`;
* `yc cic trunk-connection list-public-connections`.

##### BareMetal

Добавлена команда `yc baremetal public-prefix-pool` для управления набором публичных IP‑префиксов (диапазонов адресов) в BareMetal.

##### Yandex MPP Analytics for PostgreSQL

Исправлена опечатка в команде `yc managed-greenplum pxf update`.

##### Smart Web Security

Сервис Smart Web Security добавлен в бета-дерево команд и доступен по команде `yc beta smartwebsecurity`.

### Версия 0.199.0 (16.03.26) {#version0.199.0}

#### Изменения в сервисах Yandex Cloud

##### Compute Cloud

Добавлен параметр `--os-nvidia-driver` в команду создания образа:

```bash
yc compute image create --os-nvidia-driver <nvidia-driver>
```

##### Managed Service for OpenSearch

Добавлен параметр конфигурации `http-max-initial-line-length` в команды управления кластером:
* `yc managed-opensearch cluster create`;
* `yc managed-opensearch cluster update`.


##### Managed Service for ClickHouse®

В команду `add-zookeeper` добавлена возможность указывать тип хоста:

```bash
yc managed-clickhouse cluster add-zookeeper --host type=<host_type>
```

##### Managed Service for PostgreSQL

Из команды создания кластера `yc managed-postgresql cluster create` удалены устаревшие версии PostgreSQL (9.6, 10, 10-1c, 11, 11-1c, 12, 12-1c), версия по умолчанию изменена на `16`.

##### Managed Service for MySQL®

* Добавлена команда `yc managed-mysql database update` для обновления баз данных. 
* Поддержана защита от удаления `deletion protection` для баз данных MySQL.

##### SmartCaptcha

Сервис SmartCaptcha добавлен в бета-дерево команд и доступен по команде `yc beta smartcaptcha`.


### Версия 0.199.0 (12.03.26) {#version0.199.0}

#### Изменения в сервисах Yandex Cloud {#services-0.199.0}

##### Managed Service for ClickHouse® {#mch-01.199.0}

В команду `managed-clickhouse cluster add-zookeeper` добавлена возможность указывать тип хоста:

* `yc managed-clickhouse cluster add-zookeeper --host type=<host_type>`

##### Managed Service for PostgreSQL {#mpg-01.199.0}

* Удалены устаревшие и неподдерживаемые версии PostgreSQL: 9.6, 10, 10-1c, 11, 11-1c, 12, 12-1c.
* При создании кластера Managed Service for PostgreSQL командой `yc managed-postgresql cluster create` по умолчанию используется версия 16.

### Версия 0.198.0 (09.03.26) {#version0.198.0}

#### Изменения в CLI {#cli} {#cli-0.198.0}

Исправлена проблема, связанная с проверкой обновлений.

#### Изменения в сервисах Yandex Cloud {#services-0.198.0}

##### Compute Cloud {#compute-0.198.0}

В команду `yc compute image create` добавлен флаг `--os-nvidia-driver`, который позволяет указать версию драйвера NVIDIA при создании ВМ:

* `yc compute image create --os-nvidia-driver <nvidia-driver>`

### Версия 0.197.0 (05.03.26) {#version0.197.0}

#### Изменения в сервисах Yandex Cloud {#services-0.197.0}

##### Application Load Balancer {#alb-0.197.0}

Добавлена поддержка клиентских сертификатов в следующих командах:
* `yc application-load-balancer add-listener`;
* `yc application-load-balancer add-http-listener`;
* `yc application-load-balancer add-stream-listener`;
* `yc application-load-balancer update-listener`;
* `yc application-load-balancer update-http-listener`;
* `yc application-load-balancer update-stream-listener`;
* `yc application-load-balancer add-sni`;
* `yc application-load-balancer add-http-sni`;
* `yc application-load-balancer add-stream-sni`;
* `yc application-load-balancer update-sni`;
* `yc application-load-balancer update-http-sni`;
* `yc application-load-balancer update-stream-sni`;
* `yc application-load-balancer append-http-route`;
* `yc application-load-balancer prepend-http-route`;
* `yc application-load-balancer insert-http-route`;
* `yc application-load-balancer update-http-route`;
* `yc application-load-balancer append-grpc-route`;
* `yc application-load-balancer prepend-grpc-route`;
* `yc application-load-balancer insert-grpc-route`;
* `yc application-load-balancer update-grpc-route`.

##### BareMetal {#baremetal-0.197.0}

Добавлены команды управления дополнительными приватными подсетями в следующих командах:
* `yc baremetal server create`;
* `yc baremetal server update`.

##### Cloud DNS {#dns-0.197.0}

Добавлена поддержка описаний DNS-записей в следующих командах:
* `yc dns zone list-records`;
* `yc dns zone add-records`;
* `yc dns zone delete-records`;
* `yc dns zone replace-records`.

##### Yandex Identity Hub {#org-0.197.0}

Добавлена поддержка флага `--parameters` в команде `yc organization-manager organization bind-access-policy`.

##### Managed Service for OpenSearch {#managed-opensearch-0.197.0}

Добавлен параметр конфигурации `search_max_buckets` в следующих командах:
* `yc managed-opensearch cluster create`;
* `yc managed-opensearch cluster update`.

##### Resource Manager {#resmgr-0.197.0}

Добавлена поддержка флага `--parameters` в следующих командах:
* `yc resource-manager folder bind-access-policy`;
* `yc resource-manager cloud bind-access-policy`.

##### Virtual Private Cloud {#vpc-0.197.0}

* В команду `yc vpc address create` добавлена возможность создания внутренних IPv4-адресов с помощью параметра `--internal-ipv4 subnet=<subnet>`.
* В `yc vpc address` добавлена команда `list-by-subnet` для листинга адресов по подсети: `yc vpc address list-by-subnet --subnet-id <subnet-id>`.

### Версия 0.196.0 (02.03.26) {#version0.196.0}

#### Изменения в сервисах Yandex Cloud {#services-0.196.0}

##### Cloud Desktop {#cloud-desktop-0.196.0}

Добавлена полная поддержка параметров `labels`, `description` и `name` в следующих командах:
* `yc desktops desktop create`;
* `yc desktops desktop update-properties`;
* `yc desktops group create`;
* `yc desktops image copy`;
* `yc desktops image update`.

##### Yandex SmartCaptcha {#smartcaptcha-0.196.0}

Добавлена поддержка параметра `labels`.

### Версия 0.195.0 (26.02.26) {#version0.195.0}

#### Изменения в сервисах Yandex Cloud


##### Yandex StoreDoc
Добавлены настройки автоскейлинга и окна обслуживания для команд `create` и `restore`:
* `yc managed-mongodb cluster create`;
* `yc managed-mongodb cluster restore --maintenance-window --disk-size-autoscaling`.


##### Managed Service for PostgreSQL
* Добавлены настройки автоскейлинга и окна обслуживания для команд `create` и `restore`:
  * `yc managed-postgresql cluster create`;
  * `yc managed-postgresql cluster restore --maintenance-window --disk-size-autoscaling`.
* Удален флаг для выключения `autofailover`.

##### Yandex Managed Service for Valkey™
Добавлены настройки автоскейлинга и окна обслуживания для команд `create` и `restore`:
  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore --maintenance-window --disk-size-autoscaling`.

##### Managed Service for Kubernetes
В методы управления NodeGroup добавлены параметры '--reserved-instance-pool-id' и '--variables', которые позволяют указать пулы резервов ВМ и пользовательские переменные соответственно:
  * `yc managed-kubernetes node-group create`;
  * `yc managed-kubernetes node-group update`.

### Версия 0.195.0 (23.02.26) {#version0.195.0}

#### Изменения в сервисах Yandex Cloud

##### Yandex StoreDoc

Добавлены настройки автоскейлинга и окна обслуживания для команд `create` и `restore`:
* `yc managed-mongodb cluster create`;
* `yc managed-mongodb cluster restore --maintenance-window --disk-size-autoscaling`.

##### Yandex Managed Service for Valkey™

Добавлены настройки автоскейлинга и окна обслуживания для команд create и restore
* `yc managed-redis cluster create`
* `restore --maintenance-window --disk-size-autoscaling`

### Версия 0.194.0 (19.02.26) {#version0.194.0}

#### Изменения в сервисах Yandex Cloud {#services-0.194.0}

##### Compute Cloud {#compute-0.194.0}

В параметр `--attach-local-disk` команд для создания ВМ на выделенных хостах добавлены опции `kms-key-id` и `kms-key-name` для подключения к ВМ зашифрованных локальных дисков:
* `yc compute instance create --attach-local-disk kms-key-id=<идентификатор_ключа_KMS>`;
* `yc compute instance create-with-container --attach-local-disk kms-key-name=<имя_ключа_KMS>`.

### Версия 0.193.0 (16.02.26) {#version0.193.0}

#### Изменения в сервисах Yandex Cloud {#services-0.193.0}

##### Cloud Registry {#cloud-registry-0.192.0}

Добавлены команды для управления правами доступа к артефактам в Cloud Registry:
* `yc cloud-registry artifact list-access-bindings`;
* `yc cloud-registry artifact set-access-bindings`;
* `yc cloud-registry artifact add-access-binding`;
* `yc cloud-registry artifact remove-access-binding`.

##### Managed Service for OpenSearch {#mos-0.192.0}

Изменено описание параметров конфигурации Managed Service for OpenSearch в командах:
* `yc managed-opensearch cluster create`;
* `yc managed-opensearch cluster update`.

##### Object Storage {#objstorage-0.192.0}

Добавлены команды для настройки выгрузки метаданных объектов (S3 Inventory):
* `yc storage bucket create-inventory-configuration`;
* `yc storage bucket delete-inventory-configuration`;
* `yc storage bucket get-inventory-configuration`;
* `yc storage bucket list-inventory-configurations`.

##### Yandex Managed Service for PostgreSQL {#mpg-0.192.0}

Исправлена проблема с дублированием вывода в команде `yc managed-postgresql connect`.

##### Yandex MPP Analytics for PostgreSQL {#mgp-0.192.0}

Исправлена проблема с дублированием вывода в команде `yc managed-greenplum connect`.

### Версия 0.192.0 (12.02.26) {#version0.192.0}

#### Изменения в сервисах Yandex Cloud {#services-0.192.0}

##### Serverless Integrations  {#si-name-0.192.0}

В следующие команды для управления рабочим процессом добавлены параметры `--set-is-public` и `--remove-is-public`, с помощью которых можно включить или выключить публичный доступ к запуску процесса:
* `yc serverless workflow create`;
* `yc serverless workflow update`.

### Версия 0.191.0 (06.02.26) {#version0.191.0}

#### Изменения в CLI {#cli-0.191.0}

* Изменен способ получения эндпоинта для авторизации.
* Удалены команды для работы с Yandex Managed Service for SQL Server.

#### Изменения в сервисах Yandex Cloud {#services-0.191.0}

##### Yandex Managed Service for Kubernetes {#managed-k8s-name-0.191.0}

В следующие команды для управления группой узлов добавлен параметр `--enable-workload-identity-federation`, с помощью которого можно включить или выключить [интеграцию с федерацией сервисных аккаунтов](../iam/concepts/workload-identity.md) Identity and Access Management:
* `yc managed-kubernetes node-group create`;
* `yc managed-kubernetes node-group update`.

### Версия 0.190.0 (05.02.26) {#version0.190.0}

#### Изменения в сервисах Yandex Cloud

##### Connection Manager
Добавлен флаг `--secret-folder-id` для команд создания подключения `yc metadata-hub connection-manager connection create`.

##### Workflows
Исправлен пример cron-выражения для расписания:
  * `yc serverless workflow create`

### Версия 0.189.0 (02.02.26) {#version0.189.0}

#### Изменения в сервисах Yandex Cloud

##### Connection Manager
Добавлен флаг `--secret-folder-id` для команд создания подключения:
  * `yc metadata-hub connection-manager connection create`

### Версия 0.188.0 (26.01.26) {#version0.188.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for Apache Kafka®

Добавлен параметр `message-timestamp-type` для управления топиками Apache Kafka® в следующие команды:
* `yc managed-kafka topic create`;
* `yc managed-kafka topic update`.

### Версия 0.187.0 (23.01.26) {#version0.187.0}

#### Изменения в CLI {#cli}

Для инструментов командной строки YC CLI добавлено обращение к сервису инициализации.

#### Изменения в сервисах Yandex Cloud

##### Managed Service for PostgreSQL

Добавлен параметр выбора типа шифрования пароля пользователя `--user_password_encryption` в следующие команды:
* `yc managed-postgresql user create`;
* `yc managed-postgresql user update`.

##### Object Storage

В команду получения подписанной ссылки `yc storage s3 presign` добавлен параметр `--http-method` для указания метода HTTP (GET/PUT).

##### Managed Service for Trino

Добавлен параметр `private-access` в команды управления кластером:
* `yc managed-trino cluster create`;
* `yc managed-trino cluster update`;
* `yc managed-trino cluster get`.

### Версия 0.186.0 (19.01.26) {#version0.186.0}

#### Изменения в CLI {#cli-0.186.0}

Исправлено отображение цветов при использовании параметра `--pager` со значением `less` в `yc beta`.

#### Изменения в сервисах Yandex Cloud {#services-0.186.0}

##### Yandex Cloud Registry {#cloud-registry-full-name-0.186.0}

Добавлена команда `configure-docker` для Docker Credential helper.

##### Data Transfer {#data-transfer-name-0.186.0}

Добавлен параметр `--labels` в следующие команды:
* `datatransfer transfer create`;
* `datatransfer transfer update`;
* `datatransfer endpoint <ENDPOINT_TYPE> create`;
* `datatransfer endpoint <ENDPOINT_TYPE> update`.

##### Yandex Data Processing {#dataproc-name-0.186.0}

Добавлены команды для назначения прав доступа в Yandex Data Processing:
* `yc dataproc cluster list-access-bindings`;
* `yc dataproc cluster set-access-bindings`;
* `yc dataproc cluster add-access-binding`;
* `yc dataproc cluster remove-access-binding`.
  
##### Yandex Identity Hub {#org-full-name-0.186.0}

Добавлены параметры для настройки сложности пароля в следующие команды:
* `yc organization-manager idp userpool create`;
* `yc organization-manager idp userpool update`.

### Версия 0.185.0 (22.12.25) {#version0.185.0}

#### Изменения в CLI {#cli} {#cli-0.185.0}

Исправлена ошибка при вызове команд `yc beta`.

### Версия 0.184.0 (22.12.25) {#version0.184.0}

#### Изменения в сервисах Yandex Cloud {#services-0.184.0}

##### Container Registry {#container-registry-name-0.184.0}

В команде `yc container registry configure-docker` исправлен парсинг версии Docker.

### Версия 0.183.0 (18.12.25) {#version0.183.0}

#### Изменения в сервисах Yandex Cloud {#services-0.183.0}

##### Object Storage {#objstorage-name-0.183.0}

* В команду `yc storage bucket update` добавлены следующие параметры:
  * `--disable-statickey-auth=<true_или_false>` — управление возможностью аутентификации в бакете с помощью статических ключей;
  * `--private-endpoints-force-cloudconsole-access=<true_или_false>` — управление возможностью доступа из консоли управления к бакету, доступ к которому разрешен только из сервисных подключений VPC.
 
##### Managed Service for Trino {#mtr-name-0.183.0}

* Добавлены команды для создания и обновления каталогов Greenplum® в Managed Service for Trino:
  * `yc managed-trino catalog create greenplum`;
  * `yc managed-trino catalog update greenplum`.

### Версия 0.182.0 (15.12.25) {#version0.182.0}

#### Изменения в CLI {#cli-0.182.0}

* В команду `yc init` добавлен параметр `--username`.

#### Изменения в сервисах Yandex Cloud {#services-0.182.0}

##### Identity and Access Management {#iam-name-0.182.0}

* Для команды `yc iam whoami` исправлена ошибка, которая возникала при получении идентификатора текущего субъекта.

##### Managed Service for Apache Kafka® {#mkf-name-0.182.0}

* Добавлена поддержка Apache Kafka® версии 4.0.

##### Yandex Object Storage {#objstorage-0.182.0}

* Добавлены команды для управления выгрузкой метаданных объектов в табличном виде (S3 Inventory):
  * `yc storage bucket get-inventory-configuration`;
  * `yc storage bucket create-inventory-configuration`;
  * `yc storage bucket delete-inventory-configuration`;
  * `yc storage bucket list-inventory-configurations`.

### Версия 0.181.0 (11.12.25) {#version0.181.0}

#### Изменения в сервисах Yandex Cloud {#services-0.181.0}

##### API Gateway {#api-gw-name-0.181.0}

Добавлены команды для остановки и возобновления работы API-шлюза:
* `yc serverless api-gateway stop`;
* `yc serverless api-gateway resume`.

##### BareMetal {#baremetal-name-0.181.0}

В команды `yc baremetal server create` и `yc baremetal server update` для параметра `--network-interfaces` добавлена опция `ephemeral-public-subnet` для явного указания эфемерной публичной подсети, также добавлена валидация числа передаваемых подсетей.

##### Cloud Interconnect {#interconnect-name-0.181.0}

В команде `yc cic private-connection update` исправлено обновление составных полей.

##### Cloud Registry {#cloud-registry-name-0.181.0}

Добавлены команды для управления политиками жизненного цикла артефактов в реестрах:
* `yc cloud-registry registry lifecycle-policy get`;
* `yc cloud-registry registry lifecycle-policy list`;
* `yc cloud-registry registry lifecycle-policy create`;
* `yc cloud-registry registry lifecycle-policy update`;
* `yc cloud-registry registry lifecycle-policy delete`;
* `yc cloud-registry registry lifecycle-policy change-state`.

##### Identity and Access Management {#iam-name-0.181.0}

Добавлена команда `yc iam access-key issue-ephemeral` для выпуска эфемерных статических ключей доступа.

##### Yandex Identity Hub {#org-full-name-0.181.0}

В командах `yc organization-manager mfa-enforcement create` и `yc organization-manager mfa-enforcement update` добавлен список поддерживаемых значений для параметра `--acr-id`.

##### Managed Service for Apache Airflow™ {#maf-name-0.181.0}

В команды `yc managed-airflow cluster create` и `yc managed-airflow cluster update` добавлен параметр `--gitsync` для использования git-репозитория в качестве источника для DAG.

##### Managed Service for Apache Spark™ {#msp-name-0.181.0}

В команды `yc managed-spark cluster create` и `yc managed-spark cluster update` добавлен параметр `--spark-version` для выбора конкретной версии Apache Spark™ при создании и изменении кластера.

##### Managed Service for Sharded PostgreSQL {#mspqr-name-0.181.0}

В команде `yc managed-sharded-postgresql cluster update-config` исправлена ошибка при обновлении конфигурации роутера.

##### Managed Service for Trino {#mtr-name-0.181.0}

Для управления конфигурацией ресурсных групп и параметров запросов:
* добавлены команды:
  * `yc managed-trino cluster get-resource-groups`;
  * `yc managed-trino cluster set-resource-groups`;
  * `yc managed-trino cluster remove-resource-groups`;
* в команду `yc managed-trino cluster create` добавлен параметр `--resource-groups-from-file`;
* в команды `yc managed-trino cluster create` и `yc managed-trino cluster update` добавлен параметр `--query-properties`.

##### Yandex StoreDoc {#mmg-name-0.181.0}

В команду `yc managed-mongodb cluster restore` добавлены параметры `--whitelist` и `--blacklist` для частичного восстановления кластера.

### Версия 0.180.0 (04.12.25) {#version0.180.0}

##### Managed Service for Trino

* Добавлены команды для создания и обновления каталога Trino с коннектором MySQL® для Managed Service for Trino:
  * `yc managed-trino catalog create mysql`;
  * `yc managed-trino catalog update mysql`.

##### Yandex Identity Hub

* Убрали часть парольных политик из команд по управлению пулами пользователей:
  * `yc organization-manager idp userpool create`;
  * `yc organization-manager idp userpool update`.

### Версия 0.179.0 (02.12.25) {#version0.179.0}

#### Изменения в CLI {#cli}

* Добавлено новое поддерево команд `yc beta` с экспериментальными командами, использующими обновленный интерфейс.

#### Изменения в сервисах Yandex Cloud

##### Yandex Identity Hub

* Добавлены команды для управления политиками авторизации на уровне организации:
  * `yc organization-manager organization list-access-policy-bindings`;
  * `yc organization-manager organization bind-access-policy`;
  * `yc organization-manager organization unbind-access-policy`.

##### Resource Manager

* Добавлены команды для управления политиками авторизации на уровне облака:
  * `yc resource-manager cloud list-access-policy-bindings`;
  * `yc resource-manager cloud bind-access-policy`;
  * `yc resource-manager cloud unbind-access-policy`.

##### Resource Manager

* Добавлены команды для управления политиками авторизации на уровне каталога:
  * `yc resource-manager folder list-access-policy-bindings`;
  * `yc resource-manager folder bind-access-policy`;
  * `yc resource-manager folder unbind-access-policy`.

##### Audit Trails

* Добавлен флаг `--destination-yds-codec` для выбора метода сжатия событий при настройке трейлов Data Streams:
  * `yc audit-trails trail create`;
  * `yc audit-trails trail update`.

### Версия 0.178.0 (01.12.25) {#version0.178.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for Apache Kafka®

* Добавлен параметр `--disk-encryption-key-id` для указания ключа шифрования дисков кластера: `yc managed-kafka cluster create`

##### Instance Groups

* Добавлены команды для управления режимом отключения зоны доступности (zonal shift) в Instance Groups:
  * `yc compute instance-group disable-zones`
  * `yc compute instance-group enable-zones`

### Версия 0.177.0 (27.11.25) {#version0.177.0}

#### Изменения в сервисах Yandex Cloud

##### Cloud Router

* Добавлены команды для перемещения PublicConnection, PrivateConnection, TrunkConnection и RoutingInstance:
  * `yc cic public-connection move`
  * `yc cic private-connection move`
  * `yc cic trunk-connection move`
  * `yc cloudrouter routing-instance move`

##### Identity and Access Management

* Добавлено автоматическое сохранение SubjectID при инициализации профиля `yc init`.

##### Managed Service for Apache Airflow™, Managed Service for ClickHouse®, Yandex MPP Analytics for PostgreSQL, Managed Service for Apache Kafka®, Apache Hive™ Metastore, Managed Service for MySQL®, Managed Service for OpenSearch, Managed Service for PostgreSQL, Yandex Managed Service for Valkey™, Managed Service for Apache Spark™, Managed Service for Trino, Yandex StoreDoc

* Добавлены команды для управления access bindings:
  * `yc managed-airflow cluster list-access-bindings`
  * `yc managed-airflow cluster set-access-bindings`
  * `yc managed-airflow cluster add-access-bindings`
  * `yc managed-airflow cluster remove-access-bindings`
  * `yc managed-clickhouse cluster list-access-bindings`
  * `yc managed-clickhouse cluster set-access-bindings`
  * `yc managed-clickhouse cluster add-access-bindings`
  * `yc managed-clickhouse cluster remove-access-bindings`
  * `yc managed-greenplum cluster list-access-bindings`
  * `yc managed-greenplum cluster set-access-bindings`
  * `yc managed-greenplum cluster add-access-bindings`
  * `yc managed-greenplum cluster remove-access-bindings`
  * `yc managed-kafka cluster list-access-bindings`
  * `yc managed-kafka cluster set-access-bindings`
  * `yc managed-kafka cluster add-access-bindings`
  * `yc managed-kafka cluster remove-access-bindings`
  * `yc managed-metastore cluster list-access-bindings`
  * `yc managed-metastore cluster set-access-bindings`
  * `yc managed-metastore cluster add-access-bindings`
  * `yc managed-metastore cluster remove-access-bindings`
  * `yc managed-mongodb cluster list-access-bindings`
  * `yc managed-mongodb cluster set-access-bindings`
  * `yc managed-mongodb cluster add-access-bindings`
  * `yc managed-mongodb cluster remove-access-bindings`
  * `yc managed-mysql cluster list-access-bindings`
  * `yc managed-mysql cluster set-access-bindings`
  * `yc managed-mysql cluster add-access-bindings`
  * `yc managed-mysql cluster remove-access-bindings`
  * `yc managed-opensearch cluster list-access-bindings`
  * `yc managed-opensearch cluster set-access-bindings`
  * `yc managed-opensearch cluster add-access-bindings`
  * `yc managed-opensearch cluster remove-access-bindings`
  * `yc managed-postgresql cluster list-access-bindings`
  * `yc managed-postgresql cluster set-access-bindings`
  * `yc managed-postgresql cluster add-access-bindings`
  * `yc managed-postgresql cluster remove-access-bindings`
  * `yc managed-redis cluster list-access-bindings`
  * `yc managed-redis cluster set-access-bindings`
  * `yc managed-redis cluster add-access-bindings`
  * `yc managed-redis cluster remove-access-bindings`
  * `yc managed-spark cluster list-access-bindings`
  * `yc managed-spark cluster set-access-bindings`
  * `yc managed-spark cluster add-access-bindings`
  * `yc managed-spark cluster remove-access-bindings`
  * `yc managed-trino cluster list-access-bindings`
  * `yc managed-trino cluster set-access-bindings`
  * `yc managed-trino cluster add-access-bindings`
  * `yc managed-trino cluster remove-access-bindings`

### Версия 0.176.0 (20.11.25) {#version0.176.0}

#### Изменения в сервисах Yandex Cloud

##### Workflows

Добавлены команды для управления правами доступа:
* `serverless workflow list-access-bindings`;
* `serverless workflow set-access-bindings`;
* `serverless workflow add-access-binding`;
* `serverless workflow remove-access-binding`;
* `serverless workflow allow-unauthenticated-execution`;
* `serverless workflow deny-unauthenticated-execution`.

##### Managed Service for MySQL®

Добавлена команда `yc managed-mysql connect`.

##### AI Studio

Добавлены команды для MCP Hub:
* `serverless mcp-gateway get`;
* `serverless mcp-gateway list`;
* `serverless mcp-gateway create`;
* `serverless mcp-gateway update`;
* `serverless mcp-gateway delete`;
* `serverless mcp-gateway list-operations`;
* `serverless mcp-gateway list-access-bindings`;
* `serverless mcp-gateway set-access-bindings`;
* `serverless mcp-gateway add-access-binding`;
* `serverless mcp-gateway remove-access-binding`;
* `serverless mcp-gateway allow-unauthenticated-invoke`;
* `serverless mcp-gateway deny-unauthenticated-invoke`.

### Версия 0.175.0 (10.11.25) {#version0.175.0}

#### Изменения в сервисах Yandex Cloud

##### Yandex Identity Hub

Добавлены недостающие поля в команды управления SAML-приложениями:

* `organization-manager idp application saml application create`;
* `organization-manager idp application saml application update`.

### Версия 0.174.0 (06.11.25) {#version0.174.0}

#### Изменения в CLI {#cli}

Добавлен параметр `subject-id` в команду `yc init`.

#### Изменения в сервисах Yandex Cloud

##### Application Load Balancer

Добавлена поддержка поля `path` для ALB session affinity по сookie:
  * `yc application-load-balancer backend-group update`;
  * `yc application-load-balancer backend-group create`.

##### Yandex BareMetal

Добавлена группа команд `yc baremetal private-cloud-connection`:
  * `yc baremetal private-cloud-connection get`;
  * `yc baremetal private-cloud-connection list`;
  * `yc baremetal private-cloud-connection create`;
  * `yc baremetal private-cloud-connection delete`.

##### Yandex Identity and Access Management

Добавлена команда для просмотра списка шаблонов политик доступа:
  * `yc iam access-policy-template list`.

##### Yandex Identity Hub

* Добавлена группа команд `yc organization-manager idp application saml application` для управления SAML-приложениями:
  * `yc iam organization-manager idp application saml application get`;
  * `yc iam organization-manager idp application saml application list`;
  * `yc iam organization-manager idp application saml application create`;
  * `yc iam organization-manager idp application saml application update`;
  * `yc iam organization-manager idp application saml application delete`;
  * `yc iam organization-manager idp application saml application suspend`;
  * `yc iam organization-manager idp application saml application reactivate`;
  * `yc iam organization-manager idp application saml application list-operations`;
  * `yc iam organization-manager idp application saml application list-assignments`;
  * `yc iam organization-manager idp application saml application add-assignments`;
  * `yc iam organization-manager idp application saml application remove-assignments`;
  * `yc iam organization-manager idp application saml application list-access-bindings`;
  * `yc iam organization-manager idp application saml application set-access-bindings`;
  * `yc iam organization-manager idp application saml application update-access-bindings`.

* Добавлена группа команд `yc organization-manager idp application saml signature-certificate` для управления SAML-сертификатами:
  * `yc iam organization-manager idp application saml signature-certificate get`;
  * `yc iam organization-manager idp application saml signature-certificate list`;
  * `yc iam organization-manager idp application saml signature-certificate create`;
  * `yc iam organization-manager idp application saml signature-certificate update`;
  * `yc iam organization-manager idp application saml signature-certificate delete`.

##### Yandex MPP Analytics for PostgreSQL

В команду `yc managed-greenplum cluster update` добавлен параметр `--connection-pooling-idle-in-transaction-timeout`
  * `yc managed-greenplum cluster update`.

##### Managed Service for PostgreSQL

Добавлены методы аутентификации для пользователя `AUTH_METHOD_PASSWORD` и `AUTH_METHOD_IAM` в команды:
  * `yc managed-postgresql user create`;
  * `yc managed-postgresql user update`.

##### Yandex Object Storage

Исправлена ошибка фильтрации загружаемых объектов в команде `yc storage s3 cp`.

### Версия 0.173.0 (30.10.25) {#version0.173.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for ClickHouse®

В следующие команды добавлен параметр `engine` для выбора и отображения типа движка базы данных ClickHouse®:
  * `yc managed-clickhouse database create`
  * `yc managed-clickhouse database get`
  * `yc managed-clickhouse database list`

##### BareMetal

Добавлена команда `yc baremetal image` для работы с образами:
* `yc baremetal image get`
* `yc baremetal image list`

#### Изменения в CLI {#cli}

* Добавлена поддержка сервиса Yandex Managed Service for Sharded PostgreSQL. Используйте команды `yc managed-sharded-postgresql`.
* В `yc init` добавлен параметр `userpool-id`.

### Версия 0.172.0 (27.10.25) {#version0.172.0}

#### Изменения в сервисах Yandex Cloud

##### Yandex Identity Hub

* Добавлена группа команд `yc organization-manager mfa-enforcement`.
* Добавлены команды для управления пользователями SAML-федераций:
  * `yc organization-manager federation saml suspend-user-accounts` — для блокировки пользователей.
  * `yc organization-manager federation saml reactivate-user-accounts` — для разблокировки пользователей.

* В команде `yc organization-manager idp user create` исправлена обработка флага `--is-active` при создании пользователя, когда пользователь создавался всегда активным.

### Версия 0.171.0 (20.10.25) {#version0.171.0}

#### Изменения в сервисах Yandex Cloud

##### Cloud DNS

Добавлена команда `yc dns zone move` для перемещения зоны DNS в другой каталог.

##### Yandex Identity Hub

* Для команды `yc organization-manager idp user create` добавлена новая возможность: теперь можно не указывать пароль при создании пользователя. Пароль будет сгенерирован автоматически.
* Добавлена команда сброса пароля пользователя `yc organization-manager idp user reset-password`.

##### Identity and Access Management

Добавлена команда `yc iam access-analyzer list-subject-access-bindings` для получения access-bindings по субъекту.

##### Managed Service for Trino

* В команды `yc managed-trino cluster create` и `yc managed-trino cluster update` добавлены флаги для настройки доверенных сертификатов кластера Managed Service for Trino:
  * `--trusted-certs-from-files` — для передачи списка файлов с доверенными сертификатами.
  * `--remove-trusted-certs` — для удаления всех доверенных сертификатов.

### Версия 0.170.0 (16.10.25) {#version0.170.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for PostgreSQL

Добавлена команда `yc managed-postgresql connect` для подключения пользователя с IAM-аутентификацией.

##### Managed Service for Apache Airflow™

Добавлено конфигурирование dag-processor для Airflow 3.0 и выше.

##### Cloud Interconnect

* Добавлена команда получения информации о ресурсе по его идентификатору.
* Добавлены команды `get-by-vpc-network-id` и `get-by-cic-private-connection-id`.

##### Yandex Identity Hub

* Добавлена команда `yc organization-manager group list-effective` для вывода групп внутри организации, в которых состоит пользователь.
* Добавлена возможность управления парольными политиками при создании и обновлении пула пользователей.
* Добавлена группа команд `yc organization-manager idp application oauth application` для управления OAuth-приложениями:
  * `yc organization-manager idp application oauth application get`;
  * `yc organization-manager idp application oauth application list`;
  * `yc organization-manager idp application oauth application create`;
  * `yc organization-manager idp application oauth application update`;
  * `yc organization-manager idp application oauth application delete`;
  * `yc organization-manager idp application oauth application suspend`;
  * `yc organization-manager idp application oauth application reactivate`;
  * `yc organization-manager idp application oauth application list-operations`;
  * `yc organization-manager idp application oauth application list-assignments`;
  * `yc organization-manager idp application oauth application add-assignments`;
  * `yc organization-manager idp application oauth application remove-assignments`;
  * `yc organization-manager idp application oauth application list-access-bindings`;
  * `yc organization-manager idp application oauth application add-access-bindings`;
  * `yc organization-manager idp application oauth application set-access-bindings`;
  * `yc organization-manager idp application oauth application update-access-bindings`;
  * `yc organization-manager idp application oauth application remove-access-bindings`.

##### Yandex MPP Analytics for PostgreSQL

* Для команды создания кластера `yc managed-greenplum cluster create` версия по умолчанию изменена на 6.28.
* Для команды `yc managed-greenplum connect` с использованием IAM-аутентификации удалена опция `--user`. Пользователь теперь определяется автоматически.

##### Object Storage

Добавлена проверка на максимальный размер объекта в команде `yc storage s3 cp`.

##### BareMetal

Добавлена команда `yc baremetal rental-period list`, возвращающая доступные периоды аренды для сервера.

##### Cloud Router

Уточнено описание команд `yc cloudrouter routing-instance create`, `yc cloudrouter routing-instance upsert-prefixes` и `yc cloudrouter routing-instance remove-prefixes`, добавлены примеры.

##### Managed Service for Trino

Добавлены команды для создания и обновления Hudi каталогов для Managed Service for Trino:
  * `yc managed-trino catalog create hudi`;
  * `yc managed-trino catalog update hudi`.

##### Managed Service for YTsaurus

Добавлены команды для управления кластерами Managed Service for YTsaurus:
  * `yc managed-ytsaurus cluster get`;
  * `yc managed-ytsaurus cluster start`;
  * `yc managed-ytsaurus cluster stop`;
  * `yc managed-ytsaurus cluster delete`;
  * `yc managed-ytsaurus cluster list`;
  * `yc managed-ytsaurus cluster get-configuration`.

### Версия 0.169.0 (01.10.25) {#version0.169.0}

#### Изменения в сервисах Yandex Cloud

##### Container Registry {#container-registry-name-0.169.0}

В следующие команды добавлен параметр `--page-token` для постраничного вывода списка ресурсов:
* `yc container registry list`;
* `yc container registry list-access-bindings`;
* `yc container repository list`;
* `yc container repository lifecycle-policy list`;
* `yc container repository lifecycle-policy list-dry-run-results`;
* `yc container image list-scan-results`;
* `yc container image list-vulnerabilities`.

##### Cloud Registry {#cloud-registry-name-0.169.0}

В следующие команды добавлен параметр `--page-token` для постраничного вывода списка ресурсов:
* `yc cloud-registry registry list-access-binding`;
* `yc cloud-registry registry list`;
* `yc cloud-registry registry list-artifact`.

##### Yandex Identity Hub {#org-full-name-0.169.0}

В следующие команды добавлена возможность указывать домен не только в самой команде, например `yc organization-manager idp userpool domain get <идентификатор_пула_пользователей> <домен>`, но и с помощью параметра `--domain`:
* `yc organization-manager idp userpool domain get`;
* `yc organization-manager idp userpool domain list`;
* `yc organization-manager idp userpool domain add`;
* `yc organization-manager idp userpool domain validate`;
* `yc organization-manager idp userpool domain delete`.

##### Yandex Managed Service for Valkey™ {#mrd-name-0.169.0}

В команду `yc managed-redis cluster update` добавлен параметр `--valkey-modules` для управления модулями Valkey™.

##### BareMetal {#baremetal-name-0.169.0}

В выводе команды `yc baremetal configuration list` исправлено отображение информации о процессоре.

### Версия 0.168.0 (29.09.25) {#version0.168.0}

#### Изменения в сервисах Yandex Cloud

##### Container Registry {#cr-0.168.0}

В команду `yc container image list` добавлен параметр `--page-token` для постраничного вывода списка образов.

##### BareMetal {#baremetal-0.168.0}

В выводе команды `yc baremetal configuration list` исправлено отображение количества ядер и добавлено значение частоты процессора.

### Версия 0.167.0 (25.09.25) {#version0.167.0}

#### Изменения в сервисах Yandex Cloud

##### Connection Manager

* Добавлены команды connection-manager внутри группы команд `metadata-hub`:
  * `yc metadata-hub connection-manager connection create`;
  * `yc metadata-hub connection-manager connection update`;
  * `yc metadata-hub connection-manager connection delete`;
  * `yc metadata-hub connection-manager connection get`;
  * `yc metadata-hub connection-manager connection resolve-cluster`;
  * `yc metadata-hub connection-manager connection list`;
  * `yc metadata-hub connection-manager connection list-operations`.

* Добавлена поддержка Apache Kafka®, групп шардов в ClickHouse® и поля `auth_source` MG (SD) в команде `yc metadata-hub connection-manager connection create kafka`.

##### Audit Trails

* Добавлен параметр `--destination-eventrouter-connector-id` для назначения EventRouter в командах создания и изменения трейла:
  * `yc audit-trails trail create`;
  * `yc audit-trails trail update`.

##### Managed Service for PostgreSQL

* Добавлена поддержка PostgreSQL 18 для команд:
  * `yc managed-postgresql cluster create`;
  * `yc managed-postgresql cluster update`;
  * `yc managed-postgresql cluster restore`.

* Исправлена ошибка `ERROR: Unsupported PostgreSQL version` при обновлении кластера 17 и 18 версий PostgreSQL в команде `yc managed-postgresql cluster update`.

##### Yandex Identity Hub

* Исправлены команды `yc organization-manager idp`.

### Версия 0.166.0 (18.09.25) {#version0.166.0}

#### Изменения в сервисах Yandex Cloud

##### Cloud Router {#cloud-routing}

Добавлена команда для управления Routing Instance `yc cloudrouter routing-instance update-networks`.

##### Compute Cloud {#compute}

Исправлена ошибка вывода результата команды `yc compute maintenance list`.

##### Managed Service for Apache Spark™ {#msp}

Добавлены команды для управления кластерами и заданиями Managed Service for Apache Spark™:
* `yc managed-spark cluster get`;
* `yc managed-spark cluster list`;
* `yc managed-spark cluster create`;
* `yc managed-spark cluster update`;
* `yc managed-spark cluster delete`;
* `yc managed-spark cluster start`;
* `yc managed-spark cluster stop`;
* `yc managed-spark cluster list-operations`;
* `yc managed-spark job create-spark`;
* `yc managed-spark job create-pyspark`;
* `yc managed-spark job create-spark-connect`;
* `yc managed-spark job get`;
* `yc managed-spark job list`;
* `yc managed-spark job cancel`.

##### Managed Service for MySQL® {#mmy}

Добавлены плагины аутентификации `mysql_no_login` и `mdb_iamproxy_auth` в следующие команды:
* `yc managed-mysql user create`;
* `yc managed-mysql user update`.

##### Managed Service for Trino {#mtr}

Добавлены команды для настройки контроля доступа к кластеру Managed Service for Trino:
* `yc managed-trino cluster create`;
* `yc managed-trino cluster get-access-control`;
* `yc managed-trino cluster set-access-control`;
* `yc managed-trino cluster remove-access-control`.

### Версия 0.165.0 (15.09.25) {#version0.165.0}

#### Изменения в сервисах Yandex Cloud

##### Identity and Access Management {#iam}

Добавлена группа команд `yc iam oauth-client-service` для управления секретами OAuth-клиентов:
* `yc iam oauth-client-secret get`;
* `yc iam oauth-client-secret list`;
* `yc iam oauth-client-secret create`;
* `yc iam oauth-client-secret delete`.

### Версия 0.164.0 (11.09.25) {#version0.164.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for Kubernetes

Добавлен параметр `--enable-workload-identity-federation`, который позволяет включать [федерацию сервисных аккаунтов](../iam/concepts/workload-identity.md) (Workload Identity Federation):

Параметр добавлен в команды:
* `yc managed-kubernetes cluster create`;
* `yc managed-kubernetes cluster update`.

##### Yandex Identity Hub

Добавлены новые группы команд:

* `yc organization-manager idp userpool` — для управления [пулами пользователей](../organization/concepts/user-pools.md); 
* `yc organization-manager idp user` — для управления [локальными пользователями](../iam/concepts/users/accounts.md#local).

##### IAM

Для управления OAuth-клиентами добавлена группа команд `yc iam oauth-client`:
* `yc iam oauth-client get`;
* `yc iam oauth-client list`;
* `yc iam oauth-client create`;
* `yc iam oauth-client update`;
* `yc iam oauth-client delete`.

##### Managed Service for MySQL®

Добавлены параметры `maintenance-window` и `performance-diagnostics` в команды создания и восстановления кластера. Для параметра `disk-size-autoscaler.disk-size-limit` изменена единица измерения с байтов на гигабайты.

Обновленные команды:
* `yc managed-mysql cluster create`;
* `yc managed-mysql cluster update`;
* `yc managed-mysql cluster restore`.

### Версия 0.163.0 (08.09.25) {#version0.163.0}

#### Изменения в сервисах Yandex Cloud

##### Compute Cloud

* Исправлена подсказка параметра `--order` команды `yc compute maintenance list`: поле `planned_at` заменено на `start_scheduled_at`.

##### Managed Service for Elasticsearch

* Удалена поддержка `managed-elasticsearch`.

### Версия 0.162.0 (04.09.25) {#version0.162.0}

#### Изменения в сервисах Yandex Cloud

##### BareMetal

Добавлен параметр `--folder-id` в команды для получения конфигурации:
  * `yc baremetal configuration get`;
  * `yc baremetal configuration list`.

##### Managed Service for MySQL®

Добавлена роль `MDB_ADMIN` для параметра `--global-permissions` в следующих командах:
  * `yc managed-mysql user create`;
  * `yc managed-mysql user update`.

##### Cloud Quota Manager

Добавлена группа команд `yc quota-manager quota-request` для управления запросами квот:
  * `yc quota-manager quota-request get`;
  * `yc quota-manager quota-request list`;
  * `yc quota-manager quota-request create`;
  * `yc quota-manager quota-request cancel`;
  * `yc quota-manager quota-request list-operations`.

##### Serverless Containers

В команду `yc serverless container revision deploy` добавлен параметр для указания сервисного аккаунта для асинхронных вызовов: `--async-service-account-id`.

##### Object Storage

Максимальное время жизни подписанной ссылки увеличено до 30 дней в команде `yc storage s3 presign`.

### Версия 0.161.0 (28.08.25) {#version0.161.0}

#### Изменения в сервисах Yandex Cloud

##### Connection Manager

Добавлены команды для управления Yandex Connection Manager
* `yc connection-manager connection create`
* `yc connection-manager connection update`
* `yc connection-manager connection delete`
* `yc connection-manager connection get`
* `yc connection-manager connection resolve-cluster`
* `yc connection-manager connection list`
* `yc connection-manager connection list-operations`

##### Workflows

Добавлена поддержка cron-таймеров Yandex Workflows:
* `yc serverless workflow create`
* `yc serverless workflow update`

### Версия 0.160.0 (25.08.25) {#version0.160.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for Trino

Добавлена опция `--version` в следующие команды:
  * `yc managed-trino cluster create`;
  * `yc managed-trino cluster update`.

##### Yandex Managed Service for Valkey™

В команду `yc managed-redis cluster restore` добавлена опция `sharded`.

##### Object Storage

* В команду `yc storage bucket create` добавлена опция `tags`.
* Добавлена команда `yc storage s3 presign`.

### Версия 0.159.0 (18.08.25) {#version0.159.0}

#### Изменения в сервисах Yandex Cloud

##### Yandex StoreDoc
Добавлен вывод `priority` и `hidden` в `yc managed-mongodb hosts list`.

##### Compute Cloud
Добавлены команды для управления пулами резервов VM:
* `compute reserved-instance-pool list-instances`;
* `compute reserved-instance-pool list-operations`.

##### Compute Cloud
Расширены команды для управления пулами резервов VM:
* `compute reserved-instance-pool create`;
* `compute reserved-instance-pool update`.

##### EventRouter

Исправлена работа флага `--deletion-protection` в команде `yc serverless eventrouter connector update`.

##### Yandex Identity Hub

Исправлено отображение timestamp в листинге доменов SAML-федераций.

### Версия 0.158.0 (11.08.25) {#version0.158.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for OpenSearch
В команду `yc managed-opensearch` добавлена поддержка `ExtensionService`.

##### Application Load Balancer

* В команду `yc apploadbalancer disable-zones` добавлена возможность управлять временем отключения зоны.
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

#### Изменения в сервисах Yandex Cloud

##### Cloud Desktop
В команду `desktops group update` добавлен флаг `--update-policy` (значение по умолчанию — `manual`).

##### Yandex Identity Hub
Добавлены команды для управления доменами SAML-федераций:
* `yc organization-manager federation saml get-domain`;
* `yc organization-manager federation saml list-domains`;
* `yc organization-manager federation saml add-domain`;
* `yc organization-manager federation saml validate-domain`;
* `yc organization-manager federation saml delete-domain`.

##### Compute Cloud
* Добавлена сортировка списка подкоманд в `yc compute`.
* Добавлены команды `yc compute maintenance`:
  * `yc compute maintenance get`;
  * `yc compute maintenance list`;
  * `yc compute maintenance reschedule`.

##### Object Storage
Удалены параметры `--sse-c`, `--sse-c-key`, `--sse-c-copy-source` и `--sse-c-copy-source-keys` команды `yc storage cp`.

##### EventRouter
Для команды `serverless eventrouter connector create message-queue` значения по умолчанию следующих параметров приведены в соответствие с аналогичным методом API:
* `--visibility-timeout`;
* `--polling-timeout`;
* `--batch-size`.

### Версия 0.156.0 (28.07.25) {#version0.156.0}

#### Изменения в сервисах Yandex Cloud

##### Managed Service for Kubernetes

* В команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update` добавлен параметр `--master-scale-policy`, который позволяет управлять вычислительными ресурсами мастеров кластера.
* В вывод команды `yc managed-kubernetes cluster get` добавлено поле `scale_policy` для получения конфигурации вычислительных ресурсов мастеров кластера.
* Добавлены команды `yc managed-kubernetes resource-preset get` и `yc managed-kubernetes resource-preset list` для получения возможных конфигураций вычислительных ресурсов для мастеров кластера.

### Версия 0.155.0 (23.07.25) {#version0.155.0}

#### Изменения в сервисах Yandex Cloud

##### Compute Cloud

В командах `yc compute instance create` и `yc compute instance update` исправлено описание для параметра `--memory`.

##### Cloud Backup

В команду `yc backup provider activate` добавлен запрос подтверждения для активации провайдера и флаг `--force` для выполнения команды без подтверждения.

##### Managed Service for Apache Kafka®

В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлен флаг `--kafka-ui-enabled` для включения Kafka UI в кластере.

##### Yandex Data Processing

В команды `yc dataproc cluster create` и `yc dataproc cluster update` добавлены параметры для указания сервисного аккаунта для управления группой ВМ, на которых размещаются хосты кластера:
* `--autoscaling-service-account-id`;
* `--autoscaling-service-account-name`.

##### Managed Service for ClickHouse®

В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster restore` добавлены параметры:
* `--maintenance-window` — для указания окна обслуживания кластера;
* `--disk-encryption-key-id` — для указания ключа шифрования дисков.

##### Managed Service for OpenSearch

* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster update` добавлены параметры для управления созданием снапшотов кластера:
    * `--snapshot-schedule`;
    * `--snapshot-day`;
    * `--snapshot-hour`;
    * `--snapshot-minute`;
    * `--snapshot-max-age-days`.
* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### Managed Service for MySQL®

* В команды `yc managed-mysql cluster create` и `yc managed-mysql cluster update` добавлен параметр `--yandexquery-access` для включения доступа к кластеру из Yandex Query.
* В команды `yc managed-mysql cluster create` и `yc managed-mysql cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### Apache Hive™ Metastore

В команды `yc managed-metastore cluster create` и `yc managed-metastore cluster update` добавлен параметр `--version` для поддержки версионирования кластера.

##### Managed Service for PostgreSQL

В команды `yc managed-postgresql cluster create` и `yc managed-postgresql cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### Yandex StoreDoc

В команды `yc managed-mongodb cluster create` и `yc managed-mongodb cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

##### Yandex Managed Service for Valkey™

В команды `yc managed-redis cluster create` и `yc managed-redis cluster restore` добавлен параметр для указания ключа шифрования дисков `--disk-encryption-key-id`.

### Версия 0.154.0 (09.07.25) {#version0.154.0}

#### Application Load Balancer

Добавлены команды для управления маршрутизацией трафика в зонах доступности балансировщиков:
* `yc alb load-balancer disable-zones`
* `yc alb load-balancer enable-zones`

#### Cloud Desktop

Флаг `--id` теперь не является обязательным для команды `yc desktop update-properties`.

#### Managed Service for ClickHouse®

Добавлены параметры для управления автоматическим расширения диска. Команды, в которых можно задавать новые параметры:
* `yc clickhouse cluster create`
* `yc clickhouse cluster update`
* `yc clickhouse restore`
* `yc clickhouse shards add`
* `yc clickhouse shard update`

#### Managed Service for GitLab

Добавлена команда для изменения инстанса `yc managed-gitlab instance update`.

#### Yandex MPP Analytics for PostgreSQL

Добавлена команда для подключения пользователей с IAM-аутентификацией `yc managed-greenplum connect`.

#### Managed Service for MySQL®

Добавлен флаг `--disk-size-autoscaling` в команду `yc managed-mysql cluster update`.

#### Managed Service for OpenSearch

Добавлены команды для включения и выключения кластера:
* `yc managed-opensearch cluster start`
* `yc managed-opensearch cluster stop`

#### Network Load Balancer

Переименованы команды для начала и отмены блокировки зон балансировщика:
* `yc load-balancer network-load-balancer disable-zones`
* `yc load-balancer network-load-balancer enable-zones`

### Версия 0.153.0 (30.06.25) {#version0.153.0}

#### Изменения в сервисах Yandex Cloud

##### Cloud Desktop

В команде `desktops update group` изменен тип флага `--disk-size` для загрузочного (boot) и рабочего (data) дисков на `byteSize`.

### Версия 0.152.0 (25.06.25) {#version0.152.0}

#### Изменения в сервисах Yandex Cloud

##### Application Load Balancer {#version-0.152-alb}

В командах `yc application-load-balancer load-balancer start-zonal-shift` и `yc application-load-balancer load-balancer cancel-zonal-shift` для старта и отмены Zonal Shift на балансировщике разрешено указывать список зон.

##### Cloud Desktop {#version-0.152-desktop}

* Добавлена команда `yc desktops group update` для обновления информации о группе рабочих столов.
* В команду `yc desktops group create` добавлены параметры `max-group-size`, `hot-standby`, `user-account-id`.

##### Network Load Balancer {#version-0.152-nlb}

Добавлены команды для старта и отмены блокировки зон балансировщика:
* `yc load-balancer network-load-balancer start-zonal-shift`
* `yc load-balancer network-load-balancer cancel-zonal-shift`

##### Apache Hive™ Metastore {#version-0.152-metastore}

Добавлены команды для управления кластерами Apache Hive™ Metastore:
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

**Managed Service for PostgreSQL**

Устаревший аргумент `version` параметра `extension` в команде `postgresql database` больше не существует.

### Версия 0.151.0 (19.06.25) {#version0.151.0}

#### Изменения в сервисах Yandex Cloud

##### Application Load Balancer

* Добавлено поле `regex_rewrite`, которое позволяет модифицировать параметры HTTP-запросов с помощью регулярных выражений на виртуальных хостах. Поддержка поля добавлена в следующие команды:
  * `yc application-load-balancer virtual-host append-http-route`
  * `yc application-load-balancer virtual-host prepend-http-route`
  * `yc application-load-balancer virtual-host insert-http-route`
  * `yc application-load-balancer virtual-host update-http-route`

##### Cloud Desktop

* Добавлена команда `yc desktops image update` для обновления информации об образе.
* Добавлена команда `yc desktops desktop update-properties` для обновления информации о рабочем столе.
* Добавлена команда `yc desktops desktop start` для запуска рабочего стола.
* Добавлена команда `yc desktops desktop stop` для остановки рабочего стола.
* Добавлена команда `yc desktops desktop update` для синхронизации рабочего стола с конфигурацией группы.
* Добавлена команда `yc desktops group update` для обновления группы рабочих столов.

##### Managed Service for Kubernetes

* Добавлены команды для управления правами доступа к кластерам Managed Service for Kubernetes:
  * `yc managed-kubernetes cluster list-access-bindings`
  * `yc managed-kubernetes cluster set-access-bindings`
  * `yc managed-kubernetes cluster add-access-binding`
  * `yc managed-kubernetes cluster remove-access-binding`

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Добавлена команда `yc managed-clickhouse cluster update-external-dictionary`, позволяющая редактировать созданные в кластере словари.
* В команде `yc managed-clickhouse cluster list-logs` у параметра `--service-type` появилось новое возможное значение: `clickhouse-keeper`.

**Managed Service for Apache Kafka®**

* В параметре `--permission` у ключа `role` появились новые возможные значения: `topic_producer`, `topic_consumer`, `schema_reader`, `schema_writer`. Применимо к следующим командам:
  * `yc managed-kafka user create`
  * `yc managed-kafka user update`
  * `yc managed-kafka user grant-permission`
  * `yc managed-kafka user revoke-permission`

**Managed Service for Trino**

* Добавлены команды для работы с каталогами Yandex Managed Service for Trino:
  * `yc managed-trino catalog create`
  * `yc managed-trino catalog delete`
  * `yc managed-trino catalog get`  
  * `yc managed-trino catalog list`
  * `yc managed-trino catalog update`

### Версия 0.150.0 (02.06.25) {#version0.150.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### BareMetal
* Добавлены группы команд для работы с сервисом BareMetal:
  * `yc baremetal boot-image`
  * `yc baremetal configuration`
  * `yc baremetal private-subnet`
  * `yc baremetal public-subnet`
  * `yc baremetal hardware-pool`
  * `yc baremetal server`
  * `yc baremetal vrf`
  * `yc baremetal zone`

##### Compute Cloud
* В команду `yc compute snapshot-schedule update` добавлены параметры `--snapshot-description` и `--snapshot-labels`, с помощью которых можно задать описание и метки снимкам дисков, создаваемым по расписанию.
* Добавлены команды для редактирования меток снимков дисков, создаваемых по расписанию:
  * `yc compute snapshot-schedule add-snapshot-labels`
  * `yc compute snapshot-schedule remove-snapshot-labels`

##### Yandex Data Processing
* В команду `yc dataproc cluster create` добавлен параметр `--oslogin` для включения доступа по OS Login на кластере.

##### Managed Service for GitLab
* Добавлены команды для управления инстансами Managed Service for GitLab:
  * `yc managed-gitlab instance get`
  * `yc managed-gitlab instance list`
  * `yc managed-gitlab instance create`
  * `yc managed-gitlab instance stop`
  * `yc managed-gitlab instance start`
  * `yc managed-gitlab instance delete`

##### Object Storage
* Добавлены команды для работы с ACL бакетов и объектов:
  * `yc storage s3api get-bucket-acl`
  * `yc storage s3api put-bucket-acl`
  * `yc storage s3api get-object-acl`
  * `yc storage s3api put-object-acl`

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for MySQL®**
* В командах `yc mysql users create` и `yc mysql users update` обновлено поведение параметра `--permissions`.

**Managed Service for Trino**
* Добавлены команды для управления кластерами Managed Service for Trino:
  * `yc managed-trino cluster get`
  * `yc managed-trino cluster list`
  * `yc managed-trino cluster create`
  * `yc managed-trino cluster update`
  * `yc managed-trino cluster delete`
  * `yc managed-trino cluster start`
  * `yc managed-trino cluster stop`
  * `yc managed-trino cluster list-operations`

### Версия 0.149.0 (20.05.25) {#version0.149.0}

#### Изменения в сервисах Yandex Cloud {#version0.149.0-services}

##### Managed Service for Apache Kafka®

* В командах `yc kafka cluster create` и `yc kafka cluster update` удален параметр `--log-preallocate` для управления соответствующей настройкой брокера Apache Kafka.
* В командах `yc kafka topic create` и `yc kafka topic update` удален параметр `--preallocate` для управления соответствующей настройкой топика Apache Kafka.

##### Managed Service for ClickHouse®

Добавлены команды для управления расширениями:
* `yc managed-clickhouse extension list`
* `yc managed-clickhouse extension get`
* `yc managed-clickhouse cluster add-extension`
* `yc managed-clickhouse cluster update-extension`
* `yc managed-clickhouse cluster get-extension`
* `yc managed-clickhouse cluster list-extensions`
* `yc managed-clickhouse cluster remove-extension`

### Версия 0.148.0 (30.04.25) {#version0.148.0}

#### Изменения в сервисах Yandex Cloud {#version0.148.0-services}

##### Compute Cloud

* В команде создания снапшотов по расписанию добавлена возможность задать описание и метки для снапшотов:
  
  ```bash
  yc compute snapshot-schedule create --snapshot-description --snapshot-labels
  ```

##### Identity and Access Management
* Добавлена команда `yc iam whoami` для получения информации о своем аккаунте.

##### Managed Service for OpenSearch

Исправлено сообщение об ошибке, которое появлялось после успешного окончания операции перезапуска кластера OpenSearch или смены мастера.

##### Managed Service for PostgreSQL
Добавлены команды для управления пользователями в ресурсных группах Greenplum®:
  * `yc managed-greenplum user create`;
  * `yc managed-greenplum user get`;
  * `yc managed-greenplum user list`;
  * `yc managed-greenplum user update`;
  * `yc managed-greenplum`.

##### EventRouter
* Добавлена команда `yc serverless eventrouter connector create event-service` для создания коннектора типа `event_service` для отправки сообщений в шину через gRPC.
* Добавлена команда `yc serverless eventrouter send-event` для отправки сообщений в шину через gRPC для коннектора типа `event_service`.

##### Object Storage

* Исправлена ошибка, при которой в некоторых случаях при выполнении команды `yc storage s3 cp` бакет считался пустым, и копирование не выполнялось.

* В конфигурацию CLI добавлены параметры для настройки команды `yc storage s3 cp`:
  * `s3.max-queue-size` — максимальное количество задач в очереди. Значение по умолчанию — `1000`.
  * `s3.max-concurrent-requests` — максимальное количество одновременных запросов. Значение по умолчанию — `10`.
  * `s3.multipart-threshold` — пороговый размер объекта, при превышении которого будет использоваться составная (multipart) загрузка.  Значение по умолчанию — `8MB`.
  * `s3.multipart-chunksize` — размер частей, на которые будет делиться объект при составной (multipart) загрузке. Значение по умолчанию — `8MB`.

   Чтобы задать эти параметры, используйте команду `yc config set <параметр> <значение>`.

##### Managed Service for PostgreSQL

В команде `yc managed-greenplum cluster update` исправлена поддержка флага `--log-enabled` для Cloud Logging.

### Версия 0.147.0 (21.04.25) {#version0.147.0}

#### Изменения в сервисах Yandex Cloud {#version0.147.0-services}

##### Сервисы управляемых баз данных {#managed-db}

* В команды `yc managed-kafka cluster create`, `yc managed-kafka cluster update` добавлен параметр `--rest-api-enabled` для включения REST API на кластере.

* В команде `yc managed-mysql cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием Yandex Connection Manager.

* В команде `yc managed-postgresql cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием Yandex Connection Manager.

* В команде `yc managed-clickhouse cluster create` поддержан аргумент `--user generate-password` для автоматической генерации пароля с использованием Yandex Connection Manager.

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
  
##### Application Load Balancer {#alb}

* Добавлены команды для работы c механизмом ручного переключения зоны доступности на балансировщике:
  * `yc application-load-balancer load-balancer start-zonal-shift`
  * `yc application-load-balancer load-balancer cancel-zonal-shift`

* Добавлен параметр `--allow-zonal-shift`, который размечает балансировщик как способный работать в режиме отказа одной зоны доступности:
  * `yc application-load-balancer load-balancer create`
  * `yc application-load-balancer load-balancer update`

##### Identity and Access Management {#iam}

Добавлены команды для управления доступом к федерациям сервисных аккаунтов:
* `yc iam workload-identity oidc federation list-access-bindings`
* `yc iam workload-identity oidc federation set-access-bindings`
* `yc iam workload-identity oidc federation add-access-binding`
* `yc iam workload-identity oidc federation remove-access-binding`

##### Managed Service for YDB {#ydb}

В команде `yc ydb database backup` поддержан аргумент storage-class для указания типа хранилища

##### Compute Cloud {#compute}

Добавлены команды для привязки инстансов к пулам резервов ВМ.

##### Object Storage {#storage}

* Добавлена команда `yc storage s3 cp` для копирования объектов между файловой системой и объектным хранилищем или между бакетами объектного хранилища.
* Добавлена команда `yc storage s3 mv` для перемещения объектов между файловой системой и объектным хранилищем или между бакетами объектного хранилища.
* Добавлена команда `yc storage s3 rm` для удаления объектов в бакете.


### Версия 0.146.1 (03.04.25) {#version0.146.1}

#### Изменения в сервисах Yandex Cloud {#version0.146.1-services}

##### Compute Cloud {#compute}

* Добавлены команды для управления пулами резервов ВМ:
  * `yc compute reserved-instance-pool get`;
  * `yc compute reserved-instance-pool list`;
  * `yc compute reserved-instance-pool create`;
  * `yc compute reserved-instance-pool update`;
  * `yc compute reserved-instance-pool delete`.

### Версия 0.146.0 (02.04.25) {#version0.146.0}

#### Изменения в сервисах Yandex Cloud {#version0.146.0-services}

##### Audit Trails {#audit-trails}

* В командах `yc audit-trails trail create` и `yc audit-trails trail update` больше не проверяются параметры `--filter-from-*`. В следующем релизе эти параметры будут удалены.

##### Cloud Interconnect {#interconnect}

* В команде `yc cic trunk-connection update` удалены параметры `--capacity` и `--pop`.
 
##### Identity and Access Management {#iam}

* В команде `yc iam api-key create` параметр `--scope` помечен как **DEPRECATED**.

##### Object Storage {#storage}

* Добавлена команда `yc storage s3api list-objects` для получения списка объектов в бакете.

##### Сервисы управляемых баз данных {#managed-db}

* Добавлен флаг `--generate-password` для автоматической генерации пароля с использованием Connection Manager в команды:
  * `yc managed-clickhouse user create`, `yc managed-clickhouse user update`;
  * `yc managed-mysql user create`, `yc managed-mysql user update`;
  * `yc managed-postgresql user create`, `yc managed-postgresql user update`.

**Managed Service for Apache Kafka®**

* В командах `yc managed-kafka user create` и `yc managed-kafka user update` в параметре `--permission` для ключа `role` добавилось новое возможное значение `topic_admin`.

**Yandex MPP Analytics for PostgreSQL**

* Для команды `yc managed-greenplum cluster create` исправлена версия по умолчанию с 6.19 на 6.25.

**Managed Service for OpenSearch**

* Добавлена команда `yc managed-opensearch cluster restart-opensearch` для перезапуска сервиса на хосте, указанном в параметре `--host`.
* Добавлена команда `yc managed-opensearch cluster switch-master` для переключения текущего мастера.
  * В параметре `--from-hosts host,[host...]` можно указать список хостов, с которых должен быть переключен мастер. Если мастер уже не находится ни на одном из указанных хостов, никаких изменений не произойдет.
  * Если параметр `--from-hosts` отсутствует, мастер будет переключен с хоста, на котором он находится в данный момент.

**Managed Service for YDB**

* В команды `yc ydb database create` и `yc ydb database update` добавлены параметры `--security-group-name` и `--security-group-id`.

### Версия 0.145.0 (18.03.25) {#version0.145.0}

#### Изменения в сервисах Yandex Cloud {#version0.145.0-services}

##### Yandex Managed Service for Valkey™ {#version0.145.0-mrd}

* В команды: `yc managed-redis cluster create`, `yc managed-redis cluster restore`,`yc managed-redis cluster update-config` добавлены параметры:
  * `activedefrag`;
  * `aof-max-size-percent`.

* Параметр `--persistence-mode` теперь может принимать значение `ON_REPLICAS` в командах:
  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.

##### Managed Service for OpenSearch {#version0.145.0-mos}

* Добавлена поддержка типа дисков `local-ssd`.
* Добавлена возможность автоматического назначения подсетей при создании кластера или добавлении группы хостов.

##### Cloud Quota Manager {#version0.145.0-quota-manager}

* Добавлена группа команд `yc quota-manager quota-limit` для просмотра лимитов квот:
  * `yc quota-manager quota-limit get` — вывести значение определенной квоты;
  * `yc quota-manager quota-limit list` — вывести список квот для определенного сервиса;
  * `yc quota-manager quota-limit list-service` — вывести список сервисов, для которых есть квоты.

##### Cloud Interconnect {#version0.145.0-cic}

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

##### Cloud Router {#version0.145.0-cloudrouter}

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

##### Network Load Balancer {#version0.145.0-nlb}

* Для команды `yc network-load-balancer update` исправлена ошибка в обработчике флага `--allow-zonal-shift`.

### Версия 0.144.0 (27.02.25) {#version0.144.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Yandex Managed Service for Valkey™

* Добавлены команды для вывода, чтения, создания, редактирования и удаления пользователей:
  * `yc managed-redis user list`;
  * `yc managed-redis user get`;
  * `yc managed-redis user create`;
  * `yc managed-redis user update`;
  * `yc managed-redis user delete`.

* Параметр `--auth-sentinel`, который позволяет авторизоваться в Redis Sentinel, добавлен в команды:

  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.

* Параметр `--user`, который позволяет добавить пользователей в Redis, добавлен в команду `yc managed-redis cluster create`.

* Параметр `--zset-max-listpack-values` добавлен в команды:
  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update-config`.

##### Resource Manager {#resmgr}

* В команду `yc resource-manager cloud create` добавлен опциональный параметр `--organization-id`.

##### Cloud Backup {#backup}

* Добавлена команда `backup backup batch-delete` для удаления всех бэкапов в архиве и удаления самого архива. Архив можно указать параметром `--archive-id` или параметрами `--instance-id` и `--policy-id`.

##### yc managed-greenplum

* Для команды `yc managed-greenplum cluster update-config` изменен список поддерживаемых версий Greenplum®:

  * удалена поддержка версий 6.17 и 6.19;
  * добавлена поддержка версии 6.25+.

* Для команд `yc managed-greenplum cluster create/update/restore` добавлен параметр `--service-account`. Параметр позволяет указать сервисный аккаунт для доступа к ресурсам Yandex Cloud в пользовательском облаке. Например, к Cloud Logging.

* Для команд `yc managed-greenplum cluster create/update` добавлены параметры:

  * `--log-enabled` — включить поставку логов в Cloud Logging;
  * `--log-folder-id <folder_id>` и `--log-group-id <log_group_id>` — указать каталог и группу для поставки логов в Cloud Logging;
  * `--log-command-center-enabled` — включить поставку логов из Command Center;
  * `--log-greenplum-enabled` — включить поставку логов из Greenplum®;
  * `--log-pooler-enabled` — включить поставку логов из пулера Odyssey®.

##### Network Load Balancer

* Для команд `yc network-load-balancer create/update` добавлен параметр `--allow-zonal-shift`, который позволяет балансировщику работать в режиме отказа одной зоны доступности (AZ).

### Версия 0.143.0 (11.02.25) {#version0.143.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Object Storage

* В команду `yc storage bucket update` добавлен параметр для указания [сервисного подключения](../vpc/concepts/private-endpoint.md) Yandex Virtual Private Cloud, из которого будет разрешен доступ в бакет:
  * `--private-endpoint`, пример: `--enable-private-endpoints true --private-endpoints cba,abc`.

### Версия 0.142.0 (30.01.25) {#version0.142.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Yandex Data Processing {#dataproc}

* В команду `yc dataproc cluster create` добавлен параметр `--environment` для указания окружения, пример: `--environment prestable`.

##### Identity and Access Management {#iam}

* Добавлена команда `yc iam refresh-token list` для вывода refresh-токенов.
* Добавлена команда `yc iam refresh-token revoke` для отзыва refresh-токенов.

##### Object Storage {#storage}

* Добавлены команды для чтения, изменения и удаления меток объекта:
  * `yc storage s3api get-object-tagging`;
  * `yc storage s3api put-object-tagging`;
  * `yc storage s3api delete-object-tagging`.
 
##### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* В команды `yc managed-mongodb cluster create`, `yc managed-mongodb cluster restore` и `yc managed-mongodb cluster update` добавлен параметр `--websql-access`, который позволяет настроить доступ в MongoDB через WebSQL.

* В команду `yc managed-mongodb cluster restore` добавлены опции, необходимые для восстановления шардированного кластера MongoDB.

**Yandex Managed Service for Valkey™**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore`, `yc managed-redis cluster update-config` добавлен параметр `--backup-retain-period-days`.

### Версия 0.141.0 (16.12.24) {#version0.141.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Functions {#serverless-functions}

В команду `yc serverless function version create` добавлен параметр `--metadata-options` для указания опций получения метаданных в функции. Пример использования: 

```bash
yc serverless function version create --metadata-options aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled
```

##### Serverless Containers {#serverless-containers}

В команду `yc serverless container revision deploy` добавлен параметр `--metadata-options` для указания опций получения метаданных в
контейнере. Пример использования: 

```bash
yc serverless container revision deploy --metadata-options aws-v1-http-endpoint=disabled,gce-http-endpoint=enabled
```

##### Identity and Access Management

В команду `yc iam api-key create` добавлен опциональный параметр `--scopes` для указания области действия API-ключа. Если параметр не задан, ключ создается без ограничений. 

Параметр `--scope` будет удален в следующий версии YC CLI.

* Добавлена команда `yc iam api-key update` для редактирования API-ключа. У команды есть следующие параметры:
  * `--description` для изменения описания API-ключа.
  * `--scopes` для изменения областей действия API-ключа.
  * `--expires_at` для изменения срока действия ключа. Если параметр не задан, API-ключ не имеет срока действия.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

В команду `yc managed-greenplum cluster create` добавлен параметр `--cloud-storage`, который позволяет указать параметры работы с облачным хранилищем. Пример включения облачного хранилища: 

```bash 
yc managed-greenplum cluster create --cloud-storage enabled=true
```

### Версия 0.140.0 (29.11.24) {#version0.140.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Application Load Balancer {#alb}

* В команды `yc alb backend-group add-http-backend` и `yc alb backend-group update-http-backend` для параметра `--http-healthcheck` добавлено свойство `--expected-statuses`. Оно позволяет указать собственные коды HTTP-статусов, которые будут считаться корректными при проверках состояния бэкенда (HealthCheck).

##### Cloud Desktop {#cloud-desktop}

* В команду `yc desktops desktop create` добавлен параметр `subnet-id`.

##### Cloud Registry {#cloud-registry}

* Добавлены команды `yc cloud-registry artifact get` и `yc cloud-registry artifact delete`, позволяющие управлять артефактами.
* Добавлены команды для управления реестрами: `yc cloud-registry registry [ get | list | create | update | delete | add-labels | remove-labels | list-access-bindings | set-access-bindings | add-access-bindings | remove-access-bindings | list-ip-permissions | set-ip-permissions | add-ip-permissions | remove-ip-permissions ]`.

##### Data Transfer {#data-transfer}

* В команду `yc datatransfer endpoint create <endpoint_type>` для эндпоинтов `postgres-target`, `clickhouse-target`, `mysql-target` и `mongo-target` добавлен параметр `--cleanup-policy`, который позволяет задавать политики очистки приемника при активации и переактивации трансфера (`drop`, `truncate` или `disabled`).

##### Yandex IoT Core {#iot}

* В текстовый формат команд `iot registry list` и `iot device list` добавлена колонка STATUS.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore` и `yc managed-redis cluster update-config` добавлены параметры:
  * `use-luajit`;
  * `io-threads-allowed`.

### Версия 0.139.0 (18.11.24) {#version0.139.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Desktop {#cloud-desktop}

* В команду `yc desktops desktop` добавлен параметр `user-account-id`. Удален праметр `subject`.
* Добавлена команда `yc desktops image` для управления образами рабочих столов.

##### Container Registry {#container-registry}

* Исправлена регрессия в Docker Credential helper, приводившая к невозможности выбора профиля не по умолчанию.

##### Compute Cloud {#compute}

* В команды `yc compute disk create` и `yc compute instance create` добавлены параметры `kms-key-id` и `kms-key-name` для поддержки шифрования дисков.

##### Serverless Containers {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлен параметр `--runtime`, позволяющий задать режим работы контейнера (`http` или `task`).

### Версия 0.138.0 (06.11.24) {#version0.138.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Compute Cloud {#compute}

* Команда `yc compute connect-to-serial-port` теперь явно проверяет наличие флагов `serial-port-enable` и `enable-oslogin` в метаданных инстанса.

##### Cloud Interconnect {#interconnect}

* Команды `yc cic point-of-presence get` и `yc cic partner get` теперь работают только с ID без параметров.
* Для `trunk-connection`, `private-connection` и `public-connection` в Cloud Interconnect и для `routing-instance` в Cloud Router исправлен формат результата команды `list` — удалена часть полей и преобразованы форматы отображения.

### Версия 0.137.0 (01.11.24) {#version0.137.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Interconnect {#interconnect}

* Исправлена работа команд `get` без параметров в Cloud Interconnect и Cloud Router.
* Исправлен формат результатов команд `list` в Cloud Interconnect и Cloud Router — теперь возвращается таблица.

##### Object Storage {#object-storage}

* Добавлены команды `yc storage s3api get-object-retention` и `yc storage s3api put-object-retention` для чтения и изменения временной блокировки объекта.
* Добавлены команды `yc storage s3api get-object-legal-hold` и `yc storage s3api put-object-legal-hold` для чтения и изменения бессрочной блокировки объекта.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `17` для параметра `--postgresql-version string`. Оно позволяет создать кластер PostgreSQL версии 17.

### Версия 0.136.0 (21.10.24) {#version0.136.0}

#### Изменения в CLI {#cli}

* В команде `yc init` теперь не предлагается зона `ru-central1-c`, поскольку она больше не используется.

#### Изменения в сервисах Yandex Cloud {#services}

##### Application Load Balancer {#alb}

* В команды `yc application-load-balancer load-balancer add-stream-listener`, `yc application-load-balancer load-balancer update-stream-listener`, `yc application-load-balancer load-balancer add-stream-sni`, `yc application-load-balancer load-balancer update-stream-sni` добавлен параметр `--idle-timeout`, позволяющий указать таймаут неактивности соединения. 

##### EventRouter {#eventrouter}

* Дополнена валидация параметров для команды `yc serverless eventrouter`.
* Исправлена ошибка при работе команды `yc serverless eventrouter put-event`.

##### Object Storage {#object-storage}

* Добавлена возможность проставить `--storage-endpoint` с помощью `yc config set`. Если пользователь не указал явно `--storage-endpoint`, то эндпоинт будет получен из `ApiEndpointService`.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

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

**yc managed-mongodb, yc managed-clickhouse, yc managed-greenplum, yc managed-postgresql, yc managed-redis, yc managed-mysql, yc managed-kafka, yc managed-elasticsearch, yc managed-opensearch**

* Уточнено описание параметров `--disk-size`, по умолчанию размер диска передается в ГБ.

### Версия 0.135.0 (07.10.24) {#version0.135.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#k8s}

* Добавлены команды для работы с продуктами Cloud Marketplace в кластере Managed Service for Kubernetes: 
   * `yc managed-kubernetes marketplace helm-release install` — установка Helm-чарта продукта Cloud Marketplace в указанный кластер Managed Service for Kubernetes.
   * `yc managed-kubernetes marketplace helm-release update` — обновление версии Helm-чарта продукта Cloud Marketplace.
   * `yc managed-kubernetes marketplace helm-release uninstall` — удаление версии Helm-чарта продукта Cloud Marketplace.
   * `yc managed-kubernetes marketplace helm-release get` — получение информации о Helm-чарте продукта Cloud Marketplace.
   * `yc managed-kubernetes marketplace helm-release list` — получение списка Helm-чартов Cloud Marketplace, установленных в кластере Managed Service for Kubernetes.

##### Load Testing

* В команду `yc loadtesting agent create` добавлены параметры `log-group-id` и `log-group-name` для указания целевой лог-группы для отправки логов агента нагрузочного тестирования.

### Версия 0.134.0 (02.10.24) {#version0.134.0}

#### Изменения в CLI {#cli}

* Добавлен глобальный параметр `--jq`. Используется для фильтрации и преобразования вывода при помощи jq-шаблонов. Примеры:
  * `yc iam role list --jq '.[].id'`
  * `ID="instance_id" yc compute instance list --jq '.[] | select(.id == env.ID)'`

#### Изменения в сервисах Yandex Cloud {#services}

##### Object Storage {#storage}

* Добавлена базовая поддержка операций с объектами через S3 API:
  * `yc storage s3api get-object` — получение объекта из бакета.
  * `yc storage s3api put-object` — загрузка объекта в бакет.
  * `yc storage s3api delete-object` — удаление объекта.
  * `yc storage s3api copy-object` — копирование существующего в бакете объекта.
  * `yc storage s3api head-object` — получение метаданных объекта.
  * `yc storage s3api delete-objects` — удаление группы объектов.

  Чтобы работать с объектами, укажите в конфигурационном файле CLI `~/.config/yandex-cloud/config.yaml` эндпоинт Object Storage:

  ```yaml
  ...
  profiles:
    default:
      ...
      storage-endpoint: https://storage.yandexcloud.net/
  ```

##### Cloud Interconnect {#interconnect}

* Добавлены команды `yc cic point-of-presence get` и `yc cic point-of-presence list` для чтения точек присутствия.
* Добавлены команды `yc cic partner get` и `yc cic partner list` для чтения партнеров Cloud Interconnect.
* Добавлены команды `yc cic trunk-connection get` и `yc cic trunk-connection list` для чтения транковых подключений.
* Добавлены команды `yc cic private-connection get` и `yc cic private-connection list` для чтения приватных соединений.
* Добавлены команды `yc cic public-connection get` и `yc cic public-connection list` для чтения публичных соединений.

##### Cloud Desktop {#cloud-desktop}

* В команду `yc desktops group create` добавлен параметр `--image-id`, который позволяет передать идентификатор образа для группы рабочих столов. 

##### Cloud Backup {#backup}

* Добавлены следующие команды:
  * `yc backup agent install` — для установки [агента Cloud Backup](../backup/concepts/agent.md) и подключения ВМ с установленным OS Login к Cloud Backup.
  * `yc backup agent reinstall` — для повторной установки агента Cloud Backup для ВМ с установленным OS Login.
  * `yc backup agent debug-info` — для получения логов установки агента Cloud Backup для ВМ с установленным OS Login.
  * `yc backup provider activate` — для активации сервиса и подключения к провайдеру резервного копирования.

* При выполнении команд теперь проверяется, активирован ли сервис Cloud Backup в каталоге.

##### Serverless Integrations {#serverless-integrations}

* Добавлена поддержка Yandex EventRouter.

##### Identity and Access Management {#iam}

* Изменен заголовок в табличном выводе команды `yc iam service accounts list`.

##### Yandex Identity Hub {#organization}

* В вывод команды `yc organization-manager user list --organization-id` добавлено время последней аутентификации пользователя.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* В командах `yc managed-greenplum cluster create` и `yc managed-greenplum cluster restore` добавлена поддержка опций `--master-host-group-ids` и `--segment-host-group-ids` для указания, на какие группы выделенных хостов размещать хосты мастера и сегментов Greenplum®.

**Yandex Managed Service for Valkey™**

* Добавлена команда `yc managed-redis backup delete` для удаления бэкапов.
* Изменена версия Redis по умолчанию на 7.2 в связи с окончанием поддержки 6.2 и 7.0.

**Managed Service for Apache Kafka®**

* В командах `yc managed-kafka cluster create`, `yc managed-kafka cluster update`, `yc managed-kafka cluster grant-permission`, `yc managed-kafka cluster revoke-permission` расширен параметр `--permission`. Его значение задается в формате `key=value,...`, в качестве `key` теперь можно использовать `allow_host` — хост, с которого действует данное правило для пользователя.

**Managed Service for Apache Airflow™**

* Исправление ошибок и улучшения работы сервиса Managed Service for Apache Airflow™.

### Версия 0.133.0 (09.09.24) {#version0.133.0}

#### Изменения в CLI {#cli}

* Исправлена ошибка, приводившая к подмене реальных сообщений об ошибке текстом `ERROR: Failed to retrieve data`. Затронутые проблемой версии: 0.131.0–0.132.1.

#### Изменения в сервисах Yandex Cloud {#services}

##### Audit Trails {#audit-trails}

* Команды для управления трейлами теперь используют поле `filtering_policy` вместо `filter`. Устаревшее поле все еще может быть доступно с помощью опции `--file` для описания запросов.

##### Compute Cloud {#compute}

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

**Managed Service for ClickHouse®**

* Добавлены команды `yc managed-clickhouse cluster [ clear-query-masking-rules | set-query-masking-rules ]` для работы с опцией `query_masking_rules` в ClickHouse®, позволяющей создавать правила для запросов с целью устранения утечки конфиденциальной информации.
* Для команды `yc managed-clickhouse cluster add-external-dictionary` добавлены параметры:
  * `--layout-max-array-size` — определение максимального количества ключей словаря.
  * `--http-header` — добавление HTTP-заголовков у HTTP-источников внешних словарей.
* Для команды `yc managed-clickhouse cluster add-external-dictionary --clickhouse-source` добавлен параметр `--secure` для включения SSL в соединениях.
* Для команды `yc managed-clickhouse cluster add-external-dictionary --mysql-source` добавлены параметры:
  * `--close-connection` — закрытие соединения после каждого запроса.
  * `--share-connection` — возможность использования соединения несколькими запросами.

**Yandex Managed Service for Valkey™**

* В команды `yc managed-redis cluster [ create | update | restore ]` добавлен параметр `--websql-access`, который позволяет установить в Redis доступ через WebSQL.

**Yandex MPP Analytics for PostgreSQL**

* В команды `yc managed-greenplum cluster [ create | update | restore ]` добавлен параметр `--yandexquery-access`, разрешающий доступ к кластеру из сервиса Yandex Query.
* В команды `yc managed-greenplum cluster [ create | update ]` добавлены параметры `--analyze-and-vacuum`, `--query-killer-idle`, `--query-killer-idle-in-transaction` и `--query-killer-long-running`, позволяющие управлять фоновыми процессами Yandex MPP Analytics for PostgreSQL.

**Managed Service for Apache Airflow™**

* Добавлены команды для работы с сервисом Managed Service for Apache Airflow™: `yc managed-airflow cluster [ get | list | delete | list-operations | start | stop | create | update ]`.

### Версия 0.132.1 (28.08.24) {#version0.132.1}

#### Изменения в CLI {#cli}

* Исправлены ошибки в документации флага `--help`.

### Версия 0.132.0 (26.08.24) {#version0.132.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Identity and Access Management {#iam}

* Добавлена команда `yc iam revoke-token` для отзыва скомпрометированных токенов.
* Добавлена команда `yc iam api-key list-scopes` для получения списка областей действия, доступных при создании API-ключей.

##### Cloud Functions {#cloud-functions}

* В команду `yc serverless function version create` добавлен параметр `--mount` для указания монтируемых ресурсов, таких как бакеты Object Storage и эфемерные диски.
* В команде `yc serverless function version create` параметр `--storage-mounts` помечен как `deprecated`.

##### Serverless Containers {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлен параметр `--mount` для указания монтируемых ресурсов, таких как бакеты Object Storage и эфемерные диски.
* В команде `yc serverless container revision deploy` параметр `--storage-mounts` помечен как `deprecated`.

##### Cloud Backup {#backup}

* Добавлен параметр `--type` в команду `backup vm list` для указания типа ресурсов, которые должны возвращаться в списке.

##### Virtual Private Cloud {#vpc}

* Добавлена группа команд `yc vpc private-endpoint` для управления ресурсами VPC Private Endpoint.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* В команды `yc managed-mongodb cluster create` и `yc managed-mongodb cluster update` добавлен параметр `--disk-size-autoscaling` для включения автоматического масштабирования диска.

**Yandex Managed Service for Valkey™**

* В командах `yc managed-redis cluster create` и `yc managed-redis cluster update` для `--disk-size-autoscaling` изменены единицы измерения `disk-size-limit` с байт на гигабайты.

### Версия 0.131.1 (15.08.24) {#version0.131.1}

#### Изменения в CLI {#cli}

* Исправлена проблема в обработке некоторых ошибок, из-за которой в тексте ошибки символ `_` заменялся на `-`.

### Версия 0.131.0 (14.08.24) {#version0.131.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Backup {#backup}

* Добавлена команда `backup policy execute` для создания резервной копии виртуальной машины согласно указанной политике резервного копирования.

##### Identity and Access Management {#iam}

* В команды `add-access-binding` и `remove-access-binding` добавлена поддержка опции `--agent`.
* Добавлено дерево команд `yc iam workload-identity` для управления федерацией удостоверений рабочей нагрузки.
* Команды `yc iam service-account list` и `yc iam service-account get` теперь показывают время последней аутентификации сервисного аккаунта.

##### Container Registry {#container-registry}

* В команду `yc container registry create` добавлена опция `--secure` для создания реестра с настройками безопасности.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* Добавлена команда `yc managed-greenplum cluster move` для перемещения кластера в другой каталог.

### Версия 0.130.0 (01.08.24) {#version0.130.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Data Transfer

* В команду `yc datatransfer endpoint create clickhouse-source` добавлен параметр `--cluster-name`, позволяющий указать имя ClickHouse-кластера для переноса данных.

##### Cloud Marketplace

* Добавлена команда `yc marketplace reset-password`, ошибочно не попавшая в прошлый релиз.

##### Identity and Access Management {#iam}

* Из дерева команд `yc iam service-control` удалены команды `pause` и `resume`.

##### Compute Cloud

* В команду `yc compute host-group list-instances` добавлен параметр `--host-id`, позволяющий указать ID хоста в группе хостов для листинга виртуальных машин.

##### Load Testing

* В команду `yc loadtesting agent create` добавлена возможность ожидания подключения созданного агента к сервису Load Testing:
  * флаг `--wait-ready` — не завершать команду, пока агент не перейдет в статус `READY FOR TEST`;
  * параметр `--wait-ready-timeout` — максимальное время ожидания для `--wait-ready` (default: 5m).

#### Изменения в CLI {#cli}

* Протокол авторизации федеративных аккаунтов изменен на Authorization Code Flow с Proof Key for Code Exchange (PKCE).

### Версия 0.129.0 (16.07.24) {#version0.129.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Load Testing

* В команде `yc loadtesting test get-report-table` исправлена ошибка для тестов без табличного отчета.

##### SmartCaptcha

Добавлена поддержка сервиса SmartCaptcha:

* Команды группы `yc smartcaptcha captcha` позволяют управлять капчами.

##### Smart Web Security

Добавлена поддержка сервиса Smart Web Security:

* Команды группы `yc smartwebsecurity security-profile` позволяют управлять профилями безопасности.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* В команды `yc managed-redis cluster create` и `yc managed-redis cluster update` добавлен параметр `--disk-size-autoscaling` для включения автоматического масштабирования диска.

**Managed Service for ClickHouse®**

* Добавлены команды для управления правами `yc managed-kafka user grant-permission` и `yc managed-kafka user revoke-permission`.
* Добавлены команды `yc managed-clickhouse hosts add` и `yc managed-clickhouse shards add`. Параметр `copy-schema` включен по умолчанию.
* Добавлена команда для удаления бэкапа `yc managed-clickhouse backup delete`.
* В команду `yc managed-kafka cluster update` добавлен параметр `--disk-type`.
* Добавлен параметр `--backup-retain-period-days` для настройки периода хранения автоматических бэкапов.

##### Cloud Marketplace {#marketplace}

* Добавлена команда `yc marketplace reset-password` для сброса пароля на виртуальных машинах с установленным агентом для сброса паролей.


### Версия 0.128.0 (02.07.24) {#version0.128.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### API Gateway {#api-gw}

В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлен параметр `--execution-timeout` для указания тайм-аута на максимальное время обработки запроса к API-шлюзу.

#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Добавлен параметр `--convert-tables-to-replicated` для конвертации таблиц в реплицируемые при добавлении в кластер ZooKeeper.

**Yandex MPP Analytics for PostgreSQL**

* В команду `yc managed-greenplum cluster expand` добавлены опции `delay-redistribution`, `parallel`, `close-cluster`.

### Версия 0.127.0 (17.06.24) {#version0.127.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Identity and Access Management {#iam}

* Добавлены команды для управления метками `yc iam service-account add-labels` и `yc iam service-account remove-labels`.
* В команды `yc iam service-account create` и `yc iam service-account update` добавлен параметр `--labels` — он задает набор меток для БД.

##### Yandex Identity Hub {#organization}

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

##### Resource Manager {#resmgr}

* Добавлены команды для управления метками `yc resource-manager cloud add-labels` и `yc resource-manager cloud remove-labels`.
* В команду `yc resource-manager cloud update` добавлен параметр `--labels` — он задает набор меток для БД.

##### Yandex IoT Core {#iot}

* Добавлены команды для включения и выключения реестров `yc iot registry enable` и `yc iot registry disable`.

##### Cloud Functions {#cloud-functions}

* Для команды `yc serverless function version create` добавлен новый параметр `concurrency`.

### Версия 0.126.0 (04.06.24) {#version0.126.0}

#### Изменения в CLI {#cli}

* В профиль добавлено поле `region`, предназначенное для работы с различными регионами.
* В команду `init` добавлен параметр `--region`, предназначенный для инициализации CLI с определенным регионом.

#### Изменения в сервисах Yandex Cloud {#services}

##### Resource Manager {#resmgr}

* Добавлена команда `yc resource-manager cloud create` для создания облака.
   * Параметр `--billing-account-id` позволяет автоматически привязать созданное облако к платежному аккаунту.
* Добавлена команда `yc resource-manager cloud delete` для удаления облака.
   * Параметр `--delete-after` позволяет удалить облако через указанное время.
* В команду `yc resource-manager folder delete` добавлен параметр `--delete-after` для отложенного удаления через указанное время.

##### Load Testing {#load-testing}

* В команду `yc loadtesting agent create` добавлен параметр `--platform-id` для создания виртуальной машины на указанной платформе.
* В команду `yc loadtesting test create` добавлены параметры для управления выгрузкой артефактов агента в Object Storage:
  * `--artifacts-output-bucket` для указания имени бакета, в который будут выгружаться артефакты.
  * `--artifacts-make-archive` для определения того, будут ли артефакты выгружаться одним архивом или по отдельности.
  * `--artifacts` для указания конкретных файлов, которые будут выгружены.

##### Managed Service for OpenSearch {#mos}

* В команды `yc managed-opensearch cluster create` и `yc managed-opensearch cluster restore` добавлен опциональный параметр `--keystore-settings`, который позволяет задать содержимое OpenSearch keystore.
* В команду `yc managed-opensearch cluster update` добавлены опциональные параметры `--set-keystore-settings` и `--remove-keystore-settings`:
   * `--set-keystore-settings` для указания списка записей, которые будут добавлены или заменены. Записи в keystore, которые не указаны в этом параметре, останутся без изменений.
   * `--remove-keystore-settings` для указания списка записей, которые должны быть удалены из keystore.

##### Cloud Functions {#cloud-functions}

* В команде `yc serverless function allow-unauthenticated-invoke` устаревшая роль `serverless.functions.invoker` заменена на новую `functions.functionInvoker`.
* Команда `yc serverless function deny-unauthenticated-invoke` теперь удаляет устаревшую роль `serverless.functions.invoker` и новую роль `functions.functionInvoker`.

##### Serverless Containers {#serverless-containers}

* В команде `yc serverless container allow-unauthenticated-invoke` устаревшая роль `serverless.containers.invoker` заменена на новую `serverless-containers.containerInvoker`.
* Команда `yc serverless container deny-unauthenticated-invoke` теперь удаляет устаревшую роль `serverless.containers.invoker` и новую роль `serverless-containers.containerInvoker`.

### Версия 0.125.0 (20.05.24) {#version0.125.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Compute Cloud
* В команду `yc compute ssh` добавлен флаг `--public-address` для подключения к ВМ по SSH, с использованием только публичного адреса.
* По умолчанию команда `yc compute ssh` будет устанавливать соединение с ВМ через публичный адрес. Если у ВМ нет публичного адреса, то соединение будет устанавливаться через внутренний адрес.

##### Identity and Access Management

* В команду `yc iam api-key create` добавлены опциональные параметры `--scope` и `--expires_at`:
  * `--scope` — для указания области действия API-ключа — сервисов, в которых его можно использовать. Если параметр не задан, то область действия ключа не ограничена.
  * `--expires_at` — для указания срока действия API-ключа. Если параметр не задан, то ключ не имеет срока действия.

##### Cloud Functions {#serverless-functions}

* Команда `yc serverless trigger create`.

  Параметры `--gateway-name`, `--gateway-id` и `--gateway-websocket-broadcast-path` позволяют указать для триггера параметры рассылки сообщений в веб-сокетные соединения API Gateway.

##### Yandex Identity Hub {#organization}

* Добавлена группа команд `yc organization-manager oslogin profile` для управления пользовательскими профилями OS Login.
* В командах `yc organization-manager oslogin user-ssh-key create` и `yc organization-manager oslogin user-ssh-key update` исправлен параметр `--expires-at` при указании значения в виде интервала. Например, значение `5h` теперь отсылает к значению в будущем.

### Версия 0.124.0 (22.04.24) {#version0.124.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* Добавлено дерево команд `yc managed-greenplum hba-rules` с командами `get`, `list`, `delete`, `create` и `update`.

**Managed Service for ClickHouse®**

* Параметр `--shard-name` команды `yc managed-clickhouse cluster create` помечен как устаревший (deprecated). Рекомендуется использовать аргумент `shard-name` параметра `--host`.

### Версия 0.123.0 (08.04.24) {#version0.123.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Для параметра `--host` команды `yc managed-clickhouse cluster restore` добавлен опциональный аргумент `shard-name`.

**Yandex StoreDoc**

* В команду `yc managed-mongodb hosts add --host` добавлены параметры `hidden`, `priority` и `secondary-delay-secs`.
* Добавлена новая команда `yc managed-mongodb hosts update` для модификации параметров `hidden`, `priority` и `secondary-delay-secs`.

##### Cloud Functions {#serverless-functions}

* Изменены лимиты батчинга для команды `yc serverless trigger create`.

##### Cloud Backup {#backup}

* В вывод результата команды `backup resource list-tasks` добавлено поле `RESULT CODE`, отображающее код завершения операции с ВМ.

#### Изменения в CLI {#cli}

* В документацию и установочный скрипт внесены исправления, помогающие настроить автодополнение для `yc` в дистрибутивах Linux, основанных на CentOS.

### Версия 0.122.0 (27.03.24) {#version0.122.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Functions {#serverless-functions}

* В команду `yc serverless function version create` добавлен параметр `--tmpfs-size` для монтирования директории `/tmp` из памяти при выделении функции 1 ГБ памяти или больше.
* Удалена команда `yc serverless trigger create cloud-logs`.

##### Data Transfer

Добавлены следующие команды для создания и изменения эндпоинтов Yandex Data Streams:
* `yc datatransfer endpoint create yds-source`;
* `yc datatransfer endpoint create yds-target`;
* `yc datatransfer endpoint update yds-source`;
* `yc datatransfer endpoint update yds-target`.

##### Cloud DNS {#dns}

В следующие команды добавлен параметр `--deletion-protection` для защиты зоны DNS от случайного удаления:
* `yc dns zone create`;
* `yc dns zone update`.

##### Compute Cloud

* Добавлена команда `yc compute instance attach-network-interface` для добавления сетевого интерфейса в уже существующую ВМ.
* Добавлена команда `yc compute instance detach-network-interface` для удаления сетевого интерфейса из уже существующей ВМ.

### Версия 0.121.0 (12.03.24) {#version0.121.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Yandex MPP Analytics for PostgreSQL {#mgp}

* Добавлено дерево команд `yc managed-greenplum pxf-datasource` с командами `get`, `list`, `delete`.
* Добавлены деревья команд `yc managed-greenplum pxf-datasource s3` и `yc managed-greenplum pxf-datasource jdbc` с командами `create` и `update`.
* Добавлены параметры `--pxf-connection-timeout`, `--pxf-upload-timeout`, `--pxf-max-threads`, `--pxf-pool-allow-core-thread-timeout`, `--pxf-poll-core-size`, `--pxf-pool-queue-capacity`, `--pxf-pool-max-size`, `--pxf-xmx`, `--pxf-xms` для команды `yc managed-greenplum cluster update`.

##### Yandex Identity Hub {#organization}

* Добавлена группа команд `yc organization-manager oslogin` для управления настройками OS Login и пользовательскими SSH-ключами.

##### Container Registry {#container-registry}

* Добавлены поля `origin` и `type` в результат `yc container image list-vulnerabilities`.

##### Load Testing {#load-testing}

* Добавлена команда `yc loadtesting test wait` для ожидания окончания нагрузочного теста.
* В команде `yc loadtesting test create` добавлены флаги `--wait` и `--wait-idle-timeout` для ожидания окончания созданного нагрузочного теста.
* В команду `yc loadtesting test create` добавлены параметры `--configuration agent-by-filter=""` и `--configuration anonymous-agent=true` для выбора агента нагрузочного тестирования по фильтру и выбора анонимного агента соответственно.
* В команду `yc loadtesting agent list` добавлен параметр `--filter` для фильтрации списка агентов.

##### Virtual Private Cloud {#vpc}

* В команду `yc vpc address create` добавлен параметр `--dns-record` для указания DNS-спецификаций адреса.
* В команду `yc vpc address update` добавлены параметры:

  * `--dns-record` для указания DNS-спецификаций адреса;
  * `--clear-dns-records` для удаления всех DNS-спецификаций адреса.

### Версия 0.120.0 (01.03.24) {#version0.120.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Compute Cloud

* В команде `yc compute connect-to-serial-port` поддержана авторизация через OS Login.

##### Audit Trails

* Добавлено дерево команд `yc audit-trails trail` с командами `get`, `list`, `create`, `update`, `delete`, `list-operations`, `list-access-bindings`, `set-access-bindigns`, `add-access-binding`, `remove-access-binding` для управления трейлами.

### Версия 0.119.0 (27.02.24) {#version0.119.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Identity and Access Management {#iam}

* Добавлено дерево команд `yc iam service-control`с командами `get`, `list`, `enable`, `pause`, `resume`, `disable` для управления доступом сервисов к ресурсам в облаке.

##### Compute Cloud

* В командах `yc compute instance create` и `yc compute instance update` добавлена поддержка настроек серийного порта.

### Версия 0.118.0 (14.02.24) {#version0.118.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Yandex MPP Analytics for PostgreSQL

* Добавлено дерево команд `yc managed-greenplum backups` с командами `get`, `list`, `delete` для управления резервными копиями.
* Добавлена команда `yc managed-greenplum cluster backup` для создания резервной копии.

##### Compute Cloud

* В команду `yc compute ssh` добавлен параметр `--identity-file` для подключения к ВМ по SSH с указанием пользовательского ключа.

##### Data Transfer

- Для следующих команд добавлен параметр `--file` для указания YAML-файла для конфигурации запроса:
  * `yc datatransfer transfer create`
  * `yc datatransfer transfer update`
  * `yc datatransfer endpoint create`
  * `yc datatransfer endpoint update`

##### Yandex Identity Hub {#organization}

* Добавлена команда `yc organization-manager federation saml delete-user-accounts` для удаления федеративных пользователей.

##### Load Testing

Добавлена команда `yc loadtesting test get-report-table` для получения табличного отчета по прошедшему нагрузочному тесту.

##### Cloud DNS {#dns}

* В команду `yc dns zone list-records` добавлен параметр `--page-token` для включения разбиения на страницы по page-токену.

### Версия 0.117.0 (30.01.24) {#version0.117.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

Для команды `yc managed-greenplum cluster restore` добавлен параметр `restore-only`, который позволяет восстановить только указанные объекты.

##### Yandex IoT Core {#iot}

В команды `yc iot registry create`, `yc iot registry update`, `yc iot broker create` и `yc iot broker update` добавлены параметры:

* `--no-logging` — выключает логирование из реестра или брокера.
* `--log-group-id`, `--log-group-name` — идентификатор или имя лог-группы, в которую будут передаваться логи.
* `--log-folder-id`, `--log-folder-name` — идентификатор или имя каталога, в стандартную лог-группу которого будут передаваться логи.
* `--min-log-level` — минимальный уровень логирования записей.

##### Managed Service for Kubernetes {#k8s}

В команде `k8s cluster update` исправлена ошибка, возникающая, когда в качестве позиционного аргумента передается `cluster-id`.

### Версия 0.116.0 (15.01.24) {#version0.116.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сети в сервисах бессерверных вычислений {#serverless}

Добавлена группа команд `yc serverless network` для управления сетями, которые используются в сервисах бессерверных вычислений (Cloud Functions, Serverless Containers и API Gateway):

  * `yc serverless network get-used` — получение информации о сети, которая подключена к ресурсам сервисов бессерверных вычислений;
  * `yc serverless network list-used` — получение списка сетей, которые подключены к ресурсам сервисов бессерверных вычислений;
  * `yc serverless network list-connections` — получение списка ресурсов сервисов бессерверных вычислений, которые подключены к какой-либо сети из заданной области (сеть, каталог, облако);
  * `yc serverless network trigger-used-cleanup` — инициировать скорейшую очистку сети от системных подсетей, если она больше не используется в сервисах бессерверных вычислений.

##### Identity and Access Management {#iam}

* В дерево команд `iam`, `resource-manager` и `organization-manager` добавлена поддержка листинга более 1000 ресурсов через параметр `limit`.

##### Object Storage

* В команду `yc storage bucket update` для параметров `--lifecycle-rules/` и `--lifecycle-rules-from-file` добавлена поддержка логического оператора `И` (`andOperation`) для объединения условий в фильтре объектов.
* В команду `yc storage bucket update` добавлен параметр `--encryption key-id=<идентификатор_ключа>` для изменения используемого ключа шифрования, а также параметр `--remove-encryption` для отключения шифрования в бакете.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* В команде `yc managed-clickhouse cluster update` добавлена возможность указать параметр `cloud-storage-data-cache-max-size` в удобном для чтения формате.

##### Cloud CDN {#cdn}

В команды `yc cdn resource update` и `yc cdn resource create` добавлены параметры для определения опции *ip address acl*:

* `--policy-type` — политика доступа клиентов по IP-адресам. Одно из значений *allow* или *deny*;
* `--acl-excepted-values` — список IP-адресов, доступ по которым будет разрешен или запрещен в зависимости от указанного policy-type.

##### Load Testing

Добавлено дерево команд `yc loadtesting` для управления сервисом нагрузочного тестирования:

* `yc loadtesting agent` — управление агентами нагрузочного тестирования;
* `yc loadtesting test-config` — управление шаблонами конфигураций нагрузочных тестов;
* `yc loadtesting test` — запуск нагрузочных тестов и управление проведенными нагрузочными тестами.

### Версия 0.115.0 (18.12.23) {#version0.115.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* В команды `yc managed-greenplum cluster create` и `yc managed-greenplum cluster update` добавлен параметр `--backup-retain-period-days`.

**Managed Service for ClickHouse®**

* Параметр `network-id` для `yc managed-clickhouse cluster restore` теперь опциональный.

##### Application Load Balancer {#alb}

* В команды `yc alb virtual-host create` и `yc alb virtual-host update` добавлен параметр `--security-profile-id` для указания профиля безопасности из Smart Web Security.

##### Compute Cloud {#compute}

* Команды `yc compute instance`, `yc compute disk`, `yc compute image`, `yc compute snapshot`, `yc compute snapshot-schedule`, `yc compute placement-group`, `yc compute host-group`, `yc compute disk-placement-group`, `yc compute filesystem`, `yc compute gpu-cluster`: добавлена возможность отображать и управлять правами доступа с помощью `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.
* Добавлена команда `yc compute instance simulate-maintenance-event`.

### Версия 0.114.0 (05.12.23) {#version0.114.0}

#### Изменения в сервисах Yandex Cloud {#services}

#### Object Storage

* Исправлена передача имени бакета в команды `yc storage bucket create`, `yc storage bucket update`, `yc storage bucket set-https`.

#### Cloud Functions {#serverless-functions}

В команду `yc serverless function version create` добавлен параметр для указания монтирования бакетов в функцию:

* `--storage-mounts`, пример: `--storage-mounts mount-point=dir,bucket=user-bucket,read-only=false`.

#### Serverless Containers {#serverless-containers}

В команду `yc serverless container revision deploy` добавлен параметр для указания монтирования бакетов в контейнер:

* `--storage-mounts`, пример: `--storage-mounts mount-point-path=/data,bucket=user-bucket,read-only=false`.

##### Compute Cloud {#compute}

* В команде `yc compute ssh` все временные сертификаты сохраняются в домашней директории пользователя.
* В команде `yc compute ssh` пользовательские параметры теперь ставятся в конец запускаемой команды `ssh`.
* В команды `yc compute disk relocate` и `yc compute instance relocate` добавлена возможность релокации нереплицируемых дисков с заданными группами размещения и ВМ с такими дисками.
* В команды `yc compute instance create` и `yc compute instance update` добавлены параметры `--maintenance-policy` и `--maintenance-grace-period`.
* Добавлена проверка на одновременное указание параметров `--spread-strategy` и `--partitions` при создании группы размещения.
* Исправлена работа PAGER для справки `help`. Теперь при запуске команды с флагом `--help` открывается окно `less`.

##### Cloud Logging {#cloud-logging}

* Исправлена ошибка, когда при лимите свыше 1000 строк ответ содержал не более 1000 строк.

#### Cloud CDN {#cdn}

В команды `yc cdn resource update` и `yc cdn resource create` добавлены параметры для настройки доступа к ресурсу по защищенному токену (_secure token_):

* `--secure-key` — секретный ключ, который будет применяться для генерации пользовательских ссылок.
* `--enable-ip-url-signing` — опциональный параметр для ограничения доступа к ресурсам по IP-адресу.
* `--clear-secure-key` — параметр для отключения доступа к ресурсу по защищенному токену.

#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Расширен список выводимых полей в отображении по умолчанию списка шардов и кластеров.
* Добавлены тип и размер резервной копии при выводе списка резервных копий.
* Исправлен баг при попытке восстановить кластер с включенным гибридным хранилищем или SQL Management командой `yc managed-clickhouse cluster restore`.

### Версия 0.113.0 (31.10.23) {#version0.113.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#k8s}

* В команду `yc k8s node-group update` добавлен параметр `--location`. Это параметр позволяет изменить [зону доступности](../overview/concepts/geo-scope.md), в которой развернута группа узлов.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`: флаг `--unmanaged-topics` помечен как `deprecated`. Соответствующее поле больше не отправляется в запросах API, но флаг останется для сохранения обратной совместимости.

**Managed Service for OpenSearch**

* Добавлена группа команд `yc managed-opensearch` для управления базами данных Managed Service for OpenSearch.

**Managed Service for ClickHouse®**

* Для команды `yc managed-clickhouse cluster --mongodb-source` добавлена настройка `options`.
* Для команды `yc managed-clickhouse cluster set-compression` добавлена настройка `level`.

##### Compute Cloud {#compute}

* Добавлена возможность замены переменных окружения в шаблонах, загружаемых с помощью команды `--metadata-from-file`.

##### Virtual Private Cloud {#vpc}

* Добавлена команда `yc vpc subnet relocate`.

### Версия 0.112.0 (12.10.23) {#version0.112.0}

#### Изменения в сервисах Yandex Cloud {#services}

###### Compute Cloud {#compute}

* Поддержано подключение к CentOS 7 с помощью команды `yc compute ssh`.
* Добавлены команды `yc compute instance relocate` и `yc compute disk relocate` для перемещения ВМ и дисков между зонами доступности.

### Версия 0.111.0 (21.09.23) {#version0.111.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Compute Cloud {#compute}

* Поддержан параметр `--network-interface` в команде `yc compute instance relocate`.
* Добавлена группа команд `yc compute ssh` для подключения к ВМ по сертификату, выписанному с помощью OS Login, и экспорта этого сертификата. OS Login используется для предоставления пользователям доступа к ВМ по SSH через IAM.

##### Managed Service for PostgreSQL

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `16` для параметра `--postgresql-version string`. Оно позволяет создать кластер PostgreSQL версии 16.


##### Yandex IoT Core {#iot}

* Добавлена группа команд `yc iot registry yds-export` для управления экспортом сообщений из IoT в Data Streams.



##### Cloud Logging {#cloud-logging}

* Исправлена ошибка вывода `yc logging read` для форматов json и json-rest



##### Cloud Functions {#serverless-functions}

В команду `yc serverless function version create` добавлены параметры асинхронного вызова:
* `--async-max-retries` - для указания максимального количества попыток вызова функции
* `--async-service-account-id` - для указания сервисного аккаунта для вызова функции
* `--async-success-ymq-arn` - для указания очереди для успешного результата
* `--async-success-sa-id` - для указания сервисного аккаунта для записи в очередь успешного результата
* `--async-failure-ymq-arn` - для указания очереди для неуспешного результата
* `--async-failure-sa-id` - для указания сервисного аккаунта для записи в очередь неуспешного результата


### Версия 0.110.0 (14.09.23) {#version0.110.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### API Gateway {#api-gw}

* В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры:
  * `--variables` — для указания значений параметров спецификации.
  * `--canary-weight` — для указания доли входящих запросов, обрабатываемых канареечным релизом шлюза.
  * `--canary-variables` — для указания значений параметров спецификации канареечного релиза.

* Добавлена команда `yc serverless api-gateway release-canary` для замены параметров спецификации параметрами канареечного релиза и удаления последнего.

* Добавлена команда `yc serverless api-gateway rollback-canary` для отключения канареечного релиза за счет установки параметру `weight` значения, равного `0`.


##### Identity and Access Management {#iam}

* Удалены группы команд `yc iam federation` и `yc iam certificate` для управления SAML-совместимыми федерациями на уровне каталога. Для работы с SAML-совместимыми федерациями теперь используйте группу команд `yc organization-manager federation`.


##### Instance Groups {#instance-groups}

Исправлена проблема команды `yc compute instance-group update`, когда не обрабатывалось имя группы ВМ, если для конфигурации использовался файл в формате YAML.

##### Compute Cloud {#compute}

* В командах `yc compute instance create` и `yc compute instance update` добавлен параметр `--placement-group-partition` для указания номера раздела в группе размещения (partition).


##### Cloud Logging {#cloud-logging}

* В команде `yc logging read` убрали ограничение для параметра `--limit`. Теперь можно выводить более 1000 записей.


##### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* Добавлена возможность создавать шардированный кластер. Если в конфигурации присутствуют соответствующие типы хостов, то кластер будет создан автоматически.
* В команды `yc mongodb cluster create`, `yc mongodb cluster update` и `yc mongodb cluster restore` добавлен параметр `--performance-diagnostics`.

**Managed Service for PostgreSQL**

* Добавлена команда `yc managed-postgresql backup delete` для удаления ручных бэкапов.
* В команду `yc managed-postgresql cluster update` добавлены флаги:
  * `--disk-size-autoscaling` — для управления настройками сервиса автоматического увеличения диска.
  * `--yandexquery-access` — для разрешения доступа к кластеру из сервиса Yandex Query.

**Managed Service for ClickHouse®**

* В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster update` добавлен флаг `--cloud-storage-prefer-not-to-merge`, позволяющий отключать слияние частей данных в Object Storage.

### Версия 0.109.0 (10.08.23) {#version0.109.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Functions {#cloud-functions}

* В команду `yc serverless trigger create mail` добавлена возможность настройки бакета для сохранения вложений письма.
* В команды `yc serverless trigger create iot-devices`, `yc serverless trigger create iot-broker`, `yc serverless trigger create object-storage`, `yc serverless trigger create container-registry` и `yc serverless trigger create mail`:
  * Добавлен параметр `--batch-size` для указания размера группы сообщений.
  * Добавлен параметр `--batch-cutoff` для указазания максимального времени формирования группы.
* В команду `yc serverless trigger create logging` добавлен параметр `--stream-names` для фильтрации по имени потока логов.
* Добавлена команда `yc serverless function version delete` для удаления версий функций.

##### Key Management Service {#kms}

* В команды ассиметричного шифрования и подписи `yc kms asymmetric-encryption-crypto decrypt`, `yc kms asymmetric-signature-crypto sign` и `yc kms asymmetric-signature-crypto sign-hash` добавлены параметры `--inform` и `--outform` для указания формата входных и выходных данных.
* В командах подписи `yc kms asymmetric-signature-crypto sign` и `yc kms asymmetric-signature-crypto sign-hash` параметр `--signature-file`, указывающий на файл, в который надо сохранить полученное значение подписи, переименован в `--signature-output-file`.

##### Managed Service for Kubernetes {#k8s}

* В команду `yc k8s node-group create` добавлен параметр `--gpu-cluster-id` для добавления узла из группы узлов в кластер с GPU.
* В команду `yc k8s node-group create` добавлен параметр `--gpu-environment` для настройки предустановленного окружения для узлов с GPU.

##### Compute Cloud {#compute}

* В команду создания группы размещения дисков `yc compute disk-placement-group create` добавлен параметр `--strategy` для указания стартегии размещения. Может принимать значения `SPREAD` или `PARTITION`.
* В команду создания группы размещения дисков `yc compute disk-placement-group create` добавлен параметр `--partition-count`. Задает количество разделов для группы со стратегией `PARTITION`.
* В команду создания диска `yc compute disk create` добавлен параметр `--disk-placement-group-partition` для указания номера раздела в группе размещения.
* Добавлена колонка `PLACEMENT GROUP` в таблице со списком дисков, получаемых командой `yc compute disk list`.
* Добавлена колонка `STRATEGY` в таблице со списком групп размещения дисков, получаемых командой `yc compute disk-placement-group list`.

##### Cloud Logging {#cloud-logging}

* Добавлена группа `yc logging sink`.

##### Instance Groups {#instance-groups}

* Добавлены команды `yc compute instance-group rolling-restart` и `yc compute instance-group rolling-recreate` для перезапуска и пересоздания ВМ в группе с учетом ограничений группы.

##### Cloud DNS {#dns}

* Добавлена команда `yc dns zone update-private-networks` для атомарного изменения списка сетей для приватных зон.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* Добавлена команда `yc managed-mongodb backup delete` для удаления резервных копий.

### Версия 0.108.1 (06.07.23) {#version0.108.1}

#### Изменения в CLI {#cli}

* Команда `oslogin` временно удалена.

### Версия 0.108.0 (04.07.23) {#version0.108.0}

#### Изменения в CLI {#cli}

* Добавлена команда `oslogin`, предназначенная для получения логина текущего пользователя ОС.
* Отключено отображение глобальных параметров по умолчанию для всех команд при вызове `yc [command] -h`. Для просмотра глобальных параметров используйте команду `yc help [command]`.

#### Изменения в сервисах Yandex Cloud {#services}

##### Key Management Service {#kms}

* В Yandex Key Management Service поддержана работа с асимметричными криптографическими ключами. Функционал находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../kms/index.md).

### Версия 0.107.0 (15.06.23) {#version0.107.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Compute Cloud {#compute}

* В команду `yc compute placement-group create` добавлен параметр `--partitions`, позволяющий указать количество партиций в `partitionPlacementStrategy`.

##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* Унифицировали конфигурационные параметры кластеров Yandex Managed Service for Valkey™ для разных версий Redis.

**Yandex MPP Analytics for PostgreSQL**

* В команду `yc managed-greenplum cluster restore` добавлен параметр:
  * `--segment-host-count`, позволяющий указать количество хостов с сегментами в восстановленном кластере.
  * `--segment-in-host`, позволяющий указать количество сегментов на хосте в восстановленном кластере.

**Managed Service for MySQL®**

* В команду `yc managed-mysql user update` добавлен параметр `--global-permissions`, позволяющий выдать привилегии `FLUSH_OPTIMIZER_COSTS` и `SHOW_ROUTINE`.

### Версия 0.106.0 (19.05.23) {#version0.106.00}

#### Изменения в CLI {#cli}

* В команду `yc organization-manager federation saml` добавлен флаг `--force-authn`.
* Добавлена опция конфигурации `fed-auth-browser-skip` для пропуска подтверждения открытия браузера (нажатия **Enter**) при аутентификации от имени федеративного пользователя. Опция принимает значения `true` и `false`.

#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#k8s}

* В параметр `--master-logging` добавлен флаг `audit-enabled`, позволяющий включать и выключать загрузку логов аудита кластера Kubernetes в Yandex Cloud Logging.

##### Cloud Backup {#backup}

* Добавлены команды группы `yc backup` для управления подключением виртуальных машин к Yandex Cloud Backup, их резервными копиями и политиками резервного копирования.

### Версия 0.105.0 (15.05.23) {#version0.105.00}

#### Изменения в CLI {#cli}

* Добавлен параметр `--impersonate-service-account-id` для выполнения действий от имени сервисного аккаунта. В параметре передается идентификатор сервисного аккаунта, тип данных значения — string.

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Logging {#cloud-logging}

* Исправлена работа команды `yc logging read` при указании флага `--follow`.

##### Managed Service for Kubernetes {#k8s}

В команду `yc k8s node-group create` добавлен параметр `--container-network-settings` для конфигурации контейнерной сети узлов кластера. В этом параметре в свойстве `pod-mtu` можно передать значение MTU для подов.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Добавлена поддержка Apache Kafka® версий 3.x, начиная с 3.3.

### Версия 0.104.0 (19.04.23) {#version0.104.00}

#### Изменения в сервисах Yandex Cloud {#services}

##### Cloud Functions {#serverless-functions}

* В команду `yc serverless trigger timer create` добавлен параметр `--payload` для привязки пользовательских данных к событию от таймера.

##### Cloud Desktop {#cloud-desktop}

* Группа команд `yc cloud-desktop` переименована в `yc desktops`.
* Добавлена пометка `[PREVIEW]` к группе команд `yc desktops`.
* Добавлена команда `yc desktops desktop restart`, которая позволяет перезагружать рабочий стол.

##### Compute Cloud {#compute}

* Исправлен листинг большого количества объектов в каталоге для всех сущностей Compute Cloud.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

Добавлена команда `yc managed-clickhouse cluster list-external-dictionaries` для листинга списка добавленных внешних словарей.

##### Cloud Logging {#cloud-logging}

* В команду `yc logging read` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc logging read default 1d "level = INFO"`
* В команду `yc logging write` добавлены позиционные параметры `MESSAGE` и `JSON-PAYLOAD`, пример: `yc logging write default test "{\"key\":\"value\"}"`

##### Cloud Functions {#functions}

* В команды `yc serverless function logs` и `yc serverless function version logs` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc serverless function logs default 1d "level = INFO"`

##### Yandex IoT Core {#iot}

В команду `yc iot broker logs` добавлены позиционные параметры `SINCE` и `FILTER`, пример: `yc iot broker logs default 1d "level = INFO"`

### Версия 0.103.0 (15.03.23) {#version0.103.00}



#### Изменения в сервисах Yandex Cloud {#services}

##### API Gateway {#api-gw}

В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры:

* `--no-logging` — для выключения логинга из API-шлюза.
* `--log-group-id`, `--log-group-name` — для указания лог-группы, в которую следует отправлять логи.
* `--log-folder-id`, `--log-folder-name` — для отправки логов в стандартную лог-группу заданного каталога.
* `--min-log-level` — для указания минимального уровня логирования записей.



##### Compute Cloud {#compute}

* Добавлена группа команд `yc compute gpu-cluster` для управления GPU-кластерами.
* Добавлены параметры `--gpu-cluster-id` и `--gpu-cluster-name` в команду `yc compute instance create` для создания виртуальной машины в GPU-кластере.


### Версия 0.102.0 (09.02.23) {#version0.102.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Instance Groups {#instance-groups}

Исправлена проблема `update` `instance-group` при указании через `name`.

##### Application Load Balancer {#alb}

Добавлена поддержка аргументов командной строки для поиска соответствий по регулярному выражению`--regex-path-match` и `--regex-fqmn-match`. Используются аналогично `exact` и `prefix`:
* `yc alb virtual-host insert-http-route --regex-path-match my_cool_regex`
* `yc alb virtual-host insert-grpc-route --regex-fqmn-match my_cool_regex`

Флаг `--rewrite-request-id`, отвечающий за перезапись заголовка `x-request-id` новым значением, добавлен в следующие команды:
* `yc application-load-balancer load-balancer add-listener`
* `yc application-load-balancer load-balancer update-listener`
* `yc application-load-balancer load-balancer add-sni`
* `yc application-load-balancer load-balancer update-sni`


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

Добавлены новые параметры для команд `yc managed-postgresql user create` и `yc managed-postgresql user update` :
* `--statement-timeout` — позволяет задавать `statement_timeout` в миллисекундах для указанного пользователя.
* `--idle-in-transaction-session-timeout` — позволяет задавать `idle_in_transaction_session_timeout` в миллисекундах для указанного пользователя.
* `--wal-sender-timeout` — позволяет задавать `wal_sender_timeout` в миллисекундах для указанного пользователя.

### Версия 0.101.0 (16.01.23) {#version0.101.0}



#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#managed-kubernetes}

В команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update` добавлен параметр `--master-logging` для настройки логирования со следующими свойствами:

* `enabled` — флаг для отправки логов в Cloud Logging.
* `log-group-id` — ID [лог-группы](../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `folder-id` — ID каталога, в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `kube-apiserver-enabled` — флаг для отправки логов `kube-apiserver` в Cloud Logging.
* `cluster-autoscaler-enabled` — флаг для отправки логов `cluster-autoscaler` в Cloud Logging.
* `events-enabled` — флаг для отправки событий Kubernetes в Cloud Logging.

Если отправка логов включена, но не указаны ни `log-group-id`, ни `folder-id`, логи будут отправляться в каталог, где находится кластер, в лог-группу по умолчанию. Указывать одновременно `log-group-id` и `folder-id` нельзя.

##### Network Load Balancer {#network-load-balancer}

В команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update` добавлен флаг `--deletion-protection` для защиты балансировщика от случайного удаления.



##### Serverless Containers {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:

* `--no-logging` — флаг для выключения логирования из контейнера.
* `--log-group-id`, `--log-group-name` — ID или имя [лог-группы](../logging/concepts/log-group.md), в которую нужно отправлять логи.
* `--log-folder-id`, `--log-folder-name` — ID или имя каталога, в который нужно отправлять логи. Логи будут отправляться в лог-группу каталога по умолчанию.
* `--min-log-level` — минимальный уровень логирования.



##### Virtual Private Cloud {#vpc}

В команды `yc vpc address create` и `yc vpc address update` добавлен флаг `--deletion-protection` для защиты статического публичного IP-адреса от случайного удаления.


### Версия 0.100.0 (27.12.22) {#version0.100.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Compute Cloud {#compute}

* В команде `yc compute instance update` добавлена возможность редактирования правил размещения на хостах.



##### Serverless Containers {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:
* `--zone-instances-limit` — максимальное количество экземпляров контейнера в зоне доступности;
* `--zone-requests-limit` — максимальное количество одновременно выполняемых вызовов контейнера в зоне доступности.



##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* Добавлена команда `yc managed-greenplum cluster restore` для восстановления кластера из бэкапа.
* Добавлена команда `yc managed-greenplum cluster list-backups` для просмотра бэкапов кластера.
* В команде `yc managed-greenplum update` появился флаг `--assign-public-ip`, чтобы назначить или отозвать публичный IP-адрес кластера.


### Версия 0.99.0 (01.12.22) {#version0.99.0}

#### Изменения в CLI {#cli}

**Object Storage**

* Добавлена поддержка Object Storage (control plane). Список возможностей:
  * Создание бакетов с возможностью указания класса хранения, максимального размера бакета и ACL.
  * Обновление параметров бакета: `ACL`, `политики`, `настройки вебсайтов`, `CORS`, `флаги анонимного доступа`, `настройки Lifecycle`, `максимальный размер бакета` и `класс хранения`.
  * Удаление бакета.
  * Привязка/отвязка HTTPS-сертификата к бакету.

#### Изменения в сервисах Yandex Cloud {#services}


##### Application Load Balancer {#alb}

* Добавлена команда `yc application-load-balancer load-balancer logging` для настройки логов балансировщика. Параметры команды:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из Cloud Logging.
  * `--enable` и `--disable` — для включения и выключения записи логов балансировщика в лог-группу из Cloud Logging.
  * `--discard` — для задания правил отбрасывания части логов на основе HTTP- или gRPC-кодов.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Elasticsearch**

* В команде `yc managed-elasticsearch cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**Yandex StoreDoc**

* В команде `yc managed-mongodb cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**Managed Service for MySQL®**

* В команде `yc managed-mysql cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.

**Yandex Managed Service for Valkey™**

* В команде `yc managed-redis cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.


**Managed Service for SQL Server**

* В команде `yc managed-sqlserver cluster restore` с параметром `--folder-id` можно передать каталог для восстановления кластера.



##### Cloud Functions {#serverless-functions}

В команду `yc serverless function version create` добавлены параметры: 
* `--no-logging` — отключает логирование в функции.
* `--log-group-id`, `--log-group-name` — отправляет логи в заданную лог-группу.
* `--log-folder-id`, `--log-folder-name` — отправляет логи в стандартную лог-группу заданного каталога.
* `--min-log-level` — задает минимальный уровень логирования записей.


### Версия 0.98.0 (09.11.22) {#version0.98.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Добавлены команды группы `yc managed-kafka connector-s3-sink`, которые позволяют управлять коннекторами типа S3-Sink, а именно создавать (create) и модифицировать (update) их.

* В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлен параметр для задания и изменения конфигурации Kafka-брокеров — `sasl-enabled-mechanisms`.

* Исправлен баг с изменением поля `properties` у коннекторов.

**Managed Service for PostgreSQL**

* В команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore` добавлено значение `15` для параметра `--postgresql-version string`. Оно позволяет создать кластер PostgreSQL версии 15.

* Для команды `yc managed-postgresql cluster create` изменено значение по умолчанию для версии создаваемого кластера PostgreSQL. Новое значение по умолчанию — `15`.

* В команду `yc managed-postgresql cluster restore` добавлена возможность восстановления кластера PostgreSQL в заданный каталог.

### Версия 0.97.0 (10.10.22) {#version0.97.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### API Gateway {#api-gw}

* Параметр `domainId` команды `add-domain` больше не поддерживается.


#### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* Добавлена команда `yc managed-greenplum cluster expand`, которая позволяет расширить существующий кластер Yandex MPP Analytics for PostgreSQL. Параметры команды:

  * `--segment-host-count` — количество добавляемых в кластер хостов;
  * `--add-segments-per-host-count` — количество сегментов, добавляемых на каждый хост кластера;
  * `--duration-seconds` — максимальная длительность сеанса распределения данных в секундах.

**Managed Service for Apache Kafka®**

* Прекращена поддержка Apache Kafka® версий 2.1 и 2.6.

### Версия 0.96.0 (19.09.22) {#version0.96.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Application Load Balancer {#alb}

* Добавлена команда `yc application-load-balancer load-balancer autoscale` для управления количеством ресурсных единиц балансировщика.
  В команду есть параметры:
  * `--min-zone-size` — минимальное число ресурсных единиц в одной зоне;
  * `--max-size` — максимальное числа ресурсных единиц во всех зонах суммарно.

* В команду `yc alb load-balancer create` добавлены параметры:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из Cloud Logging;
  * `--disable-logging` — для создания балансировщика без записи логов в лог-группу из Cloud Logging.

* В команду `yc alb load-balancer update` добавлены параметры:
  * `--log-group-id`, `--log-group-name` — для задания лог-группы из Cloud Logging;
  * `--enable-logging` и `--disable-logging` — для включения и выключения записи логов балансировщика в лог-группу из Cloud Logging.

##### Compute Cloud {#compute}

* Добавлена группа команд `yc compute snapshot-schedule` для управления снимками диска по расписанию.
* В команду `yc compute instance create` добавлен параметр `--metadata-options` для управления доступом к метаданным ВМ.

###### Cloud DNS {#dns}

* Команда `yc dns zone list-records` теперь имеет фильтрацию по имени и типу записи с помощью параметров `--record-name` и `--record-type`.


##### Изменения в сервисах управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`: для параметра `--postgresql-version string` добавлены значения `11-1c`, `12-1c`, `13-1c`, `14-1c` для создания кластера PostgreSQL версий 11-1c, 12-1c, 13-1c, 14-1c.


##### Yandex IoT Core {#iot}

* Добавлена группа команд `yc iot broker` для управления MQTT-брокером.

##### Cloud Functions {#serverless-functions}

Добавлены команды:

* `yc serverless trigger create iot-broker` — для создания триггеров для MQTT-брокеров.
* `yc serverless trigger create mail` — для создания триггеров для почты.

В команду `yc serverless function version create` добавлен параметр `--secret` для добавления [секретов](../lockbox/index.md) к версии.

##### Serverless Containers {#serverless-containers}

В команду `yc serverless container revision deploy` добавлены параметры:
* `--secret` — для добавления секретов к ревизии;
* `--min-instances` — чтобы указать минимальное количество подготовленных экземпляров контейнера.


### Версия 0.95.0 (02.09.22) {#version0.95.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### API Gateway {#api-gw}

* В команду `yc serverless api-gateway add-domain` добавлены параметры:

  * `--domain` — для указания FQDN подключаемого домена из Certificate Manager;
  * `--certificate-id` — для указания идентификатора сертификата из Certificate Manager.

  Параметр `--domain-id` считается устаревшим, вместо него рекомендуется использовать параметру `--domain` и `--certificate-id`.

* Добавлена группа команд `yc serverless api-gateway websocket` для работы с соединениями по протоколу WebSocket:

  * `yc serverless api-gateway websocket get` — получение информации о соединении;
  * `yc serverless api-gateway websocket send` — отправка данных в соединении;
  * `yc serverless api-gateway websocket disconnect` — разрыв соединения.



##### Certificate Manager {#certificate-manager}

* В команду `yc certificate-manager certificate content` добавлен параметр `--key-format` для выбора формата приватного ключа: `PKCS1` или `PKCS8`.

##### Compute Cloud {#compute}

* В команду `yc compute image create` добавлен параметр `--os-type` для указания типа операционной системы создаваемого образа: `linux` или `windows`.

##### Cloud DNS {#dns}

* Команды `yc dns zone add-records`, `yc dns zone update-records`, `yc dns zone delete-records` и `yc dns zone replace-records` теперь возвращают список выполненных изменений.

##### Identity and Access Management {#iam}

* В группе команд `yc iam federation` исправлена ошибка, возникавшая при указании имени SAML-совместимой федерации как позиционного аргумента.



##### Yandex IoT Core {#iot}

* Команды `yc iot registry logs` и `yc iot device logs` теперь возвращают логи из Cloud Logging. В команды добавлены параметры:

  * `--levels` — для поиска записей с указанными уровнями логирования;
  * `--filter` — для фильтрации записей.

  Подробнее о возможных значениях новых параметров смотрите в разделе [Язык фильтрующих выражений](../logging/concepts/filter.md).


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Добавлена поддержка Apache Kafka® версий 3.0, 3.1 и 3.2.

**Yandex Managed Service for Valkey™**

* Прекращена поддержка Redis версий 5.0 и 6.0.


##### Yandex Identity Hub {#organization}

* В команды из группы `yc organization-manager federation saml` добавлен параметр `--organization-id` для указания идентификатора организации. Исправлена ошибка, возникавшая в этих командах при указании имени SAML-совместимой федерации как позиционного аргумента.
* Добавлена группа команд `yc organization-manager group` для управления [группами пользователей](../organization/operations/manage-groups.md).


### Версия 0.94.0 (16.08.22) {#version0.94.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Cloud Logging {#cloud-logging}

* В команды `yc logging read` и `yc logging write` добавлен параметр `--stream-name`.


##### Сервисы управляемых баз данных {#managed-db}

**Yandex MPP Analytics for PostgreSQL**

* Добавлена поддержка команд:

  * `yc managed-greenplum cluster update` — позволяет изменять настройки уже созданных кластеров.
  * `yc managed-greenplum cluster update-config` — позволяет изменять параметры конфигурации уже созданных кластеров.


**Yandex Managed Service for Valkey™**

* В команды `yc managed-redis cluster create`, `yc managed-redis cluster restore`,
  `yc managed-redis hosts add`, `yc managed-redis hosts update`, `yc managed-redis shards add` добавлены параметры:

  * `--assign-public-ip=true|false` — привязывает или удаляет публичный IP-адрес хоста.
  * `--replica-priority=50` — выставляет приоритет реплики (только для нешардированного кластера).

**Managed Service for ClickHouse®**

* В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster update` добавлены параметры:

  * `--cloud-storage-move-factor` — для указания доли свободного места на локальном диске, при котором начнется перенос данных на Object Storage.
  * `--cloud-storage-data-cache` — для разрешения использования локального кеша для Object Storage.
  * `--cloud-storage-data-cache-max-size` — для указания максимального объема локального кеша для Object Storage.

**Managed Service for Apache Kafka®**

* Добавлена группа команд `yc managed-kafka connector`, которая позволяет управлять коннекторами с помощью команд `get`, `list`, `delete`, `pause`, `resume`.
* Добавлена группа команд `yc managed-kafka connector-mirrormaker`, которая позволяет управлять коннекторами типа MirrorMaker с помощью команд `create` и `update`.
* В команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update` добавлены параметры для задания и изменения конфигурационных настроек хостов-брокеров:
  - `message-max-bytes`
  - `replica-fetch-max-bytes`
  - `offsets-retention-minutes`
  - `ssl-cipher-suites`


##### Virtual Private Cloud {#vpc}

* Добавлена группа команд `yc vpc gateway` для управления шлюзами маршрутизации.
* В команды группы `yc vpc route-table` добавлена возможность указать шлюз в качестве назначения маршрута.


### Версия 0.93.0 (19.07.22) {#version0.93.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* В команде `yc managed-clickhouse cluster restore` следующие аргументы сделаны опциональными:

  * `--name`
  * `--description`
  * `--host`
  * `--user`

  Если эти параметры не были указаны, они будут взяты из исходного кластера.
  Хосты **ClickHouse®** и **ZooKeeper** будут восстановлены с той же конфигурацией, что и в исходном кластере.
  Хосты **ClickHouse®** будут восстановлены только для тех шардов, чьи бэкапы указаны для восстановления.

**Managed Service for PostgreSQL**

* Команды `yc managed-postgresql database create`, `yc managed-postgresql database list` и `yc managed-postgresql database get`.

  Добавлена поддержка шаблонов при создании базы с помощью `--template-db string`.

**Yandex StoreDoc**

* При создании нового кластера по умолчанию выбирается версия MongoDB 5.0.


##### Managed Service for Kubernetes {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`:

  * Добавлен параметр `--node-name`, позволяющий указать шаблон именования узлов в группе.

  * Добавлены параметры `--template-labels` и `--template-labels-from-files`, позволяющие указать [ресурсные метки Yandex Cloud](../resource-manager/concepts/labels.md) для ВМ — узлов группы (не путать с [метками узлов Kubernetes](../managed-kubernetes/concepts/index.md#node-labels)).



##### Serverless Containers {#serverless-containers}

* В команду `yc serverless container revision deploy` добавлены параметры `--network-id` и `--network-name`, чтобы указывать сеть, которую будет использовать ревизия контейнера. Также в команду добавлен флаг `--subnets`, позволяющий получить детальный список подсетей.


### Версия 0.92.0 (05.07.22) {#version0.92.0}

#### Изменения в CLI {#cli}

* Исправлена ошибка запуска `yc` при передаче большого количества аргументов.

#### Изменения в сервисах Yandex Cloud {#services}


##### Certificate Manager {#certificate-manager}

* В команду `yc certificate-manager certificate create` добавлен флаг `--deletion-protection`, который включает защиту сертификата от удаления.

* В команду `yc certificate-manager certificate request` добавлен флаг `--deletion-protection`, который включает защиту сертификата от удаления.

* В команду `yc certificate-manager certificate update` добавлены флаги, которые включают и отключают защиту сертификата от удаления: `--deletion-protection` и `--no-deletion-protection`.


##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* В группу команд `yc managed-redis cluster` для `create`, `restore`, `update` добавлены флаги `--client-output-buffer-limit-normal` и `--client-output-buffer-limit-pubsub` (смотрите описание в redis.conf). 

**Yandex MPP Analytics for PostgreSQL**

Добавлены команды первичной поддержки сервиса Yandex MPP Analytics for PostgreSQL:
* Группа команд `yc managed-greenplum cluster` позволяет управлять кластерами.
* Группа команд `yc managed-greenplum hosts` позволяет управлять хостами.


**Managed Service for SQL Server**

* Добавлена команда `yc managed-sqlserver hosts update <HOST> --assign-public-ip=true|false`, которая привязывает или удаляет публичный IP-адрес хоста.


### Версия 0.91.0 (12.05.22){#version0.91.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Application Load Balancer {#alb}

* В командах `yc alb lb add-location` и `yc alb lb target-states` исправлена ошибка при обработке параметра `--name`. Теперь параметр позволяет корректно искать балансировщик по имени.

##### Cloud Desktop {#cloud-desktop}

* Добавлена группа команд `yc cloud-desktop group`, которые позволяют управлять группами рабочих столов.
* Добавлена группа команд `yc cloud-desktop desktop`, которые позволяют управлять рабочими столами.

##### Cloud Functions {#functions}

* В команды `yc serverless function logs` и `yc serverless function version logs` добавлен параметр `--max-response-size`, который ограничивает размер получаемых логов.

##### Cloud Logging {#cloud-logging}

* В команду `yc logging read` добавлен параметр `--max-response-size`, который ограничивает размер получаемых логов.

##### Cloud DNS {#dns}

* Добавлена команда `yc dns bind-file migrate-to-terraform`, которая формирует из файла BIND спецификацию для Terraform и печатает ее в стандартный вывод.

##### Serverless Containers {#serverless-containers}

* Добавлена команда `yc serverless containers rollback`, которая откатывает контейнер к указанной ревизии.

##### Managed Service for YDB {#ydb}

* В группу команд `yc ydb database` добавлены команды `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`, позволяющие устанавливать и просматривать список ролей для баз данных.
* В группу команд `yc ydb backup` добавлены команды `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`, позволяющие устанавливать и просматривать список ролей для бэкапов баз данных.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Elasticsearch**

* Добавлены группа команд `yc managed-elasticsearch extension`, которые позволяют управлять пользовательскими расширениями для кластеров.

**Managed Service for MySQL®**

* В команду `yc managed-mysql cluster create` добавлен параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
* В команду `yc managed-mysql cluster restore` добавлены:

  * Параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
  * Флаг `--deletion-protection`, позволяющий восстанавливать кластер сразу с включенной защитой от удаления.

**Managed Service for PostgreSQL**

* В команду `yc managed-postgresql cluster create` добавлен параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
* В команду `yc managed-postgresql cluster restore` добавлены:

  * Параметр `--host-group-ids`, который задает список хостов для размещения кластера на выделенных серверах.
  * Флаг `--deletion-protection`, позволяющий восстанавливать кластер сразу с включенной защитой от удаления.


**Managed Service for SQL Server**

* В команды `yc managed-sqlserver create` и `yc managed-sqlserver update` добавлен параметр `--service-account-id` для назначения сервисного аккаунта хостам кластера SQL Server.
* Добавлены команды `yc managed-sqlserver database backup-export` и `yc managed-sqlserver database backup-import` для экспорта и импорта бэкапов баз данных в пользовательское хранилище.
* Добавлена команда `yc managed-sqlserver cluster start-failover` для ручного запуска смены мастера в кластере.


**Managed Service for Apache Kafka®**

* В команду `yc managed-kafka cluster update` добавлен флаг `--assign-public-ip` для управления публичным доступом к брокерам.

### Версия 0.90.0 (13.04.22) {#version0.90.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Yandex Data Processing {#dataproc}

* В команду `yc dataproc cluster create` добавлен параметр `--initialization-action` для указания скрипта инициализации кластера.

##### Compute Cloud {#compute}

* В команду `yc compute instance create` добавлен флаг `--attach-local-disk` для создания инстанса с подключенным к нему локальным диском.

##### Application Load Balancer {#alb}

* В команды `yc alb backend-group add-stream-backend` и `yc alb backend-group update-stream-backend` добавлен флаг `--enable-proxy-protocol` для включения proxy-протокол для бэкенда.

##### Cloud DNS {#dns}

* В команду `yc dns zone update` добавлен флаг `--clear-network-ids` для удаления списка виртуальных сетей, из которых видны записи внутренней DNS-зоны.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* В команду `yc managed-clickhouse cluster restore` добавлен параметр `--folder-id` для указания каталога, в котором будет создан восстановленный кластер.

* В команду `yc managed-clickhouse cluster update` добавлен флаг:


  * `--yandexquery-access` — для разрешения доступа к кластеру из сервиса Yandex Query.


**Managed Service for MySQL®**


* В команду `yc managed-mysql cluster update` добавлен параметр `--performance-diagnostics`, позволяющий управлять настройками сервиса диагностики производительности.


### Версия 0.89.0 (23.03.22) {#version0.89.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Compute Cloud {#compute}

* Добавлена команда `yc compute filesystem resize` для изменения размера файлового хранилища.
* В команду `yc compute instance update` добавлен флаг `--preemptible`, позволяющий сделать обычную ВМ прерываемой и наоборот.

##### Cloud Functions {#functions}

* Команды `yc serverless function logs` и `yc serverless function version logs` теперь возвращают логи из Cloud Logging. В команды добавлены параметры:

  * `--levels` для поиска записей с указанными уровнями логирования;
  * `--filter` для фильтрации записей.

  Подробнее о возможных значениях новых параметров смотрите в разделе [Язык фильтрующих выражений](../logging/concepts/filter.md).


##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* Параметр `--persistence-mode`, который позволяет выбрать режим персистентности кластера Redis, добавлен в команды:

  * `yc managed-redis cluster create`;
  * `yc managed-redis cluster restore`;
  * `yc managed-redis cluster update`.
  
  В последнюю команду также добавлен флаг `--force`, обязательный при отключении персистентности кластера.

**Managed Service for ClickHouse®**

* Добавлена команда `yc managed-clickhouse hosts update` для редактирования хостов кластера ClickHouse®. У команды есть параметр `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.
* В команду `yc managed-clickhouse cluster create` добавлены флаги `--datatransfer-access` и `--yandexquery-access` для управления доступом к хостам кластера из сервисов Data Transfer и Yandex Query, соответственно.
* В команде `yc managed-clickhouse cluster restore` параметр `--backup-id` теперь принимает список значений для восстановления шардированного кластера.

**Managed Service for MySQL®**

* В вывод команды `yc managed-mysql hosts list` добавлена колонка `PRIORITY`.
* В команду `yc managed-mysql hosts update` добавлен параметр `--priority` для изменения приоритета хоста при переключении мастера.

### Версия 0.88.0 (16.02.22) {#version0.88.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Data Transfer

* Добавлена команда `list` для `endpoint` и `transfer`:

  * `yc datatransfer endpoint list`;
  * `yc datatransfer transfer list`;

* Добавлены команды для обновления `endpoint` и `transfer`:

  * `yc datatransfer endpoint update postgres-source`;
  * `yc datatransfer endpoint update postgres-target`;
  * `yc datatransfer endpoint update mysql-source`;
  * `yc datatransfer endpoint update mysql-target`;
  * `yc datatransfer transfer update`;


##### Cloud CDN {#cdn}

* Добавлена возможность делать полную очистку кеша ресурса: `yc cdn cache purge --all`.
* Исправлено создание ресурса, когда источник — бакет или балансер.

##### API Gateway {#api-gw}

* В команды `yc serverless api-gateway create` и `yc serverless api-gateway update` добавлены параметры `--network-id` и `--network-name` для указания сети API-шлюза, а также параметры `--subnet-id` и `--subnet-name` для детального списка подсетей.

##### Compute Cloud {#compute}

* Добавлены команды `yc compute disk move` и `yc compute instance move` для перемещения дисков и инстансов между каталогами.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for SQL Server**

* В команды `yc managed-sqlserver update`, `yc managed-sqlserver start` добавлен флаг `confirm-payment` для подтверждения согласия с лицензионными платежами.


### Версия 0.87.0 (18.01.22) {#version0.87.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Yandex Data Processing {#dataproc}

* Добавлена команда `yc dataproc job cancel <JOB-ID>|<JOB-NAME>`.

  Теперь можно отменить выполнение незавершенного задания.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Elasticsearch**

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


#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* В команду `yc managed-kafka cluster update` добавлен параметр `--maintenance-window`, позволяющий задать параметры окна обслуживания.
* Добавлена команда `yc managed-kafka cluster reschedule-maintenance`, позволяющая изменить время запуска запланированной задачи по обслуживанию кластера.


##### Application Load Balancer {#alb}

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

##### Cloud CDN {#cdn}

* Добавлены команды для управления ресурсами Cloud CDN:
  * `yc cdn resource create`
  * `yc cdn resource update`

##### Cloud Logging {#cloud-logging}

* В команды `yc logging group {create,update}` добавлен параметр `--data-stream` для поддержки Yandex Data Streams.

##### Virtual Private Cloud {#vpc}

* Добавлены команды `yc vpc subnet add-range` и `remove-range` для добавления или удаления диапазонов адресов в подсетях.

##### Managed Service for YDB {#ydb}

* В команду `yc ydb database create` добавлен параметр `--labels` — он задает набор меток для БД.
* В команду `yc ydb database update` добавлен параметр `--labels` — он меняет весь набор меток для БД.
* Добавлены команды для управления метками `yc ydb database add-labels` и `yc ydb database remove-labels`.


### Версия 0.85.0 (29.11.21) {#version0.85.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Команда `yc managed-kafka cluster update`.

  Добавлен флаг `--version`, позволяющий обновить версию кластера Apache Kafka®.


##### Managed Service for Kubernetes {#k8s}

* Команда `yc k8s cluster update`.

  Добавлен параметр `--node-ipv4-mask-size` — он измеряет размер `CIDR`, выделяемый на каждый узел кластера.

##### Application Load Balancer {#alb}

* Добавлены команды для работы с Stream бэкендами:
  * Добавление Stream бэкенда: `yc application-load-balancer backend-group add-stream-backend`.
  * Изменение Stream бэкенда: `yc application-load-balancer backend-group update-stream-backend`.
  * Удаление Stream бэкенда: `yc application-load-balancer backend-group delete-stream-backend`.

##### Resource Manager {#resmgr}

* Добавлена команда `yc resource-manager folder delete`, которая позволяет удалить каталог.


#### Изменения в CLI {#cli}

Исправлена ошибка в команде `yc init`. Теперь при проверке доступности endpoints не игнорируются настройки proxy.

### Версия 0.84.0 (16.11.21) {#version0.84.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Cloud CDN {#cdn}

* Добавлена команда `yc cdn resource` для управления ресурсами Cloud CDN (get, list, delete, get-provider-cname).


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Добавлена команда `yc managed-kafka cluster move`.

**Yandex StoreDoc**

* Добавлена поддержка создания кластера с версией MongoDB 5.0.
* Добавлена команда `yc managed-mongodb hosts restart` для перезагрузки указанных хостов.

**Managed Service for MySQL®**

* В вывод команды `yc managed-mysql hosts list` добавлена колонка `BACKUP PRIORITY`.

**Managed Service for ClickHouse®**

В команды `yc managed-clickhouse cluster create` и `yc managed-clickhouse cluster restore` добавлены новые флаги:
* `--embedded-keeper` — позволяет создать кластер, используя ClickHouse® вместо ZooKeeper.


##### Yandex Data Processing {#dataproc}

* Команда `yc dataproc cluster create`, флаг `--subcluster`.

  Добавлен параметр `assign-public-ip`, позволяющий выделить публичные IP-адреса для всех хостов подкластера.


### Версия 0.83.0 (26.10.21) {#version0.83.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Cloud CDN {#cdn}

* Добавлены группы команд для поддержки сервиса Yandex Cloud CDN, который позволяет организовать доставку контента до конечных потребителей с помощью сети распространения контента (Content Delivery Network, CDN):
  * `yc cdn origin` — для управления источниками.
  * `yc cdn origin-group` — для управления группами источников.
  * `yc cdn provider` — для подключения к провайдеру CDN.
  * `yc cdn cache` — для управления кешированием контента CDN-ресурсов.

##### Application Load Balancer {#alb}

* Добавлены команды `yc application-load-balancer load-balancer start` и `yc application-load-balancer load-balancer stop` для запуска и остановки L7-балансировщика.

##### Managed Service for YDB {#ydb}

* Добавлены команды `yc ydb database start` и `yc ydb database stop` для запуска и остановки БД.


##### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* В команду `yc managed-redis cluster start-failover` добавлен параметр `--hostnames` для указания хостов кластера (в том числе шардированного), с которых нужно переключить мастер.

**Managed Service for Apache Kafka®**

* Добавлена команда `yc managed-kafka cluster list-logs` для получения лога кластера.

**Managed Service for MySQL®**

* В команду `yc managed-mysql hosts update` добавлены параметры:
  * `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.
  * `--backup-priority` для изменения приоритета хоста при создании резервных копий кластера.

**Managed Service for PostgreSQL**

* В команду `yc managed-postgresql hosts update` добавлен параметр `--assign-public-ip` для управления публичным доступом к хосту: `true` — хост доступен по публичному IP-адресу, `false` — публичный доступ отключен.

### Версия 0.82.0 (23.09.21) {#version0.82.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Compute Cloud {#compute}

* Добавлен флаг `--pooled` в команду `yc compute image create` для создания образа, оптимизированного для развертывания.
* Добавлена группа команд `yc compute filesystem` для управления файловыми хранилищами.
* Добавлены новые команды для подключения и отключения файловых хранилищ от ВМ: `yc compute instance attach-filesystem` и `yc compute instance detach-filesystem`.
* Добавлен параметр `--attach-filesystem` в команду `yc compute instance create` для создания ВМ с подключенным файловым хранилищем.

##### Managed Service for Kubernetes {#k8s}

* Добавлен параметр `--node-labels` в команду `yc k8s node-group update` — он меняет весь набор меток для узлов группы.
* Добавлена команда `yc k8s node-group add-node-labels` для добавления меток к узлам группы.
* Добавлена команда `yc k8s node-group remove-node-labels` для удаления меток для узлов группы.

##### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless trigger create yds` для создания триггеров для Data Streams.

##### Serverless Containers {#serverless-containers}

* Добавлена группа команд `yc serverless containers` для поддержки сервиса Yandex Serverless Containers — он позволяет запускать контейнеры без необходимости работы с Kubernetes или разворачивания ВМ.

##### Virtual Private Cloud {#vpc}

* Добавлена команда `yc vpc network list-route-tables` для списка таблиц роутинга в сети.
* Добавлена команда `yc vpc network list-security-groups` для списка групп безопасности в сети.

#### Yandex Data Processing {#dataproc}

* Добавлен параметр `--log-group-id` в команды `yc dataproc cluster create` и `yc dataproc cluster update` для привязки лог-группы Cloud Logging к кластеру. Чтобы остановить отправку логов кластера в Cloud Logging, укажите пустое значение в качестве идентификатора лог-группы: `--log-group-id=""`.

##### Managed Service for YDB {#ydb}

* Добавлены параметры для управления лимитами БД в режиме Serverless в команды `yc ydb database create` и `yc ydb database update`:
  * `--sls-storage-size`
  * `--sls-throttling-rcu`
  * `--sls-enable-throttling-rcu`
  * `--sls-provisioned-rcu`


##### Yandex Managed Service for Valkey™

* Значение параметра `--redis-version` по умолчанию в команде `yc managed-redis cluster create` изменено на 6.2.

##### Managed Service for MySQL®

* Добавлено отображение настройки `replication source` в команду `yc managed-mysql hosts list`.

##### Managed Service for PostgreSQL

* Добавлено отображение настройки `replication source` в команду `yc managed-postgresql hosts list`.

##### Data Transfer

* Добавлены группы команд `yc datatransfer endpoint` и `yc datatransfer transfer` для управления эндпоинтами и трансферами сервиса Yandex Data Transfer.

### Версия 0.81.0 (06.09.21) {#version0.81.0}

#### Изменения в CLI {#cli}

* Добавлено описание параметров и команд в автодополнении по умолчанию.
* Команда `yc completion <SHELL>`.

  Добавлен флаг `--without-desc` для отключения описания в автодополнении.
* Поддержано автодополнение параметров: `folder-id`, `folder-name`, `cloud-id`, `format`, `profile`.

#### Изменения в сервисах Yandex Cloud {#services}


##### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless trigger create billing-budget` для создания триггеров на события от сервиса Yandex Cloud Billing.
* Добавлены команды для управления подключениями к управляемым БД:
  * `yc serverless mdbproxy update clickhouse`
  * `yc serverless mdbproxy create clickhouse`

##### Cloud Logging {#logging}

* Исключена суб-команда `get-default` из `logging group`.


### Версия 0.80.0 (19.08.21) {#version0.80.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Instance Groups {#instance-groups}

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

##### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless trigger create logging` для создания триггеров на Cloud Logging.

##### Application Load Balancer {#alb}

* Добавлены команды для работы с gRPC-маршрутами:
  * `yc application-load-balancer virtual-host append-grpc-route`
  * `yc application-load-balancer virtual-host prepend-grpc-route`
  * `yc application-load-balancer virtual-host insert-grpc-route`
  * `yc application-load-balancer virtual-host remove-grpc-route`
  * `yc application-load-balancer virtual-host update-grpc-route`
* Добавлена команда `yc application-load-balancer virtual-host update-http-route` для обновления HTTP-маршрутов.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®, Managed Service for Elasticsearch, Managed Service for Apache Kafka®, Yandex StoreDoc, Managed Service for MySQL®, Managed Service for PostgreSQL, Yandex Managed Service for Valkey™, Managed Service for SQL Server**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`.

  Флаг `--deletion-protection` позволяет установить защиту от случайного удаления кластера. Для снятия защиты от удаления укажите `--deletion-protection=false`.

**Yandex StoreDoc**

* Добавлена команда `yc managed-mongodb hosts stepdown`.

  Команда переключает выбранный мастер в режим реплики, мастером в этом случае станет доступная реплика.
* Команды `yc managed-mongodb cluster get` и `yc managed-mongodb cluster update`.

  Добавлено поле `backup-retain-period-days`, показывающее сколько дней хранятся автоматические резервные копии.

**Yandex Managed Service for Valkey™**

* Добавлена поддержка Redis версии 6.2.

**Managed Service for MySQL®**

* Команда `yc managed-mysql hosts update`.

  Добавлена команда`yc managed-mysql hosts update HOST --replication-source HOST` для указания источника репликации каскадной реплики.


**Managed Service for SQL Server**

* Добавлена команда `yc managed-sqlserver database restore`.

  Команда позволяет восстановить заданную БД на существующем кластере из резервной копии. Возможно восстановление под другим именем.


**Managed Service for Apache Kafka®**

* Добавлена поддержка Apache Kafka® 2.8.


##### Yandex Data Processing {#dataproc}

* Команды `yc dataproc cluster create`, `yc dataproc cluster update`.

  Флаг `--deletion-protection` позволяет установить/убирать для кластера защиту от случайного удаления.

  Для снятия защиты от удаления укажите `--deletion-protection=false`.

##### Resource Manager {#resmgr}

* Команда `yc resource-manager cloud list`.

  Добавлено отображение организации облака.

##### Yandex Identity Hub {#organization}

Появилась поддержка сервиса Yandex Identity Hub.

Yandex Identity Hub — это решение для корпоративных клиентов, с помощью которого можно подключить к вашей организации сервисы Yandex Cloud и управлять доступом сотрудников к этим сервисам.

Сервис Yandex Identity Hub находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../organization/index.md).

##### Cloud Functions {#serverless-functions}

* Команда `yc serverless trigger create`.

  Параметры `--invoke-container-name`, `--invoke-container-id` и `--invoke-container-path` позволяют указать для триггера контейнер Serverless Containers.


### Версия 0.79.0 (13.07.21) {#version0.79.0}

#### Изменения в сервисах Yandex Cloud


#### Cloud Logging {#logging}

Добавлена поддержка сервиса Yandex Cloud Logging.

Cloud Logging — сервис для чтения и записи логов сервисов и пользовательских приложений.

Сервис Cloud Logging находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее о сервисе читайте в [документации](../logging/index.md).

#### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless function set-scaling-policy` для задания настроек масштабирования функции.
* Добавлена команда `yc serverless function list-scaling-policies` для просмотра настроек масштабирования функции.
* Добавлена команда `yc serverless function remove-scaling-policy` для удаления настроек масштабирования функции.
* Команда `yc serverless function version create`.

  Исправлена обработка директорий для параметра `--source-path` на Windows.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команда `yc managed-clickhouse cluster update`.

  Добавлен параметр `--cloud-storage` для включения хранения данных в Object Storage.

### Версия 0.78.0 (29.06.21) {#version0.78.0}



#### Managed Service for Kubernetes {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--network-acceleration-type`, который позволяет указать для группы узлов тип сети: стандартная или программно ускоренная.

* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--cilium` для создания кластера, который поддерживает туннельный режим и использует Cilium CNI.

#### Yandex Data Processing {#dataproc}

* Команда `yc dataproc job create-<JOB-TYPE>`.

  Теперь после запуска задания в терминале отображается лог его выполнения.


### Версия 0.77.0 (07.06.21) {#version0.77.0}


**Compute Cloud**

* Команда `yc compute instance`.

  В `network_interface` добавлены ключи `dns-record-spec` и `ipv6-dns-record-spec`.

**API Gateway**

* Добавлена команда `yc serverless api-gateway add-domain` для привязывания домена к API-шлюзу.
* Добавлена команда `yc serverless api-gateway remove-domain` для отсоединения домена от API-шлюза.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Elasticsearch**

* Команда `yc managed-elasticsearch cluster list-logs`.

  Добавлен параметр `--service-type` для получения логов Kibana.

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлен параметр `--service-account`.

**Managed Service for Apache Kafka®**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.

  Добавлены параметры `--num-partitions` и `--default-replication-factor` для задания и изменения конфигурационных настроек брокеров Apache Kafka®.

**Yandex Managed Service for Valkey™**

* Команды `yc managed-redis cluster create\update`.

  Добавлены параметры `--slowlog-log-slower-than`, `--slowlog-max-len`, `--databases` и `--notify-keyspace-events` (смотрите описание в redis.conf).

### Версия 0.76.0 (19.05.21) {#version0.76.0}

**Managed Service for PostgreSQL**

* Команда `yc managed-postgresql cluster update`.

  Добавлен флаг `--serverless-access` для доступа к хостам кластера Yandex Managed Service for PostgreSQL из функции Yandex Cloud Functions.


**Virtual Private Cloud**

* Добавлена команда `yc vpc address move` для перемещения адреса между каталогами облака.

**Compute Cloud**

* Команда `yc compute instance-group`.

  В вывод групп добавлено отображение статуса группы.


### Версия 0.75.0 (13.04.21) {#version0.75.0}

#### Изменения в сервисах Yandex Cloud


#### Compute Cloud {#compute}

* Команда `yc compute create-with-container`.

  Добавлен параметр `--gpus`, который позволяет создать Container Optimized Image с [GPU](../glossary/gpu.md).


#### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* Команда `yc managed-redis cluster create`.

  Добавлен параметр `--disk-type-id [local-ssd|network-ssd]`, который позволяет выбрать тип диска.

**Managed Service for MySQL®**

* Команда `yc managed-mysql cluster list-logs`.

  Теперь логи по умолчанию выводятся в необработанном формате (as is). Чтобы включить старый формат логов, используйте параметр `--format=yaml`.

**Managed Service for Elasticsearch**

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлены флаги управления паролем администратора кластера (пользователь `admin`):
  * `--admin-password`, который позволяет вручную задать пароль;
  * `--generate-admin-password`, который позволяет автоматически сгенерировать пароль;
  * `--read-admin-password`, который позволяет задать пароль из файла.
* Удалены команды `yc managed-elasticsearch user`. Управление пользователями теперь доступно нативными средствами Elasticsearch через пользователя `admin`.
* Команда `yc managed-elasticsearch create`.

  Добавлен параметр `--edition [basic|gold|platinum]`, который позволяет указать редакцию Elasticsearch при создании кластера.

**Managed Service for Apache Kafka®**

* Команда `yc managed-kafka cluster create`.

  Добавлен параметр `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.


#### Yandex Data Processing {#dataproc}

* Команда `yc dataproc cluster create`.

  Добавлен параметр `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.


### Версия 0.74.0 (29.03.21) {#version0.74.0}

* Добавлена поддержка платформ macOS/arm64 (Apple Silicon M1) и linux/arm64.


#### Изменения в сервисах Yandex Cloud

#### Yandex Data Processing {#dataproc}

* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.

  Добавлен параметр `--security-group-ids`, который позволяет установить набор групп безопасности для кластера.


### Версия 0.73.0 (17.03.21) {#version0.73.0}

#### Изменения в сервисах Yandex Cloud


#### Container Registry {#container-registry}

Добавлены команды управления разрешенными IP-адресами для загрузки и скачивания Docker-образов:
* `yc container registry add-ip-permissions` добавляет IP-адреса.
* `yc container registry list-ip-permissions` позволяет посмотреть IP-адреса.
* `yc container registry set-ip-permissions` устанавливает IP-адреса.
* `yc container registry remove-ip-permissions` удаляет IP-адреса.

#### Cloud Functions {#cloud-functions}

* Команда `yc serverless function version create`.

  Добавлены значения по умолчанию для параметров:
  * `--execution-timeout` – три секунды;
  * `--memory` – 128 МБ.
* Команда `yc serverless function version create`.

  Добавлен параметр `--add-service-account` для указания дополнительных сервисных аккаунтов для версии.

#### Cloud Logs {#logs}

* Добавлена команда `yc logs`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

* Команда `yc managed-kafka cluster create`.

  Для параметров `--disk-size`, `--disk-type`, `--resource-preset`, `--zookeeper-disk-size`, `--zookeeper-disk-type` и `--zookeeper-resource-preset` теперь не указываются значения по умолчанию. Если значения не указаны, будут применяться значения по умолчанию, заданные на сервере.
* Команда `yc managed-kafka cluster create`.

  Добавлен флаг `--unmanaged-topics`, позволяющий включить управление топиками Apache Kafka® через AdminAPI.

  Добавлен флаг `--auto-create-topics-enable`, позволяющий включить автоматическое создание топиков Apache Kafka®.

* Команда `yc managed-kafka user create`.

  Добавлена роль `admin`, позволяющая включить управление топиками кластера Apache Kafka® через AdminAPI.

**Yandex Managed Service for Valkey™**

* Команда `yc managed-redis cluster create`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера Redis.

* Команда `yc managed-redis cluster restore`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера Redis из резервной копии.

### Версия 0.72.0 (11.02.21)



#### Изменения в сервисах Yandex Cloud

#### Application Load Balancer {#alb}

Добавлена первичная поддержка сервиса Yandex Application Load Balancer:
* Команды группы `yc alb backend-group` позволяют управлять группой бэкендов.
* Команды группы `yc alb http-router` позволяют управлять HTTP-роутерами.
* Команды группы `yc alb load-balancer` позволяют управлять L7-балансировщик.
* Команды группы `yc alb target-group` позволяют управлять целевыми группами.
* Команды группы `yc alb virtual-host` позволяют управлять виртуальными хостами.

#### Compute Cloud {#compute}

* Команды `yc compute instance|disk|image list` теперь возвращают более 1000 элементов.


### Версия 0.71.0 (03.02.21) {#version0.71.0}

#### Изменения в сервисах Yandex Cloud


#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Добавлен параметр `--placement-group`, позволяющий указать `placement policy group` для группы узлов при создании.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

  Для параметра `--postgresql-version string` добавлено значение `13` для создания кластера PostgreSQL версии 13.

**Managed Service for MySQL®**

* Команда `yc managed-mysql cluster update`.

  Добавлен флаг `--mysql-version`, позволяющий обновить версию MySQL®-сервера.

**Managed Service for Elasticsearch**

* Добавлены команды `yc managed-elasticsearch hosts create` и `yc managed-elasticsearch hosts delete` для добавления и удаления хостов.


**Managed Service for SQL Server**

Добавлена первичная поддержка сервиса Yandex Managed Service for SQL Server:
* Команды группы `yc managed-sqlserver cluster` позволяют управлять кластерами.
* Команды группы `yc managed-sqlserver database` позволяют управлять БД.
* Команды группы `yc managed-sqlserver user` позволяют управлять пользователями.


**Managed Service for ClickHouse®**

* Команды `yc managed-clickhouse host add` и `yc managed-clickhouse shards add`.

  Добавлен флаг `--copy-schema`, который позволяет скопировать схему с других хостов ClickHouse®.

### Версия 0.70.0 (22.12.20) {#version0.70.0}


#### Изменения в CLI {#cli}

**Улучшено**

* Команда `yc container registry configure-docker`.

  Добавлен флаг `--disable`, позволяющий отключить интеграцию с Docker Credential Helper.


#### Изменения в сервисах Yandex Cloud


#### Identity and Access Management {#iam}

Добавлена команда `yc iam federation list-user-accounts` для листинга пользователей федерации.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for MySQL®, Managed Service for PostgreSQL, Managed Service for ClickHouse®, Yandex Managed Service for Valkey™, Yandex StoreDoc, Managed Service for Apache Kafka®**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update` и `yc <имя сервиса управляемой БД> cluster restore`.

  Параметр `--security-group-ids` позволяет установить для кластера набор групп безопасности.

**Managed Service for Apache Kafka®**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.

  Добавлены параметры для задания и изменения конфигурационных настроек Apache Kafka® брокеров: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, `--log-preallocate`.
* Команды `yc managed-kafka topic create` и `yc managed-kafka topic update`.

  Добавлены параметры для задания и изменения настроек топика: `--cleanup-policy`, `--compression-type`, `--delete-retention-ms`, `--file-delete-delay-ms`, `--flush-messages`, `--flush-ms`, `--min-compaction-lag-ms`, `--retention-bytes`, `--retention-ms`, `--max-message-bytes`, `--min-insync-replicas`, `--segment-bytes`, `--preallocate`.

**Managed Service for Elasticsearch**

Добавлена первичная поддержка сервиса Managed Service for Elasticsearch:
* Команды группы `yc managed-elasticsearch cluster` позволяют управлять кластерами.
* Команды группы `yc managed-elasticsearch user` позволяют управлять пользователями.

### Версия 0.69.0 (02.12.20) {#version0.69.0}

#### Изменения в сервисах Yandex Cloud


#### Managed Service for Kubernetes {#k8s}

* Исправлен парсинг флага `ipv6-address` для сетевой спецификации групп узлов.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for Apache Kafka®**

Добавлена первичная поддержка сервиса Managed Service for Apache Kafka®:
* Команды группы `yc managed-kafka cluster` позволяют управлять кластерами.
* Команды группы `yc managed-kafka topic` позволяют управлять топиками.
* Команды группы `yc managed-kafka user` позволяют управлять пользователями.

**Managed Service for MySQL®**

* Команда `yc managed-mysql user grant-permission`.

  Параметр `--permissions` поддерживает привилегию `REFERENCES`.

**Managed Service for MySQL®, Managed Service for PostgreSQL**

* Команда `yc <имя сервиса управляемой БД> cluster update`.

  Добавлен флаг `--websql-access` для управления доступом из [консоли управления](https://console.yandex.cloud).

### Версия 0.68.0 (03.11.20) {#version0.68.0}

#### Изменения в сервисах Yandex Cloud


#### Compute Cloud {#compute}

* Добавлена возможность указать размер блока для дисков при создании ВМ.

#### Key Management Service {#kms}

* Команда `yc kms symmetric-key create`.

  Добавлен флаг `--deletion-protection` для включения защиты ключа от удаления.
* Команда `yc kms symmetric-key update`.

  Добавлены флаги для включения и выключения защиты ключа от удаления: `--deletion-protection` и `--no-deletion-protection`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore` и `yc managed-clickhouse cluster update`.

  Добавлены флаги:
  * `--admin-password`, `--generate-admin-password` и `--read-admin-password` — устанавливает пароль пользователя `admin`, который используется при включенном управлении пользователями через SQL.
  * `--enable-sql-database-management` — включает управление БД через SQL.
  * `--enable-sql-user-management` — включает управление пользователями и правами доступа через SQL.

**Managed Service for MySQL®**

* Команда `yc managed-mysql user grant-permission`.

  Добавлен параметр `--permissions`, который поддерживает привилегии `ALL_PRIVILEGES` (синоним для `ALL`).


#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены флаги `--cluster-ipv6-range`, `--dual-stack` и `--service-ipv6-range`, которые позволяют создавать кластеры Kubernetes с параллельным использованием IPv4 и IPv6.
* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

  Добавлен параметр `--security-group-ids`, который устанавливает для кластера группу безопасности.
* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--network-interface`, который позволяет более детально задавать сетевые спецификации для узлов. Например, управлять настройкой групп безопасности для сетевых интерфейсов и настраивать интерфейсы узлов для параллельного использования IPv4 и IPv6 в кластерах Kubernetes.


### Версия 0.67.0 (05.10.20) {#version0.67.0}



#### Изменения в сервисах Yandex Cloud

#### Compute Cloud {#compute}

**Исправлено**

* Исправлена ошибка, при которой не получалось добавить ВМ в существующую группу размещения.

#### Container Registry {#container-registry}

* Добавлены команды `yc container image list-vulnerabilities` и `yc container image scan` для сканирования Docker-образов.


### Версия 0.66.0 (28.09.20) {#version0.66.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Compute Cloud {#compute}

* Добавлена команда `yc compute host-group`, позволяющая управлять выделенными хостами.
* Добавлена команда `yc compute host-type`, позволяющая управлять типами выделенных хостов.
* Добавлена команда `yc compute disk-placement-group`, позволяющая управлять группами нереплицированных дисков.


#### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* Команда `yc managed-mongodb cluster restore --help`.

  Добавлен пример использования параметра `--recovery-target-timestamp`.

### Версия 0.65.0 (22.09.20) {#version0.65.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Yandex Data Processing {#dataproc}

Добавлена поддержка функциональности UI Proxy:
* Добавлена команда `yc dataproc cluster list-ui-links`, позволяющая получить список ссылок для доступа к интерфейсам кластера Yandex Data Processing.
* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.
  Добавлен параметр `--ui-proxy`, позволяющий включить функциональность UI Proxy для кластера Yandex Data Processing.
* Команды `yc dataproc cluster create`, `yc dataproc subcluster create`, `yc dataproc subcluster update`.
  Добавлены параметры для автомасштабируемых подкластеров: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration` и `--warmup-duration`.
* Команда `yc dataproc subcluster list`.
  В ответ добавлено поле `instance group id` с идентификаторами групп ВМ автомасштабируемых подкластеров.

#### Certificate Manager {#certificate-manager}

* Добавлена команда `yc certificate-manager certificate content` для получения содержимого сертификата.

  С ее помощью можно загрузить цепочку сертификатов и закрытый ключ для самостоятельного использования в конфигурации веб-сервера на ВМ.


#### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* Команды `yc managed-mongodb cluster get` и `yc managed-mongodb cluster update`.

  Добавлено поле `backup-retain-period-days`, показывающее сколько дней хранятся автоматические резервные копии.
* Команды `yc managed-mongodb cluster list-backups` и `yc managed-mongodb backup list`.

  Добавлены поля `SIZE` и `TYPE`, содержащие размер и тип резервной копии.
* Команда `yc managed-mongodb cluster list-logs`.

  Добавлен параметр `filter` позволяющий фильтровать запрашиваемые записи.

  Если задан параметр `follow`, то значение по умолчанию для параметра `limit` игнорируется. При этом явное указание параметра `limit` ограничивает количество выводимых записей.

### Версия 0.64.0 (08.09.20) {#version0.64.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Compute Cloud {#compute}

* Команда `yc compute instance-group`.

  * Добавлена возможность устанавливать и просматривать список ролей для группы ВМ: `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.
  * Добавлены команды для удаления и остановки ВМ в группе ВМ: `stop-instances`, `delete-instances`.


#### Сервисы управляемых баз данных {#managed-db}

* Команда `yc <имя сервиса управляемой БД> cluster list-logs` для всех управляемых БД использует новые методы [API](../glossary/rest-api.md) `StreamLogs` для стриминга логов.

  Всем командам добавлен флаг `--follow`, позволяющий получать новые записи логов по мере их появления.

**Managed Service for ClickHouse®**

* Добавлена команда `yc managed-clickhouse versions list` для получения списка версий, доступных для установки.
* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`.

  Добавлен параметр `--cloud-storage` для включения хранения данных в Object Storage.

**Yandex StoreDoc**

* Добавлена поддержка создания кластера с версией MongoDB 4.4.
* Команды `yc managed-mongodb cluster update` и `yc managed-mongodb cluster enable-sharding`.

  Для [шардированных](../storedoc/concepts/sharding.md) кластеров появилась возможность задавать тип хоста: `mongoinfra`.


#### Certificate Manager {#certificate-manager}

Появилась поддержка сервиса для управления TLS-сертификатами: Yandex Certificate Manager.

С помощью Certificate Manager вы можете получать и обновлять TLS-сертификаты от Let's Encrypt®, а также импортировать собственные сертификаты.

Сертификаты можно использовать в сервисах Yandex Cloud для обеспечения безопасности соединений.

Сервис Certificate Manager находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../certificate-manager/index.md).


### Версия 0.63.0 (28.08.20) {#version0.63.0}

#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена проблема с авторизацией для федеративных пользователей при инициализации нового профиля CLI.


#### Изменения в сервисах Yandex Cloud {#services}

#### Virtual Private Cloud {#vpc}

* Добавлена группа команд `yc vpc address` для управления [IP-адресами](../vpc/concepts/address.md#public-addresses).


### Версия 0.62.0 (20.08.20) {#version0.62.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Cloud Functions {#serverless-functions}

* Команда `yc serverless function version create`.
  * Добавлен параметр `--source-version-id` для указания базовой версии функции.
  * Добавлены параметры `--network-id` и `--network-name` для указания сети для версии функции. Детальный список подсетей можно указать с помощью параметров `--subnet-id` и `--subnet-name`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for MySQL®**

* Команда `yc managed-mysql user update`.

  Флаг `--global-permissions` позволяет выдать привилегию `PROCESS`.

**Managed Service for ClickHouse®, Managed Service for MySQL®, Managed Service for PostgreSQL, Yandex Managed Service for Valkey™, Yandex StoreDoc**

* Команда `yc <имя сервиса управляемой БД> cluster update`.

  Добавлены параметры `--maintenance-window-anytime` и `--maintenance-window-weekly` для указания параметров окон обслуживания. Они будут использованы для планирования времени работ с кластером.
* Добавлена команда `yc <имя сервиса управляемой БД> cluster reschedule-maintenance` для управления запланированной задачей по обслуживанию кластера.

**Yandex StoreDoc**

* Команда `yc managed-mongodb cluster restore`.

  Добавлен параметр `--recovery-target-timestamp` для указания точки восстановления резервной копии.

### Версия 0.61.0 (03.08.20) {#version0.61.0}



#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Теперь значение параметра `--version` корректно учитывается при создании регионального кластера.

##### Compute Cloud {#compute}

* Команда `yc compute instance update-network-interface`.

  Параметр `--security-group-id` теперь принимает список значений, разделенных запятыми.

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  Добавлен параметр `--coi-spec-file` для передачи [спецификации образа](../cos/concepts/coi-specifications.md#coi-spec-example).

  Добавлен параметр `--coi-spec-file` для передачи спецификации образа.

##### Virtual Private Cloud {#vpc}

* Команды `yc vpc subnet create` и `yc vpc subnet update`.

  Параметры `--domain-name-server` и `--ntp-server` теперь принимают список значений, разделенных запятыми.
* Добавлена команда `yc vpc subnet list-used-addresses`.

  Команда выводит список используемых в подсети адресов.


### Версия 0.60.0 (20.07.20) {#version0.60.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Compute Cloud {#compute}

* Добавлена команда `yc compute instance update-network-interface`.

  Команда позволяет изменять параметры сетевого интерфейса на уже созданных ВМ.

##### Cloud Functions {#serverless-functions}

* Команда `yc serverless function logs`.

  Использование флага `--follow` теперь гарантирует получение журналов выполнения самой свежей версии функции с переданным тегом.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update` и `yc managed-clickhouse cluster restore`.

  Добавлен параметр `--service-account` для выбора сервисного аккаунта, привязанного к хостам.
* Добавлены команды для управления группами шардов `yc managed-clickhouse shard-groups`.

### Версия 0.59.0 (02.07.20) {#version0.59.0}



#### Изменения в сервисах Yandex Cloud {#services}

#### API Gateway {#api-gw}

Появилась поддержка сервиса Yandex API Gateway.

API Gateway — сервис для управления API-шлюзами, поддерживающий спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с другими облачными сервисами.

Сервис API Gateway находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее о сервисе читайте в [документации](../api-gateway/index.md).

#### Identity and Access Management {#iam}

* Командам `yc iam federation create` и `yc iam federation update` добавлены флаги:
  * `--encrypted-assertions` для включения шифрования утверждений SAML;
  * `--case-insensitive-name-ids` для включения нечувствительных к регистру Name IDs пользователей.


### Версия 0.58.0 (16.06.20) {#version0.58.0}

#### Изменения в сервисах Yandex Cloud {#services}


##### Cloud Functions {#serverless-functions}

* Добавлены команды для остановки и возобновления работы триггеров `yc serverless trigger pause` и `yc serverless trigger resume`.
* Команда `yc serverless function invoke`.

  Увеличено время ожидания результата вызова функции с 30 секунд до 25 минут.

##### Virtual Private Cloud {#vpc}

* Команды `yc vpc subnet create` и `yc vpc subnet update`.

  Добавлены параметры для настройки опций DHCP: `--domain-name`, `--domain-name-server` и `--ntp-server`.

##### Managed Service for Kubernetes {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен параметр `--gpus=GPUS` для указания количества GPU, которые будут на узлах.

##### Container Registry {#container-registry}

* Добавлены команды для управления политиками автоматического удаления Docker-образов `yc container repository lifecycle-policy`.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Добавлены команды для управления метками `yc managed-mysql cluster add-labels` и `yc managed-mysql cluster remove-labels`.

**Yandex Managed Service for Valkey™**

* Добавлена поддержка Redis версии 6.

### Версия 0.57.0 (26.05.20) {#version0.57.0}


#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена работа Docker Credential helper с HTTPS-адресами. Теперь возможно получить аутентификационные данные для адреса вида `https://cr.yandex`.


#### Изменения в сервисах Yandex Cloud {#services}


#### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless trigger create container-registry` создания триггеров для Yandex Container Registry.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Изменена платформа и количество ядер, используемые по умолчанию при создании группы узлов. Теперь используется платформа Intel Cascade Lake (`standard-v2`) в двухъядерной конфигурации `cores: 2`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Добавлена команда `yc managed-clickhouse format-schema`.

  Команда дает возможность управления Cap'n Proto и Protobuf схемами в кластере ClickHouse®.

**Yandex StoreDoc**

* Добавлена команда `yc managed-mongodb hosts resetup`.

  Команда перезагружает данные на выбранном хосте: сначала удаляет все данные, а затем восстанавливает их из реплики.

### Версия 0.56.0 (23.04.20) {#version0.56.0}

#### Изменения в сервисах Yandex Cloud {#services}

##### Все сервисы {#all}

* В командах `get` и `delete` теперь можно передавать несколько идентификаторов или имен ресурсов.

##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команды `yc managed-clickhouse user create` и `yc managed-clickhouse user update`.

  В помощи появилась информация про параметры флага `settings`.

**Managed Service for ClickHouse®, Managed Service for PostgreSQL, Managed Service for MySQL®**

* Команда `yc <имя сервиса управляемой БД> host list`.

  В выводе появился столбец со значениями `assign_public_ip`.

**Yandex Managed Service for Valkey™**

* Команда `yc managed-redis host list`.

  В выводе появились столбцы со значениями `type` и `shard_name`.


##### Container Optimized Image {#coi}

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

#### Изменения в сервисах Yandex Cloud {#services}


#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлен параметр `--node-ipv4-mask-size` для настройки размера `CIDR`, выделяемого на каждый узел кластера.
* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлены параметры `--max-unavailable` и `--max-expansion` для контроля количества удаляемых и создаваемых узлов в процессе обновления группы.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®, Managed Service for PostgreSQL, Managed Service for MySQL®**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster restore`, `yc <имя сервиса управляемой БД> host add`.

  Добавлено свойство `subnet-name` к параметру `--host` для указания подсети по имени.

**Yandex StoreDoc, Managed Service for ClickHouse®, Yandex Managed Service for Valkey™**

* Команда `yc <имя сервиса управляемой БД> cluster list-logs`.

  Добавлено форматирование строчек лога.


#### Container Optimized Image {#coi}

* Команда `yc compute instance create-with-container`.

  Добавлена возможность монтирования `docker volumes` в Docker-контейнер, созданный в Container Optimized Image с помощью параметров `container-volume-tmpfs` и `container-volume-host-path`.
* Команда `yc compute instance update-container`.

  Добавлена возможность обновления `docker volumes` в Docker-контейнере, созданном в Container Optimized Image.


### Версия 0.54.0 (24.03.20) {#version0.54.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Стали более понятными сообщения при ошибках ввода команд и параметров.


#### Изменения в сервисах Yandex Cloud {#services}

##### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены параметры `--kms-key-id` и `--kms-key-name` для создания кластера Kubernetes с шифрованием секретов в KMS.


### Версия 0.53.0 (04.03.20) {#version0.53.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске `yc` на ВМ внутри Yandex Cloud, если в конфиге `yc` не указан `folder-id`, то будет использоваться каталог, в котором создана ВМ.
* Добавлен флаг `--version`, в дополнение к команде `yc version`.

**Исправлено**

* Исправлено обновление через `yc components update` на WSL 1.
* Исправлено аварийное завершение при вызове команды `yc help`.

#### Изменения в сервисах Yandex Cloud {#services}


##### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster get-credentials`.

  Добавлена проверка и выдача предупреждения, если у пользователя установлена утилита `kubectl` версии ниже 1.11, такие версии не поддерживают способ аутентификации, который задается данной командой.


##### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команда `yc managed-clickhouse user`.

  Добавлена возможность управлять квотами пользователей.
* Команда `yc managed-clickhouse cluster`.

  Добавлены флаги `metrica-access`, `datalens-access` и `websql-access` в команды создания, восстановления и редактирования кластеров.
* Добавлены команды `yc managed-clickhouse ml-model`.

  Позволяет управлять ML моделями в кластере ClickHouse®.

**Yandex StoreDoc, Managed Service for PostgreSQL, Managed Service for MySQL®, Yandex Managed Service for Valkey™**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`, `yc <имя сервиса управляемой БД> cluster restore`.

  Добавлен флаг `datalens-access`, регулирующий доступ Yandex DataLens к кластеру.

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


#### Изменения в сервисах Yandex Cloud {#services}

#### Compute Cloud {#compute}

* Команда `yc compute instance create`.

  В параметр `--network-interface` добавлено свойство `nat-address`, позволяющее указать создаваемому инстансу конкретный NAT-адрес.
* Добавлены команды `yc compute instance add-one-to-one-nat` и `yc compute instance remove-one-to-one-nat`.

  Команды позволяют управлять NAT на уже созданных инстансах.
* Команды `yc compute instance create` и `yc compute instance update`.

  Добавлен параметр `--network-settings`, с помощью которого можно изменить тип сети на `Software accelerated` и обратно в `Standard`.

#### Key Management Service {#kms}

* Команда `yc kms symmetric-key`.

  Добавлены команды, позволяющие управлять ролями на отдельные ключи: `list-access-bindings`, `set-access-bindings`, `add-access-binding`, `remove-access-binding`.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--enable-network-policy` для создания кластера Kubernetes с поддержкой [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
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


#### Изменения в сервисах Yandex Cloud {#services}

#### Identity and Access Management {#iam}

* Добавлены команды для создания и управления SAML-совместимыми федерациями удостоверений и сертификатами к ним: `yc iam federation` и `yc iam certificate`. Подробнее про SAML-совместимые федерации удостоверений можно узнать в [документации](../organization/concepts/add-federation.md).


### Версия 0.50.0 (27.01.20) {#version0.50.0}



#### Изменения в сервисах Yandex Cloud {#services}

* Для [ресурсов, на которые можно назначать роли](../iam/concepts/access-control/resources-with-access-control.md).

  Добавлены альтернативы параметру `--subject` для команд управления ролями: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login` и `--all-authenticated-users`.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Добавлен флаг `--auto-scale`, позволяющий создать группу узлов динамического размера под управлением [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### Compute Cloud {#compute}

* Команда `yc compute instance create`.

  При указании флага `--gpus` автоматически выбирается платформа `gpu-standard-v1`.


### Версия 0.49.0 (21.01.20) {#version0.49.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске CLI с флагом `--debug`, строка лога ответа API-вызова теперь выводит не только gRPC-код статуса, но и его описание.


#### Изменения в сервисах Yandex Cloud {#services}

#### Key Management Service {#kms}

Появилась поддержка сервиса для управления криптографическими ключами: Yandex Key Management Service.

Key Management Service позволяет создавать ключи шифрования и организовывать схемы защиты данных в ваших приложениях и сервисах.

Используйте ключи, чтобы защитить секреты, личные данные и другую конфиденциальную информацию, которую вы храните в облаке.

Сервис Key Management Service находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее про сервис читайте в [документации](../kms/index.md).


### Версия 0.48.0 (27.12.19) {#version0.48.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При обновлении CLI теперь выводится текущая устанавливаемая версия.

#### Изменения в сервисах Yandex Cloud {#services}


#### Compute Cloud {#compute}

* Добавлена возможность работы с группой размещения `yc compute placement-group --help`.
* Команды `yc compute instance create` и `yc compute instance update`.

  Параметр для указания платформы переименован с `--platform-id` на `--platform`. Старое именование продолжает поддерживаться.
* Команда `yc compute instance create`.

  SSH-ключ, добавленный с помощью параметра `--ssh-key`, записывается в метаданные с ключом `ssh-keys` вместо `ec2-user-data`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for MySQL®**

* Добавлена поддержка создания кластера с версией MySQL® 8.0.
* Добавлена команда для ручного переключения мастера для указанного кластера MySQL® `yc managed-mysql cluster start-failover`.
* Команда `yc managed-mysql cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**Managed Service for PostgreSQL**

* Добавлена команда для ручного переключение мастера для указанного кластера PostgreSQL `yc managed-postgresql cluster start-failover`.
* Команда `yc managed-postgresql cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**Managed Service for ClickHouse®**

* Команда `yc managed-clickhouse cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

**Yandex Managed Service for Valkey™**

* Команда `yc managed-redis cluster update`.

  Добавлена возможность переименовать кластер с помощью параметра `--new-name`.

### Версия 0.47.0 (17.12.19) {#version0.47.0}



#### Изменения в CLI {#cli}

**Улучшено**

* Добавлена возможность [аутентификации с помощью федерации](operations/authentication/federated-user.md) при вызове `yc` в неинтерактивном режиме. Этот режим используется, когда CLI запускается пользователем не напрямую, например в скрипте или в `kubectl`.


### Версия 0.46.0 (13.12.19) {#version0.46.0}



#### Изменения в CLI {#cli}

**Улучшено**

* Для ускорения диагностики проблем авторизации, в журнал отладки запроса пишется CRC32 отправляемого [IAM-токена](../iam/concepts/authorization/iam-token.md).

#### Изменения в сервисах Yandex Cloud {#services}

#### Cloud Functions {#serverless-functions}

* Добавлена команда `yc serverless trigger create object-storage` для подписки на изменения бакета в Yandex Object Storage.


### Версия 0.45.0 (03.12.19) {#version0.45.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Увеличено время между повторными попытками подключения в случае недоступности любого ресурса, задействованного в выполнении команды.


#### Изменения в сервисах Yandex Cloud {#services}

#### Yandex IoT Core {#iot}

* Добавлены команды для управления паролями: `yc iot registry password` и `yc iot device password`.
* Команды `yc iot registry create` и `yc iot device create`.

  Добавлены флаги для поддержки авторизации по логину и паролю: `--password`, `--read-password` и `--generate-password`.
* Команды `yc iot mqtt publish` и `yc iot mqtt subscribe`.

  Добавлены флаги для поддержки авторизации по логину и паролю: `--username` и `--password`.


### Версия 0.44.0 (19.11.19) {#version0.44.0}


#### Изменения в сервисах Yandex Cloud {#services}

#### Cloud Functions {#serverless-functions}

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


#### Изменения в сервисах Yandex Cloud {#services}


#### Compute Cloud {#compute}

* Добавлены подробности в лог и в текст об ошибке при [авторизации изнутри ВМ](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (с помощью IAM-токена из метаданных).

* Добавлены подробности в лог и в текст об ошибке при авторизации изнутри ВМ (с помощью IAM-токена из метаданных).


#### Изменения в сервисах управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Добавлена поддержка создания баз PostgreSQL версии 12.

**Yandex StoreDoc**

* Добавлена поддержка создания кластера с версией MongoDB 4.2.

### Версия 0.42.0 (21.10.19) {#version0.42.0}


#### Изменения в сервисах Yandex Cloud {#services}

#### Compute Cloud {#compute}

* Добавлены команды `yc compute instance-group start`, `yc compute instance-group stop` для запуска и остановки группы ВМ.

#### Container Registry {#container-registry}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  Для значений "always", "never", "on-failure" параметра `--container-restart-policy` добавлено альтернативное написание: "Always", "Never", "OnFailure".

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Удален флаг `--default-gateway-v4-address`.


#### Изменения в сервисах управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

  Для параметра `--postgresql-version string` добавлено значение `10_1c` для создания кластера PostgreSQL версии 10-1c.

### Версия 0.41.1 (26.09.19) {#version0.41.1}

* Небольшие исправления и обновления.

### Версия 0.41.0 (25.09.19) {#version0.41.0}



#### Изменения в сервисах Yandex Cloud {#services}

#### Container Registry {#container-registry}

* Команда `yc compute instance create-with-container`.

  Из параметра `--create-boot-disk` удалена поддержка свойств `snapshot-*`.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены параметры для управления типом мастера: `--regional`, `--region` и `--master-location`.
* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

  Добавлены параметры для управления политикой обслуживания: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.
* Команда `yc managed-kubernetes node-groups update`.

  Добавлены параметры для управления политикой обслуживания: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.


### Версия 0.40.0 (20.09.19) {#version0.40.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Container Registry {#container-registry}

* Добавлена команда для получения подробной информации о реестре: `yc container registry repository get`.
* Команда `yc container registry repository list`.

  Добавлен вывод уникального идентификатора реестра.


#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> create clusters`.

  Для параметра `--*resource-preset` добавлено значение по умолчанию: s2.micro.

**Yandex StoreDoc**

* Команда `yc managed-mongodb create clusters`.

  Для параметра `--mongodb-version` изменено значение по умолчанию: с 3.6 на 4.0.

### Версия 0.39.0 (16.09.19) {#version0.39.0}

#### Изменения в сервисах Yandex Cloud {#services}


#### Container Registry {#container-registry}

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

* Добавлена проверка доступности эндпоинтов API Yandex Identity and Access Management, Yandex Resource Manager, Yandex Compute Cloud. Если эндпоинт недоступен, выдается ошибка.
* Добавлено отображение деталей ошибок.

#### Изменения в сервисах Yandex Cloud {#services}


#### Container Registry {#container-registry}

**Улучшено**

* Добавлена поддержка ОС Windows для работы с Docker Credential helper.
* Добавлена подробная ошибка при использовании `docker login` одновременно с Docker Credential helper.

#### Instance Groups {#instance-groups}

* Добавлены команды для управления метаданными группы ВМ: `yc compute instance-group add-metadata` и `yc compute instance-group remove-metadata`.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster update`.

  Добавлены параметры `--node-service-account-id` и `--node-service-account-name`, позволяющие добавить или изменить сервисный аккаунт для узлов у существующего кластера Kubernetes.
* Команда `yc managed-kubernetes node-group update`.

  Добавлены параметры для изменения параметров существующей группы узлов: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.
* Добавлены команды для управления метками: `yc managed-kubernetes node-group add-labels` и `yc managed-kubernetes node-group remove-labels`.
* Добавлены команды для управления метаданными группы узлов: `yc managed-kubernetes node-group add-metadata` и `yc managed-kubernetes node-group remove-metadata`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команда `yc managed-postgresql cluster update`.

  Добавлен флаг `--connection-pool-discard` для отключения менеджера подключений.
* Команды `yc managed-postgresql user create` и `yc managed-postgresql user update`.

  Добавлена возможность указать логин и задать права доступа для пользователя с помощью параметров `--login` и `--grants`.

### Версия 0.36.0 (27.08.19) {#version0.36.0}



#### Изменения в сервисах Yandex Cloud {#services}

#### Resource Manager {#resmgr}

* Команда `yc resource-manager cloud update`.

  Добавлена возможность переименовать облако.


### Версия 0.35.1 (16.08.19) {#version0.35.1}

#### Изменения в сервисах Yandex Cloud {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> cluster create`.

  Переименованы типы дисков по умолчанию: `network-nvme` на `network-ssd`, `local-nvme` на `local-ssd`.

### Версия 0.35.0 (09.08.19) {#version0.35.0}

#### Изменения в CLI {#cli}

**Улучшено**

* В сообщение о новой версии CLI добавлена ссылка на документацию с описанием релизов.

#### Изменения в сервисах Yandex Cloud {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команда `yc managed-postgresql cluster create`.

  Для параметра `--user` добавлены свойства: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Версия 0.34.0 (26.07.19) {#version0.34.0}

#### Изменения в сервисах Yandex Cloud {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Yandex Managed Service for Valkey™**

* Команда `yc managed-redis shards`.

  Добавлена поддержка шардов для кластеров Redis.

**Managed Service for ClickHouse®**

* Команда `yc managed-clickhouse cluster add-external-dictionary`.

  Добавлена поддержка словарей PostgreSQL. Флаги для работы со словарями: `--postgresql-source`, `--postgresql-source-hosts` и `--postgresql-invalidate-query`.

**Managed Service for MySQL®**

* Команда `Managed Service for MySQL® cluster update-config --set`.

  Добавлена возможность глобально задать режим SQL с помощью параметра `sql_mode`.

### Версия 0.33.0 (19.07.19) {#version0.33.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Индикатор прогресса выполнения команды изменен с точек на [троббер](https://ru.wikipedia.org/wiki/Троббер).

#### Изменения в сервисах Yandex Cloud {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for PostgreSQL**

* Команды `yc managed-postgresql user create` и `yc managed-postgresql user update`.

  Добавлена настройка параметров пользователя с помощью параметров `--lock_timeout`, `--log_min_duration_statement` и т. д.

### Версия 0.32.0 (05.07.19) {#version0.32.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Команды для отображения списка элементов `yc <сервис> <ресурс> list`.

  Увеличено максимальное число элементов в выводе со 100 до 1000.

#### Изменения в сервисах Yandex Cloud {#services}

#### Сервисы управляемых баз данных {#managed-db}

**Yandex StoreDoc**

* Команды `yc managed-mongodb cluster update` и `yc managed-mongodb cluster update-config`.

  Для [шардированных](../storedoc/concepts/sharding.md) кластеров появилась возможность изменять параметры компонентов `mongos` и `mongocfg`.

### Версия 0.31.0 (01.07.19) {#version0.31.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При использовании CLI на ВМ, запущенной от имени сервисного аккаунта, по умолчанию CLI будет авторизовываться от имени этого сервисного аккаунта.

**Исправлено**

* Попытка получить ресурс, указав его уникальный идентификатор, завершалась с ошибкой, если в конфигурации CLI не был задан параметр `folder-id`.
* Попытка получить каталог, указав его уникальный идентификатор, завершалась с ошибкой, если у пользователя не было роли `viewer` на каталог в Yandex Cloud.
* Команда `yc init` завершалась с ошибкой, если у пользователя не было роли `viewer` в Yandex Cloud.

#### Изменения в сервисах Yandex Cloud {#services}


#### Network Load Balancer {#load-balancer}

* Команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update`.

  Для параметра `--listener` появилась возможность задать свойство `target-port`, позволяющее настроить NAT так, чтобы целевые ресурсы принимали трафик на порту, отличном от порта `listener`.


#### Сервисы управляемых баз данных {#managed-db}

**Managed Service for ClickHouse®**

* Команды `yc managed-clickhouse user create` и `yc managed-clickhouse user update`.

  Добавлен параметр `--settings`, позволяющий задать пользовательские настройки.

### Версия 0.30.0 (18.06.19) {#version0.30.0}



#### Изменения в сервисах Yandex Cloud {#services}

#### Compute Cloud {#compute}

* Команда `yc compute instance update`.

  Добавлены параметры `--service-account-id` и `--service-account-name`, позволяющие добавить или изменить сервисный аккаунт для существующей ВМ.
* Команда `yc compute instance create`.

  Изменено количество ядер, используемое по умолчанию при создании ВМ с платформой Intel Cascade Lake (`standard-v2`). Теперь `cores: 2`.

#### Managed Service for Kubernetes {#k8s}

* Команда `yc managed-kubernetes cluster update`.

  Добавлен флаг `--default-gateway-v4-address`, позволяющий обновить адрес шлюза для существующего Kubernetes кластера.


### Версия 0.29.0 (11.06.19) {#version0.29.0}

* Небольшие исправления и обновления.

### Версия 0.28.0 (05.06.19) {#version0.28.0}

#### Изменения в CLI {#cli}

* Добавлено автоматическое повторное подключение в случае недоступности любого ресурса, задействованного в выполнении команды. CLI повторит попытку соединения 5 раз, частота повтора вычисляется с помощью экспоненциального откладывания (exponential backoff).

#### Изменения в сервисах Yandex Cloud {#services}


#### Compute Cloud {#compute-cloud}

* Команда `yc compute instance create`.

  Добавлен параметр `--gpus`, позволяющий указать количество графических процессоров у виртуальной машины.


#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> cluster get`.

  Улучшен вывод информации о кластере.
* Команда `yc <имя сервиса управляемой БД> cluster create`.

  Добавлен параметр `--backup-window-start`, позволяющий при создании кластера настроить время его ежедневного резервного копирования.

**Managed Service for ClickHouse®**

* Команда `yc managed-clickhouse cluster add-zookeeper`.

  Добавлена возможность добавлять хосты ZooKeeper.
* Команда: `yc managed-clickhouse shards add`.

  Изменена логика создания шардов:
  * Если не указан параметр `--host`, параметры для шарда копируются из самого старого шарда.
  * Если указан параметр `--host`, требуется введение всех параметров.
  * Если шарды отсутствуют, для создания шарда также требуется введение всех параметров.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._