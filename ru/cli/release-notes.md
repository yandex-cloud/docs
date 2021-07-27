---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Релизы YC CLI

## Версия 0.79.0 (13.07.21) {#latest-release}

### Изменения в сервисах {{ yandex-cloud }}

### {{ cloud-logging-name }} {#logging}

Добавлена поддержка сервиса {{ cloud-logging-name }}.

{{ cloud-logging-name }} — сервис для чтения и записи логов сервисов и пользовательских приложений.

Сервис {{ cloud-logging-name }} находится на стадии [Preview](../overview/concepts/launch-stages.md). Подробнее о сервисе читайте в [документации](../logging/).

### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless function set-scaling-policy` для задания настроек масштабирования функции.
* Добавлена команда `yc serverless function list-scaling-policies` для просмотра настроек масштабирования функции.
* Добавлена команда `yc serverless function remove-scaling-policy` для удаления настроек масштабирования функции.
* Команда `yc serverless function version create`.

  Исправлена обработка директорий для флага `--source-path` на Windows.

### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команда `yc managed-clickhouse cluster update`.

    Добавлен флаг `--cloud-storage` для включения хранения данных в {{ objstorage-name }}.

## Предыдущие релизы {#previous-releases}

### Версия 0.78.0 (29.06.21) {#version0.78.0}

#### {{ managed-k8s-name }} {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлен флаг `--network-acceleration-type`, который позволяет указать для группы узлов тип сети: стандартная или программно-ускоренная.

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

  Добавлен флаг `--service-type` для получения логов Kibana.

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлен флаг `--service-account`.

**{{ mkf-name }}**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.

  Добавлены флаги `--num-partitions` и `--default-replication-factor` для задания и изменения конфигурационных настроек брокеров Kafka.

**{{ mrd-name }}**

* Команды `yc managed-redis cluster create\update`.

  Добавлены флаги `--slowlog-log-slower-than`, `--slowlog-max-len`, `--databases` и `--notify-keyspace-events` (см. описание в redis.conf).

### Версия 0.76.0 (19.05.21) {#version0.76.0}

**{{ mpg-name }}**

* Команда `yc managed-postgresql cluster update`.

  Добавлен флаг `--serverless-access` для доступа к хостам кластера Managed Service for PostgreSQL из функции Cloud Functions.

**{{ vpc-name }}**

* Добавлена команда `yc vpc address move` для перемещения адреса между каталогами облака.

**{{ compute-name }}**

* Команда `yc compute instance-group`.

  В вывод групп добавлено отображение статуса группы.

### Версия 0.75.0 (13.04.21) {#version0.75.0}

#### Изменения в сервисах {{ yandex-cloud }}

#### {{ compute-name }} {#compute}

* Команда `yc compute create-with-container`.

  Добавлен флаг `--gpus`, который позволяет создать Container Optimized Image с GPU.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mrd-name }}**

* Команда `yc managed-redis cluster create`.

  Добавлен ключ `--disk-type-id [local-ssd|network-ssd]`, который позволяет выбрать тип диска.

**{{ mmy-name }}**

* Команда `yc managed-mysql cluster list-logs`.

  Теперь логи по умолчанию выводятся в необработанном формате (AS IS). Чтобы включить старый формат логов, используйте флаг `--format=yaml`.

**{{ mes-name }}**

* Команды `yc managed-elasticsearch cluster create` и `yc managed-elasticsearch cluster update`.

  Добавлены флаги управления паролем адинистратора кластера (пользователь `admin`):

  * `--admin-password`, который позволяет вручную задать пароль;
  * `--generate-admin-password`, который позволяет автоматически сгенерировать пароль;
  * `--read-admin-password`, который позволяет задать пароль из файла.

* Удалены команды `yc managed-elasticsearch user`. Управление пользователями теперь доступно нативными средствами Elasticsearch через пользователя `admin`.

* Команда `yc managed-elasticsearch create`.

  Добавлен флаг `--edition [basic|gold|platinum]`, который позволяет указать редакцию {{ ES }} при создании кластера

**{{ mkf-name }}**

* Команда `yc managed-kafka cluster create`.

  Добавлен флаг `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.

#### {{ dataproc-name }} {#dataproc}

* Команда `yc dataproc cluster create`.

  Добавлен флаг `--host-group-ids`, контролирующий размещение кластера на выделенных серверах.

### Версия 0.74.0 (29.03.21) {#version0.74.0}

* Добавлена поддержка платформ macOS/arm64 (Apple Silicon M1) и linux/arm64.

#### Изменения в сервисах {{ yandex-cloud }}

#### {{ dataproc-name }} {#dataproc}

* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.

  Добавлен флаг `--security-group-ids`, который позволяет установить набор групп безопасности для кластера.

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

  Добавлены значения по умолчанию для флагов:
  * `--execution-timeout` – три секунды;
  * `--memory` – 128 МБ.

* Команда `yc serverless function version create`.

  Добавлен флаг `--add-service-account` для указания дополнительных сервисных аккаунтов к версии.

#### {{ cloud-logs-name }} {#logs}

* Добавлена команда `yc logs`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mkf-name }}**

* Команда `yc managed-kafka cluster create`.

  Для флагов `--disk-size`, `--disk-type`, `--resource-preset`, `--zookeeper-disk-size`, `--zookeeper-disk-type` и `--zookeeper-resource-preset` теперь не указываются значения по умолчанию. Если значения не указаны, будут применяться значения по умолчанию, задаваемые на сервере.

* Команда `yc managed-kafka cluster create`.

  Добавлен флаг `--unmanaged-topics`, позволяющий включить управление топиками {{ KF }} через AdminAPI.

  Добавлен флаг `--auto-create-topics-enable`, позволяющий включить автоматическое создание топиков {{ KF }}.

* Команда `yc managed-kafka user create`.

  Добавлена роль `admin`, позволяющая включить управление топиками кластера {{ KF }} через AdminAPI.

**{{ mrd-name }}**

* Команда `yc managed-redis cluster create`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера {{ RD }}.

* Команда `yc managed-redis cluster restore`.

  Добавлен флаг `--enable-tls`, который позволяет включить TLS при создании кластера {{ RD }} из резервной копии.

### Версия 0.72.0 (11.02.21)

#### Изменения в сервисах {{ yandex-cloud }}

#### {{ alb-name }} {#alb}

Добавлена первичная поддержка сервиса {{ alb-name }}:
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

    Добавлен флаг `--placement-group` позволяющий указать `placement policy group` для группы узлов при создании.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

  Для флага `--postgresql-version string` добавлено значение `13` для создания кластера {{ PG }} версии 13.

**{{ mmy-name }}**

* Команда `yc managed-mysql cluster update`.

  Добавлен флаг `--mysql-version`, позволяющий обновить версию MySQL-сервера.

**{{ mes-name }}**

* Добавлены команды `yc managed-elasticsearch hosts create` и `yc managed-elasticsearch hosts delete` для добавления и удаления хостов.

**{{ mms-name }}**

Добавлена первичная поддержка сервиса {{ mms-name }}: 
* Команды группы `yc managed-sqlserver cluster` позволяют управлять кластерами. 
* Команды группы `yc managed-sqlserver database` позволяют управлять базами данных. 
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

**{{ mmy-name }}, {{ mpg-name }}, {{ mch-name }}, {{ mrd-name }}, {{ mmg-name }}, {{ mkf-name }}**

- Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update` и `yc <имя сервиса управляемой БД> cluster restore`.

    Флаг `--security-group-ids` позволяет установить для кластера набор групп безопасности.

**{{ mkf-name }}**

* Команды `yc managed-kafka cluster create` и `yc managed-kafka cluster update`.
  
  Добавлены флаги для задания и изменения конфигурационных настроек Kafka брокеров: `--compression-type`, `--log-flush-interval-messages`, `--log-flush-interval-ms`, `--log-flush-scheduler-interval-ms`, `--log-retention-bytes`, `--log-retention-hours`, `--log-retention-minutes`, `--log-retention-ms`, `--log-segment-bytes`, `--log-preallocate`.


* Команды `yc managed-kafka topic create` и `yc managed-kafka topic update`.
  
  Добавлены флаги для задания и изменения настроек топика: `--cleanup-policy`, `--compression-type`, `--delete-retention-ms`, `--file-delete-delay-ms`, `--flush-messages`, `--flush-ms`, `--min-compaction-lag-ms`, `--retention-bytes`, `--retention-ms`, `--max-message-bytes`, `--min-insync-replicas`, `--segment-bytes`, `--preallocate`.


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

- Команда `yc managed-mysql user grant-permission`.

    Флаг `--permissions` поддерживает привилегию `REFERENCES`.

**{{ mmy-name }}, {{ mpg-name }}**

- Команда `yc <имя сервиса управляемой БД> cluster update`.

    Добавлен флаг `--websql-access` для управления доступом из [консоли управления]({{ link-console-main }}).

### Версия 0.68.0 (03.11.20) {#version0.68.0}

#### Изменения в сервисах {{ yandex-cloud }}

#### {{ compute-name }} {#compute}

* Добавлена возможность указать размер блока для дисков при создании виртуальной машины.

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
  * `--enable-sql-database-management` — включает управление базами данных через SQL.
  * `--enable-sql-user-management` — включает управление пользователями и правами доступа через SQL.

**{{ mmy-name }}**

* Команда `yc managed-mysql user grant-permission`.
  Добавлен флаг `--permissions`, который поддерживает привилегии `ALL_PRIVILEGES` (синоним для `ALL`).

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.
  Добавлены флаги `--cluster-ipv6-range`, `--dual-stack` и `--service-ipv6-range`, которые позволяют создавать кластеры {{ k8s }} с параллельным использованием IPv4 и IPv6.

* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.
  Добавлен флаг `--security-group-ids`, который устанавливает для кластера группу безопасности.

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.
  Добавлен флаг `--network-interface`, который позволяет более детально задавать сетевые спецификации для узлов. Например, управлять настройкой групп безопасности для сетевых интерфейсов и настраивать интерфейсы узлов для параллельного использования IPv4 и IPv6 в кластерах {{ k8s }}.


### Версия 0.67.0 (05.10.20) {#version0.67.0}

#### Изменения в сервисах {{ yandex-cloud }}

#### {{ compute-name }} {#compute}

**Исправлено**

* Исправлена ошибка, при которой не получалось добавить виртуальную машину в существующую группу размещения.

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
  Добавлен пример использования флага `--recovery-target-timestamp`.

### Версия 0.65.0 (22.09.20) {#version0.65.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ dataproc-name }} {#dataproc}

Добавлена поддержка функциональности UI Proxy:
* Добавлена команда `yc dataproc cluster list-ui-links`, позволяющая получить список ссылок для доступа к интерфейсам кластера {{ dataproc-name }}.
* Команды `yc dataproc cluster create` и `yc dataproc cluster update`.
  Добавлен параметр  `--ui-proxy`, позволяющий включить функциональность UI Proxy для кластера {{ dataproc-name }}.
* Команды `yc dataproc cluster create`, `yc dataproc subcluster create`, `yc dataproc subcluster update`.
  Добавлены флаги для автомасштабируемых подкластеров: `--autoscaling-decommission-timeout`, `--cpu-utilization-target`, `--max-hosts-count`, `--measurement-duration`, `--preemptible`, `--stabilization-duration` и `--warmup-duration`.
* Команда `yc dataproc subcluster list`.
  В ответ добавлено поле `instance group id` с идентификаторами групп ВМ автомасштабируемых подкластеров.

#### {{ certificate-manager-name }} {#certificate-manager}

* Добавлена команда `yc certificate-manager certificate content` для получения содержимого сертификата.
  С ее помощью можно загрузить цепочку сертификатов и закрытый ключ для самостоятельного использования в конфигурации веб-сервера на виртуальной машине.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Команды  `{{ yc-mdb-mg }} cluster get` и `{{ yc-mdb-mg }} cluster update`.
  Добавлено поле `backup-retain-period-days`, показывающее сколько дней хранятся автоматические резервные копии.

* Команды  `{{ yc-mdb-mg }} cluster list-backups` и `{{ yc-mdb-mg }} backup list`.

    Добавлены поля `SIZE` и `TYPE`, содержащие размер и тип резервной копии.

* Команда `{{ yc-mdb-mg }} cluster list-logs`.

    Добавлен параметр `filter` позволяющий фильтровать запрашиваемые записи.

    Если задан параметр `follow`, то значение по умолчанию для параметра `limit` игнорируется. При этом явное указание параметра `limit` ограничивает количество выводимых записей.

### Версия 0.64.0 (08.09.20) {#version0.64.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Команда `yc compute instance-group`.
    - Добавлена возможность устанавливать и просматривать список ролей для группы виртуальных машин: `list-access-bindings`, `set-access-bindings`, `add-access-binding` и `remove-access-binding`.
    - Добавлены команды для удаления и остановки ВМ в группе виртуальных машин: `stop-instances`, `delete-instances`.

#### Сервисы управляемых баз данных {#managed-db}

* Команда `yc <имя сервиса управляемой БД> cluster list-logs` для всех управляемых БД использует новые методы API `StreamLogs` для стриминга логов.

    Всем командам добавлен флаг `--follow`, позволяющий получать новые записи логов по мере их появления.

**{{ mch-name }}**

* Добавлена команда `yc managed-clickhouse versions list` для получения списка версий, доступных для установки.
* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster restore`.

    Добавлен флаг `--cloud-storage` для включения хранения данных в {{ objstorage-full-name }}.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 4.4.

* Команды  `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster enable-sharding`.

    Для [шардированных](../managed-mongodb/concepts/sharding.md) кластеров появилась возможность задавать тип хоста: `mongoinfra`.

#### {{ certificate-manager-name }} {#certificate-manager}

Появилась поддержка сервиса для управления TLS-сертификатами: {{ certificate-manager-full-name }}.

С помощью {{ certificate-manager-full-name }} вы можете получать и обновлять TLS-сертификаты от Let’s Encrypt®, а также импортировать собственные сертификаты.
Сертификаты можно использовать в сервисах {{ yandex-cloud }} для обеспечения безопасности соединений.

Сервис {{ certificate-manager-full-name }} находится на стадии Preview. Подробнее про сервис читайте в [документации](../certificate-manager/).

### Версия 0.63.0 (28.08.20) {#version0.63.0}

#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена проблема с авторизацией для федеративных пользователей при инициализации нового профиля YC CLI.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ vpc-name }} {#vpc}

* Добавлена группа команд `yc vpc address` для управления [IP-адресами](../vpc/concepts/address.md#public-addresses).

### Версия 0.62.0 (20.08.20) {#version0.62.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless function version create`.

    - Добавлен флаг `--source-version-id` для указания базовой версии функции.
    - Добавлены флаги `--network-id` и `--network-name` для указания сети для версии функции, детальный список подсетей можно указать с помощью флагов `--subnet-id` и `--subnet-name`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**

* Команда `yc managed-mysql user update`

    Флаг `--global-permissions` позволяет выдать привилегию `PROCESS`.

**{{ mch-name }}, {{ mmy-name }}, {{ mpg-name }}, {{ mrd-name }}, {{ mmg-name }}**

* Команда `yc <имя сервиса управляемой БД> cluster update`.

    Добавлены флаги `--maintenance-window-anytime` и `--maintenance-window-weekly` для указания параметров окон обслуживания. Они будут использованы для планирования времени работ с кластером.

* Добавлена команда `yc <имя сервиса управляемой БД> cluster reschedule-maintenance` для управления запланированной задачей по обслуживанию кластера.

**{{ mmg-name }}**

* Команда `yc managed-mongodb cluster restore`.

    Добавлен флаг `--recovery-target-timestamp` для указания точки восстановления резервной копии.

### Версия 0.61.0 (03.08.20) {#version0.61.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

- Команда `yc managed-kubernetes cluster create`.

  Теперь значение флага `--version` корректно учитывается при создании регионального кластера.

##### {{ compute-name }} {#compute}

* Команда `yc compute instance update-network-interface`.

   Флаг `--security-group-id` теперь принимает список значений, разделенных запятыми.

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

   Добавлен флаг `--coi-spec-file` для передачи [спецификации образа](../cos/concepts/index.md#coi-spec-example).

##### {{ vpc-name }} {#vpc}

* Команды `yc vpc subnet create` и `yc vpc subnet update`.

   Флаги `--domain-name-server` и `--ntp-server` теперь принимают список значений, разделенных запятыми.

* Добавлена команда `yc vpc subnet list-used-addresses`.

   Команда выводит список используемых в подсети адресов.

### Версия 0.60.0 (20.07.20) {#version0.60.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ compute-name }} {#compute}

* Добавлена команда `yc compute instance update-network-interface`.

  Команда позволяет изменять параметры сетевого интерфейса на уже созданных виртуальных машинах.

##### {{ sf-name }} {#serverless-functions}

* Команда `yc serverless function logs`.

    Использование флага `--follow` теперь гарантирует получение журналов выполнения самой свежей версии функции с переданным тегом.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `yc managed-clickhouse cluster create`, `yc managed-clickhouse cluster update` и `yc managed-clickhouse cluster restore`

    Добавлен флаг `--service account` для выбора сервисного аккаунта, привязанного к хостам.
* Добавлены команды для управления группами шардов `yc managed-clickhouse shard-groups`.

### Версия 0.59.0 (02.07.20) {#version0.59.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ api-gw-name }} {#api-gw}

Появилась поддержка сервиса {{ api-gw-full-name }}.

{{ api-gw-full-name }} — сервис для управления API-шлюзами, поддерживающий спецификацию [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification) и набор расширений для взаимодействия с другими облачными сервисами.

Сервис {{ api-gw-full-name }} находится на стадии Preview. Подробнее о сервисе читайте в [документации](https://cloud.yandex.ru/docs/api-gateway/).

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

    Добавлены флаги для настройки опций DHCP: `--domain-name`, `--domain-name-server` и `--ntp-server`.

##### {{ managed-k8s-name }} {#k8s}

* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

    Добавлен флаг `--gpus=GPUS` для указания количества GPU, которые будут на узлах.

##### {{ container-registry-name }} {#container-registry}

* Добавлены команды для управления политиками автоматического удаления Docker-образов `yc container repository lifecycle-policy`.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлены команды для управления метками `yc managed-mysql cluster add-labels` и `yc managed-mysql cluster remove-labels`.

**{{ mrd-name }}**

* Добавлена поддержка {{ RD }} версии 6.

### Версия 0.57.0 (26.05.20) {#version0.57.0}

#### Изменения в CLI {#cli}

**Исправлено**

* Исправлена работа Docker Credential helper с HTTPS-адресами. Теперь возможно получить аутентификационные данные для адреса вида `https://cr.yandex`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create container-registry` создания триггеров для {{ container-registry-name }}.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes node-group create`.

  Изменена платформа и количество ядер, используемые по умолчанию при создании группы узлов. Теперь используется платформа Intel Cascade Lake (`standard-v2`) в двухъядерной конфигурации `cores: 2`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Добавлена команда `{{ yc-mdb-ch }} format-schema`.

  Команда дает возможность управления  Cap'n Proto и Protobuf схемами в кластере {{ CH }}.

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

**{{ mrd-name }}**

* Команда `yc managed-redis host list`.

    В выводе появились столбцы со значениями `type` и `shard_name`.

##### {{ coi }} {#coi}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

  При передаче файла с переменными окружения через флаг `--container-env-file` корректно обрабатываются символы `=` в значениях переменных.

### Версия 0.55.0 (13.04.20) {#version0.55.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Поддержана аутентификация при использовании `http_proxy`.
* Добавлено автодополнение для командной оболочки `zsh`.
* При завершении выполнения операции комбинацией клавиш **Ctrl**+**C** `yc` выводит информацию о запущенной операции.

**Исправлено**

* Исправлено ожидание в 30 секунд, если в используемом профиле не задано свойство `folder-id` или `folder-name`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--node-ipv4-mask-size` для настройки размера `CIDR`, выделяемых на каждый узел кластера.
* Команды `yc managed-kubernetes node-group create` и `yc managed-kubernetes node-group update`.

  Добавлены флаги `--max-unavailable` и `--max-expansion` для контроля количества удаляемых и создаваемых узлов в процессе обновления группы.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}, {{ mpg-name }}, {{ mmy-name }}**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster restore`, `yc <имя сервиса управляемой БД> host add`.

  Добавлено свойство `subnet-name` к флагу `--host` для указания подсети по имени.

**{{ mmg-name }}, {{ mch-name }}, {{ mrd-name }}**

* Команда `yc <имя сервиса управляемой БД> cluster list-logs`.

    Добавлено форматирование строчек лога.

#### {{ coi }} {#coi}

* Команда `yc compute instance create-with-container`.

    Добавлена возможность монтирования `docker volumes` в Docker-контейнер, созданный в {{ coi }} с помощью флагов `container-volume-tmpfs` и `container-volume-host-path`.
* Команда `yc compute instance update-container`.

    Добавлена возможность обновления `docker volumes` в Docker-контейнере, созданном в {{ coi }}.

### Версия 0.54.0 (24.03.20) {#version0.54.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Стали более понятными сообщения, при ошибках ввода команд и флагов.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

  Добавлены флаги `--kms-key-id` и `--kms-key-name` для создания кластера {{ k8s }} с шифрованием секретов в KMS

### Версия 0.53.0 (04.03.20) {#version0.53.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске `yc` на виртуальной машине внутри {{ yandex-cloud }}, если в конфиге `yc` не указан `folder-id`, то будет использоваться каталог, в котором создана виртуальная машина.
* Добавлен флаг `--version`, в дополнение к команде `yc version`.

**Исправлено**

* Исправлено обновление через `yc components update` на WSL 1.
* Исправлено аварийное завершение при вызове команды `yc help`.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

##### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster get-credentials`.

  Добавлена проверка и выдача предупреждения, если у пользователя установлена утилита `kubectl` версии ниже 1.11, такие версии не поддерживают способ аутентификации, который задаётся данной командой.

##### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} user`.

  Добавлена возможность управлять квотами пользователей.

* Команда `{{ yc-mdb-ch }} cluster`.

  Добавлены флаги `metrica-access`, `datalens-access` и `websql-access` в команды создания, восстановления и редактирования кластеров.

* Добавлены команды `{{ yc-mdb-ch }} ml-model`.

  Позволяет управлять ML моделями в кластере Clickhouse.

**{{ mmg-name }}, {{ mpg-name }}, {{ mmy-name }}, {{ mrd-name }}**

* Команды `yc <имя сервиса управляемой БД> cluster create`, `yc <имя сервиса управляемой БД> cluster update`, `yc <имя сервиса управляемой БД> cluster restore`.

  Добавлен флаг `datalens-access`, регулирующий доступ Yandex.DataLens к кластеру.

### Версия 0.52.1 (21.02.20) {#version0.52.1}

#### Изменения в CLI {#cli}

**Исправлено**

* При установке не пишется WARN  о, на самом деле, несуществующей проблеме.

### Версия 0.52.0 (21.02.20) {#version0.52.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске `yc` с флагом `--help` или `-h`, помощь открывается в интерактивном режиме:
  в `less` (`$PAGER`) на linux и macOS, в `more` на windows. Это убирает необходимость отматывать вывод помощи наверх.

* Debug логи выполнения и взаимодействия с API теперь сохраняются не в директорию установки, а в директорию конфигурации
  `$HOME/.config/yandex-cloud/logs`. Это устраняет проблему, когда `yc`, установленный как отдельный бинарный файл,
  неожиданно сохранял лог рядом и мог не иметь на это прав.
* Debug логи сохраняются и в случае успешных запросов. В случае обращения в поддержку по поводу проблемы возникшей
  в процессе выполнения команды `yc`, вероятно, мы сможем помочь быстрее, если вы приложите сохраненный лог.

**Исправлено**
* Во время выполнения команд `yc components ...` не выводится предложение обновиться.


#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Команда `yc compute instance create`.

  В флаг `--network-interface` добавлен параметр `nat-address`, позволяющий указать создаваемому инстансу конкретный NAT-адрес.

* Добавлены команды `yc compute instance add-one-to-one-nat` и `yc compute instance remove-one-to-one-nat`.

  Команды позволяют управлять NAT на уже созданных инстансах.

* Команды `yc compute instance create` и `yc compute instance update`.

  Добавлен флаг `--network-settings`, с помощью которого можно изменить тип сети на `Software accelerated` и обратно в `Standard`.

#### {{ kms-name }} {#kms}

* Команда `yc kms symmetric-key`.

  Добавлены команды, позволяющие управлять ролями на отдельные ключи:
  `list-access-bindings`, `set-access-bindings`, `add-access-binding`, `remove-access-binding`.

#### {{ managed-k8s-name }} {#k8s}
* Команда `yc managed-kubernetes cluster create`.

  Добавлен флаг `--enable-network-policy` для создания кластера Kubernetes с поддержкой
  [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/).

* Команда `yc k8s cluster get-credentials`.

  Добавлен флаг `--context-name`, позволяющий пользователю указать имя создаваемого `context` в `kubeconfig`.

  Имя создаваемого контекста по умолчанию стало более понятным: `yc-<cluster-name>`.

  Выводится пояснение результата выполнения.


### Версия 0.51.0 (12.02.20) {#version0.51.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Команды `yc <сервис> <ресурс> create`.

  Добавлена возможность передавать имя ресурса как аргумент команды. Теперь команды вида `yc <сервис> <ресурс> create --name <имя ресурса>` и `yc <сервис> <ресурс> create <имя ресурса>` равнозначны.

  Например, вместо команды `yc managed-kubernetes cluster create --name my-cluster ...` теперь можно использовать команду `yc managed-kubernetes cluster create my-cluster ...`.

* Команды `yc <сервис> <ресурс> set-access-binding`.

  Добавлено предупреждение, что команда удаляет назначеные роли. Если команда вызвана пользователем напрямую (а не с помощью другой команды или скрипта), будет запрошено подтверждение.

**Исправлено**

* Команда `yc init`.

  Теперь значения флагов `--cloud-id`, `--folder-id` и `--folder-name` учитываются корректно.

* Отключены сообщения о наличии новой версии `yc` при неинтерактивном вызове команды.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{iam-name}} {#iam}
* Добавлены команды для создания и управления SAML-совместимыми федерациями удостоверений и сертификатами к ним: `yc iam federation` и `yc iam certificate`. Подробнее про SAML-совместимые федерации удостоверений можно узнать в [документации](https://cloud.yandex.ru/docs/iam/concepts/users/identity-federations).

### Версия 0.50.0 (27.01.20) {#version0.50.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

* Для [ресурсов, на которые можно назначать роли](../iam/concepts/access-control/resources-with-access-control.md).

    Добавлены альтернативы флагу `--subject` для команд управления ролями: `--service-account-id`, `--service-account-name`, `--user-account-id`, `--user-yandex-login` и `--all-authenticated-users`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes node-group create`.

    Добавлен флаг `--auto-scale`, позволяющий создать группу узлов динамического размера под управлением [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler#cluster-autoscaler).

#### {{ compute-name }} {#compute}

* Команда `yc compute instance create`.

  При указании флага `--gpus` автоматически выбирается платформа `gpu-standard-v1`.

### Версия 0.49.0 (21.01.20) {#version0.49.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При запуске YC CLI с флагом `--debug`, строка лога ответа API-вызова теперь выводит не только gRPC-код статуса, но и его описание.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ kms-name }} {#kms}

Появилась поддержка сервиса для управления криптографическими ключами: {{ kms-full-name }}.

{{ kms-full-name }} (KMS) позволяет создавать ключи шифрования и организовывать схемы защиты данных в ваших приложениях и сервисах.
Используйте ключи, чтобы защитить секреты, личные данные и другую конфиденциальную информацию, которую вы храните в облаке.

Сервис {{ kms-full-name }} находится на стадии Preview. Подробнее про сервис читайте в [документации](https://cloud.yandex.ru/docs/kms/).

### Версия 0.48.0 (27.12.19) {#version0.48.0}

#### Изменения в CLI {#cli}

**Улучшено**
* При обновлении YC CLI теперь выводится текущая устанавливаемая версия.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Добавлена возможность работы с группой размещения `yc compute placement-group --help`.
* Команды `yc compute instance create` и `yc compute instance update`.

    Флаг для указания платформы переименован с `--platform-id` на `--platform`. Старое именование продолжает поддерживаться.
* Команда `yc compute instance create`.

    SSH-ключ, добавленный с помощью флага `--ssh-key`, записывается в метаданные с ключом `ssh-keys` вместо `ec2-user-data`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmy-name }}**

* Добавлена поддержка создания кластера с версией {{ MY }} 8.0.
* Добавлена команда для ручного переключения мастера для указанного кластера {{ MY }} `{{ yc-mdb-my }} cluster start-failover`.
* Команда `{{ yc-mdb-my }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mpg-name }}**

* Добавлена команда для ручного переключение мастера для указанного кластера {{ PG }} `{{ yc-mdb-pg }} cluster start-failover`.
* Команда `{{ yc-mdb-pg }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

**{{ mrd-name }}**

* Команда `{{ yc-mdb-rd }} cluster update`.

    Добавлена возможность переименовать кластер с помощью флага `--new-name`.

### Версия 0.47.0 (17.12.19) {#version0.47.0}

#### Изменения в CLI {#cli}
**Улучшено**

* Добавлена возможность [аутентификации с помощью федерации](operations/authentication/federated-user.md) при вызове `yc` в неинтерактивном режиме. Этот режим используется, когда CLI запускается пользователем не напрямую, например в скрипте или в `kubectl` при работе с [кластером Kubernetes](../managed-kubernetes/concepts/index.md#kubernetes-cluster) в {{ managed-k8s-name }}.

### Версия 0.46.0 (13.12.19) {#version0.46.0}

#### Изменения в CLI {#cli}

**Улучшено**
* Для ускорения диагностики проблем авторизации, в журнал отладки запроса пишется CRC32 отправляемого [IAM-токена](../iam/concepts/authorization/iam-token.md).

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ sf-name }} {#serverless-functions}

* Добавлена команда `yc serverless trigger create object-storage` для подписки на изменения бакета в {{ objstorage-name }}.

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

* Для Windows Subsystem for Linux (WSL) при авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../iam/concepts/users/identity-federations.md) теперь корректно происходит переход в браузер.

### Версия 0.43.0 (11.11.19) {#version0.43.0}

#### Изменения в CLI {#cli}

* Добавлена возможность авторизации в CLI с помощью [SAML-совместимых федераций удостоверений](../iam/concepts/users/identity-federations.md).

    Для этого выполните команду `yc init --federation-id=<FEDERATION_ID>`, после чего можно использовать CLI для работы от имени пользователя этой федерации.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Добавлены подробности в лог и в текст об ошибке при [авторизации изнутри виртуальной машины](../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) (с помощью IAM-токена из метаданных).

#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Добавлена поддержка создания баз {{ PG }} версии 12.

**{{ mmg-name }}**

* Добавлена поддержка создания кластера с версией {{ MG }} 4.2.

### Версия 0.42.0 (21.10.19) {#version0.42.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Добавлены команды `yc compute instance-group start`, `yc compute instance-group stop` для запуска и остановки группы виртуальных машин.

#### {{ container-registry-name }} {#container-registry}

* Команды `yc compute instance create-with-container` и `yc compute instance update-container`.

   Для значений "always", "never", "on-failure" флага `--container-restart-policy` добавлено альтернативное написание: "Always", "Never", "OnFailure".

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

    Удален флаг `--default-gateway-v4-address`.

#### Изменения в сервисах управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `yc managed-postgresql cluster create`, `yc managed-postgresql cluster update` и `yc managed-postgresql cluster restore`.

   Для флага `--postgresql-version string` добавлено значение `10_1с` для создания кластера {{ PG }} версии 10-1с.

### Версия 0.41.1 (26.09.19) {#version0.41.1}

* Небольшие исправления и обновления.

### Версия 0.41.0 (25.09.19) {#version0.41.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ container-registry-name }} {#container-registry}

* Команда `yc compute instance create-with-container`.

    Из флага `--create-boot-disk` удалена поддержка параметров `snapshot-*`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster create`.

    Добавлены флаги для управления типом мастера: `--regional`, `--region` и `--master-location`.

* Команды `yc managed-kubernetes cluster create` и `yc managed-kubernetes cluster update`.

    Добавлены флаги для управления политикой обслуживания: `--auto-upgrade`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.

* Команда `yc managed-kubernetes node-groups update`.

    Добавлены флаги для управления политикой обслуживания: `--auto-upgrade`, `--auto-repair`, `--anytime-maintenance-window`, `--daily-maintenance-window` и `--weekly-maintenance-window`.


### Версия 0.40.0 (20.09.19) {#version0.40.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ container-registry-name }} {#container-registry}

* Добавлена команда для получения подробной информации о реестре: `yc container registry repository get`,
* Команда `yc container registry repository list`.

    Добавлен вывод уникального идентификатора реестра.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> create clusters`.

    Для флагов `--*resource-preset` добавлено значение по умолчанию: s2.micro.

**{{ mmg-name }}**

* Команда `{{ yc-mdb-mg }} create clusters`.

    Для флага `--mongodb-version` изменено значение по умолчанию: с 3.6 на 4.0.

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

* Добавлена проверка доступности эндпоинтов API {{ iam-short-name }}, {{ resmgr-short-name }}, {{ compute-short-name }}. Если эндпоинт недоступен, выдается ошибка.
* Добавлено отображение деталей ошибок.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ container-registry-name }} {#container-registry}

**Улучшено**

* Добавлена поддержка ОС Windows для работы с Docker Credential helper.
* Добавлена подробная ошибка при использовании `docker login` одновременно с Docker Credential helper.

#### {{ ig-name }} {#instance-groups}

* Добавлены команды для управления метаданными группы виртуальных машин: `yc compute instance-group add-metadata` и `yc compute instance-group remove-metadata`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster update`.

    Добавлены флаги `--node-service-account-id` и `--node-service-account-name`, позволяющие добавить или изменить сервисный аккаунт для узлов у существующего кластера {{ k8s }}.

* Команда `yc managed-kubernetes node-group update`.

    Добавлены флаги для изменения параметров существующей группы узлов: `--metadata`, `--metadata-from-file`, `--platform-id`, `--memory`, `--cores`, `--core-fraction`, `--disk-type`, `--disk-size`, `--preemptible`.

* Добавлены команды для управления метками: `yc managed-kubernetes node-group add-labels` и `yc managed-kubernetes node-group remove-labels`.

* Добавлены команды для управления метаданными группы узлов: `yc managed-kubernetes node-group add-metadata` и `yc managed-kubernetes node-group remove-metadata`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команда `{{ yc-mdb-pg }} cluster update`.

    Добавлен флаг `--connection-pool-discard` для отключения менеджера подключений.

* Команды `{{ yc-mdb-pg }} user create` и `yc managed-postgresql user update`.

    Добавлена возможность указать логин и задать права доступа для пользователя с помощью флагов `--login` и `--grants`.

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

    Для флага `--user` добавлены параметры: `permission`, `conn-limit`, `default-transaction-isolation`, `lock-timeout`, `log-min-duration-statement`, `synchronous-commit`, `temp-file-limit`, `log-statement`.

### Версия 0.34.0 (26.07.19) {#version0.34.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mrd-name }}**

* Команда `{{ yc-mdb-rd }} shards`.

    Добавлена поддержка шардов для Redis-кластеров.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster add-external-dictionary`.

    Добавлена поддержка словарей PostgreSQL. Флаги для работы со словарями: `--postgresql-source`, `--postgresql-source-hosts` и `--postgresql-invalidate-query`.

**{{ mmy-name }}**

* Команда `{{ mmy-name }} cluster update-config --set`

    Добавлена возможность глобально задать режим SQL с помощью параметра `sql_mode`.

### Версия 0.33.0 (19.07.19) {#version0.33.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Индикатор прогресса выполнения команды изменен с точек на [троббер](https://ru.wikipedia.org/wiki/Троббер).

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mpg-name }}**

* Команды `{{ yc-mdb-pg }} user create` и `{{ yc-mdb-pg }} user update`.

    Добавлена настройка параметров пользователя с помощью флагов `--lock_timeout`, `--log_min_duration_statement` и т. д.

### Версия 0.32.0 (05.07.19) {#version0.32.0}

#### Изменения в CLI {#cli}

**Улучшено**

* Команды для отображения списка элементов `yc <сервис> <ресурс> list`.

   Увеличено максимальное число элементов в выводе со 100 до 1000.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### Сервисы управляемых баз данных {#managed-db}

**{{ mmg-name }}**

* Команды  `{{ yc-mdb-mg }} cluster update` и `{{ yc-mdb-mg }} cluster update-config`.

    Для [шардированных](../managed-mongodb/concepts/sharding.md) клаcтеров появилась возможность изменять параметры компонентов `mongos` и `mongocfg`.

### Версия 0.31.0 (01.07.19) {#version0.31.0}

#### Изменения в CLI {#cli}

**Улучшено**

* При использовании CLI на виртуальной машине, запущенной от имени сервисного аккаунта, по умолчанию CLI будет авторизовываться от имени этого сервисного аккаунта.

**Исправлено**

* Попытка получить ресурс, указав его уникальный идентификатор, завершалась с ошибкой, если в конфигурации CLI не был задан параметр `folder-id`.

* Попытка получить каталог, указав его уникальный идентификатор, завершалась с ошибкой, если у пользователя не было роли `viewer` на каталог в {{ yandex-cloud }}.

* Команда `yc init` завершалась с ошибкой, если у пользователя не было роли `viewer` в {{ yandex-cloud }}.

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ network-load-balancer-name }} {#load-balancer}

* Команды `yc load-balancer network-load-balancer create` и `yc load-balancer network-load-balancer update`.

    Для флага `--listener`  появилась возможность задать параметр `target-port`, позволяющий настроить NAT так, чтобы целевые ресурсы принимали трафик на порту, отличном от порта `listener`.

#### Сервисы управляемых баз данных {#managed-db}

**{{ mch-name }}**

* Команды `{{ yc-mdb-ch }} user create` и `{{ yc-mdb-ch }} user update`.

    Добавлен флаг `--settings`, позволяющий задать пользовательские настройки.

### Версия 0.30.0 (18.06.19) {#version0.30.0}

#### Изменения в сервисах {{ yandex-cloud }} {#services}

#### {{ compute-name }} {#compute}

* Команда `yc compute instance update`.

    Добавлены флаги `--service-account-id` и `--service-account-name`, позволяющие добавить или изменить сервисный аккаунт для существующей виртуальной машины.

* Команда `yc compute instance create`.

    Изменено количество ядер, используемое по умолчанию при создании виртуальной машины с платформой Intel Cascade Lake (`standard-v2`). Теперь `cores: 2`.

#### {{ managed-k8s-name }} {#k8s}

* Команда `yc managed-kubernetes cluster update`.

    Добавлен флаг `--default-gateway-v4-address`, позволяющий обновить адрес шлюза для существующего {{ k8s }} кластера.

### Версия 0.29.0 (11.06.19) {#version0.29.0}

* Небольшие исправления и обновления.

### Версия 0.28.0 (05.06.19) {#version0.28.0}

#### Изменения в CLI {#cli}

* Добавлено автоматическое повторное подключение в случае недоступности любого ресурса, задействованного в выполнении команды. CLI повторит попытку соединения 5 раз, частота повтора вычисляется с помощью экспоненциального откладывания (exponential backoff).

#### Изменения в сервисах {{ yandex-cloud }} {#services}

####  {{ compute-name }} {#compute-cloud}

* Команда `yc compute instance create`.

    Добавлен флаг `--gpus`, позволяющий указать количество графических процессоров у виртуальной машины.

#### Сервисы управляемых баз данных {#managed-db}

**Все сервисы управляемых БД**

* Команда `yc <имя сервиса управляемой БД> cluster get`.

    Улучшен вывод информации о кластере.

* Команда `yc <имя сервиса управляемой БД> cluster create`.

    Добавлен флаг `--backup-window-start`, позволяющий при создании кластера настроить время его ежедневного резервного копирования.

**{{ mch-name }}**

* Команда `{{ yc-mdb-ch }} cluster add-zookeeper`.

    Добавлена возможность добавлять хосты ZooKeeper.

* Команда: `{{ yc-mdb-ch }} shards add`.

    Изменена логика создания шардов:
    - Если не указан флаг `--host`, параметры для шарда копируются из самого старого шарда.
    - Если указан флаг `--host`, требуется введение всех параметров.
    - Если шарды отсутствуют, для создания шарда также требуется введение всех параметров.
