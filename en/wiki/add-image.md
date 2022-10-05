# Embedding images

You can add images to Wiki pages by pasting them from the clipboard, by specifying links to external resource, or by uploading files to {{ wiki-name }}. To learn more about additional parameters for inserting images, see the [{#T}](static-markup/files.md) section.

{% if audience == "internal" %}

To host and store images, we recommend using the [Jing](https://jing.yandex-team.ru/) corporate file hosting.

{% endif %}

## Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

    - Copy a picture from the image editor or take a screenshot.

    - Copy a picture from a web page.

    - Copy an image file from the file manager on your computer.

    {% note alert %}

    Copy images one at a time. {{ wiki-name }} does not support inserting multiple images at the same time.

    {% endnote %}

1. Open the wiki page and click **Edit**.

1. Paste the image into the Wiki page text.

The image is automatically uploaded to {{ wiki-name }} and a link to the image appears in the Wiki page text. It also appears in the list of attached files on the left panel ![](../_assets/wiki/attach-btn.png).

## Inserting an image using a link {#link}

If the image is from a web resource:

1. Open the wiki page and click **Edit**.

1. Copy the link to the image.

1. Add the link to the Wiki page using markup:

    ```
    ![Alternative text](image address)
    ```

For example:

| Markup | Result |
| --- | --- |
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you paste an image link with no markup, the image will be added to the Wiki page without alternative text.

{% endnote %}

## Inserting an image that has already been uploaded to {{ wiki-name }} {#attach}

Open the page. In the upper-right corner, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions**, then select ![](../_assets/wiki/svg/attachments.svg) **Files**.

1. To upload an image to your Wiki page, click **Select file**, then open the desired file or files.

1. To copy an image link, hover over the file and click ![](../_assets/wiki/svg/copy-link.svg) **Copy the embed code**.

1. In the upper-right corner of the page, click **Edit**.

   {% note tip %}

   In editing mode, you can see a list of all uploaded files in the left panel of the ![](../_assets/wiki/attach-btn.png) tab.

   {% endnote %}

1. Paste the link to the Wiki page. For example:

    ```
    200x0:/users/login/.files/image.png
    ```

{% if audience == "internal" %}

## Insert a file from Jing using a link {#jing}

1. Copy an image link from the [Jing](https://jing.yandex-team.ru/) screenshot sharing service.

1. Paste the link to your text. The image will appear on the page.

{% endif %}

#### See also

* [{#T}](attach-file.md)

* [{#T}](add-grid.md)

* [{#T}](basic-markup.md)

