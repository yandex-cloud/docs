# Embedding images

Images can be embedded on a Wiki page from the clipboard via a link to an external resource or from files uploaded to {{ wiki-name }}. You can set additional parameters for embedding images in [{#T}](static-markup/files.md).

{% if audience == "internal" %}

We recommend storing images on [Jing](https://jing.yandex-team.ru/), the corporate file hosting service.

{% endif %}

## Pasting images from the clipboard {#clipboard}

1. Copy an image to the clipboard:

    - Copy an image from an image editor or take a screenshot.

    - Copy an image from a web-page.

    - Copy the image file from the file manager on your computer.

    {% note alert %}

    Copy images one by one. {{ wiki-name }} does not support pasting multiple images at the same time.

    {% endnote %}

1. Open the Wiki page and click **Edit**.

1. Paste an image from the clipboard to the Wiki page's text body.

The image will be automatically uploaded to {{ wiki-name }}, and the image link will appear in the page's text body. It will also appear in the list of attached files on the left-hand panel ![](../_assets/wiki/attach-btn.png).

## Embedding an image via a link {#link}

If your image is hosted on another resource:

1. Open the Wiki page and click **Edit**.

1. Copy the link to the image.

1. Embed the link on a Wiki page using the following markup:

    ```
    ![Alternative text](image address)
    ```

Example:

| Markup | Result |
| --- | --- |
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you insert an image link into the page text without markup elements, the image will be displayed on the page with no alternative text.

{% endnote %}

## Embedding an image uploaded to {{ wiki-name }} {#attach}

1. Upload the image to the Wiki page.

    1. Click the icon on the left-hand panel ![](../_assets/wiki/attach-btn.png).

    1. Click **Select file**.

    1. Upload the desired file(s).

    1. A list of all uploaded files will be available on the left-hand panel on the ![](../_assets/wiki/attach-btn.png) tab.

1. Open the Wiki page and click **Edit**.

1. Copy the link to the image:

    1. On the left-hand panel, open the list of uploaded files (![](../_assets/wiki/attach-btn.png)).

    1. Hover over the file and click ![](../_assets/wiki/get-link-btn.png).

    1. A message saying **File link copied** will pop up. Now, you can now insert the link into the Wiki page text.

1. Embed a link to a Wiki page. Example:

    ```
    200x0:/users/login/.files/image.png
    ```

{% if audience == "internal" %}

## Embedding files via a Jing link {#jing}

1. Copy the image link from [Jing](https://jing.yandex-team.ru/).

1. Paste the link into the text body. The image will appear on the page.

{% endif %}

#### See also

* [{#T}](attach-file.md)

* [{#T}](add-grid.md)

* [{#T}](basic-markup.md)

