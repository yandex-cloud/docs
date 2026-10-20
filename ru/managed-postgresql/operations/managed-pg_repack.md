---
title: Перепаковка данных в {{ mpg-full-name }}
description: Следуя данной инструкции, вы сможете выполнять перепаковку таблиц и индексов в {{ mpg-name }}.
---

# Перепаковка данных в {{ mpg-name }}

Перепаковка таблиц и индексов устраняет _раздувание данных_ (bloat).


Получить информацию о состоянии таблиц и индексов можно в [консоли управления]({{ link-console-main }}) на вкладке **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** страницы управления кластером или в сервисе [{{ monitoring-full-name }}](../../monitoring/index.yaml).

[Подробнее о мониторинге состояния кластера {{ PG }}](monitoring.md).

## Получить список рекомендуемых к перепаковке объектов {#recomendations-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}**.
    
      На вкладке отображаются рекомендуемые к перепаковке объекты с наибольшим уровнем раздутия.

      Для каждой базы данных отображается не более 10 объектов, а для всего кластера — не более 1000 объектов. В список включены только объекты, у которых процент раздутия выше 5% или размер раздутия больше 1 ГБ. Вы также можете [выполнить перепаковку объектов, которых нет в списке рекомендуемых](#start-repack-not-recommended).

{% endlist %}

### Отсортировать список рекомендуемых к перепаковке объектов {#sort-recomendations-repack}

Чтобы отсортировать рекомендуемые к перепаковке объекты, на вкладке **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}** выберите:

* В поле **Тип объекта** — тип отображаемого объекта. Доступные варианты: **Таблица**, **Индекс** или **Все** объекты.
* В поле **Топ по** — метрику, по которой отбираются объекты. Доступные варианты: **Размер** раздутых данных (в байтах) или **Процент** раздутых данных от общего размера объекта.
* В поле **База данных** — базу данных, которой принадлежат объекты.

## Получить список активных перепаковок {#active-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.

{% endlist %}

## Запустить перепаковку рекомендуемого объекта {#start-repack}

Вы можете запустить перепаковку одного или нескольких объектов. Если объектов несколько, они должны быть одного типа.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_recomendations_vRLWf }}**.
  1. Выберите один или несколько объектов для перепаковки и внизу экрана нажмите **{{ ui-key.yacloud.postgresql.DataRepack.TopBloatObjects.action_start-repack_7ccLM }}**.
  1. Подтвердите запуск перепаковки.

{% endlist %}

## Запустить перепаковку объекта, которого нет в списке рекомендуемых {#start-repack-not-recommended}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_start-repack_tnJdP }}**.
  1. Выберите тип объекта для перепаковки и укажите одно или несколько имен объектов.
  1. Нажмите кнопку **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_start-repack_tnJdP }}**.

{% endlist %}

## Остановить перепаковку {#cancel-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.postgresql.DataRepack.StartRepackFormDialog.action_cancel_4wAmZ }}**.

{% endlist %}

## Посмотреть логи перепаковки {#log-repack}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_data-repack }}**.
  1. На открывшейся странице перейдите на вкладку **{{ ui-key.yacloud.postgresql.DataRepack.DataRepackPageContent.title_active-repacks_hjUWj }}**.
  1. В строке нужной перепаковки нажмите на значок ![icon](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.postgresql.DataRepack.RunningRepacks.action_goto-logs_5Ng11 }}**.

      На открывшейся странице будут отображены логи `REPACK` за период времени с начала перепаковки до текущего времени. Чтобы посмотреть подробную информацию о событии, нажмите на интересующую запись в списке.

      Подробнее о работе с логами кластера в разделе [{#T}](cluster-logs.md).

{% endlist %}