# Inserting a video

To add a video to a page, use the [`not_var{{iframe}}`](actions/objects.md#iframe-video) dynamic block. You can insert videos from external sources, such as Vimeo or YouTube.

1. Open the page and click **Edit**.

1. Add the dynamic block code with a link to the video to the page.

Example:

```
{{iframe src="https://player.vimeo.com/video/207028770" width="640" height="300" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe}}
```

{% note tip %}

When adding videos from YouTube, use the link that is intended for placement on third-party resources. These links take the following format:

```
https://www.youtube.com/embed/oCRQj_zyPjk
```

To get a link to YouTube, under the video, select **Share** → **Embed** and copy the `src` parameter value. 

{% endnote %}

### See also

- [{#T}](attach-file.md)
- [{#T}](add-grid.md)
- [{#T}](basic-markup.md)

