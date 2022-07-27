# Images and files

## Embedding images {#add-image}

To add an image to the page, use the markup:

```
![Alternative text](image address)
```

{% note info %}

If you paste an image link with no markup, the image itself will be displayed on the page.

{% endnote %}

| Markup | Result |
| --- | --- |
| `![Logo]({{ yandex-logo-link }})` |![](../../_assets/wiki/logo95x37x8.png) |

### Setting image size {#img-size}

Set the size of the image on the page in pixels:

```
<width>x<height>:<link to image>
```

{% note info %}

The image is scaled proportionally, so the height value can be set approximately. For example, a drawing with this markup will be displayed correctly: `300x0:<link to the picture>`.

{% endnote %}

| Markup | Result |
| --- | --- |
| `no-highlight 60x20:{{ yandex-logo-link }}` |![](../../_assets/wiki/resize-pic.png) |

### Adding download links for images {#download-link}

Use the link markup:

```
[link text](image URL)
```

| Markup | Result |
| --- | --- |
| `[Yandex logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

### Make an image a link {#img-link}

Images can also function as links so that when you click on the image, a page or file opens. To do this, add links to the markup element instead of the text [insert an image](#add-image):

```
[![Alternative text](image address)](link address)
```

| Markup | Result |
| --- | --- |
| `[![Logo]({{ yandex-logo-link }})]({{ link-yandex }})` | [![Logo](../../_assets/wiki/logo95x37x8.png)]({{ link-yandex }}) |

## Inserting a video {#video}

To add a video to a page, use the [dynamic block `not_var{{iframe}}`](../actions/iframe.md). You can insert videos from external sources, such as Vimeo or YouTube.

## Adding links to files {#file-ref}

Place the link to the file in the text of the page using one of the following methods:

| Markup | Result |
| --- | --- |
| `http://file-address` | [http://file-address](http://file-address) |
| `[link text](http://file-address)` | [link text](http://file-address) |

