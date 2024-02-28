# Inserting an image

You can add images to pages by pasting them from the clipboard, through links to external resources, or from files uploaded to {{ wiki-name }}. To learn more about additional parameters for embedding images, see [{#T}](static-markup/files.md).


## Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

   - Copy a picture from an image editor or take a screenshot.

   - Copy a picture from a web page.

   - Copy an image file from the file manager on your computer.

   {% note alert %}

   Copy images one at a time. {{ wiki-name }} does not support inserting multiple images concurrently.

   {% endnote %}

1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

1. Paste the image from the clipboard into the page text.

The image will be automatically uploaded to {{ wiki-name }} and a link to the image will appear in the page text. It will also be available in the list of attached files. To view the list, open the ![](../_assets/wiki/svg/actions-icon.svg) **Actions** menu and click ![](../_assets/wiki/svg/attachments.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-sidebar.icon-files }}**.

## Inserting an image using a link {#link}

If the image is from a web resource:

1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

1. Copy the link to the image.

1. Add the link to the page using markup:

   ```
   ![<alternative_text>](<image_address>)
   ```

For example:

| Markup | Result |
--- | ---
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you paste an image link with no markup, the image will be added to the page without alternative text.

{% endnote %}

## Inserting an image already uploaded to {{ wiki-name }} {#attach}

1. Open the page. In the top-right corner, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../_assets/wiki/svg/attachments.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-sidebar.icon-files }}**.

1. To upload an image to your page, click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-attachments.upload-btn-text }}** and open the file(s) you need.

1. To copy an image link, hover over the file and click ![](../_assets/wiki/svg/copy-link.svg) **Copy the embed code**.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}** in the top-right corner of the page.

1. Paste the link to the page, for example:

   ```
   200x0:/users/login/.files/image.png
   ```


#### See also

* [{#T}](attach-file.md)

* [{#T}](add-grid.md)

* [{#T}](basic-markup.md)