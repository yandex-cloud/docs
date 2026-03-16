---
title: Управление запросами в {{ ycdr-full-name }}
description: Следуя данной инструкции, вы научитесь создавать, редактировать, запускать и удалять запросы в {{ ycdr-name }}.
---

# Управление запросами

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

В этом разделе описано, как создавать и выполнять запросы на языке [KQL (Kusto Query Language)](../../kql-reference.md), а также управлять ими.

## Создание нового запроса {#create-query}

Чтобы создать новый запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование.
  1. Нажмите **{{ ui-key.yacloud_org.security.ycdr.InvestigationPageLayout.newQuery_mzeBV }}**.
  1. В редакторе запросов введите KQL-запрос или выберите шаблон.

  {% note tip %}

  Используйте подсказку в редакторе: {{ ui-key.yacloud_org.security.ycdr.query-placeholder_auE1D }}.

  {% endnote %}

{% endlist %}

## Редактирование запроса {#edit-query}

Чтобы отредактировать запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте расследование с нужным запросом.
  1. Выберите вкладку с запросом.
  1. Внесите изменения в редакторе запросов.

  Изменения сохраняются автоматически.

{% endlist %}

## Выбор периода {#select-time-period}

Чтобы выбрать период для запроса:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Нажмите на селектор периода рядом с кнопкой запуска.
  1. Выберите один из пресетов:
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_5_minutes_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_30_minutes_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_1_hour_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_3_hours_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_6_hours_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_12_hours_s5Gq5 }};
     * {{ ui-key.yacloud_org.security.ycdr.preset_last_day_s5Gq5 }}.

  Или выберите произвольный период:

  1. Нажмите на селектор временного периода.
  1. Выберите произвольный период.
  1. Укажите дату и время начала периода.
  1. Укажите дату и время окончания периода.
  1. Нажмите **{{ ui-key.yacloud.common.apply }}**.

{% endlist %}

## Запуск запроса {#run-query}

Чтобы запустить запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Убедитесь, что запрос введен в редакторе.
  1. Выберите временной период.
  1. Нажмите кнопку запуска запроса.

  После запуска запрос переходит в статус **{{ ui-key.yacloud_org.security.siem.cell-result-running_4S3Mi }}**. По завершении результаты отображаются в таблице и на гистограмме.

{% endlist %}

## Остановка выполняющегося запроса {#stop-query}

Чтобы остановить выполняющийся запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Во время выполнения запроса нажмите кнопку остановки.
  1. Запрос перейдет в статус **{{ ui-key.yacloud_org.security.siem.cell-result-canceled_fqtbJ }}**.

{% endlist %}

## Переименование запроса {#rename-query}

Чтобы переименовать запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Нажмите на название запроса на вкладке.
  1. Введите новое название.
  1. Нажмите клавишу **Enter** или кликните вне поля ввода.

{% endlist %}

## Удаление запроса {#delete-query}

Чтобы удалить запрос:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Нажмите правой кнопкой мыши на вкладку запроса.
  1. Выберите **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Подтвердите удаление.

  {% note warning %}

  Удаление запроса необратимо. Результаты и история выполнения будут удалены.

  {% endnote %}

{% endlist %}

## Поделиться запросом {#share-query}

Чтобы поделиться запросом:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Откройте запрос.
  1. В меню действий выберите **{{ ui-key.yacloud_org.security.siem.cell-result-action-share_i1khy }}**.
  1. Скопируйте ссылку на запрос.

  Ссылка содержит текст запроса и выбранный период. Получатель сможет открыть запрос в своем расследовании.

{% endlist %}

## Настройка отображаемых полей в результатах {#configure-result-fields}

Чтобы настроить отображаемые поля в таблице результатов:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Выполните запрос.
  1. В таблице результатов нажмите на значок настройки столбцов.
  1. Выберите поля, которые хотите отображать.
  1. Измените порядок полей перетаскиванием.
  1. Нажмите **{{ ui-key.yacloud.common.apply }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/investigations.md).
* [{#T}](../../concepts/queries.md).
* [{#T}](work-with-templates.md).
* [{#T}](query-history.md).