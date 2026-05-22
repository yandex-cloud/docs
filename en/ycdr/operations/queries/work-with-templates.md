---
title: Working with query templates in {{ ycdr-full-name }}
description: Follow this guide to learn how to work with query templates in {{ ycdr-name }}.
---

# Working with query templates

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

You can save frequently used queries as templates and quickly integrate them in investigations.

The following template categories are available:

* **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}**: Templates created by the user and available across investigations.
* **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}**: Templates available to all users, but restricted to a specific investigation.
* **{{ ui-key.yacloud_org.security.siem.template_type_global_qSrVE }}**: Templates available to all users across all investigations.

## Accessing the templates panel {#open-templates-panel}

To open the templates panel:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation.
  1. Click **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.title_xK9v2 }}** on the right side of the screen.
  1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.query-data-panel.tab-templates_tPl3Q }}** tab.

{% endlist %}

## Navigating template folders {#navigate-template-folders}

Templates within each category can be organized into folders. Users can create and give names to folders to facilitate navigation and group templates by threat type, event source, investigation phase, or other criteria.

To access a folder:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Select a category.
  1. Select the relevant folder from the list.

{% endlist %}

## Searching for a template {#search-template}

To find a template:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Enter your keywords in the search field.
  1. The results will be displayed automatically.

  The system will search for keywords across template names and contents.

{% endlist %}

## Inserting a template into a query {#insert-template}

To insert a template into your current query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Find the required template.
  1. Click the template.
  1. Select **{{ ui-key.yacloud_org.security.siem.action_insert_into_query_kR3x1 }}**.

  The template text will be added to the query editor.

{% endlist %}

## Creating a new query from a template {#create-query-from-template}

To create a new query from a template:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Find the required template.
  1. Click the template.
  1. Select **{{ ui-key.yacloud_org.security.siem.action_new_query_from_template_pL7m2 }}**.

  This will create a new tab pre-populated with a query from the selected template.

{% endlist %}

## Saving a query as a template {#save-as-template}

To save your current query as a template:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query you want to save.
  1. In the actions menu, select **Save as template**.
  1. Enter a name for the template.
  1. Select a folder to save it to:
     * **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}**: For personal use.
     * **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}**: For all instance users.
  1. Click **{{ ui-key.yacloud_org.security.siem.title_ap766 }}**.

{% endlist %}

## Creating a template folder {#create-template-folder}

To create a folder for templates:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Select either the **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** or **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}** category.
  1. Click **{{ ui-key.yacloud_org.security.siem.action_new_folder_qmx81 }}**.
  1. Enter a name for the directory.
  1. Click **Create**.

{% endlist %}

## Managing templates {#manage-templates}

### Renaming a template {#rename-template}

To rename a template:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Find the required template.
  1. Right-click the template.
  1. Select **{{ ui-key.yacloud_org.security.siem.action_rename_vN4w3 }}**.
  1. Enter a new name.
  1. Click **Save**.

{% endlist %}

### Deleting a template {#delete-template}

To delete a template:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the templates panel.
  1. Find the required template.
  1. Right-click the template.
  1. Select **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Confirm the deletion.

  {% note info %}

  Deletion is restricted to the **{{ ui-key.yacloud_org.security.siem.my_8uT22 }}** and **{{ ui-key.yacloud_org.security.siem.template_type_local_77J2t }}** categories. You cannot delete any shared templates.

  {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](manage-queries.md)
* [{#T}](work-with-schema-datasets.md)