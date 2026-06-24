---
title: Какие возникают ошибки при работе с {{ sd-full-name }}
description: Из статьи вы узнаете, какие бывают ошибки в работе сервиса {{ sd-full-name }}.
---

# Диагностика ошибок в {{ sd-full-name }}

В интерфейсе {{ sd-name }} собраны все ошибки в работе следующих модулей:

* [{{ vuln-man-name }} ({{ vuln-man-short-name }})](vm-diagnostic.md)
* [{{ td-full-name }} ({{ td-name }})](td-diagnostics.md)
* [Контроль {{ k8s }}® ({{ kspm-name }})](kspm-diagnostics.md)
* [Контроль конфигурации ({{ cspm-name }})](cspm-diagnostics.md)
* [Контроль данных ({{ dspm-name }})](dspm-diagnostics.md)

Чтобы посмотреть обнаруженные ошибки:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. В верхней части окна выберите [окружение](*popup-1).
  1. На панели слева нажмите ![vector-circle](../../_assets/console-icons/vector-circle.svg) **Окружение**.
  1. Перейдите на вкладку **Уведомления**.
  1. Выберите модуль. Отобразится таблица со следующими столбцами:
     
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_message_b4Q1s }}` — текст ошибки.
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_source_y9C3p }}` — ресурс, в котором была обнаружена ошибка.
     * `{{ ui-key.yacloud_org.security.workspaces.WorkspaceModuleErrorsTable.field_date_d5R8n }}` — дата обнаружения ошибки.

{% endlist %}

[*popup-1]: _Окружение {{ sd-name }}_ — это контейнер, который содержит настройки и ресурсы модулей {{ sd-name }}, перечень контролируемых ресурсов, параметры контроля и другие настройки.
