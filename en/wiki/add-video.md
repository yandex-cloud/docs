# Adding a video or audio


To add a video or audio file to a page, use the [dynamic block not_var{{iframe}}](actions/iframe.md). It enables you to add media files from external sources, such as Yandex&#160;Music, Vimeo, or YouTube.


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


### See also

* [{#T}](attach-file.md)
* [{#T}](add-grid.md)
* [{#T}](basic-markup.md)
* [{#T}](static-markup/html-code.md)