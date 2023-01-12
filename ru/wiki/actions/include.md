# Текст из внешних источников

Блок `include` позволяет вставлять контент с другой [страницы в {{ wiki-name }}](#include-wiki) или из [внешних источников](#include-ext).

## Вызов блока {#include-call}

```
{{ include page="{{ wiki-pagename }}/" notoc notitle nomark}} 
```

## Параметры блока {#include-params}

### Страницы {{ wiki-name }} {#include-wiki}

Параметр | Описание
--- | ---
`page` | Обязательный параметр. Относительный адрес страницы в {{ wiki-name }}.
`notitle` | Отображение заголовка подключаемой страницы. Чтобы не отображать заголовок, укажите `notitle = 1`.
`notoc` | Отображение заголовков из подключаемой страницы в общем оглавлении. Чтобы не добавлять заголовки, укажите `notoc = 1`.
`nowarning` | Сообщение об ошибке пользователям, у которых нет прав на чтение подключаемой страницы. Чтобы не показывать сообщение, укажите `nowarning = 1`.
`from` / `to` | Имена [якорей](#anchor) на странице {{ wiki-name }}, ограничивающих содержимое, которое будет подключено. По умолчанию подключается вся страница. Параметр работает только для якорей, добавленных вручную: автоматические якоря из заголовков использовать нельзя.

### Внешние источники {#include-ext}

Параметр | Описание
--- | ---
`href` | Обязательный параметр. URL-адрес страницы.
`expired` | Время жизни кеша внешней страницы в минутах. По умолчанию 60 минут. Чтобы отключить хранение кеша, укажите значение `expired = 0 `.
`login` | Логин для HTTP-авторизации.
`passwd` | Пароль для HTTP-авторизации.
`formatter` | Форматирование текста подключаемой страницы. Если параметр не указан, он будет определен автоматически по расширению подключаемого файла. Если определить формат не удалось, подставляется значение `code`.
`enc` | Кодировка подключаемой страницы. По умолчанию — `Windows-1251`.

### Примеры {#include-examples}

* Чтобы вставить на страницу файл из svn-репозитория, используйте код:
    ```
    {{include href="https://svn.yandex.ru/wiki/planner/trunk/src/planner/urls.py" formatter="python" expired=50}}
    ```

* Чтобы вставить на страницу файл из git-репозитория, используйте код:
    ```
    {{include href="https://github.yandex-team.ru/tools/wiki.git/?a=blob_plain;f=src/wiki/formatters/classes/base.py;h=4a77086f0e26551a19b2f7aed5ca898266dbe0d6;hb=HEAD" formatter="python" expired=999 from="11" to="20"}}
    ```

* Чтобы вставить на страницу секцию страницы {{ wiki-name }}, ограниченной якорями, используйте код:
    ```
    {{include page="/wiki/vodstvo/lists/Grids" from="tracker-start" to="tracker-end" nomark notitle}}
    ```
* Чтобы вставить на страницу файл из Arcanum, используйте код:
    ```
    {{include href="https://a.yandex-team.ru/api/v1/repos/arc/tree/blob/trunk/arcadia/extsearch/video/vh/common/abc_mapping/data/abc_mapping.json?commit_id=HEAD" formatter="json" expired=999 from="110" to="117"}}
    ```
    Чтобы получить ссылку для вставки из Arcanum, откройте файл с исходным кодом и переключитесь в режим **Raw**.

{% note info %}

Чтобы посмотреть, как работает блок `include` в {{ wiki-name }}, перейдите по [ссылке](https://wiki.yandex-team.ru/wiki/vodstvo/actions/actioninclude/#primery).

{% endnote %}