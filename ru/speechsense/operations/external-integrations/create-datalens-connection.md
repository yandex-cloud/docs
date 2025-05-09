---
title: Создание подключения к {{ speechsense-full-name }} из {{ datalens-full-name }}
description: Из статьи вы узнаете, как создать подключение к {{ speechsense-name }} из {{ datalens-short-name }}.
---

# Создание подключения к {{ speechsense-name }} из {{ datalens-full-name }}

{% include [datalens-speechsense-connection-roles-note](../../../_includes/datalens/operations/datalens-speechsense-connection-roles-note.md) %}

Вы можете создать подключение из интерфейса {{ datalens-full-name }} или со страницы проекта {{ speechsense-name }}.

{% list tabs group=instructions %}

- Интерфейс {{ datalens-name }} {#datalens}

  {% include [create-speechsense-connection](../../../_includes/datalens/operations/datalens-create-speechsense-connection.md) %}

- Интерфейс {{ speechsense-name }} {#speechsense}

  1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
  1. Перейдите в нужное пространство, затем выберите нужный проект.
  1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.reports.reports }}**.
  1. Нажмите **{{ ui-key.yc-ui-talkanalytics.reports.datalens-key-value }}** — вы перейдете в {{ datalens-short-name }}. Поле **ID проекта** в подключении к {{ speechsense-name }} будет заполнено автоматически.
  1. Оставьте опцию **Автоматически создать дашборд, чарты и датасет над подключением** включенной, если хотите получить готовый дашборд, датасет и стандартный набор чартов.

     ![image](../../../_assets/datalens/operations/connection/connection-speechsense.png)

  1. Нажмите **Создать подключение**.
  1. Укажите название подключения и нажмите **Создать**.

{% endlist %}
