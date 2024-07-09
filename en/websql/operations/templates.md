# Working with saved queries

You can save any query for later use and to create a template out of it. The ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section enables you to:

* [Save a query as a template](#save-query).
* [Use a saved query](#use-templates).
* [Edit a saved query](#alter-template).
* [Publish a saved query](#publish-query).
* [Configure access permissions for a published query](#set-access-rights-to-published-query).
* [Delete a saved query](#remove-query).

## Saving a query as a template {#save-query}

To save a query:

{% list tabs %}

- Query editor

  1. In the ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}) section, connect to the database and [go to the query editor](query-executor.md).
  1. In the data panel, click ![image](../../_assets/console-icons/floppy-disk.svg) next to the **Execute** button.
  1. In the **Save query** window:
     1. Select the database to query. By default, the current database is specified in this field.
     1. Specify a **Name**, i.e., any name under which the query will be displayed in the list of saved queries.
     1. For your saved query to be used as a template in the suggestions list, select **Add tip** and type the **Tip text** including `userTemplate_`.

        {% note tip %}

        If you add a suggestion and specify a template name, you can include in the query the arguments to be highlighted when this template is selected, such as `SELECT $1 FROM employees LIMIT $2`.

        {% endnote %}

     1. Review or edit the query.
     1. Click **Save**.

- **Saved queries** section

  1. Open [{{ websql-full-name }}]({{ websql-link }}).
  1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.
  1. In the top-right corner, click ![image](../../_assets/websql/new-connection.svg).
  1. In the window that opens:

     1. Select the database connection to query.
     1. Specify a **Name**, i.e., any name under which the query will be displayed in the list of saved queries.
     1. For your saved query to be used as a template in the suggestions list, select **Add tip** and type the **Tip text** including `userTemplate_`.

        {% note tip %}

        If you add a suggestion and specify a template name, you can include in the query the arguments to be highlighted when this template is selected, such as `SELECT $1 FROM employees LIMIT $2`.

        {% endnote %}

     1. Enter the query text.
     1. Click **Save**.

{% endlist %}

After you save the query, it will appear in the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** window. If you have added a suggestion, it will appear as a template along with the [ready-made {{ websql-full-name }} templates](#use-templates).

## Using a saved query {#use-templates}

{% list tabs %}

- Query editor

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

- **Saved queries** section

  1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the query you need and select **Use query**: it will show up in the data panel.
  1. Click **Open in editor**.
  1. (Optional) Update query parameters.
  1. Click **Execute**.

{% endlist %}

## Editing a saved query {#alter-template}

To edit a saved query:

1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.

1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the query you need and select **Edit query**.

1. In the window that opens:

   1. Select the database to query.
   1. Specify a **Name**, i.e., any name under which the query will be displayed in the list of saved queries.
   1. Add, edit, or delete a suggestion.

      {% note tip %}

      If you add a suggestion and specify a template name, you can include in the query the arguments to be highlighted when this template is selected, such as `SELECT $1 FROM employees LIMIT $2`.

      {% endnote %}

   1. Review or edit the query.

1. Click **Save**.

## Publishing a query {#publish-query}

You can publish your query. Once published, the query will be available to all folder users. You cannot unpublish a query.

To publish a query:

1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.

1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the query you need and select **Publish query**.

1. In the window that opens, click **Publish**.

You will see ![image](../../_assets/console-icons/lock-open.svg) next to the name of the published query.

## Configuring access permissions for a published query {#set-access-rights-to-published-query}

To configure access permissions:

1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.

1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the query you need and select **Access permissions**.

1. In the window that opens, click **Assign roles**.

1. Assign the required roles and click **Save**.

## Deleting a saved query {#remove-template}

To delete a saved query:

1. Go to the ![image](../../_assets/console-icons/floppy-disk.svg) **Saved queries** section.

1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the query you need and select **Delete**.

1. In the window that opens, click **Apply**.
