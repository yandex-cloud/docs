# Manage forms

## Edit form {#edit}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select a form in the list and click it.

   To filter the list of forms, type part of the form name in the search bar or use the fields above the list.

1. [Add or edit form prompts](add-questions.md).

   To learn more about prompt parameters, go to [{#T}](blocks-ref/blocks-reference.md).

1. To change the appearance of a form, select a theme and [set the text layout](appearance.md).

1. To send email notifications when you receive responses, to create issues in {{ tracker-name }}, or to add information to {{ wiki-name }}, [configure integration with the appropriate service](notifications.md).

{% note info %}

Any changes are saved in the [history](#log).

{% endnote %}

## View the revision history {#log}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Next to the form name in the **Modified** column, click the time or date of the last change.

## To group forms {#sec_groups}
{% if audience == "external" %}
If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can group forms by topic, project, team, or other attributes:
{% else %}
You can group forms by topic, project, team, or other attributes:{% endif %}

1. On the {{ forms-name }} top panel, select **Groups**.

1. Click **Create group** and enter a group name.

1. Add forms to the group in one of the following ways:
   * In the **Manage group** section on the group page, enter the name of the form and click **Save**.
   * On the form editing page, go to **Settings** and select **Access**. In the **Group** list, select the group you want your form to be part of.

1. Set up [access](access.md#access_groups) to the group of forms.

{% if audience == "internal" %}

## Move a form to a different admin panel {#sec_export}

You can copy forms [across internal and external admin panels](go-to-forms.md) using the export and import features.

For example, you created a feedback form for a new service to be tested by Yandex employees. After the service is released, you need to create a similar feedback form for external users. In this case, it's convenient to transfer the previously created form from the internal admin panel to an external one.

The form transfer is performed in two stages:

### Step 1. Form export

1. On the {{ forms-full-name }} top panel, open **My forms** and select the form.

1. Export a JSON file with the form parameters as follows:

   * Hover over the form name and click ![](../_assets/forms/context-menu.png) → **Export**.

   * Open the form in the constructor and click ![](../_assets/forms/context-menu.png) → **Export form** at the top right of the page.

The JSON file is saved to the default downloads folder.

### Step 2. Form import

1. Open the admin panel to import the form to: [internal]({{ link-forms-admin }}) or [external]({{ link-forms-ext }}).

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. In the upper-right corner of the page, click **Import**.

1. Select the saved JSON file and click **Save**.

The form opens in the constructor and is saved in the list.  You can continue working with form.

{% endif %}

## Deleting a form {#sec_delete}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select the form and hover over the trigger.

1. Click ![](../_assets/forms/context-menu.png) and select **Delete**.