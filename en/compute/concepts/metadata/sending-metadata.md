---
title: Transferring metadata to a {{ compute-name }} VM instance
description: In this article, you will learn about the ways to transfer metadata to {{ compute-full-name }} VM instances.
---

# Transferring metadata to VM instances

You can provide [metadata](../vm-metadata.md) to a VM when [creating](../../operations/index.md#vm-create) or [updating](../../operations/vm-control/vm-update.md#change-metadata) it. Data for connection to a VM can only be provided when creating the VM; moreover, in a [VM running Linux](../../operations/vm-create/create-linux-vm.md), a public SSH key must be provided for each user.

You can update VM metadata only in the [user-data](./directories.md#dir-user) folder. To learn more about updating VM metadata, see [{#T}](../../operations/vm-metadata/update-vm-metadata.md).

{% note warning %}

All metadata, including user-defined metadata, is unencrypted. If the metadata contains sensitive information, make sure to protect it, e.g., through encryption.

{% endnote %}

## Specifics of providing environment variables in metadata via the CLI {#environment-variables}

With the [{{ yandex-cloud }} CLI](../../../cli/index.yaml), you can provide both the names of [environment variables](https://en.wikipedia.org/wiki/Environment_variable) and the values of local environment variables to the VM metadata. They will be substituted into the new VM's metadata when running the CLI command:

{% list tabs %}

- Providing the values of variables

  To provide the values of local variables to the VM metadata, specify them in the `user-data` key in `$<variable_name>` format. When executing a CLI command, the values of these variables will be substituted into the `cloud-init` configuration from the environment the command is executed in.

  Here is an example:

  ```yaml
  ...
  users:
  - name: $USER_NAME
  ...
  ```

  In this case, when executing the CLI command, the value of the `USER_NAME` variable will be substituted from the environment running that command. For example, if the environment features a variable named `USER_NAME` set to `my-user`, the string supplied to VM metadata will appear as `- name: my-user` instead of `- name: $USER_NAME`.

  {% note info %}

  If the variable has no value set in the environment, an empty value will be supplied to the metadata without any error message.

  {% endnote %}

- Providing the names of variables

  To provide the names of variables instead of values to the metadata in `$<variable_name>` format, use the two-dollar syntax.

  Here is an example:

  ```bash
  ...
  # Save YC params
  echo "Saving YC params to the ~/.bashrc"
  cat << EOF >> $$HOME/.bashrc
  ...
  ```

  In which case the `HOME` variable value will not be substituted from the environment the CLI command is executed in. Instead, the `cat << EOF >> $HOME/.bashrc` string will be written to the VM metadata.

{% endlist %}

For an example of using variables when supplying metadata to a VM via the {{ yandex-cloud }} CLI, see [{#T}](../../operations/vm-create/create-with-env-variables.md).

#### See also {#see-also}

* [Updating VM metadata](../../operations/vm-metadata/update-vm-metadata.md)
* [Creating a VM with a custom configuration script](../../operations/vm-create/create-with-cloud-init-scripts.md)
* [Creating a VM with metadata from environment variables](../../operations/vm-create/create-with-env-variables.md)
* [Transferring a {{ lockbox-full-name }} secret to a VM through metadata](../../operations/vm-create/create-with-lockbox-secret.md)
* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./accessing-metadata.md)
* [{#T}](./identity-document.md)