# Configure access

## Who can edit a form {#access}

By default, only the owner (creator) of the form can edit it.

{% if audience == "external" %}If you're using [{{ forms-full-name }} for business](forms-for-org.md), you can give your employees access to edit the form:

{% else %}

To give others access to edit the form:{% endif %}

1. In the upper panel in {{ forms-name }}, go to **My forms**.

1. Select the form and go to **Settings** → **Access**.

1. Select who can edit the form:

   {% if audience == "external" %}
   * **All employees**: All employees of your organization can edit the form.
{% else %}
   * **All employees**: All Yandex employees can edit the form.
{% endif %}
   * **Owner only**.
   * **Selected employees**: Only the listed employees can edit the form. To add a new user to the list, enter their name or username. {% if audience == "internal" %} You can also specify the name of a team on Staff or in ABC to grant access to multiple users at once.{% endif %}

1. Click **Save**.

## Who can edit a group of forms {#access_groups}

{% if audience == "external" %}
If you use [{{ forms-full-name }} for business](forms-for-org.md), you can group forms by topic, project, team, or other attribute.
{% else %}
Forms can be grouped by topic, project, team, or other attribute.{% endif %}

To configure access to a group of forms:

1. In the upper panel of {{ forms-name }}, select the **Groups** tab.

1. Select a group from the list.

1. In the **Access** section, specify who can edit the group of forms:

   {% if audience == "external" %}
   * **All employees**: All employees of your organization can edit the group.
{% else %}
   * **All employees**: All Yandex employees can edit the group.
{% endif %}
   * **Owner only**.
   * **Selected employees**: Only the listed employees can edit the group. To add a new user to the list, enter their name or username. {% if audience == "internal" %} You can also specify the name of a team on Staff or in ABC to grant access to multiple users at once.{% endif %}

1. Click **Save**.

{% if audience == "internal" %}

## Request access via IDM {#idm}

Using the **IDM** service, you can easily configure access to any Yandex forms, even if the form owner doesn't work at Yandex anymore.

Access can be granted to one or more employees as well as to Staff or ABC teams to perform the following actions:

* Manage the form.
* Manage the group of forms.
* Download files attached to the form.

If you set up management rights for forms or a group of forms using the [interface {{ forms-full-name }}](#access), they will also be applied to **IDM**.

To configure access via **IDM**:

1. Go to [**IDM**](https://idm.yandex-team.ru/).

1. Click **Request role**.

1. Select a service:
   * **Forms Int** for forms available only to Yandex employees.
   * **Forms Ext** for Yandex forms to be used by external users.

1. Select the requested role type: [form management](#manager) or [access to files](#files).

1. Enter the names of the employees or the name of the team on Staff or in ABC.

   {% note warning %}

   You can't request access for the main subdivisions, such as Yandex, Business Support Team, or External Consultants.

   {% endnote %}

1. Specify the form code or the form group code. You can copy the code from the URL.

   {% cut "How to get the code" %}
   
   * For forms available to Yandex employees:
   `{{ link-forms }}surveys/80550/` the code is `80550`.
   * For Yandex forms for external users:
   `https://forms.yandex.ru/surveys/10034284.07057b6e2f312c17aa8da44a4146b5cfa7115ed7/` the code is `10034284`.
   * In the form group:
   `{{ link-forms }}admin/groups/1639/settings` the code is `1639`.

   {% endcut %}

1. Click **Request**. Access requests are sent to everyone who has form management rights. When one of them approves the request, access is granted.

### Access to form management {#manager}

To grant form management access to an employee or group, request a role in the IDM service for them:

* **Form group manager**: this role allows a user to manage the group of forms.

* **Form manager**: this role allows a user to manage a certain form.

{% note info %}

The **Superuser** and **Technical support** roles belong to the {{ forms-full-name }} development team and cannot be requested.

{% endnote %}

After an employee leaves the company, their supervisor automatically gets the right to manage all forms that the employee had access to. A list of such forms is emailed to the manager.

### Access to downloading files {#files}

To configure access to the files that were attached to the form when filling it out for an employee or a team, request the **Downloading files for forms** role in the IDM service.

Users with this role don't have access to the form settings, but can download attached files via a direct link. The names of such employees and teams are displayed on the tab **Settings** → **Access** in the **Who can access files** section.

{% endif %}

