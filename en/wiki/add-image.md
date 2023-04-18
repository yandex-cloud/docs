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

1. Open the page and click **Edit**.

1. Paste the image from the clipboard into the page text.

The image will be automatically uploaded to {{ wiki-name }} and a link to the image will appear in the page text. It will also be available in the list of attached files. To view the list, open the ![](../_assets/wiki/svg/actions-icon.svg) **Actions** menu and click ![](../_assets/wiki/svg/attachments.svg) **Files**.

## Inserting an image using a link {#link}

If the image is from a web resource:

1. Open the page and click **Edit**.

1. Copy the link to the image.

1. Add the link to the page using markup:

   ```
   ![Alternative text](image URL)
   ```

For example:

| Markup | Result |
--- | ---
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you paste an image link with no markup, the image will be added to the page without alternative text.

{% endnote %}

## Inserting an image that's already uploaded to {{ wiki-name }} {#attach}

1. Open the page. In the top-right corner, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../_assets/wiki/svg/attachments.svg) **Files**.

1. To upload an image to your page, click **Select file** and open the file(s) you need.

1. To copy an image link, hover over the file and click ![](../_assets/wiki/svg/copy-link.svg) **Copy the embed code**.

1. In the upper-right corner of the page, click **Edit**.

   {% note tip %}

   In editing mode, you can see a list of all uploaded files in the left-hand panel of the ![](../_assets/wiki/attach-btn.png) tab.

   {% endnote %}

1. Paste the link to the page. For example:

   ```
   200x0:/users/login/.files/image.png
   ```


#### See also

* [{#T}](attach-file.md)

* [{#T}](add-grid.md)

* [{#T}](basic-markup.md)