[Документация Yandex Cloud](../index.md) > [Yandex Data Transfer](index.md) > Начало работы

# Как начать работать с Data Transfer

С помощью сервиса Data Transfer вы сможете перенести данные из стороннего кластера-источника в кластер-приемник, не останавливая обслуживание пользователей. В этой инструкции рассмотрим перенос стороннего кластера MySQL® в Managed Service for MySQL®. Репликация происходит с помощью настройки [эндпоинтов](concepts/index.md#endpoint) и [трансфера](concepts/index.md#transfer) между ними.

Полный список энгдпоинтов и возможных трансферов между ними приведен в разделе [Доступные трансферы в Data Transfer](transfer-matrix.md).


Вы создадите ресурсы в [консоли управления](https://console.yandex.cloud) в своем [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder), для работы с которым потребуется [роль](../iam/roles-reference.md#editor) `editor`. Часть ресурсов платные, поэтому проверьте, что ваш [платежный аккаунт активен](../billing/concepts/billing-account-statuses.md).



<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvd3cn6zv43igozbf5?autoplay=0&mute=0" allow="autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>


## Настройте источник и приемник {#db-settings}

1. [Создайте кластер-приемник Managed Service for MySQL®](../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. При этом:

    * Версия MySQL® должна быть не ниже, чем в кластере-источнике.

        Перенос данных с повышением мажорной версии MySQL® возможен, но не гарантируется. Подробнее в [документации MySQL®](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

        Миграция с понижением версии MySQL® [невозможна](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

    * [Режим SQL](../managed-mysql/concepts/settings-list.md#setting-sql-mode) должен быть таким же, как и в кластере-источнике.

1. [Подготовьте кластер-приемник](operations/prepare.md#target-my).

## Создайте эндпоинт для источника {#source}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/data-transfer) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Нажмите кнопку **Создать эндпоинт**.
  1. В поле **Направление** выберите `Источник`.
  1. Укажите имя эндпоинта.
  1. В поле **Тип базы данных** выберите `MySQL®`.
  1. Укажите параметры эндпоинта в соответствующем блоке настроек.
  
     Подробнее о доступных параметрах читайте в разделе [Передача данных из эндпоинта-источника MySQL®](operations/endpoint/source/mysql.md).

  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте эндпоинт для приемника {#target}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/data-transfer) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../_assets/console-icons/aperture.svg) **Эндпоинты**.
  1. Нажмите кнопку **Создать эндпоинт**.
  1. В поле **Направление** выберите `Приёмник`.
  1. Укажите имя эндпоинта.
  1. В поле **Тип базы данных** выберите `MySQL®`.
  1. Укажите параметры эндпоинта в соответствующем блоке настроек.

     Подробнее о доступных параметрах читайте в разделе [Передача данных в эндпоинт-приемник MySQL®](operations/endpoint/target/mysql.md).

  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте трансфер {#create-transfer}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/data-transfer) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **Трансферы**.
  1. Нажмите кнопку **Создать трансфер**.
  1. Укажите имя трансфера.
  1. (Опционально) Добавьте описание трансфера.
  1. Выберите созданные эндпоинты для источника и приемника.
  1. Выберите [тип трансфера](concepts/index.md#transfer-type):

     * **Копирование** — чтобы создать полную копию данных без дальнейшего получения обновлений из источника. Этот тип также можно использовать для [репликации постоянно меняющихся таблиц](concepts/transfer-lifecycle.md#select-transfer-type).

       Если вам нужно создавать полную копию данных через определенные интервалы времени, включите настройку **Периодическое копирование**.

     * **Репликация** — чтобы непрерывно получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).
     * **Копирование и репликация** — чтобы создать полную копию данных источника и поддерживать ее в актуальном состоянии.

  1. Нажмите кнопку **Создать**.

{% endlist %}

Подробнее читайте в разделе [Создать трансфер](operations/transfer.md#create).

## Активируйте трансфер {#activate}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/data-transfer) в сервис **Data Transfer**.
  1. На панели слева выберите ![image](../_assets/console-icons/arrow-right-arrow-left.svg) **Трансферы**.
  1. Нажмите значок ![ellipsis](../_assets/console-icons/ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **Активировать**.

{% endlist %}

Начнется процесс переноса данных.

## Завершите перенос данных {#finish-transfer}

1. Дождитесь перехода трансфера в статус **Реплицируется**.
1. Переведите кластер-источник в режим _только чтение_ и переключите нагрузку на кластер-приемник.
1. Отслеживайте состояние трансфера на странице [мониторинга](operations/monitoring.md).

   Когда [график](operations/monitoring.md#sinker.pusher.time.row_max_lag_sec) **Maximum data transfer delay** (отставание данных в секундах) упадет до нуля, все изменения, произошедшие в кластере-источнике после завершения копирования данных, будут перенесены в кластер-приемник. С этого момента вы сможете работать с перенесенными данными.

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте больше о [подготовке баз данных для использования сервиса](operations/prepare.md) и [настройке трансферов](operations/transfer.md).
* Изучите [роли](security/index.md), действующие в Data Transfer.
* Ознакомьтесь с [практическими руководствами по работе с сервисом](tutorials/index.md).