# Объекты из внешних источников

Блок `iframe` позволяет вставлять на страницу любую другую страницу, объекты, аудио или видеоролики из внешних источников, таких как Youtube, Vimeo, Coub.

{% if audience == "internal" %}

Используйте динамический блок `iframe`, чтобы вставить на страницу [документ Office](../office365/embed-iframe.md) вместе с другим контентом, оформленным с помощью вики-разметки.

{% endif %}

## Вызов блока {#iframe-call}

```
{{iframe src="http://адресСтраницы" width=700px height=600px frameborder=0 scrolling=no}}
```

## Параметры блока {#iframe-params}

Параметр | Описание
--- | ---
`src` | Обязательный параметр. Содержит адрес объекта.
`width` | Указывает на ширину фрейма в пикселях или в процентах от ширины страницы.
`height` | Указывает на высоту фрейма в пикселях.
`frameborder` | Указывает на наличие или отсутствие рамки фрейма.
`scrolling` | Указывает на наличие полос прокрутки для окна фрейма.
`allowfullscreen` | Разрешает для фрейма полноэкранный режим. Всегда имеет значение `true`.

## Разрешенные поддомены {#video-domain}

Параметр `src` может содержать адреса, которые принадлежат доменам:

- `vimeo.com`

- `yandex.ru`

{% if audience == "internal" %}

- `yandex-team.ru`

{% endif %}

- `yandex.ua`

- `yandex.kz`

- `yandex.by`

- `youtube.com`

- `youtube-nocookie.com`

- `player.vimeo.com`

- `player.vimple.ru`

- `vkontakte.ru`

- `vk.com`

- `coub.com`

{% note info %}

Некоторые ресурсы могут запрещать вставку их страниц с помощью iframe. Например, главная страница {{ link-yandex }}.

{% endnote %}