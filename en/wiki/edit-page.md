# Editing a page

You can edit text, add titles and lists, and embed links, images, and tables in a [{{ wiki-name }} page](pages-types.md#wysiwyg).

You can change any {{ wiki-name }} page you have [edit permissions](page-management/access-setup.md#read-only) to. Here is how:

1. Open the page you need and click **Edit** in the top-right corner.

1. Make changes to the page text:

   **Renaming a page**
   * Click the page name and enter a new one.

   **Editing and viewing panels**
   * By default, the edit screen for a page created in the old editor is split into two parts: the left part is for editing, while the right one is for preview. To disable preview, click the **Split mode** toggle at the bottom of the page.
   * To open a full screen preview, click **Preview** in the top right corner.
   * On pages created in the [new editor](./wysiwyg-create.md), changes are displayed immediately when creating text or using markup elements.

   **Editing text on a page**
   * In editing mode on a page created in the old editor, you can only add unformatted text. To set the structure and layout of the text, use special characters: the [Markdown markup language](basic-markup.md).
   * To add frequently used formatting elements to the text, use the toolbar at the top of a page.
   * On pages created in the [new editor](./wysiwyg-create.md), changes are displayed immediately when creating text or using markup elements.

   **Attaching files to a page**
   * In the top-right corner, click ![](../_assets/wiki/svg/actions-icon.svg) **Actions**, select ![](../_assets/wiki/svg/attachments.svg) **Files**, and upload images or other files to the page. For example, you may need it to [embed an image in the text of your page](add-image.md).

   **Adding a table**
   * You can embed a [dynamic table](add-grid.md#grid) in a page. You can sort these tables by column and edit them in {{ wiki-name }} page view mode.

   **Adding dynamic blocks**
   * Use [dynamic blocks](actions.md) to add a table of contents, automatically generated lists of pages, items from external resources, and other elements to your {{ wiki-name }} pages. Dynamic blocks only work on pages created in the old editor.


1. Click **Save**.
   After saving the page, its copy is added to the [history of changes](history.md). In the history, you can always view previous versions of the page, compare them with each other, or restore any of them.

## Editing {{ wiki-name }} home page

You can edit [{{ wiki-name }} home page]({{ link-wiki }}) just like any other page.

{% note info %}

By default, the author of the {{ wiki-name }} home page is a service account. If the "Only authors" access type is selected for this page, other users cannot access it. To allow others to access the page, click the [{{ link-homepage-access }}]({{ link-homepage-access }}) link and change the access parameters.

{% endnote %}

### See also

* [{#T}](page-management/access-setup.md)

* [{#T}](page-management/edit-owner.md)

* [{#T}](page-management/move-page.md)

* [{#T}](delete-page.md)
