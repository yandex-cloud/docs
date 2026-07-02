[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Console](../index.md) > Пошаговые инструкции > Поиск в консоли управления

# Поиск в консоли управления

## Найти ресурсы и информацию {#seek}

Чтобы найти облачные ресурсы, разделы документации и получить справочную информацию, вы можете использовать поиск:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом верхнем углу [консоли управления](https://console.yandex.cloud) нажмите ![image](../../_assets/console-icons/magnifier.svg) **Поиск** или клавиши **ALT** + **S**.
  1. Выберите область поиска:

      * `Везде` — все доступные [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) и документация.
      * `Ресурсы` — [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder) всех облаков или конкретного облака.
      * `Документация` — только документация.

  1. В поле **Поиск по облачным ресурсам** введите поисковый запрос.

      Вы увидите результаты поиска в сервисах, каталогах и документации, а также ответ, сформированный Yandex Search API и YandexGPT.

      Чтобы скопировать ссылку на результаты поиска, нажмите значок ![image](../../_assets/console-icons/link.svg).

{% endlist %}


## Объекты и поля поиска {#objects-and-fields}

Поиск в каталогах происходит по определенным типам объектов и полям.


### Yandex API Gateway {#api-gw}

Тип объекта | Поля
--- | ---
[API-шлюз](../../api-gateway/concepts/index.md) | Домен, идентификатор, имя


### Yandex Application Load Balancer {#alb}

Тип объекта | Поля
--- | ---
[HTTP-роутер](../../application-load-balancer/concepts/http-router.md) | Идентификатор, имя
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Внутренний IP-адрес, идентификатор, имя, публичный IPv4-адрес, публичный IPv6-адрес
[Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) | Идентификатор, имя
[Целевая группа](../../application-load-balancer/concepts/target-group.md) | Идентификатор, имя


### Yandex Audit Trails {#at}

Тип объекта | Поля
--- | ---
[Трейл](../../audit-trails/concepts/trail.md) | Идентификатор, имя


### Yandex Cloud CDN {#cdn}

Тип объекта | Поля
--- | ---
[CDN-ресурс](../../cdn/concepts/resource.md) | Идентификатор, имя


### Yandex Cloud DNS {#dns}

Тип объекта | Поля
--- | ---
[Зона DNS](../../dns/concepts/dns-zone.md) | Зона, идентификатор, имя, метки


### Yandex Cloud Functions {#functions}

Тип объекта | Поля
--- | ---
[Подключение к управляемой базе данных](../../functions/operations/database-connection.md) | Идентификатор, имя
[Функция](../../functions/concepts/function.md) | Идентификатор, имя


### Yandex Cloud Logging {#logging}

Тип объекта | Поля
--- | ---
[Лог-группа](../../logging/concepts/log-group.md) | Идентификатор, имя
[Приемник логов](../../logging/operations/create-sink.md) | Идентификатор, имя


### Yandex Cloud Postbox {#postbox}

Тип объекта | Поля
--- | ---
[Адрес](../../postbox/concepts/glossary.md#adress) | Идентификатор, имя


### Yandex Compute Cloud {#compute}

Тип объекта | Поля
--- | ---
[Виртуальная машина](../../compute/concepts/vm.md) | FQDN, идентификатор, имя, имя хоста, метки, описание
[Группа виртуальных машин](../../compute/concepts/instance-groups/index.md) | Идентификатор, имя, метки
[Диск](../../compute/concepts/disk.md) | Идентификатор, имя, описание
[ВМ с GPU](../../compute/concepts/gpus.md) | Идентификатор, имя
[Расписание](../../compute/concepts/snapshot-schedule.md) | Идентификатор, имя, описание
[Снимок диска](../../compute/concepts/snapshot.md) | Идентификатор, имя, метки, описание
[Файловое хранилище](../../compute/concepts/filesystem.md) | Идентификатор, имя, метки, описание


### Yandex Container Registry {#registry}

Тип объекта | Поля
--- | ---
[Реестр](../../container-registry/concepts/registry.md) | Идентификатор, имя
[Репозиторий](../../container-registry/concepts/repository.md) | Идентификатор, имя


### Yandex Data Processing {#dataproc}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, описание, хосты


### Yandex Identity and Access Management {#iam}

Тип объекта | Поля
--- | ---
[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) | Идентификатор, имя


### Yandex Key Management Service {#kms}

Тип объекта | Поля
--- | ---
[Асимметричная ключевая пара подписи](../../kms/concepts/asymmetric-signature-key.md) | Идентификатор, имя
[Асимметричная ключевая пара шифрования](../../kms/concepts/asymmetric-encryption-key.md) | Идентификатор, имя
[Симметричный ключ](../../kms/concepts/symmetric-encryption.md) | Идентификатор, имя


### Yandex Lockbox {#lockbox}

Тип объекта | Поля
--- | ---
[Секрет](../../lockbox/concepts/secret.md) | Идентификатор, имя


### Yandex Managed Service for Apache Airflow™ {#maf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Бакет, идентификатор, имя, описание, сервисный аккаунт, хосты


### Yandex Managed Service for Apache Kafka® {#mkf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, топики, хосты


### Yandex Managed Service for ClickHouse® {#mch}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### Yandex Managed Service for Elasticsearch {#mes}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### Yandex MPP Analytics for PostgreSQL {#mgp}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### Yandex Managed Service for Kubernetes {#k8s}

Тип объекта | Поля
--- | ---
[Группа узлов](../../managed-kubernetes/concepts/index.md#node-group) | Идентификатор, идентификатор кластера, имя
[Кластер](../../glossary/cluster.md) | Идентификатор, имя


### Yandex StoreDoc {#mmg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for MySQL® {#mmy}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### Yandex Managed Service for OpenSearch {#mos}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### Yandex Managed Service for PostgreSQL {#mpg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for Valkey™ {#mrd}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, хосты


### Yandex Managed Service for YDB {#ydb}

Тип объекта | Поля
--- | ---
[База данных](../../ydb/concepts/resources.md#database) | Идентификатор, имя


### Yandex Message Queue {#message-queue}

Тип объекта | Поля
--- | ---
[Очередь сообщений](../../message-queue/concepts/queue.md) | Идентификатор, имя


### Yandex MetaData Hub {#metadata-hub}

Тип объекта | Поля
--- | ---
[Кластер](../../metadata-hub/concepts/metastore.md) | Идентификатор, имя, описание, сервисный аккаунт, хосты


### Yandex Monitoring {#monitoring}

Тип объекта | Поля
--- | ---
[Алерт](../../monitoring/concepts/alerting/alert.md) | Идентификатор, имя, описание
[Дашборд](../../monitoring/concepts/visualization/dashboard.md) | Идентификатор, имя, описание
[Канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) | Идентификатор, имя, описание


### Yandex Network Load Balancer {#nlb}

Тип объекта | Поля
--- | ---
[Сетевой балансировщик](../../network-load-balancer/concepts/index.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, публичный IPv4-адрес
[Целевая группа](../../network-load-balancer/concepts/target-resources.md) | Идентификатор, имя, метки, описание


### Yandex Object Storage {#storage}

Тип объекта | Поля
--- | ---
[Бакет](../../storage/concepts/bucket.md) | Идентификатор, имя


### Yandex Serverless Containers {#containers}

Тип объекта | Поля
--- | ---
[Контейнер](../../serverless-containers/concepts/container.md) | Идентификатор, имя


### Yandex Virtual Private Cloud {#vpc}

Тип объекта | Поля
--- | ---
[IP-адрес](../../vpc/concepts/address.md) | IP-адрес, идентификатор, имя, описание
[NAT-инстанс](../../tutorials/routing/nat-instance/index.md) | Внутренний IP-адрес, идентификатор, идентификатор подсети, идентификатор публичного IPv4-адреса, имя, описание, публичный IPv4-адрес
[Группа безопасности](../../vpc/concepts/security-groups.md) | Идентификатор, имя, описание
[Облачная сеть](../../vpc/concepts/network.md#network) | Идентификатор, имя, описание
[Подсеть](../../vpc/concepts/network.md#subnet) | Идентификатор, имя, описание
[Таблица маршрутизации](../../vpc/concepts/routing.md) | Идентификатор, имя, описание
[Шлюз](../../vpc/concepts/gateways.md) | Идентификатор, имя, описание