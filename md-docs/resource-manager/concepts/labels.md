# Метки ресурсов сервисов


Большая часть сервисов {{ yandex-cloud }} поддерживает использование меток для маркировки ресурсов.

_Метка_ — это пара ключ-значение в формате `<имя_метки>=<значение_метки>`. Вы можете использовать метки для разделения ресурсов на логические группы.

Ограничения при работе с метками:

* Максимальное количество меток на один ресурс: 64.
* Параметры ключа метки:

  * Длина — от 1 до 63 символов.
  * Может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания.
  * Первый символ — буква.

* Параметры значения метки:

  * Длина — до 63 символов.
  * Может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания.

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

Метки поддержаны не во всех ресурсах сервисов и могут не отображаться в некоторых интерфейсах. Например, метки ресурсов могут быть не видны в интерфейсах консоли управления, {{ cloud-center }} или {{ billing-name }}.

{% endnote %}

### Инфраструктура и сеть {#infra}

* [{{ api-gw-full-name }}](../../api-gateway/index.md)
* [{{ alb-full-name }}](../../application-load-balancer/index.md)
* [{{ cdn-full-name }}](../../cdn/index.md)
* [{{ dns-full-name }}](../../dns/index.md)
* [{{ cloud-logging-full-name }}](../../logging/index.md)
* [{{ compute-full-name }}](../../compute/index.md)
* [{{ load-testing-full-name }}](../../load-testing/index.md)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.md)
* [{{ objstorage-full-name }}](../../storage/index.md)
* [{{ vpc-full-name }}](../../vpc/index.md)

### Платформа данных {#data-platform}

* [{{ dataproc-full-name }}](../../data-proc/index.md)
* [{{ data-transfer-full-name }}](../../data-transfer/index.md)
* [{{ ml-platform-full-name }}](../../datasphere/index.md)
* [{{ message-queue-full-name }}](../../message-queue/index.md)
* [{{ maf-full-name }}](../../managed-airflow/index.md)
* [{{ mkf-full-name }}](../../managed-kafka/index.md)
* [{{ mch-full-name }}](../../managed-clickhouse/index.md)
* [{{ mgp-full-name }}](../../managed-greenplum/index.md)
* [{{ mmg-full-name }}](../../storedoc/index.md)
* [{{ mmy-full-name }}](../../managed-mysql/index.md)
* [{{ mos-full-name }}](../../managed-opensearch/index.md)
* [{{ mpg-full-name }}](../../managed-postgresql/index.md)
* [{{ mrd-full-name }}](../../managed-valkey/index.md)
* [{{ ydb-full-name }}](../../ydb/index.md)
* [{{ metadata-hub-full-name }}](../../metadata-hub/index.md) ({{ connection-manager-full-name }} и кластеры {{ metastore-full-name }})

### Контейнеры {#containers}

* [{{ container-registry-full-name }}](../../container-registry/index.md)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.md)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.md)

### Бессерверные вычисления {#serverless}

* [{{ sf-full-name }}](../../functions/index.md)
* [{{ iot-full-name }}](../../iot-core/index.md)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.md)
* [{{ si-full-name }}](../../serverless-integrations/index.md) ({{ er-name }})

### Безопасность {#security}

* [{{ at-full-name }}](../../audit-trails/index.md)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.md)
* [{{ iam-full-name }}](../../iam/index.md)
* [{{ kms-full-name }}](../../kms/index.md)
* [{{ lockbox-full-name }}](../../lockbox/index.md)

### Инструменты разработчика {#developer-tools}

* [{{ mgl-full-name }}](../../managed-gitlab/index.md)

### Мониторинг и управление ресурсами {#resources-operations}

* [{{ org-full-name }}](../../organization/index.md)
* [{{ resmgr-full-name }}](../index.md)

## Примеры использования {#examples}

* [{#T}](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md)

#### См. также {#see-also}

* [Управление метками](../operations/manage-labels.md)
* [Управление метками в сообществах {{ ml-platform-full-name }}](../../datasphere/operations/community/manage-community-labels.md)
* [Управление метками в проектах {{ ml-platform-full-name }}](../../datasphere/operations/projects/manage-project-labels.md)

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._