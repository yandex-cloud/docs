---
title: Работать с алертами в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} работать с алертами.
---

# Работа с алертами

## Изменить статус алерта {#status}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем [алерта](../../concepts/alerts.md).
  1. В открывшемся окне в левом верхнем углу выберите статус.

{% endlist %}


## Проанализировать алерт с помощью ИИ {#ai-analysis}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем алерта.
  1. В открывшемся окне нажмите ![sparkles](../../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud_org.security-center.alert.action_alert_analysis }}**.

      Справа откроется панель диалога с AI-ассистентом и его анализом.

{% endlist %}


## Оставить комментарий к алерту {#comment}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Нажмите на строку таблицы с именем алерта.
  1. В открывшемся окне перейдите на вкладку **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}**.
  1. Введите и оформите комментарий, затем нажмите ![paper-plane](../../../_assets/console-icons/paper-plane.svg) **{{ ui-key.yacloud_org.security.alerts.comment_form.send }}**.

{% endlist %}
