---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Updating the source endpoint

To update the source endpoint:

{% list tabs %}

- Management console

  1. In [management console]({{ link-console-main }}), select the folder where you want to change the endpoint.

  1. In the list of services, select **{{ data-transfer-name }}**.

  1. Select the endpoint to update.

  1. At the top-right of the window, click ![pencil](../../../_assets/pencil.svg) **Edit**.

  1. Edit the endpoint parameters:

      {% cut "{{mmy-short-name}}" %}
      - Enter the DB user **Password**.
      - Update the **Whitelist of tables**. If set, data is only transferred from whitelisted tables.
      - Update the **Blacklist of tables**. Data from blacklisted tables isn't transferred.
      - **DB time zone** in UTC.

      {% endcut %}

      {% cut "{{mpg-short-name}}" %}
      - **DB user password**.
      - **Whitelist of tables**. If set, data is only transferred from whitelisted tables.
      - **Blacklist of tables**. Data from blacklisted tables isn't transferred.

      {% endcut %}

      {% cut "{{MY}}" %}
      - **DB user password**.
      - **Whitelist of tables**. If set, data is only transferred from whitelisted tables.
      - **Blacklist of tables**. Data from blacklisted tables isn't transferred.
      - **PEM certificate** to access the database.
      - **DB time zone** in UTC.

      {% endcut %}

      {% cut "{{PG}}" %}
      - **DB user password**.
      - **Whitelist of tables**. If set, data is only transferred from whitelisted tables.
      - **Blacklist of tables**. Data from blacklisted tables isn't transferred.

      {% endcut %}

  1. Click **Apply**.

{% endlist %}

