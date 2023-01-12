# Configure access

## Who can edit a form {#access}

By default, only the creator of the form can edit it.

{% if audience == "external" %}If you are using [{{ forms-full-name }} for business](forms-for-org.md), you can give your employees access to edit the form:

{% else %}

To allow others to edit your form:{% endif %}

1. On the {{ forms-full-name }} top panel, select **My forms**.

1. Select a form and open the **Settings** → **Access** tab.

1. Select who can edit the form:

   {% if audience == "external" %}
   * **All employees**: All employees of your organization can edit the form.
   {% else %}
   * **All employees**: All Yandex employees can edit the form.
   {% endif %}
   * **Creator only**.
   * **Selected employees**: Only the listed employees can edit the form. To add a new user to the list, enter their login or name in the field. {% if audience == "internal" %} You can also grant access to multiple employees at once by specifying the name of a team in Staff or in ABC.{% endif %}

1. Click **Save**.

## Who can edit a group of forms {#access_groups}

{% if audience == "external" %}
If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can group forms by topic, project, team, or other attributes.
{% else %}
Forms can be grouped by topic, project, team, or other attributes.{% endif %}

To configure access to a group of forms:

1. On the {{ forms-name }} top panel, select **Groups**.

1. Choose the group from the list.

1. In the **Access** section, specify who can edit the group of forms:

   {% if audience == "external" %}
   * **All employees**: All employees of your organization can edit the group.
   {% else %}
   * **All employees**: All Yandex employees can edit the group.
   {% endif %}
   * **Creator only**.
   * **Selected employees**: Only the listed employees can edit the group. To add a new user to the list, enter their login or name in the field. {% if audience == "internal" %} You can also grant access to multiple employees at once by specifying the name of a team in Staff or in ABC.{% endif %}

1. Click **Save**.

{% if audience == "internal" %}

## Request access via IDM {#idm}

**IDM** is a convenient way to configure access to any Yandex form, even if the creator of the form is no longer a Yandex employee.

Access can be granted to one or multiple employees and Staff or ABC teams for the following actions:
* Manage forms.
* Manage a group of forms.
* Download files attached to a form.

If you set up permissions to manage a form or a group of forms in the [{{ forms-full-name }} interface](#access), they are also displayed in **IDM**.

To configure access via **IDM**:

1. Go to the [**IDM** service](https://idm.yandex-team.ru/).

1. Click **Request role**.

1. Select a service:
   * **Forms Int** for forms that are only available to Yandex employees.
   * **Forms Ext** for Yandex forms that can be accessed by external users.

1. Select the type of requested role: [manage forms](#manager) or [file access](#files).

1. Enter the names of employees or the name of a Staff or ABC team.

   {% note warning %}

   You can't request access for the main departments: Yandex, Business support team, and External consultants.

   {% endnote %}

1. Specify the form or form group code. You can copy the code from the URL.

   {% cut "How to gain code" %}

   * In forms that can be accessed by Yandex employees:
      `{{ link-forms }}surveys/80550/` code `80550`.
   * In Yandex forms for external users:
      `https://forms.yandex.ru/surveys/10034284.07057b6e2f312c17aa8da44a4146b5cfa7115ed7/` code `10034284`.
   * In a group of forms:
      `{{ link-forms }}admin/groups/1639/settings` code `1639`.

   {% endcut %}

1. Click **Request**. Access requests are sent to every user who has permission to manage the form. Access is granted once any of them approves the request.

### Access to manage forms {#manager}

To configure access to manage forms for an employee or group, request the following role in IDM:

* **Form group manager** to manage a group of forms.

* **Form manager** to manage a specific form.

{% note info %}

The **Superuser** and **Tech support** roles are only granted to the {{ forms-full-name }} development team and can't be requested.

{% endnote %}

When an employee leaves employment, their supervisor is automatically granted the right to manage all forms the employee was allowed to access. A list of these forms is sent to the supervisor's email address.

### Access to download files {#files}

To configure an employee or group's access to files that were attached to a form when filling it out, request the **Download files for forms** role in IDM.

The role owners don't have access to form settings, but can download its files via a direct link. The names of these employees and groups are displayed in **Settings** → **Access** under **Who can access files**.

{% endif %}