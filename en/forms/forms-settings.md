# Manage forms

## Edit a form {#edit}

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Choose a form from the list and click it.

   To filter the list of forms, type part of the form name in the search bar or use the fields above the list.

1. [Add or edit form prompts](add-questions.md).

   To learn more about prompt parameters, go to [{#T}](blocks-ref/blocks-reference.md).

1. To change the appearance of the form, select a theme and [set the text layout](appearance.md).

1. To send email notifications when you receive responses, to create tasks in {{ tracker-name }}, or to add information to {{ wiki-name }}, [configure integration with the appropriate service](notifications.md).

{% note info %}

The entire change [history](#log) is saved.

{% endnote %}

## Who can edit a form {#access}

By default, only the owner (creator) of the form can edit it.

If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can give your employees access to edit the form:


1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Select the form and go to **Settings** → **Access**.


1. [Connect the form to your organization.](#add-connect) All organization employees will be able to edit the form.


1. Select who can edit the form:

      - **All employees**: All employees of your organization can edit the form.

   - **Owner only**.
   - **Selected employees**: Only the listed employees can edit the form. To add a new user to the list, enter their name or username.

1. Click **Save**.


## Connect a form to an organization in {{ org-full-name }} {#add-connect}

If you connect a form to an organization in [{{ org-full-name }}]({{ link-org-main }}), you can let the organization's employees edit it. You can also configure [integration with {{ tracker-name }} and {{ wiki-name }}](notifications.md) in the form.

To connect a form to an organization:

1. [Enable {{ forms-full-name }}.](enable-forms.md)

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Choose a form from the list and click it.

1. In the top panel, click ![](../_assets/forms/settings.png) and select the organization.

   If you are registered in several organizations, you can see which organization each of the forms belongs to in the list of forms.


## Group forms {#sec_groups}


If you 're using  [{{ forms-full-name }} for business](forms-for-org.md), you can group forms by topic, project, team, or other feature:


1. In the upper panel of {{ forms-name }}, select the **Groups** tab.

1. Click **Create group** and enter the group name.

1. In the **Access** section on the group page, specify who can edit the group.

1. Add forms to the group in one of the following ways:
   * In the **Manage group** section on the group page, enter the name of the form and click **Save**.
   * On the form editing page, go to **Settings** and select **Access**. On the **Group** list, select the group you want your form to be part of.

## View the change history {#log}

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Next to the form name in the **Modified** column, click the time or date of the last change.


## Delete form {#sec_delete}

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Select a form and hover over it.

1. Click ![](../_assets/forms/context-menu.png) and select **Delete**.

