---
title: Как выполнять запросы к {{ search-api-full-name }} с помощью API v1
description: Следуя данной инструкции, вы узнаете, как использовать API v1 сервиса {{ search-api-name }} для отправки поисковых запросов и получения поисковой выдачи.
---

# Выполнение поисковых запросов с помощью API v1

[API v1](../concepts/index.md#api-v1) сервиса {{ search-api-name }} позволяет выполнять [текстовый поиск](../concepts/get-request.md) и [поиск по картинкам](../concepts/pic-search.md) в поисковой базе Яндекса и получать результат поиска в формате [XML](../concepts/response.md) или [HTML](../concepts/html-response.md) (для текстового поиска) в синхронном режиме. Поисковая выдача зависит от заданных в запросе параметров.

## Перед началом работы {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте облако к работе {#initial-setup}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) созданному сервисному аккаунту [роль](../security/index.md#search-api-executor) `{{ roles-search-api-executor }}`.
1. [Создайте](../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ для созданного сервисного аккаунта.
1. [Зарегистрируйтесь](./workaround.md) в сервисе {{ search-api-name }}.

## Сформируйте поисковый запрос {#form-request}

В зависимости от типа поиска, выбранного при регистрации в сервисе, указывайте в запросе подходящее имя домена:
* `yandex.ru` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}`;
* `yandex.com.tr` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-turkish }}`;
* `yandex.com` — для типа поиска `{{ ui-key.yacloud.search-api.test-query.label_search_type-international }}`.

{% list tabs %}

- Текстовый поиск методом GET

  Для текстового поиска вы можете использовать [GET-запросы](../concepts/get-request.md).

  {% note warning %}

  Специальные символы, передаваемые в качестве значений параметров, необходимо заменять на соответствующие экранированные последовательности в соответствии с percent-encoding. Например, вместо знака равно `=` используйте последовательность `%3D`.

  {% endnote %}

  1. Чтобы получить ответ в [XML-формате](../concepts/response.md), сформируйте GET-запрос в следующем виде:

      ```httpget
      https://yandex.<домен>/search/xml
        ? [folderid=<идентификатор_каталога>]
        & [apikey=<API-ключ>]
        & [query=<текст_поискового_запроса>]
        & [lr=<идентификатор_региона_поиска>]
        & [l10n=<язык_уведомлений>]
        & [sortby=<тип_сортировки>]
        & [filter=<тип_фильтрации>]
        & [maxpassages=<количество_пассажей>]
        & [groupby=<параметры_группировки_результатов>]
        & [page=<номер_страницы>]
      ```

      Подробную информацию о параметрах запроса см. в разделе [Параметры запроса](../concepts/get-request.md#parameters).

      **Пример запроса**:

      ```httpget
      https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4
      ```

      Этот запрос возвращает пятую страницу результатов поиска по запросу `<table>`. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Регион поиска — Новосибирская область. Язык уведомлений — русский. К результатам поиска будет применен семейный фильтр. Количество пассажей — три. Результаты группируются по домену и сортируются по релевантности. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно пяти.

  1. Отправьте запрос к поисковой базе Яндекса. Для этого воспользуйтесь утилитой [cURL](https://curl.haxx.se):

      ```bash
      curl \
        --request GET \
        --output result.xml \
        'https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&query=%3Ctable%3E&lr=11316&l10n=ru&sortby=rlv&filter=strict&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D5.docs-in-group%3D3&maxpassages=3&page=4'
      ```

      В результате выполнения запроса в текущей директории будет сохранен файл `result.xml`, содержащий результаты поискового запроса в формате [XML](../concepts/response.md).

      Для того чтобы получить ответ в формате [HTML](../concepts/html-response.md), добавьте `/html` в путь URL запроса. Например: `https://yandex.ru/search/xml/html?folderid=b1...`. Подробнее см. в разделе [{#T}](../concepts/get-request.md#get-request-format).

- Текстовый поиск методом POST

  Для текстового поиска вы можете использовать [POST-запросы](../concepts/post-request.md).

  {% note warning %}

  Специальные символы, передаваемые в качестве значений параметров в теле запроса, необходимо заменять на соответствующие экранированные последовательности в соответствии с XML-encoding. Например, вместо символа амперсанд `&` используйте последовательность `&amp;`.

  {% endnote %}

  1. Чтобы получить ответ в [XML-формате](../concepts/response.md), сформируйте URL POST-запроса в следующем виде:

      ```httpget
      https://yandex.<домен>/search/xml
        ? [folderid=<идентификатор_каталога>]
        & [filter=<тип_фильтрации>]
        & [lr=<идентификатор_региона_поиска>]
        & [l10n=<язык_уведомлений>]
      ```

      Подробную информацию о параметрах URL запроса см. в разделе [Параметры запроса](../concepts/post-request.md#parameters).

      **Пример запроса**:

      ```httppost
      https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru
      ```

  1. Подготовьте файл с телом запроса, например `body.xml`.

      **Пример файла с телом запроса**:

      ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <request>
        <query>&lt;table&gt;</query>
        <sortby order="descending">tm</sortby>
        <maxpassages>2</maxpassages>
        <page>4</page>
        <groupings>
          <groupby attr="d" mode="deep" groups-on-page="10" docs-in-group="3" />
        </groupings>
      </request>
      ```

      Подробную информацию о параметрах, задаваемых в теле запроса, см. в разделе [Параметры тела запроса](../concepts/post-request.md#post-body-parameters).

      Приведенный пример запроса возвращает пятую страницу результатов поиска по запросу `<table>`. Результаты сортируются по времени редактирования документа в порядке от наиболее свежего к наиболее старому. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Регион поиска — Новосибирская область. К результатам поиска применен семейный фильтр. Результаты группируются по домену. Каждая группа содержит три документа, а количество групп, возвращаемых на одной странице, равно десяти. Максимальное количество пассажей на один документ — два.

  1. Отправьте запрос к поисковой базе Яндекса. Для этого воспользуйтесь утилитой [cURL](https://curl.haxx.se):

      ```bash
      curl \
        --request POST \
        --header "Authorization: Api-Key <API-ключ>" \
        --data "@body.xml" \
        --output result.xml \
        'https://yandex.ru/search/xml?folderid=b1gt6g8ht345********&filter=strict&lr=11316&l10n=ru'
      ```

      В результате выполнения запроса в текущей директории будет сохранен файл `result.xml`, содержащий результаты поискового запроса в формате [XML](../concepts/response.md).

      Для того чтобы получить ответ в формате [HTML](../concepts/html-response.md), добавьте `/html` в путь URL запроса. Например: `https://yandex.ru/search/xml/html?folderid=b1...`. Подробнее см. в разделе [{#T}](../concepts/post-request.md#post-request-format).

- Поиск по картинкам

  В настоящий момент для поиска по картинкам можно использовать только GET-запросы.

  {% note warning %}

  Специальные символы, передаваемые в качестве значений параметров, необходимо заменять на соответствующие экранированные последовательности в соответствии с percent-encoding. Например, вместо знака равно `=` используйте последовательность `%3D`.

  {% endnote %}

  1. Сформируйте GET-запрос в следующем формате:

      ```text
      https://yandex.<домен>/images-xml
        ? [folderid=<идентификатор_каталога>]
        & [apikey=<API-ключ>]
        & [text=<текст_поискового_запроса>]
        & [groupby=<настройки_группировки_результатов>]
        & [p=<номер_страницы>]
        & [fyandex=<фильтр_семейный_поиск>]
        & [site=<доменное_имя_сайта>]
        & [itype=<формат_картинки>]
        & [iorient=<тип_ориентации_изображения>]
        & [isize=<размер_картинки>]
        & [icolor=<цвет_картинки>]
      ```

      Подробную информацию о параметрах запроса см. в разделе [Параметры запроса](../concepts/pic-search.md#parameters).

      **Пример запроса**:

      ```html
      https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color
      ```

      Этот запрос возвращает третью страницу результатов поиска картинок по запросу `funny cats`. Тип поиска — `{{ ui-key.yacloud.search-api.test-query.label_search_type-russian }}` (yandex.ru). Сервис возвращает результаты для найденных на сайте `somepics.ru` цветных картинок среднего размера в формате JPG с горизонтальной ориентацией изображения. К результатам поиска будет применен фильтр «Семейный поиск». Страница будет содержать три группы результатов поиска.

  1. Отправьте запрос к поисковой базе картинок Яндекса. Для этого воспользуйтесь утилитой [cURL](https://curl.haxx.se):

      ```bash
      curl \
        --request GET \
        --output result.xml \
        'https://yandex.ru/images-xml?folderid=b1gt6g8ht345********&apikey=your_service_account_API_key********&text=funny+cats&groupby=attr=ii.groups-on-page=3&p=2&fyandex=1&site=somepics.ru&itype=jpg&iorient=horizontal&isize=medium&icolor=color'
      ```

      В результате выполнения запроса в текущей директории будет сохранен файл `result.xml`, содержащий результаты поискового запроса в [формате](../concepts/pic-response.md) XML.

{% endlist %}