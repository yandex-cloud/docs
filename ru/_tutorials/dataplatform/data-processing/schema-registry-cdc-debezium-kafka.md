# Создание реестра схем для поставки данных в формате Debezium CDC из {{ KF }}


Вы можете создать реестр схем, чтобы отслеживать эволюцию схем для источника {{ KF }} или {{ mkf-full-name }} с помощью сервиса [{{ data-transfer-full-name }}](../../../data-transfer). В этом руководстве отслеживается эволюция схем для источника {{ mkf-name }}. 

Чтобы отследить изменение схем для источника {{ mkf-name }}:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Создайте реестр схем](#create-schema-registry).
1. [Подготовьте и запустите трансфер](#set-up-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#prepare-cloud}


{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mkf-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mkf-name }}](../../../managed-kafka/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных ([тарифы {{ data-transfer-name }}](../../../data-transfer/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

[Создайте кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) произвольной конфигурации. Если вы планируете подключаться к хостам-брокерам из интернета, включите публичный доступ. В этом случае подключаться к ним можно только с использованием SSL-соединения.

## Создайте реестр схем {#create-schema-registry}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с реестром схем.
  1. Перейдите в сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Пространство имён**.
  1. Нажмите кнопку **Создать пространство имён**. 
  1. Укажите [настройки пространства имен](../../../metadata-hub/operations/create-name-space.md). После сохранения пространства имен, вы сможете использовать его идентификатор для получения URL {{ schema-registry-name }}: `{namespace_id}.{{ schema-registry-endpoint }}`.

{% endlist %}

## Подготовьте и запустите трансфер {#set-up-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. Перейдите в сервис **{{ data-transfer-full-name }}**. 
  1. [Создайте эндпоинт-источник {{ KF }}](../../../data-transfer/operations/endpoint/source/kafka.md) со следующими настройками:

      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — **{{ KF }}**.
      * **Тип подключения** — **Ручная настройка**.
      * **Тип инсталляции** — **Кластер {{ mkf-name }}**.
      * В блоке **Кластер {{ mkf-name }}**:

          * **Кластер {{ mkf-name }}** — выберите [созданный ранее](#prepare-infrastructure) кластер {{ mkf-name }}.
          * **Аутентификация** — **SASL**.
          * **Имя пользователя** и **Пароль** — имя и пароль пользователя в кластере {{ mkf-name }}.

      * В блоке **Расширенные настройки** → **Правила конвертации**:

          * **Правила конвертации** — **Парсер Debezium CDC**.
          * **Настройки подключения к {{ schema-registry-name }}** — **On Premise {{ schema-registry-name }}**.
          * **{{ schema-registry-name }} URL** — [полученный ранее](#create-schema-registry) URL {{ schema-registry-name }}.

  1. [Создайте и запустите](../../../data-transfer/operations/transfer.md) трансфер данных.

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Кластер {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md).
  1. [Трансфер {{ data-transfer-name }}](../../../data-transfer/operations/transfer.md#delete).

{% endlist %}
