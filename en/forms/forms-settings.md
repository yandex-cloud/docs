---
title: How to manage forms in {{ forms-full-name }}
description: In this tutorial, you will learn how to manage forms in {{ forms-full-name }}.
---

# Managing forms

## Edit a form {#edit}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select a form from the list and click it.

   To filter the list of forms, type part of the form name in the search bar or use the fields above the list.

1. [Add or edit form prompts](add-questions.md).

   To learn more about prompt parameters, go to [{#T}](blocks-ref/blocks-reference.md).

1. To change the appearance of a form, select a theme and [set the text layout](appearance.md).

1. To send email notifications when you receive responses, to create issues in {{ tracker-name }}, or to add information to {{ wiki-name }}, [configure integration with the appropriate service](notifications.md).

{% note info %}

Any changes are saved in the [history](#log).

{% endnote %}


### Change the form language {#translate}

The form cannot be automatically translated into another language.

If you need the form in another language:
* [Create a copy](new-form.md#sec_copy_form) of the form and change its text yourself.
* [Create a new form](new-form.md#create-form) and enter the text yourself in the language you need.


## View the revision history {#log}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Next to the form name in the **Modified** column, click the time or date of the last change.

## Group forms {#sec_groups}
If you are using [{{ forms-full-name }} for business](forms-for-org.md), you can group forms by topic, project, team, or other attributes:

1. On the {{ forms-name }} top panel, select **Groups**.

1. Click **Create group** and enter a group name.

1. Add forms to the group in one of the following ways:
   * In the **Manage group** section on the group page, enter the name of the form and click **{{ ui-key.yacloud.common.save }}**.
   * On the form editing page, go to **Settings** and select **Access**. In the **Group** list, select the group you want your form to be part of.

1. Set up [access](access.md#access_groups) to the group of forms.


## Move a form to a different account or organization

A form can be moved to a different account or organization only upon request from the form creator to the [technical support](feedback.md).

Form creators can move their forms only in the following cases:

* They are moving a [personal form](personal-forms.md) to another account for which this form will also be personal.
* They are moving a personal form to an organization they belong to.
* They are moving a [business form](forms-for-org.md) to a different account and both the source and target accounts belong to the same organization.

You cannot convert a business form to a personal form.



## Deleting a form {#sec_delete}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select the form and hover over the trigger.

1. Click ![](../_assets/forms/context-menu.png) and select **{{ ui-key.yacloud.common.delete }}**.