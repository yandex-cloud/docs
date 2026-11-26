---
title: Вопросы и ответы про дашборды
description: На странице представлены вопросы и ответы про дашборды.
---

# Дашборды



{% include [configure-link-between-selectors](../../_qa/datalens/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../../_qa/datalens/unavailable-selector-values.md) %}

{% include [apply-filter-to-two-datasets](../../_qa/datalens/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../../_qa/datalens/configure-selectors.md) %}

{% include [making-available-chart](../../_qa/datalens/making-available-chart.md) %}

### Что делать, если при сохранении дашборда возникает ошибка `Validation error Request failed with status code 500`? {#validation-error-500}

В имени дашборда можно использовать:

* прописные и строчные буквы латиницы или кириллицы;
* цифры;
* дефис, точку и пробел.

Если в имени есть другие символы, измените его и повторно сохраните дашборд.

### Почему селектор отменяет фильтр, заданный в чарте? {#filter-filtered-data}

Фильтр уровня дашборда имеет приоритет над фильтром уровня чарта. Продублируйте в чарте поле, по которому нужно фильтровать данные: оригинальное поле используйте в фильтре чарта, а копию — в селекторе на дашборде.

### Что делать, если пропал доступ к дашборду со статистикой подкастов в Яндекс Музыке или в нем отображаются не все подкасты? {#yandex-music-podcast-statistics}

Статистика в {{ datalens-full-name }} обновляется раз в сутки, поэтому данные на графиках могут временно отличаться от статистики в Яндекс Музыке. Подождите от одного часа до суток и проверьте дашборд еще раз.

Если проблема осталась, откройте [форму обратной связи Яндекс Музыки](https://yandex.ru/support/music/podcast-authors/statistics.html#statistics__feedback-form), перейдите к блоку **Нужна помощь** внизу страницы и нажмите **Написать в чат**.

### Как сделать публичным дашборд, содержащий данные Метрики или AppMetrica? {#how-metrica-appmetrica-share}

Опубликовать такой дашборд нельзя.

Чтобы поделиться дашбордом, содержащим данные Метрики или AppMetrica, воспользуйтесь одним из способов:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}




{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
