# Inserting an image

You can add images to Wiki pages by pasting them from the clipboard, specifying links to external resources, or uploading files to {{ wiki-name }}. To learn more about additional parameters for embedding images, see [{#T}](static-markup/files.md).

{% if audience == "internal" %}

We recommend using [Jing](https://jing.yandex-team.ru/), our corporate file hosting service, to host and store your images.

{% endif %}

## Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

   - Copy a picture from an image editor or take a screenshot.

   - Copy a picture from a web page.

   - Copy an image file from the file manager on your computer.

   {% note alert %}

   Copy images one at a time. {{ wiki-name }} doesn't support inserting multiple images concurrently.

   {% endnote %}

1. Open the Wiki page and click **Edit**.

1. Paste the image into the Wiki page text.

The image is automatically uploaded to {{ wiki-name }} and a link to the image appears in the Wiki page text. It also appears in the list of attached files on the left panel ![](../_assets/wiki/attach-btn.png).

## Inserting an image using a link {#link}

If the image is from a web resource:

1. Open the Wiki page and click **Edit**.

1. Copy the link to the image.

1. Add the link to the Wiki page using markup:

   ```
   ![Alternative text](image URL)
   ```

For example:

| Markup | Result |
--- | ---
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you paste an image link with no markup, the image will be added to the Wiki page without alternative text.

{% endnote %}

## Inserting an image that's already uploaded to {{ wiki-name }} {#attach}

1. Open the page. In the upper-right corner, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../_assets/wiki/svg/attachments.svg) **Files**.

1. To upload an image to your Wiki page, click **Select file** and open the desired file or files.

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

## Inserting a file using a link from Jing {#jing}

1. Copy an image link from [Jing](https://jing.yandex-team.ru/), a service for publishing screenshots.

1. Paste the link into text. The image appears on the page.

{% endif %}

#### See also

* [{#T}](attach-file.md)

* [{#T}](add-grid.md)

* [{#T}](basic-markup.md)