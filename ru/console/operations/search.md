# Поиск в консоли управления

## Найти ресурсы и информацию {#seek}

Чтобы найти облачные ресурсы, разделы документации и получить справочную информацию, вы можете использовать поиск:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В левом верхнем углу [консоли управления]({{ link-console-main }}) нажмите ![image](../../_assets/console-icons/magnifier.svg) **{{ ui-key.yacloud.common.search }}** или клавиши **ALT** + **S**.
  1. Выберите область поиска:

      * `{{ ui-key.yacloud_components.search.search_filters_all }}` — все доступные [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) и документация.
      * `Ресурсы` — [каталоги](../../resource-manager/concepts/resources-hierarchy.md#folder) всех облаков или конкретного облака.
      * `{{ ui-key.yacloud_components.search.search_filters_docs }}` — только документация.

  1. В поле **{{ ui-key.yacloud_components.search.label_placeholder }}** введите поисковый запрос.

      Вы увидите результаты поиска в сервисах, каталогах и документации, а также ответ, сформированный {{ search-api-full-name }} и {{ yagpt-name }}.

      Чтобы скопировать ссылку на результаты поиска, нажмите значок ![image](../../_assets/console-icons/link.svg).

{% endlist %}


## Объекты и поля поиска {#objects-and-fields}

Поиск в каталогах происходит по определенным типам объектов и полям.


### {{ api-gw-full-name }} {#api-gw}

Тип объекта | Поля
--- | ---
[API-шлюз](../../api-gateway/concepts/index.md) | Идентификатор, имя, метки, описание, домен


### {{ alb-full-name }} {#alb}

Тип объекта | Поля
--- | ---
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Идентификатор, имя, метки, описание, внутренний IP-адрес, публичный IPv4-адрес, публичный IPv6-адрес
[Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) | Идентификатор, имя, метки, описание
[Целевая группа](../../application-load-balancer/concepts/target-group.md) | Идентификатор, имя, метки, описание
[HTTP-роутер](../../application-load-balancer/concepts/http-router.md) | Идентификатор, имя, метки, описание


### {{ at-full-name }} {#at}

Тип объекта | Поля
--- | ---
[Трейл](../../audit-trails/concepts/trail.md) | Идентификатор, имя, метки, описание


### {{ certificate-manager-full-name }} {#certificate-manager}

Тип объекта | Поля
--- | ---
[Сертификат](../../certificate-manager/concepts/index.md) | Идентификатор, имя, домены, метки, описание


### {{ backup-full-name }} {#backup}

Тип объекта | Поля
--- | ---
[Политика резервного копирования](../../backup/concepts/policy.md) | Идентификатор, имя


### {{ cdn-full-name }} {#cdn}

Тип объекта | Поля
--- | ---
[CDN-ресурс](../../cdn/concepts/resource.md) | Идентификатор, CNAME, метки


### {{ dns-full-name }} {#dns}

Тип объекта | Поля
--- | ---
[Зона DNS](../../dns/concepts/dns-zone.md) | Зона, идентификатор, имя, метки, описание
Эндпоинт | Идентификатор, имя, метки, описание
Файрвол | Идентификатор, имя, метки, описание


### {{ sf-full-name }} {#functions}

Тип объекта | Поля
--- | ---
[Подключение к управляемой базе данных](../../functions/operations/database-connection.md) | Идентификатор, имя, метки, описание
[Триггер](../../functions/concepts/trigger/index.md) | Идентификатор, имя, метки, описание
[Функция](../../functions/concepts/function.md) | Идентификатор, имя, метки, описание


### {{ cloud-logging-full-name }} {#logging}

Тип объекта | Поля
--- | ---
[Лог-группа](../../logging/concepts/log-group.md) | Идентификатор, имя, метки
[Приемник логов](../../logging/operations/create-sink.md) | Идентификатор, имя, метки


### {{ postbox-full-name }} {#postbox}

Тип объекта | Поля
--- | ---
[Адрес](../../postbox/concepts/glossary.md#address) | Идентификатор, адрес, метки, описание


### {{ cloud-registry-full-name }} {#cloud-registry}

Тип объекта | Поля
--- | ---
[Реестр](../../cloud-registry/concepts/registry.md) | Идентификатор, имя, метки, описание


### {{ compute-full-name }} {#compute}

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


### {{ container-registry-full-name }} {#registry}

Тип объекта | Поля
--- | ---
[Реестр](../../container-registry/concepts/registry.md) | Идентификатор, имя, метки
[Репозиторий](../../container-registry/concepts/repository.md) | Идентификатор, имя


### {{ dataproc-full-name }} {#dataproc}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, хосты


### {{ data-transfer-full-name }} {#data-transfer}

Тип объекта | Поля
--- | ---
[Трансфер](../../data-transfer/concepts/index.md#transfer) | Идентификатор, имя, метки, описание
[Эндпоинт](../../data-transfer/concepts/index.md#endpoint) | Идентификатор, имя, метки, описание


### {{ iam-full-name }} {#iam}

Тип объекта | Поля
--- | ---
[Авторизованный ключ](../../iam/concepts/authorization/key.md) | Идентификатор, описание
[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) | Идентификатор, имя, метки, описание
[Статический ключ доступа](../../iam/concepts/authorization/access-key.md) | Идентификатор, идентификатор ключа, описание
[API-ключ](../../iam/concepts/authorization/api-key.md) | Идентификатор, описание


### {{ kms-full-name }} {#kms}

Тип объекта | Поля
--- | ---
[Асимметричная ключевая пара подписи](../../kms/concepts/asymmetric-signature-key.md) | Идентификатор, имя, метки, описание
[Асимметричная ключевая пара шифрования](../../kms/concepts/asymmetric-encryption-key.md) | Идентификатор, имя, метки, описание
[Симметричный ключ](../../kms/concepts/symmetric-encryption.md) | Идентификатор, имя, метки, описание


### {{ lockbox-full-name }} {#lockbox}

Тип объекта | Поля
--- | ---
[Секрет](../../lockbox/concepts/secret.md) | Идентификатор, имя, метки, описание


### {{ maf-full-name }} {#maf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, сервисный аккаунт, бакет S3


### {{ mkf-full-name }} {#mkf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, топики, хосты


### {{ mch-full-name }} {#mch}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ mgl-full-name }} {#gitlab}

Тип объекта | Поля
--- | ---
[Инстанс](../../managed-gitlab/concepts/index.md) | Идентификатор, имя, метки, описание


### {{ managed-k8s-full-name }} {#k8s}

Тип объекта | Поля
--- | ---
[Группа узлов](../../managed-kubernetes/concepts/index.md#node-group) | Идентификатор, идентификатор кластера, имя, метки, описание
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание


### {{ mmy-full-name }} {#mmy}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ mos-full-name }} {#mos}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, хосты


### {{ mpg-full-name }} {#mpg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ mtr-full-name }} {#mtr}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, метки, описание, сервисный аккаунт


### {{ mrd-full-name }} {#mrd}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ ydb-full-name }} {#ydb}

Тип объекта | Поля
--- | ---
[База данных](../../ydb/concepts/resources.md#database) | Идентификатор, имя, метки, описание
[Резервная копия]({{ ydb.docs }}/devops/backup-and-recovery) | Идентификатор, имя, метки, описание


### {{ message-queue-full-name }} {#message-queue}

Тип объекта | Поля
--- | ---
[Очередь сообщений](../../message-queue/concepts/queue.md) | Идентификатор, имя, метки


### {{ metadata-hub-full-name }} {#metadata-hub}

Тип объекта | Поля
--- | ---
[Кластер](../../metadata-hub/concepts/metastore.md) | Идентификатор, имя, метки, описание, сервисный аккаунт


### {{ monitoring-full-name }} {#monitoring}

Тип объекта | Поля
--- | ---
[Алерт](../../monitoring/concepts/alerting/alert.md) | Идентификатор, имя, описание
[Дашборд](../../monitoring/concepts/visualization/dashboard.md) | Идентификатор, имя, описание
[Канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) | Идентификатор, имя, описание


### {{ mgp-full-name }} {#mgp}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ network-load-balancer-full-name }} {#nlb}

Тип объекта | Поля
--- | ---
[Сетевой балансировщик](../../network-load-balancer/concepts/index.md) | Идентификатор, имя, метки, описание, внутренний IPv4-адрес, внутренний IPv6-адрес, публичный IPv4-адрес, публичный IPv6-адрес
[Целевая группа](../../network-load-balancer/concepts/target-resources.md) | Идентификатор, имя, метки, описание


### {{ objstorage-full-name }} {#storage}

Тип объекта | Поля
--- | ---
[Бакет](../../storage/concepts/bucket.md) | Идентификатор, имя, идентификатор ресурса, теги


### {{ resmgr-full-name }} {#resource-manager}

Тип объекта | Поля
--- | ---
[Каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) | Идентификатор, имя, метки, описание
[Облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) | Идентификатор, имя, метки, описание


### {{ serverless-containers-full-name }} {#containers}

Тип объекта | Поля
--- | ---
[Контейнер](../../serverless-containers/concepts/container.md) | Идентификатор, имя, метки, описание


### {{ sws-full-name }} {#sws}

Тип объекта | Поля
--- | ---
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Идентификатор, имя, метки, описание
[Профиль ARL](../../smartwebsecurity/concepts/arl.md) | Идентификатор, имя, метки, описание
[Профиль WAF](../../smartwebsecurity/concepts/waf.md) | Идентификатор, имя, метки, описание
[Профиль безопасности](../../smartwebsecurity/concepts/profiles.md) | Идентификатор, имя, метки, описание
[Список совпадений](../../smartwebsecurity/concepts/conditions.md#match-list) | Идентификатор, имя, метки, описание


### {{ captcha-full-name }} {#captcha}

Тип объекта | Поля
--- | ---
[Капча](../../smartcaptcha/concepts/validation.md) | Идентификатор, имя, метки, описание


### {{ mmg-full-name }} {#mmg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ vpc-full-name }} {#vpc}

Тип объекта | Поля
--- | ---
[IP-адрес](../../vpc/concepts/address.md) | Адрес, идентификатор, имя, метки, описание
[Группа безопасности](../../vpc/concepts/security-groups.md) | Идентификатор, имя, метки, описание
[Облачная сеть](../../vpc/concepts/network.md#network) | Идентификатор, имя, метки, описание
[Подсеть](../../vpc/concepts/network.md#subnet) | Идентификатор, имя, метки, описание, CIDR v4, CIDR v6
[Приватный эндпоинт](../../vpc/concepts/private-endpoint.md) | Идентификатор, имя, метки, описание
[Таблица маршрутизации](../../vpc/concepts/routing.md) | Идентификатор, имя, метки, описание
[Шлюз](../../vpc/concepts/gateways.md) | Идентификатор, имя, метки, описание
