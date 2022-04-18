# Embedding video or audio

{% if audience == "internal" %}

We recommend storing you video and audio files on [Jing](https://jing.yandex-team.ru/), the corporate file hosting service.

## Videos from external platforms {#hosting}

{% endif %}

To add a video or audio to your Wiki page, use the [not_var{{iframe}}](actions/iframe.md) dynamic block. The block is used to embed media files from external sources, such as Yandex Music, Vimeo, or Youtube.

{% if audience == "internal" %}

If your video should only be available to Yandex employees, [upload](https://wiki.yandex-team.ru/users/askarkamalov/kak-zalivat-nda-video-v-videoxosting/) the video to the NDA channel in the Video Hosting service.

{% endif %}

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

{% if audience == "internal" %}

## Adding video or audio files {#post-file}

Media files can be uploaded to Wiki pages as attachments or added to the text using [HTML](static-markup/html-code.md) tags.

1. Upload your file using one of the following methods:

    * Use a hosting service which allows other users to access the file. For example, you can use [Jing](https://jing.yandex-team.ru/), the corporate file hosting service. Then your file will be available to all employees on any {{ wiki-name }} page.

    * Attach the file to the Wiki page: in the left-hand panel, click ![](../_assets/wiki/attach-btn.png), then drag and drop the file. Then your file will be available to other users with access to that page.

1. Copy the link to the uploaded file. To get a link to the file attached to a Wiki page:

    1. In the left-hand panel, hover the cursor over the file.

    1. Right-click the download icon ![](../_assets/wiki/download-btn.png) and select **Copy link address**.

1. Add the link to the page using the HTML tags:

    * for video files, use `<video>`;

    * for audio files, use `<audio>`.

Example:

```html
<video src="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
width="640" height="480" controls="controls">Your browser does not support this video.
<a href="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
target="_blank">Download video</a></video>
```

{% note info %}

{{ tracker-name }} and Atushka use an outdated Wiki formatter, so HTML code snippets in ticket descriptions and comments should be enclosed in the symbols: `<# ... #>`.

{% endnote %}

{% endif %}

### See also

* [{#T}](attach-file.md)
* [{#T}](add-grid.md)
* [{#T}](basic-markup.md)
* [{#T}](static-markup/html-code.md)

