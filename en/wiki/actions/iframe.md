# Objects from external sources

You can use the `iframe` block to embed other pages, objects, audio, or video clips from external sources (such as Youtube, Vimeo, and Coub) to your page.

{% if audience == "internal" %}

Use the `iframe` dynamic block to embed [Office documents](../office365/embed-iframe.md) on the page along with other content formatted using the Wiki markup.

{% endif %}

## Calling the block {#iframe-call}

```
{{iframe src="http://pageURL" width=700px height=600px frameborder=0 scrolling=no}}
```

## Block parameters {#iframe-params}

| Parameter | Description |
| --- | --- |
| `src` | Required parameter. Contains the object address. |
| `width` | Indicates the width of the frame in pixels or as a percentage of the page width. |
| `height` | Indicates the height of the frame in pixels. |
| `frameborder` | Indicates the presence or absence of frames. |
| `scrolling` | Indicates the presence of scrollbars for the frame window. |
| `allowfullscreen` | Allows full-screen mode for the frame. Always set to `true`. |

## Enables subdomains {#video-domain}

The `src` parameter may contain addresses that belong to the following domains:

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

Some resources don't allow embedding their pages via iframe. For example, the {{ link-yandex }} home page.

{% endnote %}

