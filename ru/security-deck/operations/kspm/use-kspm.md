---
title: Работать с дашбордом модуля Контроль {{ k8s }}® (KSPM) в {{ sd-full-name }}
description: Инструкция по работе с интерфейсом модуля Контроль {{ k8s }}® (KSPM) в {{ sd-name }}.
---

# Работать с дашбордом модуля KSPM

{% include [note-preview-kspm](../../../_includes/security-deck/note-preview-kspm.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![image](../../../_assets/security-deck/kspm.svg) **{{ ui-key.yacloud_org.security-center.label_kspm }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md).
  1. На вкладке **{{ ui-key.yacloud_org.security-center.kspm.title_clusters }}** убедитесь, что все кластеры подключены к KSPM и находятся в активном статусе контроля.
  1. Изучите вкладку **{{ ui-key.yacloud_org.security-center.kspm.title_dashboard }}**. На ней размещены следующие блоки:
      * **{{ ui-key.yacloud_org.security.kspm.TopControlsByErrorsWidget.table_controls_rJ32E }}** — содержит самые нарушаемые в области контроля правила и количество нарушений.
      * Блок с общей статистикой по области контроля — содержит количество кластеров с ошибками подключения к KSPM, количество кластеров с предупреждениями по безопасности, а также **{{ ui-key.yacloud_org.kspm.TopClustersByErrorsWidget.table_clusters }}** и количество нарушений.
      * Список алертов с указанием типа угрозы, статуса и временем последнего обновления.

        {% include [kspm-alerts](../../../_includes/security-deck/kspm-alerts.md) %}

{% endlist %}