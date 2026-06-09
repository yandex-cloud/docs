# Метки ресурсов сервисов


Большая часть сервисов Yandex Cloud поддерживает использование меток для маркировки ресурсов.

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

    Например, можно [посмотреть детализацию расходов DataSphere](../../datasphere/operations/community/billing-details.md).

* Поиск ресурсов, принадлежащих одному проекту, владельцу, окружению и т. д.

    Например, с помощью метки `project:app` можно найти ресурсы Yandex Cloud, которые используются в проекте `app`.

* Группирование ресурсов по различным критериям: проекту, команде, среде, приложению и т. д.

    Например, с помощью меток `environment:production` и `environment:test` можно обозначить принадлежность ресурсов Yandex Cloud к производственной и тестовой среде.

* Автоматизация выполнения действий с группой ресурсов: запуск, остановка или удаление маркированных ресурсов.

    Например, можно [управлять группой ресурсов с помощью функции Yandex Cloud Functions](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md).

## Сервисы, в которых поддержаны метки {#services}

{% note info %}

Метки поддержаны не во всех ресурсах сервисов и могут не отображаться в некоторых интерфейсах. Например, метки ресурсов могут быть не видны в интерфейсах консоли управления, Cloud Center или Yandex Cloud Billing.

{% endnote %}

### Инфраструктура и сеть {#infra}

* [Yandex API Gateway](../../api-gateway/index.md)
* [Yandex Application Load Balancer](../../application-load-balancer/index.md)
* [Yandex Cloud CDN](../../cdn/index.md)
* [Yandex Cloud DNS](../../dns/index.md)
* [Yandex Cloud Logging](../../logging/index.md)
* [Yandex Compute Cloud](../../compute/index.md)
* [Yandex Load Testing](../../load-testing/index.md)
* [Yandex Network Load Balancer](../../network-load-balancer/index.md)
* [Yandex Object Storage](../../storage/index.md)
* [Yandex Virtual Private Cloud](../../vpc/index.md)

### Платформа данных {#data-platform}

* [Yandex Data Processing](../../data-proc/index.md)
* [Yandex Data Transfer](../../data-transfer/index.md)
* [Yandex DataSphere](../../datasphere/index.md)
* [Yandex Message Queue](../../message-queue/index.md)
* [Yandex Managed Service for Apache Airflow™](../../managed-airflow/index.md)
* [Yandex Managed Service for Apache Kafka®](../../managed-kafka/index.md)
* [Yandex Managed Service for ClickHouse®](../../managed-clickhouse/index.md)
* [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/index.md)
* [Yandex StoreDoc](../../storedoc/index.md)
* [Yandex Managed Service for MySQL®](../../managed-mysql/index.md)
* [Yandex Managed Service for OpenSearch](../../managed-opensearch/index.md)
* [Yandex Managed Service for PostgreSQL](../../managed-postgresql/index.md)
* [Yandex Managed Service for Valkey™](../../managed-valkey/index.md)
* [Yandex Managed Service for YDB](../../ydb/index.md)
* [Yandex MetaData Hub](../../metadata-hub/index.md) (Yandex Connection Manager и кластеры Apache Hive™ Metastore)

### Контейнеры {#containers}

* [Yandex Container Registry](../../container-registry/index.md)
* [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md)
* [Yandex Serverless Containers](../../serverless-containers/index.md)

### Бессерверные вычисления {#serverless}

* [Yandex Cloud Functions](../../functions/index.md)
* [Yandex IoT Core](../../iot-core/index.md)
* [Yandex Serverless Containers](../../serverless-containers/index.md)
* [Yandex Serverless Integrations](../../serverless-integrations/index.md) (EventRouter)

### Безопасность {#security}

* [Yandex Audit Trails](../../audit-trails/index.md)
* [Yandex Certificate Manager](../../certificate-manager/index.md)
* [Yandex Identity and Access Management](../../iam/index.md)
* [Yandex Key Management Service](../../kms/index.md)
* [Yandex Lockbox](../../lockbox/index.md)

### Инструменты разработчика {#developer-tools}

* [Yandex Managed Service for GitLab](../../managed-gitlab/index.md)

### Мониторинг и управление ресурсами {#resources-operations}

* [Yandex Identity Hub](../../organization/index.md)
* [Yandex Resource Manager](../index.md)

## Примеры использования {#examples}

* [Создание триггера для бюджетов, который вызывает функцию Cloud Functions для остановки ВМ](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md)

#### См. также {#see-also}

* [Управление метками](../operations/manage-labels.md)
* [Управление метками в сообществах Yandex DataSphere](../../datasphere/operations/community/manage-community-labels.md)
* [Управление метками в проектах Yandex DataSphere](../../datasphere/operations/projects/manage-project-labels.md)

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._