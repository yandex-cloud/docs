# Sharing a dashboard

You can share your dashboard with colleagues:

1. Open the dashboard page.

1. Copy the dashboard address and send it to the person you want to share it with.

By default, any dashboard can be viewed by all users, but you can restrict access to the dashboard.

{% note tip %}

If someone shares a dashboard with you, [add it to Favorites](favourites.md#section_vj1_rdj_nz) so that you can always find it easily.

{% endnote %}

## Restricting access to dashboards {#section_k2z_1nk_pz}

If you want to restrict users&apos; access to your dashboard, you can change access settings:

1. Open the dashboard page.

1. Select ![](../../_assets/tracker/icon-settings.png) → **Edit access control** to the left of the dashboard name.

1. Set permissions to **Read**, **Write**, and **Grant** for the following categories of users:

    - **Users and robots**: Individual settings for individual users. To add a user to this category, enter the login or the user's name in the search bar at the top of the table.

    - **Groups**: Settings for {% if audience == "external" %}all employees.{% else %} departments and teams. To add a new department, enter its name in the search bar at the top of the table.{% endif %}

        {% note tip %}

        To add all {% if audience == "external" %}of your organization's{% else %}Yandex{% endif %} employees, select the {% if audience == "external" %}`All employees`{% else %}`Yandex`{% endif %} group.

        {% endnote %}

    - **Roles**: Settings for users who have specific roles for the dashboard:

        - **Owner**: The owner of the dashboard. By default, the owner is the person who created the dashboard, and only the owner has **Write** and **Grant** permissions.

            {% note alert %}

            Try not to change the access settings for the dashboard owner unless necessary. If you accidentally revoked grant permissions from the owner, contact your {% if audience == "external" %}organization's{% endif %} admin.

            {% endnote %}

1. Click **Apply**.

## Adding a dashboard to Favorites {#section_gnx_s3l_pz}

If a dashboard was shared with you, you can add it to Favorites so that it&apos;s easy to find:

1. Open the dashboard.

1. Click ![](../../_assets/tracker/add-to-favorites.png) to the right of the dashboard name.

Your favorite dashboards are available in the **Dashboards** menu on the top panel in {{ tracker-name }}.

