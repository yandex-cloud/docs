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
[API-шлюз](../../api-gateway/concepts/index.md) | Домен, идентификатор, имя


### {{ alb-full-name }} {#alb}

Тип объекта | Поля
--- | ---
[HTTP-роутер](../../application-load-balancer/concepts/http-router.md) | Идентификатор, имя
[Балансировщик нагрузки](../../application-load-balancer/concepts/application-load-balancer.md) | Внутренний IP-адрес, идентификатор, имя, публичный IPv4-адрес, публичный IPv6-адрес
[Группа бэкендов](../../application-load-balancer/concepts/backend-group.md) | Идентификатор, имя
[Целевая группа](../../application-load-balancer/concepts/target-group.md) | Идентификатор, имя


### {{ at-full-name }} {#at}

Тип объекта | Поля
--- | ---
[Трейл](../../audit-trails/concepts/trail.md) | Идентификатор, имя


### {{ cdn-full-name }} {#cdn}

Тип объекта | Поля
--- | ---
[CDN-ресурс](../../cdn/concepts/resource.md) | Идентификатор, имя


### {{ dns-full-name }} {#dns}

Тип объекта | Поля
--- | ---
[Зона DNS](../../dns/concepts/dns-zone.md) | Зона, идентификатор, имя, метки


### {{ sf-full-name }} {#functions}

Тип объекта | Поля
--- | ---
[Подключение к управляемой базе данных](../../functions/operations/database-connection.md) | Идентификатор, имя
[Функция](../../functions/concepts/function.md) | Идентификатор, имя


### {{ cloud-logging-full-name }} {#logging}

Тип объекта | Поля
--- | ---
[Лог-группа](../../logging/concepts/log-group.md) | Идентификатор, имя
[Приемник логов](../../logging/operations/create-sink.md) | Идентификатор, имя


### {{ postbox-full-name }} {#postbox}

Тип объекта | Поля
--- | ---
[Адрес](../../postbox/concepts/glossary.md#adress) | Идентификатор, имя


### {{ compute-full-name }} {#compute}

Тип объекта | Поля
--- | ---
[Виртуальная машина](../../compute/concepts/vm.md) | FQDN, идентификатор, имя, имя хоста, метки, описание
[Группа виртуальных машин](../../compute/concepts/instance-groups/index.md) | Идентификатор, имя, метки
[Диск](../../compute/concepts/disk.md) | Идентификатор, имя, описание
[ВМ с GPU](../../compute/concepts/gpus.md) | Идентификатор, имя
[Расписание](../../compute/concepts/snapshot-schedule.md) | Идентификатор, имя, описание
[Снимок диска](../../compute/concepts/snapshot.md) | Идентификатор, имя, метки, описание
[Файловое хранилище](../../compute/concepts/filesystem.md) | Идентификатор, имя, метки, описание


### {{ container-registry-full-name }} {#registry}

Тип объекта | Поля
--- | ---
[Реестр](../../container-registry/concepts/registry.md) | Идентификатор, имя
[Репозиторий](../../container-registry/concepts/repository.md) | Идентификатор, имя


### {{ dataproc-full-name }} {#dataproc}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Идентификатор, имя, описание, хосты


### {{ iam-full-name }} {#iam}

Тип объекта | Поля
--- | ---
[Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) | Идентификатор, имя


### {{ kms-full-name }} {#kms}

Тип объекта | Поля
--- | ---
[Асимметричная ключевая пара подписи](../../kms/concepts/asymmetric-signature-key.md) | Идентификатор, имя
[Асимметричная ключевая пара шифрования](../../kms/concepts/asymmetric-encryption-key.md) | Идентификатор, имя
[Симметричный ключ](../../kms/concepts/symmetric-encryption.md) | Идентификатор, имя


### {{ load-testing-full-name }} {#load-testing}

Тип объекта | Поля
--- | ---
[Дашборд регрессий](../../load-testing/concepts/load-test-regressions.md#dashbordy-regressij) | Идентификатор, имя
[Генератор нагрузки](../../load-testing/concepts/load-generator.md) | Идентификатор, имя, метки
[Тест](../../load-testing/operations/create-test-bucket.md) | Идентификатор, имя, метки


### {{ lockbox-full-name }} {#lockbox}

Тип объекта | Поля
--- | ---
[Секрет](../../lockbox/concepts/secret.md) | Идентификатор, имя


### {{ maf-full-name }} {#maf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Бакет, идентификатор, имя, описание, сервисный аккаунт, хосты


### {{ mkf-full-name }} {#mkf}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, топики, хосты


### {{ mch-full-name }} {#mch}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### {{ mes-full-name }} {#mes}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### {{ mgp-full-name }} {#mgp}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### {{ managed-k8s-full-name }} {#k8s}

Тип объекта | Поля
--- | ---
[Группа узлов](../../managed-kubernetes/concepts/index.md#node-group) | Идентификатор, идентификатор кластера, имя
[Кластер](../../glossary/cluster.md) | Идентификатор, имя


### {{ mmg-full-name }} {#mmg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ mmy-full-name }} {#mmy}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### {{ mos-full-name }} {#mos}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, описание, пользователи, хосты


### {{ mpg-full-name }} {#mpg}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Базы данных, внутренний IP-адрес, идентификатор, имя, метки, описание, пользователи, хосты


### {{ mrd-full-name }} {#mrd}

Тип объекта | Поля
--- | ---
[Кластер](../../glossary/cluster.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, хосты


### {{ ydb-full-name }} {#ydb}

Тип объекта | Поля
--- | ---
[База данных](../../ydb/concepts/resources.md#database) | Идентификатор, имя


### {{ message-queue-full-name }} {#message-queue}

Тип объекта | Поля
--- | ---
[Очередь сообщений](../../message-queue/concepts/queue.md) | Идентификатор, имя


### {{ metadata-hub-full-name }} {#metadata-hub}

Тип объекта | Поля
--- | ---
[Кластер](../../metadata-hub/concepts/metastore.md) | Идентификатор, имя, описание, сервисный аккаунт, хосты


### {{ monitoring-full-name }} {#monitoring}

Тип объекта | Поля
--- | ---
[Алерт](../../monitoring/concepts/alerting/alert.md) | Идентификатор, имя, описание
[Дашборд](../../monitoring/concepts/visualization/dashboard.md) | Идентификатор, имя, описание
[Канал уведомлений](../../monitoring/concepts/alerting/notification-channel.md) | Идентификатор, имя, описание


### {{ network-load-balancer-full-name }} {#nlb}

Тип объекта | Поля
--- | ---
[Сетевой балансировщик](../../network-load-balancer/concepts/index.md) | Внутренний IP-адрес, идентификатор, имя, метки, описание, публичный IPv4-адрес
[Целевая группа](../../network-load-balancer/concepts/target-resources.md) | Идентификатор, имя, метки, описание


### {{ objstorage-full-name }} {#storage}

Тип объекта | Поля
--- | ---
[Бакет](../../storage/concepts/bucket.md) | Идентификатор, имя


### {{ serverless-containers-full-name }} {#containers}

Тип объекта | Поля
--- | ---
[Контейнер](../../serverless-containers/concepts/container.md) | Идентификатор, имя


### {{ vpc-full-name }} {#vpc}

Тип объекта | Поля
--- | ---
[IP-адрес](../../vpc/concepts/address.md) | IP-адрес, идентификатор, имя, описание
[NAT-инстанс](../../tutorials/routing/nat-instance/index.md) | Внутренний IP-адрес, идентификатор, идентификатор подсети, идентификатор публичного IPv4-адреса, имя, описание, публичный IPv4-адрес
[Группа безопасности](../../vpc/concepts/security-groups.md) | Идентификатор, имя, описание
[Облачная сеть](../../vpc/concepts/network.md#network) | Идентификатор, имя, описание
[Подсеть](../../vpc/concepts/network.md#subnet) | Идентификатор, имя, описание
[Таблица маршрутизации](../../vpc/concepts/routing.md) | Идентификатор, имя, описание
[Шлюз](../../vpc/concepts/gateways.md) | Идентификатор, имя, описание