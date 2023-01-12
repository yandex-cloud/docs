# Objects from external sources

The `iframe` block enables you to add other pages, objects, audio clips, or videos from external sources (such as YouTube, Vimeo, and Coub) to your page.



## Using the block {#iframe-call}

```
{{iframe src="http://pageURL" width=700px height=600px frameborder=0 scrolling=no}}
```

## Block parameters {#iframe-params}

| Parameter | Description |
--- | ---
| `src` | Required parameter. Contains the address of the object. |
| `width` | Indicates the width of the iframe in pixels or as a percentage of the page width. |
| `height` | Indicates the height of the iframe in pixels. |
| `frameborder` | Indicates if there is an iframe border. |
| `scrolling` | Indicates if there are scrollbars in the iframe window. |
| `allowfullscreen` | Allows full-screen mode for the iframe. Always `true`. |

## Subdomains allowed {#video-domain}

The `src` parameter can contain addresses that belong to the domains listed below:

- `vimeo.com`

- `yandex.ru`



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

Some resources might prohibit inserting their pages using an iframe. For example, the {{ link-yandex }} homepage.

{% endnote %}