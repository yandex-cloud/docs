# Creating your first Wiki page

Try out {{ wiki-name }} features by creating your first page in the old editor. The page will be created in your personal cluster, so do not be afraid to experiment.

## Creating a page {#create}

To create a page in your personal cluster:

1. [Go to {{ wiki-name }}]({{ link-wiki }}) and click ![](../_assets/wiki/svg/create-page.svg) **Create page** in the left-hand panel.

1. Select the **Old editor** type.

1. In the **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.name }}** field, enter the page title.

1. The address field is filled in automatically. Do not edit it if this is your first time creating a page.

1. Select **Personal cluster**.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.create }}**.

1. Paste this sample into the entry field on the left or come up with your own text:

   ```
   # First-level heading
   ## Second-level heading
   Cluster text.
   Sample [link]({{ link-yandex }}).
   ### Third-level heading
   *Text is in italics.* **Text is in bold.**
   ~~Strikethrough~~. `Source code snippet`
   Bulleted list:
   * List item.
     * Sub-item.
     * Sub-item.
   * List item.

   Numbered list:
   1. List item.
   2. List item:
   3. List item.

   Sample table:

   |heading 1|heading 2|heading 3|
   |---|---|---|
   |cell 11|cell 12|cell 13|
   |cell 21|cell 22||
   ```

   {% cut "See the result" %}

   ![](../_assets/wiki/example-wiki-page.png)

   {% endcut %}

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.

A list of all your pages is available on the top {{ wiki-name }} panel in the ![](../_assets/wiki/svg/structure-icon.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.tree }}** menu.

## Configuring access {#access}

To configure access to your page:

1. Open the page.

1. At the top of the page, click the button that specifies its access mode (by default, **Available to all employees**).

1. Specify who can view the page:

   - **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.access_to_parent }}**: Access level is inherited from the parent page.

   - **All employees**: All employees of your organization.

   - **Only authors**: Only [authors](page-management/edit-owner.md) can view and edit the page.

   - **Specific employees**: Enter the usernames of employees who should be able to view and edit the page.

   {% note warning %}

   It is not recommended to change the access settings for the [{{ wiki-name }} homepage]({{ link-homepage }}).
   By default, the author of the {{ wiki-name }} home page is a service account. If the "Only authors" access type is selected for this page, other users can't access it. To allow others to access the page, click the [{{ link-homepage-access }}]({{ link-homepage-access }}) link and change the access parameters.

   {% endnote %}

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-editor-struct.page_save }}**.





