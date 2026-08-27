# Как начать работать с {{ data-transfer-name }}

С помощью сервиса {{ data-transfer-name }} вы сможете перенести данные из стороннего кластера-источника в кластер-приемник, не останавливая обслуживание пользователей. В этой инструкции рассмотрим перенос стороннего кластера {{ MY }} в {{ mmy-name }}. Репликация происходит с помощью настройки [эндпоинтов](concepts/index.md#endpoint) и [трансфера](concepts/index.md#transfer) между ними.

Полный список энгдпоинтов и возможных трансферов между ними приведен в разделе [{#T}](transfer-matrix.md).


Вы создадите ресурсы в [консоли управления]({{ link-console-main }}) в своем [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), для работы с которым потребуется [роль](../iam/roles-reference.md#editor) `editor`. Часть ресурсов платные, поэтому проверьте, что ваш [платежный аккаунт активен](../billing/concepts/billing-account-statuses.md).



<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvd3cn6zv43igozbf5?autoplay=0&mute=0" allow="autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>


## Настройте источник и приемник {#db-settings}

1. [Создайте кластер-приемник {{ mmy-name }}](../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

    * Версия {{ MY }} должна быть не ниже, чем в кластере-источнике.

        Перенос данных с повышением мажорной версии {{ MY }} возможен, но не гарантируется. Подробнее в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

        Миграция с понижением версии {{ MY }} [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

    * [Режим SQL](../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

1. [Подготовьте кластер-приемник](operations/prepare.md#target-my).

## Создайте эндпоинт для источника {#source}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
  1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
  1. Укажите имя эндпоинта.
  1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `{{ MY }}`.
  1. Укажите параметры эндпоинта в соответствующем блоке настроек.
  
     Подробнее о доступных параметрах читайте в разделе [{#T}](operations/endpoint/source/mysql.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте эндпоинт для приемника {#target}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
  1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
  1. Укажите имя эндпоинта.
  1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** выберите `{{ MY }}`.
  1. Укажите параметры эндпоинта в соответствующем блоке настроек.

     Подробнее о доступных параметрах читайте в разделе [{#T}](operations/endpoint/target/mysql.md).

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте трансфер {#create-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
  1. Укажите имя трансфера.
  1. (Опционально) Добавьте описание трансфера.
  1. Выберите созданные эндпоинты для источника и приемника.
  1. Выберите [тип трансфера](./concepts/index.md#transfer-type):

     * {{ dt-type-copy }} — чтобы создать полную копию данных без дальнейшего получения обновлений из источника. Этот тип также можно использовать для [репликации постоянно меняющихся таблиц](concepts/transfer-lifecycle.md#select-transfer-type).

       Если вам нужно создавать полную копию данных через определенные интервалы времени, включите настройку **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferTypeSnapshot.regular_snapshot.title }}**.

     * {{ dt-type-repl }} — чтобы непрерывно получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).
     * {{ dt-type-copy-repl }} — чтобы создать полную копию данных источника и поддерживать ее в актуальном состоянии.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

Подробнее читайте в разделе [{#T}](operations/transfer.md#create).

## Активируйте трансфер {#activate}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
  1. [Перейдите]({{ link-console-main }}/link/data-transfer) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}**.
  1. Нажмите значок ![ellipsis](../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

{% endlist %}

Начнется процесс переноса данных.

## Завершите перенос данных {#finish-transfer}

1. Дождитесь перехода трансфера в статус {{ dt-status-repl }}.
1. Переведите кластер-источник в режим _только чтение_ и переключите нагрузку на кластер-приемник.
1. Отслеживайте состояние трансфера на странице [мониторинга](operations/monitoring.md).

   Когда [график](operations/monitoring.md#sinker.pusher.time.row_max_lag_sec) **Maximum data transfer delay** (отставание данных в секундах) упадет до нуля, все изменения, произошедшие в кластере-источнике после завершения копирования данных, будут перенесены в кластер-приемник. С этого момента вы сможете работать с перенесенными данными.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте больше о [подготовке баз данных для использования сервиса](operations/prepare.md) и [настройке трансферов](operations/transfer.md).
* Изучите [роли](security/index.md), действующие в {{ data-transfer-name }}.
* Ознакомьтесь с [практическими руководствами по работе с сервисом](tutorials/index.md).
