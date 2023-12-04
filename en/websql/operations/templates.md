# Working with SQL query templates

{% include notitle [preview](../../_includes/note-preview-by-request.md) %}

Use ready-made templates and your own saved queries to create SQL queries quickly.

## Using ready-made templates {#available-templates}

To apply ready-made templates:

1. Begin typing `template_` in the query field.
1. Select one of the ready-made templates from the suggestions list:

   * `template_CREATE`
   * `template_DELETE`
   * `template_DROP_TABLE`
   * `template_INSERT`
   * `template_SELECT`
   * `template_UPDATE`

1. Add relevant parameters to the template. Use the `TAB` key to switch between the parts of the template you are adding parameters to.
1. Click **Run**.

## Creating custom templates {#custom-templates}

You can save any SQL query as a template and use it whenever you need. To save a query:

1. In the data panel, for any query, click ![image](../../_assets/websql/template.svg) next to the **Execute** button.
1. In the **Save query** window:
    1. Specify the **Template name**: User-defined template name under which it will be displayed in the list of saved queries.
    1. Select **Add a tip** and type in the **Tip text** for the template to appear in the suggestions list. The text of the suggestion should contain `userTemplate_`.
    1. Verify or edit the SQL query.
    1. Click **Save**.

After you save the query, it will appear in the list of saved queries (![image](../../_assets/websql/template.svg)), and if you have added a suggestion, it will appear as a template along with the [ready-made {{ websql-full-name }} templates](#available-templates).

{% note warning %}

Queries are saved for the selected {{ yandex-cloud }} [organization](../../organization/concepts/manage-services.md) and current browser session.

{% endnote %}