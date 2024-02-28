# Objects from external sources

{% include [actions-alert](../../_includes/wiki/actions-alert.md) %}

The `iframe` block enables you to add other pages, objects, audio clips, or videos from external sources (such as YouTube, Vimeo, and Coub) to your page.


## Using the block {#iframe-call}

```
{{iframe src="http://page" width=700px height=600px frameborder=0 scrolling=no}}
```

## Block parameters {#iframe-params}

| Parameter | Description |
--- | ---
| `src` | This is a required parameter. Contains the address of the object. |
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

## Adding a video or audio {#add-video-audio}


To add a video or audio file to a page, use the [not_var{{iframe}} dynamic block](#iframe-call). It enables you to add media files from external sources, such as Yandex&#160;Music, Vimeo, or YouTube.


1. Open the page and click **{{ ui-key.yacloud.common.edit }}**.

1. Add the dynamic block code with a link to the media file to the page. Use the link for publishing files on external resources. These links are usually referred to as the "Embed code" or "HTML code".

{% note tip %}

* When adding a video from YouTube, use a link in the format:
   ```
   https://www.youtube.com/embed/oCRQj_zyPjk
   ```
   To generate this link, select **Share** → **Embed** under the YouTube video and copy the `src` parameter value.

* When adding a track from Yandex&#160;Music, use a link in the format:

   ```
   {{ yandex-music }}/iframe/#track/71263/419460
   ```
   To generate this link, select **Share** → **HTML code** in the track menu and copy the `src` parameter value.

{% endnote %}

Example of a dynamic block with a video:

```
{{iframe src="https://player.vimeo.com/video/207028770" width="640" height="300" frameborder="0" allow="autoplay; fullscreen" allowfullscreen}}
```

Example of a dynamic block with audio:

```
{{iframe frameborder="0" style="border:none;width:100%;height:180px;" width="100%" height="180" src="{{ yandex-music }}/iframe/#track/71263/419460"}}
```

