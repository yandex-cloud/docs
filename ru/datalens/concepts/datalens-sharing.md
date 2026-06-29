---
title: Поделиться объектом в организации в {{ datalens-full-name }}
description: Следуя данной инструкции, вы узнаете, как поделиться объектом с пользователями внутри организации в {{ datalens-full-name }}.
---

# Поделиться объектом в организации

Вы можете поделиться дашбордом, подключением, датасетом, чартом или отчетом с пользователями внутри организации.

Как поделиться объектом, зависит от его [расположения](./publishing-and-embedding.md#object-location) — в [воркбуке](../workbooks-collections/index.md#enable-workbooks) или в папке:

{% list tabs %}

- В воркбуке

  {% include [datalens-share-wb](../../_includes/datalens/operations/datalens-share-wb.md) %}

- В папке

  {% list tabs %}

  - Поделиться дашбордом {#dashboard}

    {% include [datalens-link-dashboard](../../_includes/datalens/operations/datalens-link-dashboard.md) %}

  - Поделиться другим объектом {#chart}

    {% include [datalens-link-chart](../../_includes/datalens/operations/datalens-link-chart.md) %}

  {% endlist %}

{% endlist %}

{% note info %}

По полученной ссылке объекты доступны только авторизованным пользователям с учетом прав доступа на них.

{% endnote %}
