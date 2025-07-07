{% include [http-common-body-params](./http-common-body-params.md) %}

* `sortMode` — правило сортировки результатов поиска, которое определяет порядок выдачи результатов поиска. Необязательный параметр. Возможные значения:

    * `SORT_MODE_BY_RELEVANCE` — сортировка по релевантности (значение по умолчанию).
    * `SORT_MODE_BY_TIME` — сортировка по времени изменения документа.
* `sortOrder` — порядок сортировки результатов поиска. Необязательный параметр. Возможные значения:

    * `SORT_ORDER_DESC` — прямой порядок сортировки — от наиболее свежего к наиболее старому (значение по умолчанию).
    * `SORT_ORDER_ASC` — обратный порядок сортировки — от наиболее старого к наиболее свежему.
* `groupMode` — метод группировки результатов. Необязательный параметр. Возможные значения:

    * `GROUP_MODE_DEEP` — группировка по доменам. Каждая группа содержит документы одного домена (значение по умолчанию).
    * `GROUP_MODE_FLAT` — плоская группировка. Каждая группа содержит один документ.
* `groupsOnPage` — максимальное количество групп, которые могут быть возвращены на одной странице результатов поиска. Необязательный параметр. Значение по умолчанию — `20`.

    При получении результата в [формате XML](../../search-api/concepts/response.md) допустимые значения — от `1` до `100`, при получении результата в [формате HTML](../../search-api/concepts/html-response.md) — от `5` до `50`.
* `docsInGroup` — максимальное количество документов, которые могут быть возвращены в одной группе. Необязательный параметр. Допустимые значения — от `1` до `3`. Значение по умолчанию — `1`.
* `maxPassages` — максимальное количество пассажей, которое может быть использовано при формировании сниппета к документу. Необязательный параметр. Допустимые значения — от `1` до `5`. По умолчанию для каждого документа возвращается не более четырех пассажей с текстом запроса.
* `region` — идентификатор страны или региона поиска, который влияет на правила ранжирования документов. Поддерживается только для типов поиска `Русский` и `Турецкий`.

    Список идентификаторов часто используемых стран и регионов см. в разделе [Регионы поиска](../../search-api/reference/regions.md).
* `l10N` — язык уведомлений поискового ответа. Влияет на текст, передаваемый в теге `found-docs-human` и в сообщениях об ошибках. Необязательный параметр. Возможные значения зависят от выбранного типа поиска:

    * Тип поиска `Русский`:
        * `LOCALIZATION_RU` — русский язык (значение по умолчанию).
        * `LOCALIZATION_BE` — белорусский язык.
        * `LOCALIZATION_KK` — казахский язык.
        * `LOCALIZATION_UK` — украинский язык.
    * Тип поиска `Турецкий`:
        * `LOCALIZATION_TR` — турецкий язык.
    * Тип поиска `Международный`:
        * `LOCALIZATION_EN` — английский язык.
* `folderId` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) пользователя или сервисного аккаунта, от имени которого вы будете выполнять запросы.
* `responseFormat` — формат получения поисковой выдачи. Необязательный параметр. Возможные значения:

    * `FORMAT_XML` — результат запроса будет передан в [формате XML](../../search-api/concepts/response.md) (значение по умолчанию).
    * `FORMAT_HTML` — результат запроса будет передан в [формате HTML](../../search-api/concepts/html-response.md).
* `userAgent` — строка, содержащая [заголовок User-Agent](https://en.wikipedia.org/wiki/User-Agent_header). Параметр позволяет получить поисковую выдачу, ориентированную на конкретные устройство и браузер, в том числе [мобильную выдачу](../../search-api/operations/v2-mobile.md). Необязательный параметр. Если параметр не задан, сервис возвращает стандартную выдачу по умолчанию.

**Список поддерживаемых параметров:**

{% include [xml-html-fields-differ-notice](./xml-html-fields-differ-notice.md) %}

| Параметр  | Поддерживается при [XML-ответе](../../search-api/concepts/response.md)  | Поддерживается при [HTML-ответе](../../search-api/concepts/html-response.md) |
| --- | --- | --- |
| `searchType` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `queryText` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `familyMode` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `fixTypoMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sortMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sortOrder` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groupMode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groupsOnPage` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `docsInGroup` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `maxPassages` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `region` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `l10N` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `folderId` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `responseFormat` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `userAgent` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |