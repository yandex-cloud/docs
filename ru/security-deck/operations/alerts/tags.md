---
title: Управление тегами алертов в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} можно добавить или удалить теги алертов.
---

# Управлять тегами алертов

Теги упрощают поиск алертов и позволяют добавить к ним контекст.

## Добавить теги алерту {#add-tag}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Выберите алерт.
  1. В поле **{{ ui-key.yacloud_org.security-center.alert.overview_tags }}**:
  
     * Если у алерта нет тегов, нажмите **{{ ui-key.yacloud_org.security.alerts.AlertTagsControl.action_add-tag_bu4cy }}**.
     * Если у алерта есть теги, нажмите значок ![image](../../../_assets/security-deck/add-tag.svg).

  1. Введите название тега или выберите из списка.

{% endlist %}

## Добавить теги нескольким алертам {#add-tag-multiple}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Отметьте ![image](../../../_assets/console-icons/check.svg) необходимые алерты и нажмите ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud_org.security.alerts.i18n.ts.action-add-tags_kUsL6 }}**.
  1. В открывшемся окне нажмите **{{ ui-key.yacloud_org.security.alerts.AlertTagsControl.action_add-tag_bu4cy }}** и введите название тега или выберите из списка.

{% endlist %}

## Удалить теги алерта {#remove-tag}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Выберите алерт.
  1. В поле **{{ ui-key.yacloud_org.security-center.alert.overview_tags }}** нажмите значок ![image](../../../_assets/security-deck/xmark.svg) рядом с тегом, который необходимо удалить.

{% endlist %}
