# Using shared templates

If you want other users to be able to use your template:

1. [Set up template sharing](share-template.md#section_nmn_prs_zz). You can configure access permissions for individual users{% if audience == "internal" %}, teams, departments{% endif %}, or the entire company.

1. Tell your colleagues [to enable your template in their personal settings](share-template.md#section_vkg_trs_zz).

## How to set up access to a template {#section_nmn_prs_zz}

To change the access settings for a template:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Manage templates**.{% else %}On the top panel in {{ tracker-name }}, click on your profile picture and choose **Personal settings**. Then click **Manage templates**.{% endif %}

1. Select an option:
    - **Issues** to edit issue templates.
    - **Comments** to edit comment templates.

1. If necessary, filter out extra templates by clicking ![](../../_assets/tracker/queue-filter.png).

1. Click **Access control** next to the desired template.

1. Set permissions to **Read**, **Write**, and **Grant** for the categories:

    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.

    - **Groups**: Settings for {% if audience == "external" %}all employees.{% else %} departments and teams. To add a new department, enter its name in the search bar at the top of the table.{% endif %}

        {% if audience == "internal" %}
		
		{% note tip %}

        To add all Yandex employees, select the `Yandex` group.

        {% endnote %}
		
		{% endif %}

    - **Roles**: Settings for users who have specific roles for the template:
        - **Owner**: The owner of the template. By default, the owner is the person who created the template. They're the only ones with **Write** and **Grant** rights.
        - **Queue team members**: Users who are members of the queue team that the issue is assigned to.

Shared templates are available to all users on the **Select** tab.

## How to share a template {#section_ucr_rrs_zz}

To share a template with a coworker, send a link to the template:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Manage templates**.{% else %}On the top panel in {{ tracker-name }}, click on your profile picture and choose **Personal settings**. Then click **Manage templates**.{% endif %}

1. Select an option:
    - **Issues** to edit issue templates.
    - **Comments** to edit comment templates.

1. If necessary, filter out extra templates by clicking ![](../../_assets/tracker/queue-filter.png).

1. Next to the desired template, select ![](../../_assets/tracker/share.png) → **Link to template**.

1. Copy the contents of the browser's address bar and send it to the person you want to share it with.

{% note info %}

The user will only be able to see the template if they have [read access](#section_nmn_prs_zz) for it.

{% endnote %}

## How to enable a shared template {#section_vkg_trs_zz}

If you have [read access](#section_nmn_prs_zz) for the desired template, you can use it to create issues and comments. To do this, enable a template:

1. {% if audience == "external" %}On the {{ tracker-name }} top panel, click ![](../../_assets/tracker/tracker-settings.png) → **Manage templates**.{% else %}On the top panel in {{ tracker-name }}, click on your profile picture and choose **Personal settings**. Then click **Manage templates**.{% endif %}

1. Select an option:
    - **Issues** to edit issue templates.
    - **Comments** to edit comment templates.

1. If necessary, filter out extra templates by clicking ![](../../_assets/tracker/queue-filter.png).

1. Find the switch next to the desired template and set it to ![](../../_assets/tracker/enabled-switch-2.png).


