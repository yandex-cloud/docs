# Adding a video or audio

{% if audience == "internal" %}

To host and store video and audio files, we recommend using the [Jing](https://jing.yandex-team.ru/) corporate file hosting.

## Video from a video hosting {#hosting}

{% endif %}

To add a video or audio file to a Wiki page, use a [dynamic block not_var{{iframe}}](actions/iframe.md). It enables you to add media files from external sources, such as Yandex&#160;Music, Vimeo, or Youtube.

{% if audience == "internal" %}

To share a video with Yandex employees only, [upload](https://wiki.yandex-team.ru/users/askarkamalov/kak-zalivat-nda-video-v-videoxosting/) it to the NDA channel in Video hosting.

{% endif %}

1. Open the wiki page and click **Edit**.

1. Add the dynamic block code with a link to the media file to the Wiki page. Use the link for publishing on external resources. These links are usually referred to as the "Embed code" or "HTML code".

{% note tip %}

* When adding a video from Youtube, use a link in the format:

    ```
    https://www.youtube.com/embed/oCRQj_zyPjk
    ```

    To generate this link, under the YouTube video, select **Share** → **Embed** and copy the value of the `src` parameter.

* When adding a track from Yandex&#160;Music, use a link in the format:

    ```
    {{ yandex-music }}/iframe/#track/71263/419460
    ```

    To generate this link, select **Share** → **HTML code** in the track menu, then copy the value of the `src` parameter.

{% endnote %}

Example of a dynamic block with a video:

```
{{iframe src="https://player.vimeo.com/video/207028770" width="640" height="300" frameborder="0" allow="autoplay; fullscreen" allowfullscreen>}}
```

Example of a dynamic block with audio:

```
{{iframe frameborder="0" style="border:none;width:100%;height:180px;" width="100%" height="180" src="{{ yandex-music }}/iframe/#track/71263/419460"}}
```

{% if audience == "internal" %}

## Adding a file with video or audio {#post-file}

You can upload media files to your Wiki page as attachments or embed them in the text using [HTML](static-markup/html-code.md) tags.

1. Upload the file using one of the following methods:

    * Use a hosting where your file will be available to other users. For example, the corporate [Jing](https://jing.yandex-team.ru/) file hosting. This will make the file available to all employees on any {{ wiki-name }} page.

    * Attach your file to a [Wiki page](attach-file.md). This will make the file available to users who have access to the page.

1. Copy a link to the uploaded file. To get a link to a file attached to a Wiki page:

    1. In the upper-right corner of the page, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions**, then select ![](../_assets/wiki/svg/attachments.svg) **Files**

1. In the **Files** panel, hover over the file.

    1. Right-click the ![](../_assets/wiki/svg/download.svg) icon and select **Copy link** from the menu.

1. Add the link to your page using HTML tags:

    * For video files, use the tag: `<video>`.

    * For audio files, use the tag: `<audio>`.

Example:

```html
<video src="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
width="640" height="480" controls="controls">Your browser does not support this video.
<a href="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
target="_blank">Download video</a></video>
```

{% note info %}

As {{ tracker-name }} and Atushka use an old Wiki formatter, enclose HTML code fragments from issue descriptions and comments in `<# ... #>`.

{% endnote %}

{% endif %}

### See also

* [{#T}](attach-file.md)
* [{#T}](add-grid.md)
* [{#T}](basic-markup.md)
* [{#T}](static-markup/html-code.md)

