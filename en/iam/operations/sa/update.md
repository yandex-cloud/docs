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

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To change the name or description of a service account:

   1. Open the {{ TF }} configuration file and edit the fragment with the service account description.
      Example of the service account description in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_iam_service_account" "sa" {
        name        = "my-robot"
        description = "this is new description"
       }
      ...
      ```
   1. Check the configuration using the command:
      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```text
      Success! The configuration is valid.
      ```

   1. Run the command:
      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:
      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify that the service account was updated in the [management console]({{ link-console-main }}) or using the [CLI](../../../cli/quickstart.md) command:

      ```bash
      yc iam service-account list
      ```

- API

   To edit the service account, use the [update](../../api-ref/ServiceAccount/update.md) method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource.

{% endlist %}
