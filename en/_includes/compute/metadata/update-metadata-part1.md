When updating VM metadata using the {{ yandex-cloud }} [`yc compute instance update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) CLI command, the [update](../../../compute/api-ref/Instance/update.md) REST API method for the [Instance](../../../compute/api-ref/Instance/index.md) resource, or the [InstanceService/Update](../../../compute/api-ref/grpc/Instance/update.md) gRPC API call, the entire existing set of [metadata](../../../compute/concepts/vm-metadata.md) in the [user-data](../../../compute/concepts/metadata/directories.md#dir-user) folder and in the `instance/attributes/*` path of the [computeMetadata](../../../compute/concepts/metadata/directories.md#dir-compute) folder is fully overwritten with the newly updated set.

To add, modify, or delete individual keys in the `instance/attributes/*` path of the `computeMetadata` folder, use the {{ yandex-cloud }} [`yc compute instance add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) and [`yc compute instance remove-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/remove-metadata.md) CLI commands, the [updateMetadata](../../../compute/api-ref/Instance/updateMetadata.md) REST API method for the [Instance](../../../compute/api-ref/Instance/index.md) resource, or the [InstanceService/UpdateMetadata](../../../compute/api-ref/grpc/Instance/updateMetadata.md) gRPC API call. In which case the `user-data` folder metadata will always be fully overwritten with new values.

To update the VM metadata:

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}

  When creating VM users via metadata using the `user-data` key, all users, including the default one specified under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, will be overwritten. To avoid this, specify the data of all users in the `user-data` key, including the user specified under **{{ ui-key.yacloud.compute.instances.create.section_access }}**.

  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the folder this VM belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
  1. In the VM row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Under **{{ ui-key.yacloud.common.metadata }}**, provide the metadata in `Key:Value` format.

      For example, to create multiple users in the virtual machine OS, add the `user-data` key and specify the following configuration in it:

      {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

  1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

- CLI {#cli}

  {% note info %}

  When creating VM users via metadata using the `user-data` key, all users, including the default one specified under `--ssh-key`, will be overwritten. To avoid this, specify the data of all users in the `user-data` key, including the user specified under `--ssh-key`.

  {% endnote %}

  In the {{ yandex-cloud }} CLI, you can provide metadata in any of the three parameters:

  * `--metadata-from-file`: As a configuration file in this format: `--metadata-from-file key=<file_path>`. Use this method to conveniently deliver a value consisting of several lines.

      For example, to add several users to a VM at the same time, describe the configuration in a [YAML](https://yaml.org/) file:

      {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

  * `--metadata`: As a comma-separated list of `key=value` pairs, e.g., `--metadata foo1=bar,foo2=baz`.

      For a multiline value, use `\n` as a separator: `--metadata user-data="#ps1\nnet user Administrator Passw0rd"`.
  * `--ssh-key`: SSH key. Only for Linux VMs.

    {{ compute-name }} creates the `yc-user` user and adds the specified SSH key to the list of authorized keys. After the VM is created, you can use this key to connect to it over SSH.

  You can combine these parameters, for example:

  ```bash
  yc compute instance update \
    --name my-instance \
    --metadata-from-file user-data=metadata.yaml \
    --metadata serial-port-enable=1
  ...
  ```

- {{ TF }} {#tf}

  {% note info %}

  When creating VM users via metadata using the `user-data` key, all users, including the default one specified under `ssh-keys`, will be overwritten. To avoid this, specify the data of all users in the `user-data` key, including the user specified under `ssh-keys`.

  {% endnote %}

  In {{ TF }}, you can specify metadata in three ways:
  * As a separate file with user metadata to process by the `cloud-init` agent. To do this, under `metadata`, specify the path to the file with user metadata, such as `cloud-init.yaml`:

    ```hcl
    ...
    metadata = {
      user-data = "${file("cloud-init.yaml")}"
    }
    ...
    ```

    {% cut "Sample contents of the `cloud-init.yaml`" file %}

    {% include [users-from-metadata-example](../users-from-metadata-example.md) %}

    {% endcut %}

  * Under `metadata`, as a line with user metadata. For a multiline value, use `\n` as a separator. For example:

    ```hcl
    ...
    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - <SSH_key_contents>"
    }
    ...
    ```

  * Only for Linux VMs. Under `ssh-keys`, specify the username and the SSH key to access Linux VMs. Enter your username and the contents of your SSH key as follows:

    ```hcl
    ...
    metadata = {
      ssh-keys = "<username>:<SSH_key_contents>"
    }
    ...
    ```

    If you are using an out-of-the-box public [image](../../../compute/concepts/image.md) from {{ marketplace-full-name }}, the specified username does not matter. The key will be assigned to the user specified in the `cloud-init` configuration by default. Such users vary depending on an image.

    If you do not know the default user, find the string containing `Authorized keys from` in the [serial port output](../../../compute/operations/vm-info/get-serial-port-output.md). It will contain the name of the user the authorized keys are assigned to.

    If you cannot find this string but you see the `no authorized ssh keys fingerprints found for user` string, it means you have provided your SSH key incorrectly. Check the format once again or try providing the SSH keys in the `user-data`field.

- API {#api}

  In the API, specify the metadata in the `metadata` property as a JSON object, e.g.:

  ```json
  "metadata": {
    "ssh-keys": "ssh-ed25519 AAAAB3Nza... user@example.com",
    "serial-port-enable": "1"
  }
  ```

  For a line break, use `\n`.

{% endlist %}

{% note warning %}

All metadata, including user-defined metadata, is unencrypted. If the metadata contains sensitive information, make sure to protect it, e.g., through encryption.

{% endnote %}