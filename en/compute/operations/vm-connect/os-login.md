# Connecting to a VM through OS Login

{% include notitle [preview](../../../_includes/note-preview-by-request.md) %}

[OS Login](../../../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To grant access to a VM that supports OS Login at the OS level, [assign](../../../iam/operations/roles/grant.md) a user the `compute.osLogin` or `compute.osAdminLogin` role.

{% note info %}

You cannot use an [SSH key pair](./ssh.md#creating-ssh-keys) to connect to a VM with access via OS Login enabled. However, it is recommended to always specify SSH keys when creating a VM: this way, you can [connect to a VM via SSH](./ssh.md#vm-connect) if you disable OS Login access for it.

{% endnote %}

1. Enable [access via OS Login](../../../organization/operations/os-login-access.md) at the organization level.
1. Set up OS Login on your VM:

   {% list tabs %}

   - Using an image with OS Login

      [Create a VM from the prepared image](../../../compute/operations/images-with-pre-installed-software/create.md) with access via OS Login. These images are available on [{{ marketplace-full-name }}](/marketplace) and contain `OS Login` in their names. When creating a VM, enable **Access via OS Login** or set the [enable-oslogin](../../concepts/vm-metadata.md) parameter to `true` in the `metadata`.

   - Installing OS Login on your image

      You can install the OS Login agent yourself in case the image from [{{ marketplace-name }}](/marketplace) with the pre-installed OS Login agent is not fit for you, e.g., if:

      * You are using a custom image that is not based on any images from {{ marketplace-name }}.
      * A VM is already deployed and you need to install the OS Login agent on it.

      To install the OS Login agent:

      1. [Download](https://storage.yandexcloud.net/mk8s/binaries/google_guest_agent-20230601.00.linux-amd64.tar.gz) the latest version of an executable file or build one from the [source code on Github](https://github.com/yandex-cloud/yandex-cloud-guest-agent).

         {% note info %}

         When downloading the file, check its hash: `33f526d1b52e24b38b2e2836a67ea32f0ecdd23e90aeb2a7bee12bd52637716a`.

         {% endnote %}

      1. Run the executable file and make sure the components are installed correctly.
      1. [Create a VM from a custom image](../../../compute/operations/vm-create/create-from-user-image.md). When creating a VM, enable **Access via OS Login** or set the [enable-oslogin](../../concepts/vm-metadata.md) parameter to `true` in the `metadata`.

      If you have any issues, [contact support]({{ link-console-support }}).

   {% endlist %}

1. Connect to the VM:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to connect to a VM:

         ```bash
         yc compute ssh --help
         ```

      1. Get a list of all VMs in the default folder:

         ```bash
         yc compute instance list
         ```

         Result:

         ```text
         +----------------------+-----------------+---------------+---------+----------------------+
         |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
         +----------------------+-----------------+---------------+---------+----------------------+
         | fhm0b28lgf********** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
         | fhm9gk85nj********** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
         +----------------------+-----------------+---------------+---------+----------------------+
         ```

      1. Connect to the VM:

         ```bash
         yc compute ssh --name <VM_name>
         ```

   {% endlist %}
