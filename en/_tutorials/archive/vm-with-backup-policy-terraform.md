# Associating a {{ backup-full-name }} policy with a VM automatically using {{ TF }}

To create a virtual machine automatically associated with a {{ backup-name }} policy:

1. [Get your cloud ready](#before-begin).
1. [Activate {{ backup-name }}](#service-activate).
1. [Create your infrastructure](#deploy).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/vm-with-backup-policy/paid-resources.md) %}

## Activate {{ backup-name }} {#service-activate}

{% include [service-activate](../_tutorials_includes/vm-with-backup-policy/service-activate.md) %}

## Create your infrastructure {#deploy}

{% note info %}

Associating a {{ backup-full-name }} policy with a VM is available for [{{ TF }} provider]({{ tf-provider-link }}/) `0.127.0` and higher.

{% endnote %}

{% include [terraform-definition](../_tutorials_includes/terraform-definition.md) %}

To create an infrastructure using {{ TF }}:

1. [Install {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [get the credentials](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials), and specify the source for installing the {{ yandex-cloud }} provider (see [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), Step 1).
1. Set up your infrastructure description files:

    {% list tabs group=infrastructure_description %}

    - Ready-made configuration {#ready}

      1. Clone the repository with configuration files.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-baas-backup-policy-auto-binding
          ```

      1. Navigate to the repository directory. Make sure it contains the following files:

          * `backup-policy-auto-binding-config.tf`: New infrastructure configuration.
          * `cloud-init.yaml`: VM metadata file.

    - Manually {#manual}

      1. Create a folder for configuration files.
      1. In the folder, create:

          1. `backup-policy-auto-binding-config.tf` configuration file:

            {% cut "backup-policy-auto-binding-config.tf" %}

            {% include [backup-policy-auto-binding-config](../../_includes/backup/backup-policy-auto-binding-config.md) %}

            {% endcut %}

          1. `cloud-init.yaml` VM metadata file:

            {% cut "cloud-init.yaml" %}

            ```yaml
            #cloud-config
            datasource:
             Ec2:
              strict_id: false
            ssh_pwauth: no
            users:
            - name: <username>
              sudo: ALL=(ALL) NOPASSWD:ALL
              shell: /bin/bash
              ssh_authorized_keys:
              - <public_SSH_key>
            packages:
              - curl
              - perl
              - jq
            runcmd:
              - curl https://{{ s3-storage-host }}/backup-distributions/agent_installer.sh | sudo bash
            ```

            {% endcut %}

    {% endlist %}

    Learn more about the properties of {{ TF }} resources in the relevant Terraform guides:

    * [Service account](../../iam/concepts/users/service-accounts.md): [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
    * Assigning a [role](../../iam/concepts/access-control/roles.md) to a service account: [yandex_resourcemanager_folder_iam_member]({{ tf-provider-resources-link }}/resourcemanager_folder_iam_member).
    * [Network](../../vpc/concepts/network.md#network): [yandex_vpc_network]({{ tf-provider-resources-link }}/vpc_network).
    * [Subnet](../../vpc/concepts/network.md#subnet): [yandex_vpc_subnet]({{ tf-provider-resources-link }}/vpc_subnet).
    * [Security group](../../vpc/concepts/security-groups.md): [yandex_vpc_security_group]({{ tf-provider-resources-link }}/vpc_security_group).
    * [VM image](../../compute/concepts/image.md) data: [yandex_compute_image]({{ tf-provider-datasources-link }}/compute_image).
    * VM boot [disk](../../compute/concepts/disk.md): [yandex_compute_disk]({{ tf-provider-resources-link }}/compute_disk).
    * [VM instance](../../compute/concepts/vm.md): [yandex_compute_instance]({{ tf-provider-resources-link }}/compute_instance).
    * [Backup policy](../../backup/concepts/policy.md): [yandex_backup_policy]({{ tf-provider-resources-link }}/backup_policy). You can create a new policy or use one of those generated automatically upon service activation.
    * Associating a backup policy with a VM: [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings). To associate one of the backup policies created automatically upon service activation, [get](../../backup/operations/policy-vm/get-info.md) its ID.

1. In the `cloud-init.yaml` file, set the following user-defined properties:

    * `name`: VM username, e.g., `vm-user`.
    * `ssh_authorized_keys`: Contents of the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) file. You need to [create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair for the SSH connection on your own.

1. Create the resources:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}

{% include [installation-note](../_tutorials_includes/vm-with-backup-policy/installation-note.md) %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. Open the `backup-policy-auto-binding.tf` file and delete your infrastructure description from it.
1. Apply the changes:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}