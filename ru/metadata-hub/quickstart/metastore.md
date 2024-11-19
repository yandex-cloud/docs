# Начало работы с {{ metastore-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

В сервисе {{ metadata-hub-name }} вы можете [создавать кластеры {{ metastore-full-name }}](#create-metastore-cluster) и [использовать их](#connect-metastore-to-dataproc) для работы с кластерами {{ dataproc-full-name }}.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. [Настройте NAT-шлюз](../../vpc/operations/create-nat-gateway.md) в подсети, в которой будут размещены кластеры {{ metastore-name }} и {{ dataproc-name }}.

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) для кластеров {{ metastore-name }} и {{ dataproc-name }}.

1. [Добавьте](../../vpc/operations/security-group-add-rule.md) в группу безопасности правила для кластера {{ metastore-name }}:

   * Для входящего трафика от клиентов:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `30000-32767`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

   * Для входящего трафика от балансировщика:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10256`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

1. Добавьте в группу безопасности правила для кластера {{ dataproc-name }}:

   * По одному правилу для входящего и исходящего служебного трафика:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

   * Отдельное правило для исходящего HTTPS-трафика на все адреса. Это позволит использовать [бакеты](../../storage/concepts/bucket.md) {{ objstorage-full-name }}, [UI Proxy](../../data-proc/concepts/interfaces.md) и [автоматическое масштабирование](../../data-proc/concepts/autoscaling.md) подкластеров {{ dataproc-name }}.

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

   * Правило, разрешающее доступ к NTP-серверам для синхронизации времени:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `123`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) с ролями `dataproc.agent`, `dataproc.provisioner` и `{{ roles.metastore.integrationProvider }}`.

1. [Создайте бакет {{ objstorage-name }}](../../storage/operations/buckets/create.md) для работы с кластером {{ dataproc-name }}.

1. В созданной ранее сети [создайте кластер {{ dataproc-name }}](../../data-proc/operations/cluster-create.md#create-cluster). В настройках задайте:

   * Сервисы `SPARK` и `YARN`.
   * Сервисный аккаунт, созданный ранее.
   * Свойство `spark:spark.sql.hive.metastore.sharedPrefixes` со значением `com.amazonaws,ru.yandex.cloud`. Нужно для выполнения заданий PySpark и для интеграции с {{ metastore-name }}.
   * Бакет, созданный ранее.
   * Группу безопасности, настроенную ранее.

## Создайте кластер {{ metastore-name }} {#create-metastore-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В консоли управления перейдите в ранее созданный каталог.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На левой панели выберите страницу ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. Выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого кластер {{ metastore-name }} будет взаимодействовать с другими сервисами {{ yandex-cloud }}, или [создайте](../../iam/operations/sa/create.md) новый.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите созданную ранее сеть и подсеть. Укажите заранее настроенную группу безопасности.
    1. (Опционально) В блоке **{{ ui-key.yacloud.logging.label_title }}** включите запись логов, выберите минимальный уровень логирования и укажите каталог или [лог-группу](../../logging/concepts/log-group.md).
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Подключите кластер {{ metastore-name }} к кластеру {{ dataproc-name }} {#connect-metastore-to-dataproc}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В созданном ранее кластере {{ dataproc-name }} задайте следующее [свойство](../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<IP-адрес_кластера_{{ metastore-name }}>:{{ port-metastore }}
        ```

        Чтобы узнать IP-адрес кластера {{ metastore-name }}, в консоли управления выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**, на левой панели выберите страницу ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** и откройте нужный кластер. IP-адрес кластера указан в блоке **{{ ui-key.yacloud.common.section-base }}**.

    1. Добавьте в группу безопасности следующее правило для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

{% endlist %}

## Что дальше {#what-is-next}

* [Работайте с таблицами при помощи {{ metastore-name }}](../tutorials/sharing-tables.md).
* [Используйте {{ metastore-name }} для переноса данных между кластерами {{ dataproc-name }}](../tutorials/metastore-import.md).
* [Храните в {{ metastore-name }} табличные данные при работе с {{ AF }}](../../data-proc/tutorials/airflow-automation.md).
* [Экспортируйте или импортируйте метаданные Hive в кластере {{ metastore-name}}](../operations/metastore/export-and-import.md).
