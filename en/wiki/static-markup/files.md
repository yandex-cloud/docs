---
title: "How to use images and files in {{ wiki-full-name }}"
description: "In this tutorial, you will learn how to use images and files in {{ wiki-name }}."
---

# Images and files

## Embedding images {#add-image}

To add image to a page, use markup:

```
![<alternative_text>](<image_address>)
```

{% note info %}

If you paste an image link with no markup, the image will be added to the page without alternative text.

{% endnote %}

| Markup | Result |
--- | ---
| `![Logo]({{ yandex-logo-link }})` | ![](../../_assets/wiki/logo95x37x8.png) |

{% note info %}

In the new editor in markup mode, you can paste images from the clipboard.

{% endnote %}

### Setting image size {#img-size}

Set the size of the image on the page in pixels:

```
<width>x<height>:<link_to_image>
```

{% note info %}

The image is scaled proportionally, so the height value can be set approximately. For example, a drawing with this markup will be displayed correctly: `300x0:<link_to_image>`.

{% endnote %}

### Setting image size {#img-size}

{% list tabs %}

- New editor

   {% include [static-markdown-alert](../../_includes/wiki/static-markdown-alert.md) %}

   Set the image size on the page in pixels in the link after the `=` sign:

   | Markup | Result |
   --- | ---
   | `![ya-logo](http://img.yandex.net/i/logo95x37x8.png "Yandex logo" =60x20)` | ![](../../_assets/wiki/resize-pic.png) |

- Old editor

   Set the size of the image on the page in pixels:

   ```
   <width>x<height>:<link to image>
   ```

   {% note info %}

   The image is scaled proportionally, so the height value can be set approximately. For example, a drawing with this markup will be displayed correctly: `300x0:<link to image>`.

   {% endnote %}

   | Markup | Result |
   --- | ---
   | `60x20:{{ yandex-logo-link }}` | ![](../../_assets/wiki/resize-pic.png) |

{% endlist %}

### Adding download links for images {#download-link}

Use the link markup:

```
[link text](image URL)
```

| Markup | Result |
--- | ---
| `[Yandex logo]({{ yandex-logo-link }})` | [Yandex logo]({{ yandex-logo-link }}) |

### Turning an image into a link {#img-link}

You can turn an image into a link for it to open a page or file when clicked. To do this, [insert an image](#add-image) in the link markup element instead of text:

```
[![<alternative_text>](<image_address>)](<link_address>)
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
