{% include [grpc-common-body-params](./grpc-common-body-params.md) %}

* `sort_mode` — правило сортировки результатов поиска, которое определяет порядок выдачи результатов поиска. Необязательный параметр. Возможные значения:

    * `SORT_MODE_BY_RELEVANCE` — сортировка по релевантности (значение по умолчанию).
    * `SORT_MODE_BY_TIME` — сортировка по времени изменения документа.
* `sort_order` — порядок сортировки результатов поиска. Необязательный параметр. Возможные значения:

    * `SORT_ORDER_DESC` — прямой порядок сортировки — от наиболее свежего к наиболее старому (значение по умолчанию).
    * `SORT_ORDER_ASC` — обратный порядок сортировки — от наиболее старого к наиболее свежему.
* `group_mode` — метод группировки результатов. Необязательный параметр. Возможные значения:

    * `GROUP_MODE_DEEP` — группировка по доменам. Каждая группа содержит документы одного домена (значение по умолчанию).
    * `GROUP_MODE_FLAT` — плоская группировка. Каждая группа содержит один документ.
* `groups_on_page` — максимальное количество групп, которые могут быть возвращены на одной странице результатов поиска. Необязательный параметр. Значение по умолчанию — `20`.

    При получении результата в [формате XML](../../search-api/concepts/response.md) допустимые значения — от `1` до `100`, при получении результата в [формате HTML](../../search-api/concepts/html-response.md) — от `5` до `50`.
* `docs_in_group` — максимальное количество документов, которые могут быть возвращены в одной группе. Необязательный параметр. Допустимые значения — от `1` до `3`. Значение по умолчанию — `1`.
* `max_passages` — максимальное количество пассажей, которое может быть использовано при формировании сниппета к документу. Необязательный параметр. Допустимые значения — от `1` до `5`. По умолчанию для каждого документа возвращается не более четырех пассажей с текстом запроса.
* `region` — идентификатор страны или региона поиска, который влияет на правила ранжирования документов. Поддерживается только для типов поиска `Русский` и `Турецкий`.

    Список идентификаторов часто используемых стран и регионов см. в разделе [Регионы поиска](../../search-api/reference/regions.md).
* `l10n` — язык уведомлений поискового ответа. Влияет на текст, передаваемый в теге `found-docs-human` и в сообщениях об ошибках. Необязательный параметр. Возможные значения зависят от выбранного типа поиска:

    * Тип поиска `Русский`:
        * `LOCALIZATION_RU` — русский язык (значение по умолчанию).
        * `LOCALIZATION_BE` — белорусский язык.
        * `LOCALIZATION_KK` — казахский язык.
        * `LOCALIZATION_UK` — украинский язык.
    * Тип поиска `Турецкий`:
        * `LOCALIZATION_TR` — турецкий язык.
    * Тип поиска `Международный`:
        * `LOCALIZATION_EN` — английский язык.
* `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) пользователя или сервисного аккаунта, от имени которого вы будете выполнять запросы.
* `response_format` — формат получения поисковой выдачи. Необязательный параметр. Возможные значения:

    * `FORMAT_XML` — результат запроса будет передан в [формате XML](../../search-api/concepts/response.md) (значение по умолчанию).
    * `FORMAT_HTML` — результат запроса будет передан в [формате HTML](../../search-api/concepts/html-response.md).
* `user_agent` — строка, содержащая [заголовок User-Agent](https://en.wikipedia.org/wiki/User-Agent_header). Параметр позволяет получить поисковую выдачу, ориентированную на конкретные устройство и браузер, в том числе [мобильную выдачу](../../search-api/operations/v2-mobile.md). Необязательный параметр. Если параметр не задан, сервис возвращает стандартную выдачу по умолчанию.

**Список поддерживаемых параметров:**

{% include [xml-html-fields-differ-notice](./xml-html-fields-differ-notice.md) %}

| Параметр  | Поддерживается при [XML-ответе](../../search-api/concepts/response.md)  | Поддерживается при [HTML-ответе](../../search-api/concepts/html-response.md) |
| --- | --- | --- |
| `search_type` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `query_text` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `family_mode` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `fix_typo_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `sort_order` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `group_mode` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `groups_on_page` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `docs_in_group` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `max_passages` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `region` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `l10n` | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg) |
| `folder_id` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `response_format` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| `user_agent` | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |