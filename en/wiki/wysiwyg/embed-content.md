# Embedded content

{% include [old-editor-warning](../../_includes/wiki/wysiwyg-old-editor.md) %}


## Image from the clipboard {#clipboard}

{% list tabs %}

- New editor

   1. Copy an image to the clipboard:

      - Copy a picture from an image editor or take a screenshot.

      - Copy a picture from a web page.

      - Copy an image file from the file manager on your computer.

   1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

   1. Paste the image from the clipboard into the page text.

   The image is automatically uploaded to {{ wiki-name }} and added to a [list of attached files](../attach-file.md).

- Old editor

   You can add an image to a page by pasting it from the [clipboard](#clipboard), through a link from an external resource, or from files uploaded to {{ wiki-name }}. To learn more about additional parameters for embedding images, see [{#T}](../static-markup/files.md).

   ### Inserting an image already uploaded to {{ wiki-name }} {#attach}

   1. Open the page. In the top-right corner, click ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** and select ![](../../_assets/wiki/svg/attachments.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-sidebar.icon-files }}**.

   1. To upload an image to your page, click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-attachments.upload-btn-text }}** and open the file(s) you need.

   1. To copy an image link, hover over the file and click ![](../../_assets/wiki/svg/copy-link.svg) **Copy the embed code**.

   1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}** in the top-right corner of the page.

   {% note tip %}

   In editing mode, you can see a list of all uploaded files in the left-hand panel of the ![](../../_assets/wiki/attach-btn.png) tab.

   {% endnote %}

   1. Paste the link to the page. For example:

      ```
      200x0:/users/login/.files/image.png
      ```


   To insert a file or image from the clipboard:

   1. Copy an image to the clipboard:

      - Copy a picture from an image editor or take a screenshot.

      - Copy a picture from a web page.

      - Copy an image file from the file manager on your computer.

   {% note alert %}

   Copy images one at a time. {{ wiki-name }} does not support inserting multiple images concurrently.

   {% endnote %}

   1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

   1. Paste the image from the clipboard into the page text.

   The image will be automatically uploaded to {{ wiki-name }} and a link to the image will appear in the page text. It will also be available in the list of attached files. To view the list, open the ![](../../_assets/wiki/svg/actions-icon.svg) **Actions** menu and click ![](../../_assets/wiki/svg/attachments.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-sidebar.icon-files }}**.

{% endlist %}

## Linked image {#image}

{% list tabs %}

- New editor

   1. Upload an image to a page or a file hosting service.

   1. Copy the image address.

   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/image.svg):

      - In the **Link** field, paste the image URL.

      - Add a **Picture caption**. The caption will be displayed when you hover over the image.

      - Enter **Alternative text**. The text is displayed if the image fails to load.

      - Specify the image size.

   1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

- Old editor

   If the image is from a web resource:

   1. Open the page and click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

   1. Copy the link to the image.

   1. Add the link to the page using markup:

      ```
      ![Alternative text](image URL)
      ```

   For example:

   | Markup | Result |
   --- | ---
   | `![Logo]({{ yandex-logo-link }})` | ![](../../_assets/wiki/logo95x37x8.png) |

   {% note info %}

   If you paste an image link with no markup, the image will be added to the page without alternative text.

   {% endnote %}

{% endlist %}

## File {#file}

{% list tabs %}

- New editor

   To add a file to a page:

   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/file.svg).

   1. Select how to upload the file:

      - To upload it via a link, click **Add by link**. Next, enter the URL of the file and the name to display in the text. Save your changes.

      - To attach a file from a device, click **Upload from device** and upload one or more files.

- Old editor

   To add a file to a page:

   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/file.svg).

   1. In the left-hand panel, click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-attachments.upload-btn-text }}** and open the file(s) you need.

{% endlist %}

## iFrame object or media file {#iframe}

{% list tabs %}

- New editor

   To embed an object or media file from an external source in a page, use an embedded iFrame:

   1. Copy the link to the resource to be displayed in the iFrame.

   1. On the toolbar, click ![](../../_assets/wiki/svg/wysiwyg/iframe.svg):

      - In the **Link** field, paste the resource URL.

      - Specify the frame size.

   1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

- Old editor

   {% note info %}

   You can find a detailed description of this function for this type of editor in the [Objects from external sources](../actions/iframe#iframe-call) section.

   {% endnote %}

{% endlist %}

## Chart {#chart}

{% list tabs %}

- New editor

   You can add [PlantUML](https://plantuml.com/)-supported diagrams to your page.

   To insert a diagram, switch to **Editor** mode, open the list of commands using the `/` symbol, and select ![](../../_assets/wiki/svg/wysiwyg/chart.svg) **Diagram**.

   To edit your diagram, click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}** in the top-right corner of the diagram block and edit its syntax using the PlantUML markup language. Save your changes.

- Old editor

   {% note info %}

   You can find a detailed description of this function for this type of editor in the [Objects from external sources](../static-markup/diagram.md) section.

   {% endnote %}

{% endlist %}

## Includes {#include}

{% list tabs %}

- New editor

   You can add content from another WYSIWYG page to your page:

   1. Switch to **Editor** mode, open the list of commands using the `/` character, and select ![](../../_assets/wiki/svg/wysiwyg/include.svg) **Include**.

   1. Specify the URL of the page to include.

   1. If required, enable the option to show an error message about pages the user has no access to.

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}

## Draw.io {#draw-io}

{% list tabs %}

- New editor

   To add a diagram created in [Draw.io](http://draw.io/) to your page, press `/` and select ![](../../_assets/wiki/svg/wysiwyg/draw-io.svg) **Draw.io** in the pop-up window.

   To change the size of the diagram, in its top-right corner, click ![](../../_assets/wiki/svg/actions-icon.svg) → **Settings** and set the new width and height in pixels.

   To edit a previously created diagram, in its top-right corner, click ![](../../_assets/wiki/svg/actions-icon.svg) and select **Edit**.

   ### Editing a diagram {#edit-draw-io}

   In Draw.io, you can add, delete, and modify elements, as well as draw freehand.

   To add an element, select it from the left panel. It will appear in the middle of the canvas, and then you can move, edit, or rotate it.

   You can connect shapes using arrows. To do this:

   1. Click the shape from which you want to draw an arrow.
   1. Four blue arrows will appear around the shape. Hold one of them and drag it to the shape to connect to.

   Now, if you move any of the connected shapes, the connecting arrows will also move.

   You can also create a new shape using the blue arrows around a shape. To do this, click one of these arrows and select the shape you want to create. The new shape will be connected to the original one.

   You can also switch to drawing mode. To do this, click the ![](../../_assets/wiki/draw-io-freehand.png =16x) button in the left panel. Now you can draw freehand on the canvas by holding the left mouse button. To exit drawing mode, click the ![](../../_assets/wiki/draw-io-freehand.png =16x) button again.

   {% note warning %}

   While in drawing mode, you cannot edit shapes.

   {% endnote %}

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}

## List of issues {#tickets-list}

{% list tabs %}

- New editor

   To add to the page an issue list from {{ tracker-name }}:

   1. Press `/`.
   1. In the pop-up window, select ![](../../_assets/wiki/svg/wysiwyg/tickets-list.svg) **Issue list**.
   1. In the **Link** field, paste the link to the issue filter in {{ tracker-name }} you want to apply.
   1. Click **Save**.

   To edit the issue list, in its top-right corner, click ![](../../_assets/wiki/svg/actions-icon.svg) → **Edit**.

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}

## Mermaid {#mermaid}

{% list tabs %}

- New editor

   You can add a diagram created with [Mermaid](http://mermaid.js.org/) to your page. To do this, press `/` and select ![](../../_assets/wiki/svg/mermaid.svg) **Mermaid** in the pop-up window.

   To edit the diagram, use [Mermaid syntax](http://mermaid.js.org/config/Tutorials.html).

- Old editor

   {% note alert %}

   This function is not supported in this type of editor.

   {% endnote %}

{% endlist %}
