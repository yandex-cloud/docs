---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Updating the target endpoint

To update the target endpoint:

{% list tabs %}

- Management console

  1. In [management console]({{ link-console-main }}), select the folder where you want to change the endpoint.

  1. In the list of services, select **{{ data-transfer-name }}**.

  1. Select the endpoint to update.

  1. At the top-right of the window, click ![pencil](../../../_assets/pencil.svg) **Edit**.

  1. Edit the endpoint parameters:

      {% cut "{{mmy-short-name}}" %}
      - Specify the DB **Replication user name**.
      - Enter the DB user **Password**.
      - In the **PEM certificate** field, click **Upload file**:
          - Upload the file or add the certificate body as text.
      - Select a value for the option **Disable foreign key checks on target. Use FOREIGN_KEY_CHECKS=0**.

      {% endcut %}

      {% cut "{{mpg-short-name}}" %}
      - Enter the DB user **Password**.

      {% endcut %}

      {% cut "{{MY}}" %}
      - Enter the DB user **Password**.
      - In the **PEM certificate** field, click **Upload file**:
          - Upload the file or add the certificate body as text.
      - Select a value for the option **Disable foreign key checks on target. Use FOREIGN_KEY_CHECKS=0**.

      {% endcut %}

      {% cut "{{PG}}" %}
      - Enter the DB user **Password**.

      {% endcut %}

  1. Click **Apply**.

{% endlist %}

