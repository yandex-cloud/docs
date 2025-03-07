---
title: Метки ресурсов сервисов
description: Из статьи вы узнаете, что такое метки, ознакомитесь с примерами использования меток и сервисами, в которых поддерживаются метки.
---

# Метки ресурсов сервисов


Большая часть сервисов {{ yandex-cloud }} поддерживает использование меток для маркировки ресурсов.

_Метка_ — это пара ключ-значение в формате `<имя_метки>=<значение_метки>`. Вы можете использовать метки для разделения ресурсов на логические группы.

{% include [tags-restrictions](../../_includes/tags-restrictions.md) %}

## Примеры использования меток {#examples}

* [Просмотр детализации использования сервисов по меткам](../../billing/operations/check-charges.md#labels_1).

    Например, можно [посмотреть детализацию расходов {{ ml-platform-name }}](../../datasphere/operations/community/billing-details.md).

* Поиск ресурсов, принадлежащих одному проекту, владельцу, окружению и т. д.

    Например, с помощью метки `project:app` можно найти ресурсы {{ yandex-cloud }}, которые используются в проекте `app`.

* Группирование ресурсов по различным критериям: проекту, команде, среде, приложению и т. д.

    Например, с помощью меток `environment:production` и `environment:test` можно обозначить принадлежность ресурсов {{ yandex-cloud }} к производственной и тестовой среде.

* Автоматизация выполнения действий с группой ресурсов: запуск, остановка или удаление маркированных ресурсов.

    Например, можно [управлять группой ресурсов с помощью функции {{ sf-full-name }}](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md).

## Сервисы, в которых поддержаны метки {#services}

{% note info %}

Метки поддержаны не во всех ресурсах сервисов и могут не отображаться в некоторых интерфейсах. Например, метки ресурсов могут быть не видны в интерфейсах консоли управления или {{ cloud-center }}.

{% endnote %}

### Инфраструктура и сеть {#infra}

* [{{ api-gw-full-name }}](../../api-gateway/index.yaml)
* [{{ alb-full-name }}](../../application-load-balancer/index.yaml)
* [{{ cdn-full-name }}](../../cdn/index.yaml)
* [{{ dns-full-name }}](../../dns/index.yaml)
* [{{ cloud-logging-full-name }}](../../logging/index.yaml)
* [{{ compute-full-name }}](../../compute/index.yaml)
* [{{ load-testing-full-name }}](../../load-testing/index.yaml)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml)
* [{{ objstorage-full-name }}](../../storage/index.yaml)
* [{{ vpc-full-name }}](../../vpc/index.yaml)

### Платформа данных {#data-platform}

* [{{ dataproc-full-name }}](../../data-proc/index.yaml)
* [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
* [{{ ml-platform-full-name }}](../../datasphere/index.yaml)
* [{{ message-queue-full-name }}](../../message-queue/index.yaml)
* [{{ maf-full-name }}](../../managed-airflow/index.yaml)
* [{{ mkf-full-name }}](../../managed-kafka/index.yaml)
* [{{ mch-full-name }}](../../managed-clickhouse/index.yaml)
* [{{ mes-full-name }}](../../managed-elasticsearch/index.yaml)
* [{{ mgp-full-name }}](../../managed-greenplum/index.yaml)
* [{{ mmg-full-name }}](../../managed-mongodb/index.yaml)
* [{{ mmy-full-name }}](../../managed-mysql/index.yaml)
* [{{ mos-full-name }}](../../managed-opensearch/index.yaml)
* [{{ mpg-full-name }}](../../managed-postgresql/index.yaml)
* [{{ mrd-full-name }}](../../managed-redis/index.yaml)
* [{{ ydb-full-name }}](../../ydb/index.yaml)
* [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml) ({{ connection-manager-full-name }} и кластеры {{ metastore-full-name }})

### Контейнеры {#containers}

* [{{ container-registry-full-name }}](../../container-registry/index.yaml)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)

### Бессерверные вычисления {#serverless}

* [{{ sf-full-name }}](../../functions/index.yaml)
* [{{ iot-full-name }}](../../iot-core/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)
* [{{ si-full-name }}](../../serverless-integrations/index.yaml) ({{ er-name }})

### Безопасность {#security}

* [{{ at-full-name }}](../../audit-trails/index.yaml)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml)
* [{{ iam-full-name }}](../../iam/index.yaml)
* [{{ kms-full-name }}](../../kms/index.yaml)
* [{{ lockbox-full-name }}](../../lockbox/index.yaml)

### Инструменты разработчика {#developer-tools}

* [{{ mgl-full-name }}](../../managed-gitlab/index.yaml)

### Мониторинг и управление ресурсами {#resources-operations}

* [{{ org-full-name }}](../../organization/index.yaml)
* [{{ resmgr-full-name }}](../../resource-manager/index.yaml)

#### См. также {#see-also}

* [Управление метками](../operations/manage-labels.md)
* [Управление метками в сообществах {{ ml-platform-full-name }}](../../datasphere/operations/community/manage-community-labels.md)
* [Управление метками в проектах {{ ml-platform-full-name }}](../../datasphere/operations/projects/manage-project-labels.md)

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
