# Adding a video or audio

{% if audience == "internal" %}

We recommend using [Jing](https://jing.yandex-team.ru/), our corporate file hosting service, to host and store your video and audio files.

## A video from a video hosting service {#hosting}

{% endif %}

To add a video or audio file to a Wiki page, use the [dynamic block not_var{{iframe}}](actions/iframe.md) It enables you to add media files from external sources, such as Yandex&#160;Music, Vimeo, or YouTube.

{% if audience == "internal" %}

To post a video for Yandex employees only, [upload](https://wiki.yandex-team.ru/users/askarkamalov/kak-zalivat-nda-video-v-videoxosting/) it to the NDA channel on Yandex VideoHosting.

{% endif %}

1. Open the Wiki page and click **Edit**.

1. Add the dynamic block code with a link to the media file to the Wiki page. Use the link for publishing files on external resources. These links are usually referred to as the "Embed code" or "HTML code".

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

{% if audience == "internal" %}

## Inserting a file with a video or audio {#post-file}

You can upload media files to a Wiki page as attachments or place them in text using [HTML](static-markup/html-code.md) tags.

1. Upload a file in one of the following ways:

   * Use a hosting service to share your file with other users. For example, our corporate hosting service [Jing](https://jing.yandex-team.ru/). This way, your file will be accessible to all employees on any {{ wiki-name }} page.

   * Attach your file to a [Wiki page](attach-file.md). In this case, it will be available to users who have access to this page.

1. Copy a link to the uploaded file. To generate a link to the file you attached to the Wiki page:

   1. In the upper-right corner of the page, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../_assets/wiki/svg/attachments.svg) **Files**.

   1. Hover over the desired file on the **Files** panel.

   1. Right-click on ![](../_assets/wiki/svg/download.svg) and select **Copy link address** in the menu.

1. Place the link on the page using HTML tags:

   * Use the `<video>` tag for video files.

   * Use the `<audio>` tag for audio files.

Example:

```html
<video src="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
width="640" height="480" controls="controls">Your browser doesn't support this video.
<a href="https://jing.yandex-team.ru/files/mishanikin/afisha.mov"
target="_blank">Download video</a></video>
```

{% note info %}

Since {{ tracker-name }} and Atushka use the old Wiki formatter, wrap HTML code snippets in ticket descriptions and comments in `<# ... #>`.

{% endnote %}

{% endif %}

### See also

* [{#T}](attach-file.md)
* [{#T}](add-grid.md)
* [{#T}](basic-markup.md)
* [{#T}](static-markup/html-code.md)