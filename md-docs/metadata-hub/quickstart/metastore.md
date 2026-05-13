# Начало работы с Apache Hive™ Metastore

В сервисе Yandex MetaData Hub вы можете [создавать кластеры Apache Hive™ Metastore](#create-metastore-cluster) и [использовать их](#connect-metastore-to-dataproc) для работы с кластерами Yandex Data Processing.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../../_assets/resource-manager/create-folder-2.png)

1. Для привязки [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) к кластеру Apache Hive™ Metastore [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, в которой будут размещены кластеры Apache Hive™ Metastore и Yandex Data Processing.

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) для кластеров Apache Hive™ Metastore и Yandex Data Processing.

1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности правила для кластера Apache Hive™ Metastore:

   * Для входящего трафика от клиентов:

       * **Диапазон портов** — `30000-32767`.
       * **Протокол** — `Любой` (`Any`).
       * **Источник** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.

   * Для входящего трафика от балансировщика:

       * **Диапазон портов** — `10256`.
       * **Протокол** — `Любой` (`Any`).
       * **Источник** — `Проверки состояния балансировщика`.

1. Добавьте в группу безопасности правила для кластера Yandex Data Processing:

   * По одному правилу для входящего и исходящего служебного трафика:

       * **Диапазон портов** — `0-65535`.
       * **Протокол** — `Любой`.
       * **Источник**/**Назначение** — `Группа безопасности`.
       * **Группа безопасности** — `Текущая`.

   * Отдельное правило для исходящего HTTPS-трафика на все адреса. Это позволит использовать [бакеты](../../storage/concepts/bucket.md) Yandex Object Storage, [UI Proxy](../../data-proc/concepts/interfaces.md) и [автоматическое масштабирование](../../data-proc/concepts/autoscaling.md) подкластеров Yandex Data Processing.

       * **Диапазон портов** — `443`.
       * **Протокол** — `TCP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.

   * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:

       * **Диапазон портов** — `123`.
       * **Протокол** — `UDP`.
       * **Назначение** — `CIDR`.
       * **CIDR блоки** — `0.0.0.0/0`.

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с ролями `dataproc.agent`, `dataproc.provisioner` и `managed-metastore.integrationProvider`.

1. [Создайте бакет Object Storage](../../storage/operations/buckets/create.md) для работы с кластером Yandex Data Processing.

1. В созданной ранее сети [создайте кластер Yandex Data Processing](../../data-proc/operations/cluster-create.md#create-cluster). В настройках задайте:

   * Сервисы `SPARK` и `YARN`.
   * Сервисный аккаунт, созданный ранее.
   * Свойство `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud`. Нужно для выполнения заданий PySpark и для интеграции с Apache Hive™ Metastore.
   * Бакет, созданный ранее.
   * Группу безопасности, настроенную ранее.

## Создайте кластер Apache Hive™ Metastore {#create-metastore-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В консоли управления перейдите в ранее созданный каталог.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
    1. На панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**.
    1. Нажмите кнопку **Создать кластер**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого кластер Apache Hive™ Metastore будет взаимодействовать с другими сервисами Yandex Cloud, или [создайте](../../iam/operations/sa/create.md) новый.
    1. Выберите версию Apache Hive™ Metastore 3.1.
    1. В блоке **Сетевые настройки** выберите созданную ранее сеть и подсеть. Укажите заранее настроенную группу безопасности.
    1. В блоке **Metastore** выберите [конфигурацию кластера](../concepts/metastore.md#presets).
    1. (Опционально) В блоке **Логирование** включите запись логов, выберите минимальный уровень логирования и укажите каталог или [лог-группу](../../logging/concepts/log-group.md).
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Подключите кластер Apache Hive™ Metastore к кластеру Yandex Data Processing {#connect-metastore-to-dataproc}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В созданном ранее кластере Yandex Data Processing задайте следующее [свойство](../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<IP-адрес_кластера_Apache Hive™ Metastore>:9083
        ```

        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в консоли управления выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../_assets/console-icons/database.svg) **Metastore-сервер**. Для нужного кластера скопируйте значение из колонки **IP-адрес**.

    1. Добавьте в группу безопасности следующее правило для исходящего трафика:

        * **Диапазон портов** — `9083`.
        * **Протокол** — `Любой` (`Any`).
        * **Источник** — `CIDR`.
        * **CIDR блоки** — `0.0.0.0/0`.

{% endlist %}

## Что дальше {#what-is-next}

* [Работайте с таблицами при помощи Apache Hive™ Metastore](../tutorials/sharing-tables.md).
* [Используйте Apache Hive™ Metastore для переноса данных между кластерами Yandex Data Processing](../tutorials/metastore-import.md).
* [Храните в Apache Hive™ Metastore табличные данные при работе с Apache Airflow™](../../data-proc/tutorials/airflow-automation.md).
* [Экспортируйте или импортируйте метаданные Hive в кластере Apache Hive™ Metastore](../operations/metastore/export-and-import.md).

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._