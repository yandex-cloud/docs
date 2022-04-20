# Embedding video or audio


To add a video or audio to your Wiki page, use the [not_var{{iframe}}](actions/iframe.md) dynamic block. The block is used to embed media files from external sources, such as Yandex Music, Vimeo, or Youtube.


1. Open the Wiki page and click **Edit**.

1. Add the dynamic block code with a link to the media file to the Wiki page. Use the auto-generated link for posting the video on other websites. Such links are usually called "Embed Code" or "HTML code".

{% note tip %}

* When adding a video from Youtube, use a link in the following format:

    ```
    https://www.youtube.com/embed/oCRQj_zyPjk
    ```

    To get the link, click **Share** → **Embed** under the video on Youtube. Then, copy the value for the `src` parameter.

* When adding a track from Yandex Music, use a link in the following format:

    ```
    {{ yandex-music }}/iframe/#track/71263/419460
    ```

    To get the link, click **Share** → **HTML code** in the track menu. Then, copy the value for the `src` parameter.

{% endnote %}

Example of a dynamic block with a video:

```
{{iframe src="https://player.vimeo.com/video/207028770" width="640" height="300" frameborder="0" allow="autoplay; fullscreen" allowfullscreen>}}
```

Example of a dynamic block with an audio:

```
{{iframe frameborder="0" style="border:none;width:100%;height:180px;" width="100%" height="180" src="{{ yandex-music }}/iframe/#track/71263/419460"}}
```


### See also

* [{#T}](attach-file.md)
* [{#T}](add-grid.md)
* [{#T}](basic-markup.md)
* [{#T}](static-markup/html-code.md)

