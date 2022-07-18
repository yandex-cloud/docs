# Creating secrets

To create a secret:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you will be creating your secret.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click **Create secret**.
   1. In the **Name** field, enter a name for the secret.
   1. (optional) In the **{{ kms-short-name }} Key** field, specify an existing key or [create a new one](../../kms/operations/key.md#create).

      The specified {{ kms-short-name }} key is used to encrypt your secret. If you omit the key, the secret is encrypted with a special system key.

      {% note tip %}

      By using your own [{{ kms-short-name }} key](../../kms/concepts/key.md) you can take full advantage of {{ kms-full-name }}.

      {% endnote %}

   1. Under **Version**:
      * In the **Key** field, enter a non-secret ID.
      * In the **Value** field, enter the confidential data you want to store.

      To add more data, click **Add pair** and repeat the steps.
   1. Click **Create**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create secret command:
      ```bash
      yc lockbox secret create --help
      ```

   1. Run the command by specifying the folder name and cloud ID in the parameters:
      ```bash
      yc lockbox secret create --name <secret name> \
        --description <secret description> \
        --payload "[{'key': '<key>', 'text_value': '<text value>'},{'key': '<key>', 'text_value': '<text value>'}]" \
        --cloud-id <cloud ID> --folder-name <folder name>
      ```

      Output:

      ```
      id: e6q2ad0j9b55tk3d781j
      folder_id: b1gktjk2rg494evcsd2a
      created_at: "2021-11-08T19:23:00.383Z"
      name: <secret name>
      description: <secret description>
      status: ACTIVE
      current_version:
        id: g6q4fn3b6okjkckanaib
        secret_id: e6e2ei4u9b55gh2d561j
        created_at: "2021-11-08T19:23:00.383Z"
        status: ACTIVE
        payload_entry_keys:
        - <key>
      ```

{% endlist %}
