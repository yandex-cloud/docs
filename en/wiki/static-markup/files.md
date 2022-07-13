# Images and files

## Embed an image {#add-image}

To add images to your page, use the following markup:

```
![Alternative text](image address)
```

{% note info %}

If you paste an image link with no markup, the image will be displayed on the page with no alternative text.

{% endnote %}

| Markup | Result |
| --- | --- |
| `![Logo]({{ yandex-logo-link }})` | ![](../../_assets/wiki/logo95x37x8.png) |

### Set the image size {#img-size}

You can set the image size in pixels with the following format:

```
<width>x<height>:<link to image>
```

{% note info %}

Images maintain their aspect ratio, so the height value you set doesn't have to be exact. For example, the image will display correctly if the following markup is used: `300x0:<link to the picture>`.

{% endnote %}

| Markup | Result |
| --- | --- |
| `no-highlight 60x20:{{ yandex-logo-link }}` | ![](../../_assets/wiki/resize-pic.png) |

### Adding an image download link {#download-link}

Use the link markup:

```
[link text](image URL)
```

| Markup | Result |
| --- | --- |
| `[Yandex logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

### Creating a link from an image {#img-link}

You can create a link from an image, so that clicking an image opens a page or document. To do this, [embed an image](#add-image) to the link markup element instead of text:

```
[![Alternative text](image address)](link address)
```

| Markup | Result |
| --- | --- |
| `[![Logo]({{ yandex-logo-link }})]({{ link-yandex }})` | [![Logo](../../_assets/wiki/logo95x37x8.png)]({{ link-yandex }}) |

## Embedding videos {#video}

To add a video to your page, use the [dynamic block not_var{{iframe}}](../actions/iframe.md). You can use it to embed videos from external sources, such as Vimeo or Youtube.

## Embedding links to files {#file-ref}

You can use one of the following methods to add a link to a file on your page:

| Markup | Result |
| --- | --- |
| `http://file-address` | [http://file-address](http://file-address) |
| `[link text](http://file-address)` | [link text](http://file-address) |

