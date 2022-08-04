# Using a form as a template for creating issues

{% note warning %}

By default, queue settings can only be accessed by the queue owner.

{% endnote %}

You can use {{ forms-full-name }} to set up your form to act as a template for creating issues as well as integrate it with the {{ tracker-name }} interface. Such form will be displayed on the issue creation page next to the basic one. It will help users create issues by following a preset template without feeling distracted by other fields and parameters.

## Step 1. Create and configure your form {#section_ovd_5hl_1gb}

1. {% if audience == "external" %}Go to [{{ forms-full-name }}]({{ link-forms }}). If the service hasn't been activated, contact your organization's administrator.{% else %}Go to [{{ forms-full-name }}]({{ link-forms }}).{% endif %}

1. [Create](../../forms/new-form.md) a new form from scratch or use the **Issue for {{ tracker-name }}** template.

   Set up your form's fields to collect data needed for issue creation.

1. Configure the name of the form. This name will be displayed in the {{ tracker-name }} interface when creating an issue.

1. Set up your form's [integration with {{ tracker-name }}](../../forms/create-task.md).

1. [Publish](../../forms/publish.md#section_link) your form and copy the link to it from the **Link** field.

## Step 2. Connect your form to the queue {#section_xxj_fll_1gb}

1. Go to the [{{ tracker-name }}]({{ link-tracker }}).

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to **Form integration** and click **Add form**.

1. Paste the link to the form.

1. Add the name and description for your form. You can view them in the form selection window when creating an issue.

1. Click **Add**.

{% if audience == "internal" %}

## Step 3. Configure form display on the issue creation page {#forms_display}

You can also hide the standard form from users on the issue creation page if necessary:

1. Go to the [{{ tracker-name }}]({{ link-tracker }}).

1. Open the [queue page](../user/queue.md).

1. To the left of the queue name, select ![](../../_assets/tracker/icon-settings.png) → **Configure**.

1. Go to **Basic settings** and click [**Show integration settings**](edit-queue-general.md).

1. Select a value for the **Display the standard issue creation form** field:

   * **Never** — never display the standard form on the issue creation page.

   * **Always** — always display the standard form on the issue creation page.

   * **Queue team only** — only display the standard form to [queue team](queue-team.md) members.

{% endif %}

