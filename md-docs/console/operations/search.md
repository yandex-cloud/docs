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
[API-шлюз](../../api-gateway/concepts/index.md) | Идентификатор, имя, метки, описание, домен


### Yandex Application Load Balancer {#alb}

Тип объекта | Поля
--- | ---
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Идентификатор, имя, метки, описание, внутренний IP-адрес, публичный IPv4-адрес, публичный IPv6-адрес
[Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) | Идентификатор, имя, метки, описание
[Целевая группа](../../application-load-balancer/concepts/target-group.md) | Идентификатор, имя, метки, описание
[HTTP-роутер](../../application-load-balancer/concepts/http-router.md) | Идентификатор, имя, метки, описание


### Yandex Audit Trails {#at}

Тип объекта | Поля
--- | ---
[Трейл](../../audit-trails/concepts/trail.md) | Идентификатор, имя, метки, описание


### Yandex Certificate Manager {#certificate-manager}

Тип объекта | Поля
--- | ---
[Сертификат](../../certificate-manager/concepts/index.md) | Идентификатор, имя, домены, метки, описание


### Yandex Cloud Backup {#backup}

Тип объекта | Поля
--- | ---
[Политика резервного копирования](../../backup/concepts/policy.md) | Идентификатор, имя


### Yandex Cloud CDN {#cdn}

Тип объекта | Поля
--- | ---
[CDN-ресурс](../../cdn/concepts/resource.md) | Идентификатор, CNAME, метки


### Yandex Cloud DNS {#dns}

Тип объекта | Поля
--- | ---
[Зона DNS](../../dns/concepts/dns-zone.md) | Зона, идентификатор, имя, метки, описание
Эндпоинт | Идентификатор, имя, метки, описание
Файрвол | Идентификатор, имя, метки, описание


### Yandex Cloud Functions {#functions}

Тип объекта | Поля
--- | ---
[Подключение к управляемой базе данных](../../functions/operations/database-connection.md) | Идентификатор, имя, метки, описание
[Триггер](../../functions/concepts/trigger/index.md) | Идентификатор, имя, метки, описание
[Функция](../../functions/concepts/function.md) | Идентификатор, имя, метки, описание


### Yandex Cloud Logging {#logging}

Тип объекта | Поля
--- | ---
[Лог-группа](../../logging/concepts/log-group.md) | Идентификатор, имя, метки
[Приемник логов](../../logging/operations/create-sink.md) | Идентификатор, имя, метки


### Yandex Cloud Postbox {#postbox}

Тип объекта | Поля
--- | ---
[Адрес](../../postbox/concepts/glossary.md#address) | Идентификатор, адрес, метки, описание


### Yandex Cloud Registry {#cloud-registry}

Тип объекта | Поля
--- | ---
[Реестр](../../cloud-registry/concepts/registry.md) | Идентификатор, имя, метки, описание


### Yandex Compute Cloud {#compute}

Тип объекта | Поля
--- | ---
[Виртуальная машина](../../compute/concepts/vm.md) | Идентификатор, имя, метки, описание, FQDN, имя хоста, идентификатор подсети, внутренний IPv4-адрес, внутренний IPv6-адрес, публичный IPv4-адрес, публичный IPv6-адрес
[Выделенный хост](../../compute/concepts/dedicated-host.md) | Идентификатор, имя, метки, описание
[Группа виртуальных машин](../../compute/concepts/instance-groups/index.md) | Идентификатор, имя, метки, описание
[Группа размещения виртуальных машин](../../compute/concepts/placement-groups.md) | Идентификатор, имя, метки, описание
[Группа размещения нереплицируемых дисков](../../compute/concepts/disk-placement-group.md) | Идентификатор, имя, метки, описание
[Диск](../../compute/concepts/disk.md) | Идентификатор, имя, метки, описание
[Кластер GPU](../../compute/concepts/gpus.md#gpu-clusters) | Идентификатор, имя, метки, описание
[Образ](../../compute/concepts/image.md) | Идентификатор, имя, метки, описание
[Пул резервов виртуальных машин](../../compute/concepts/reserved-pools.md) | Идентификатор, имя, метки, описание
[Расписание](../../compute/concepts/snapshot-schedule.md) | Идентификатор, имя, метки, описание
[Снимок диска](../../compute/concepts/snapshot.md) | Идентификатор, имя, метки, описание
[Файловое хранилище](../../compute/concepts/filesystem.md) | Идентификатор, имя, метки, описание


### Yandex Container Registry {#registry}

Тип объекта | Поля
--- | ---
[Реестр](../../container-registry/concepts/registry.md) | Идентификатор, имя, метки
[Репозиторий](../../container-registry/concepts/repository.md) | Идентификатор, имя


### Yandex Data Processing {#dataproc}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, хосты


### Yandex Data Transfer {#data-transfer}

Тип объекта | Поля
--- | ---
[Трансфер](../../data-transfer/concepts/index.md#transfer) | Идентификатор, имя, метки, описание
[Эндпоинт](../../data-transfer/concepts/index.md#endpoint) | Идентификатор, имя, метки, описание


### Yandex Identity and Access Management {#iam}

Тип объекта | Поля
--- | ---
[Авторизованный ключ](../../iam/concepts/authorization/key.md) | Идентификатор, описание
[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) | Идентификатор, имя, метки, описание
[Статический ключ доступа](../../iam/concepts/authorization/access-key.md) | Идентификатор, идентификатор ключа, описание
[API-ключ](../../iam/concepts/authorization/api-key.md) | Идентификатор, описание


### Yandex Key Management Service {#kms}

Тип объекта | Поля
--- | ---
[Асимметричная ключевая пара подписи](../../kms/concepts/asymmetric-signature-key.md) | Идентификатор, имя, метки, описание
[Асимметричная ключевая пара шифрования](../../kms/concepts/asymmetric-encryption-key.md) | Идентификатор, имя, метки, описание
[Симметричный ключ](../../kms/concepts/symmetric-encryption.md) | Идентификатор, имя, метки, описание


### Yandex Lockbox {#lockbox}

Тип объекта | Поля
--- | ---
[Секрет](../../lockbox/concepts/secret.md) | Идентификатор, имя, метки, описание


### Yandex Managed Service for Apache Airflow™ {#maf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, сервисный аккаунт, бакет S3


### Yandex Managed Service for Apache Kafka® {#mkf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, топики, хосты


### Yandex Managed Service for ClickHouse® {#mch}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for GitLab {#gitlab}

Тип объекта | Поля
--- | ---
[Инстанс](../../managed-gitlab/concepts/index.md) | Идентификатор, имя, метки, описание


### Yandex Managed Service for Kubernetes {#k8s}

Тип объекта | Поля
--- | ---
[Группа узлов](../../managed-kubernetes/concepts/index.md#node-group) | Идентификатор, идентификатор кластера, имя, метки, описание
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание


### Yandex Managed Service for MySQL® {#mmy}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for OpenSearch {#mos}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, хосты


### Yandex Managed Service for PostgreSQL {#mpg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for Trino {#mtr}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, сервисный аккаунт


### Yandex Managed Service for Valkey™ {#mrd}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Managed Service for YDB {#ydb}

Тип объекта | Поля
--- | ---
[База данных](../../ydb/concepts/resources.md#database) | Идентификатор, имя, метки, описание
[Резервная копия](https://ydb.tech/docs/ru//devops/backup-and-recovery) | Идентификатор, имя, метки, описание


### Yandex Message Queue {#message-queue}

Тип объекта | Поля
--- | ---
[Очередь сообщений](../../message-queue/concepts/queue.md) | Идентификатор, имя, метки


### Yandex MetaData Hub {#metadata-hub}

Тип объекта | Поля
--- | ---
[Кластер](../../metadata-hub/concepts/metastore.md) | Идентификатор, имя, метки, описание, сервисный аккаунт


### Yandex Monitoring {#monitoring}

Тип объекта | Поля
--- | ---
[Алерт](../../monitoring/concepts/alerting/alert.md) | Идентификатор, имя, описание
[Дашборд](../../monitoring/concepts/visualization/dashboard.md) | Идентификатор, имя, описание
[Канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) | Идентификатор, имя, описание


### Yandex MPP Analytics for PostgreSQL {#mgp}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Network Load Balancer {#nlb}

Тип объекта | Поля
--- | ---
[Сетевой балансировщик](../../network-load-balancer/concepts/index.md) | Идентификатор, имя, метки, описание, внутренний IPv4-адрес, внутренний IPv6-адрес, публичный IPv4-адрес, публичный IPv6-адрес
[Целевая группа](../../network-load-balancer/concepts/target-resources.md) | Идентификатор, имя, метки, описание


### Yandex Object Storage {#storage}

Тип объекта | Поля
--- | ---
[Бакет](../../storage/concepts/bucket.md) | Идентификатор, имя, идентификатор ресурса, теги


### Yandex Resource Manager {#resource-manager}

Тип объекта | Поля
--- | ---
[Каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) | Идентификатор, имя, метки, описание
[Облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) | Идентификатор, имя, метки, описание


### Yandex Serverless Containers {#containers}

Тип объекта | Поля
--- | ---
[Контейнер](../../serverless-containers/concepts/container.md) | Идентификатор, имя, метки, описание


### Yandex Smart Web Security {#sws}

Тип объекта | Поля
--- | ---
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Идентификатор, имя, метки, описание
[Профиль ARL](../../smartwebsecurity/concepts/arl.md) | Идентификатор, имя, метки, описание
[Профиль WAF](../../smartwebsecurity/concepts/waf.md) | Идентификатор, имя, метки, описание
[Профиль безопасности](../../smartwebsecurity/concepts/profiles.md) | Идентификатор, имя, метки, описание
[Список совпадений](../../smartwebsecurity/concepts/conditions.md#match-list) | Идентификатор, имя, метки, описание


### Yandex SmartCaptcha {#captcha}

Тип объекта | Поля
--- | ---
[Капча](../../smartcaptcha/concepts/validation.md) | Идентификатор, имя, метки, описание


### Yandex StoreDoc {#mmg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### Yandex Virtual Private Cloud {#vpc}

Тип объекта | Поля
--- | ---
[IP-адрес](../../vpc/concepts/address.md) | Адрес, идентификатор, имя, метки, описание
[Группа безопасности](../../vpc/concepts/security-groups.md) | Идентификатор, имя, метки, описание
[Облачная сеть](../../vpc/concepts/network.md#network) | Идентификатор, имя, метки, описание
[Подсеть](../../vpc/concepts/network.md#subnet) | Идентификатор, имя, метки, описание, CIDR v4, CIDR v6
[Приватный эндпоинт](../../vpc/concepts/private-endpoint.md) | Идентификатор, имя, метки, описание
[Таблица маршрутизации](../../vpc/concepts/routing.md) | Идентификатор, имя, метки, описание
[Шлюз](../../vpc/concepts/gateways.md) | Идентификатор, имя, метки, описание