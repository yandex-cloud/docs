# Working with saved SQL queries

{% include notitle [preview](../../_includes/note-preview.md) %}

You can save any SQL query to use it whenever you need and create a template.

## Saving a query {#custom-templates}

To save a query:

1. In the data panel, for any query, click ![image](../../_assets/console-icons/floppy-disk.svg) next to the **Execute** button.
1. In the **Save query** window:
   1. Select a connection to the database being queried.
   1. Specify the **Name**: a user-defined name under which the query will be displayed in the list of saved queries.
   1. For your saved query to be used as a template in the suggestions list, select **Add tip** and type the **Tip text** including `userTemplate_`.
   1. Verify or edit the SQL query.

      {% note tip %}

      If you add a suggestion and specify a template name, you can include in the query the arguments to be highlighted when this template is selected, such as `SELECT $1 FROM employees LIMIT $2`.

      {% endnote %}

   1. Click **Save**.

After you save the query, it will appear in the **Saved queries** (![image](../../_assets/console-icons/floppy-disk.svg)) window, and if you have added a suggestion, it will appear as a template along with the ready-made {{ websql-full-name }} [templates](#available-templates).

Queries are saved for the selected {{ yandex-cloud }} [organization](../../organization/concepts/manage-services.md) and current browser session.

## Using templates {#available-templates}

To apply templates:

1. Begin typing `template` in the query field.
   The suggestions list will show the saved `userTemplate_*` templates and ready-made templates:

   * `template_CREATE`
   * `template_DELETE`
   * `template_DROP_TABLE`
   * `template_INSERT`
   * `template_SELECT`
   * `template_UPDATE`

1. Select the template you need from the suggestions list.
1. Add relevant parameters to the template. Use the `TAB` key to switch between the parts of the template you are adding parameters to.
1. Click **Run**.
