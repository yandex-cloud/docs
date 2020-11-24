# DataLens Public

С помощью {{ datalens-public }} вы можете предоставить публичный доступ к созданным чартам и дашбордам: любой пользователь может просмотреть опубликованный объект без авторизации.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Правила публикации {#rules}

Для публикации чарта или дашборда необходимо выполнить следующие условия:

- [Материализовать датасет](../operations/dataset/materialize.md). После материализации {{datalens-short-name}} имеет гарантированный доступ к данным. 

    {% include [datalens-materialisation](../../_includes/datalens/datalens-materialisation.md) %}

- Выдать права публикации на связанные датасеты и подключения. Для этого вам необходимо иметь права доступа `{{ permission-admin }}` на эти объекты.

## Встраивание публичных чартов {#embedded-public-chart}

Вы можете встроить опубликованные чарты на сайт или в приложение с помощью элемента `iframe`.

Перед добавлением чарта в `iframe` необходимо добавить к адресу чарта параметр `_embedded=1`.
Параметр добавляется к адресу после знака вопроса `?`.
Например: 
```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?_embedded=1"></iframe>
```

Дополнительно вы можете передать параметр, который задает оформление чарта:
* `_theme=light` — для отображения чарта в светлой теме.
* `_theme=dark` — для отображения чарта в темной теме.

Чтобы передать больше одного параметра, перечислите их через знак амперсанда `&`. 
Например:
```
<iframe src="https://datalens.yandex/oxxbqilhotpgk?_embedded=1&_theme=dark"></iframe>
```

## Как опубликовать объект {#how-to-publish}

Вы можете предоставить публичный доступ к дашборду или чарту.

{% list tabs %}

- Дашборд

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Чарт

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}