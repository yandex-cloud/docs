# DataLens Public

С помощью {{ datalens-public }} вы можете предоставить публичный доступ к созданным чартам и дашбордам: любой пользователь может просмотреть опубликованный объект без авторизации.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Правила публикации {#rules}

Для публикации чарта или дашборда необходимо выполнить следующие условия:

- [Материализовать датасет](../operations/dataset/materialize.md). После материализации {{datalens-short-name}} имеет гарантированный доступ к данным.
- Выдать права публикации на связанные датасеты и подключения. Для этого вам необходимо иметь права доступа `{{ permission-admin }}` на эти объекты.

## Как опубликовать объект {#how-to-publish}

Вы можете предоставить публичный доступ к дашборду или чарту.

{% list tabs %}

- Дашборд

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Чарт

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}