# Images and files

## Embedding images {#add-image}

To add image to a page, use markup:

```
![Alternative text](image URL)
```

{% note info %}

If you paste an image link with no markup, the image will be added to the page without alternative text.

{% endnote %}

| Markup | Result |
--- | ---
| `![Logo]({{ yandex-logo-link }})` | ![](../../_assets/wiki/logo95x37x8.png) |

### Setting image size {#img-size}

Set the size of the image on the page in pixels:

```
<width>x<height>:<link to image>
```

{% note info %}

The image is scaled proportionally, so the height value can be set approximately. For example, a drawing with this markup will be displayed correctly: `300x0:<link to image>`.

{% endnote %}

| Markup | Result |
--- | ---
| `no-highlight 60x20:{{ yandex-logo-link }}` | ![](../../_assets/wiki/resize-pic.png) |

### Adding download links for images {#download-link}

Use the link markup:

```
[link text](image URL)
```

| Markup | Result |
--- | ---
| `[Yandex logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

### Making an image a link {#img-link}

Images can also function as links so that when you click on the image, a page or file opens. To do this, [insert an image](#add-image) in the link markup element instead of text:

```
[![Alternative text](image URL)](link)
```

| Markup | Result |
--- | ---
| `[![Logo]({{ yandex-logo-link }})]({{ link-yandex }})` | [![Logo](../../_assets/wiki/logo95x37x8.png)]({{ link-yandex }}) |

## Inserting a video {#video}

To add a video to a page, use the [dynamic block `not_var{{iframe}}`](../actions/iframe.md). It enables you to insert videos from external sources, such as Vimeo or YouTube.

## Adding links to files {#file-ref}

Place a file link in the text of a page using one of the following methods:

| Markup | Result |
--- | ---
| `http://file-address` | [http://file-address](http://file-address) |
| `[link text](http://file-address)` | [link text](http://file-address) |