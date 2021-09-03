# Embedding images

You can insert an image into a page from the clipboard, by clicking on a link from an external resource, or from files uploaded to {{ wiki-name }}. To learn more about additional parameters for inserting images, see the [{#T}](static-markup/files.md) section.

## Inserting an image from the clipboard {#clipboard}

1. Copy an image to the clipboard:

    - Copy a picture from an image editor or take a screenshot.

    - Copy a picture from a web page.

    - Copy an image file from the file manager on your computer (you can insert an image with this method only in macOS).

    {% note alert %}

    Copy images one at a time. {{ wiki-name }} does not support inserting multiple images at the same time.

    {% endnote %}

1. Open the wiki page and click **Edit**.

1. Insert an image from the clipboard into the page text.

The image is automatically uploaded to {{ wiki-name }}, and a link to the image appears in the page text. It also appears in the list of attached files on the left panel ![](../_assets/wiki/attach-btn.png).

## Inserting an image using a link {#link}

If the image is from a web resource:

1. Open the {{ wiki-name }} wiki page and click **Edit**.

1. Copy the link to the image.

1. Insert the link to the page using markup:

    ```
    ![Alternative text](image address)
    ```

For example:

| Markup | Result |
| --- | --- |
| `![Logo]({{ yandex-logo-link }})` | ![](../_assets/wiki/logo95x37x8.png) |

{% note info %}

If you paste an image link with no markup, the image will be displayed on the page with no alternative text.

{% endnote %}

## Inserting an image that has already been uploaded to {{ wiki-name }} {#attach}

1. Upload the image to the page.

    1. In the panel on the left, click ![](../_assets/wiki/attach-btn.png).

    1. Click **Select file**.

    1. Upload the desired file(s).

    1. You can see a list of all uploaded files in the panel on the left on the tab ![](../_assets/wiki/attach-btn.png).

1. Open the page and click **Edit**.

1. Copy the link to the image.

    1. In the panel on the left, open the list of uploaded files (![](../_assets/wiki/attach-btn.png)).

    1. Hover the cursor over the file and click ![](../_assets/wiki/get-link-btn.png).

    1. You will see the message **File link copied**. You can now embed it into the page text.

1. Insert the link to the page. For example:

    ```
    200x0:/users/login/.files/image.png
    ```

#### See also

- [{#T}](attach-file.md)

- [{#T}](add-grid.md)

- [{#T}](basic-markup.md)

