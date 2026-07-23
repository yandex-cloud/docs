---
title: Архивация трейсов
description: Автоматическое сохранение просмотренных трейсов в архив с расширенным сроком хранения.
---

# Архивация трейсов

Когда вы открываете трейс в интерфейсе {{ monium-name }}, он автоматически сохраняется в архив. Архивные трейсы хранятся дольше, чем трейсы в основном хранилище, что позволяет обращаться к ним для анализа инцидентов, аудита и разборов проблем.

## Как работает архивация {#how-it-works}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![alt](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../../_assets/console-icons/hierarchy.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.
  1. Выберите трейс. Система автоматически сохраняет этот трейс в архив.
  1. Архивный трейс хранится с расширенным сроком хранения.
  1. Вы можете обращаться к архивному трейсу в любой момент.

{% endlist %}

Архивация происходит автоматически — никаких дополнительных действий не требуется.

## Доступ к архивным трейсам {#access}

Архивные трейсы доступны в интерфейсе {{ monium-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![alt](../../../_assets/console-icons/compass.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.all-panel.menu.category.explore }}** → ![alt](../../../_assets/console-icons/hierarchy.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.
  1. Используйте поиск по `trace_id`.
  1. Если трейс был ранее просмотрен и сохранен в архив, он будет доступен в результатах поиска.

{% endlist %}

Также архивные трейсы доступны по прямой ссылке.
