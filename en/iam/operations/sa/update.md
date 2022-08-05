# Updating a service account

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. Go to the **Service accounts** tab.
   1. Click ![image](../../../_assets/options.svg) next to the service account and select **Edit**.
   1. Change the name of your service account.

      Name format requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. Change the description of your service account.
   1. Click **Save**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   1. See the description of the update service account command:

      ```bash
      yc iam service-account update --help
      ```

   1. Select a service account (for example, `my-robot`):

      ```bash
      yc iam service-account list
      ```

      Result:

      ```bash
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

   1. Change the service account parameters, such as name and description:

      ```bash
      yc iam service-account update my-robot \
        --new-name my-service-account \
        --description "this is my service account"
      ```

      Name format requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

- API

   To edit the service account, use the [update](../../api-ref/ServiceAccount/update.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

{% endlist %}
