[Документация Yandex Cloud](../../index.md) > [Yandex MetaData Hub](../index.md) > Schema Registry > Практические руководства > Поставка данных в формате Debezium CDC из Apache Kafka®

# Создание реестра схем для поставки данных в формате Debezium CDC из Apache Kafka®


Вы можете создать реестр схем, чтобы отслеживать эволюцию схем для источника Apache Kafka® или Yandex Managed Service for Apache Kafka® с помощью сервиса [Yandex Data Transfer](../../data-transfer/index.md). В этом руководстве отслеживается эволюция схем для источника Managed Service for Apache Kafka®. 

Чтобы отследить изменение схем для источника Managed Service for Apache Kafka®:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте реестр схем](#create-schema-registry).
1. [Подготовьте и запустите трансфер](#set-up-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#prepare-cloud}


Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for Apache Kafka®: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Managed Service for Apache Kafka®](../../managed-kafka/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы Data Transfer](../../data-transfer/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

[Создайте кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-create.md) произвольной конфигурации. Если вы планируете подключаться к хостам-брокерам из интернета, включите публичный доступ. В этом случае подключаться к ним можно только с использованием SSL-соединения.

## Создайте реестр схем {#create-schema-registry}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с реестром схем.
  1. Перейдите в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **Schema Registry** / **Пространство имён**.
  1. Нажмите кнопку **Создать пространство имён**. 
  1. Укажите [настройки пространства имен](../operations/create-name-space.md). После сохранения пространства имен, вы сможете использовать его идентификатор для получения URL Schema Registry: `{namespace_id}.schema-registry.yandexcloud.net:443`.

{% endlist %}

## Подготовьте и запустите трансфер {#set-up-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Yandex Data Transfer**. 
  1. [Создайте эндпоинт-источник Apache Kafka®](../../data-transfer/operations/endpoint/source/kafka.md) со следующими настройками:

      * **Тип базы данных** — **Apache Kafka®**.
      * **Тип подключения** — **Ручная настройка**.
      * **Тип инсталляции** — **Кластер Managed Service for Apache Kafka®**.
      * В блоке **Кластер Managed Service for Apache Kafka®**:

          * **Кластер Managed Service for Apache Kafka®** — выберите [созданный ранее](#prepare-infrastructure) кластер Managed Service for Apache Kafka®.
          * **Аутентификация** — **SASL**.
          * **Имя пользователя** и **Пароль** — имя и пароль пользователя в кластере Managed Service for Apache Kafka®.

      * В блоке **Расширенные настройки** → **Правила конвертации**:

          * **Правила конвертации** — **Парсер Debezium CDC**.
          * **Настройки подключения к Schema Registry** — **On Premise Schema Registry**.
          * **Schema Registry URL** — [полученный ранее](#create-schema-registry) URL Schema Registry.

  1. [Создайте и запустите](../../data-transfer/operations/transfer.md) трансфер данных.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Кластер Managed Service for Apache Kafka®](../../managed-kafka/operations/cluster-delete.md).
  1. [Трансфер Data Transfer](../../data-transfer/operations/transfer.md#delete).

{% endlist %}