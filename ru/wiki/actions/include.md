# Контент из другого источника

Блок `include` позволяет вставлять контент с другой [страницы в {{wiki-name}}](#include-wiki) или из [внешних источников](#include-ext).

## Вызов блока {#include-call}

```
{{ include page="/users/имяПользователя/адресСтраницы/" notoc notitle nomark}} 
```

## Параметры блока {#include-params}

### Страницы {{wiki-name}} {#include-wiki}

Параметр | Описание
--- | ---
`page` | Обязательный параметр. Относительный адрес страницы в {{wiki-name}}.
`notitle` | Отображение заголовка подключаемой страницы. Чтобы не отображать заголовок, укажите `notitle = 1`.
`notoc` | Отображение заголовков из подключаемой страницы в общем оглавлении. Чтобы не добавлять заголовки, укажите `notoc = 1`.
`nowarning` | Сообщение об ошибке пользователям, у которых нет прав на чтение подключаемой страницы. Чтобы не показывать сообщение, укажите `nowarning = 1`.
`from` / `to` | Имена [якорей](#anchor) на странице {{wiki-name}}, ограничивающих содержимое, которое будет подключено. По умолчанию подключается вся страница. Параметр работает только для якорей, добавленных вручную: автоматические якоря из заголовков использовать нельзя.

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

Чтобы вставить на страницу файл из репозитория, используйте код:
```
{{include href="https://svn.yandex.ru/wiki/planner/trunk/src/planner/urls.py" formatter="python" expired=50}}
```

{% cut "Как выглядит результат"%}

```python
from django.conf.urls.defaults import *
from django.conf import settings

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    (r'^',             include('rooms.urls')),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),
    )
```

{% endcut %}

Чтобы посмотреть, как работает блок `include` в {{wiki-name}}, перейдите по [ссылке](https://wiki.yandex-team.ru/wiki/vodstvo/actions/actioninclude/#primery).
