{% list tabs group=instructions %}

- Management console {#console}

  1. Select the {{ mgl-name }} instance you need to create a runner for.
  1. Select the **{{ ui-key.yacloud.gitlab.title_runners }}** tab.
  1. Click **{{ ui-key.yacloud.gitlab.button_runners_empty-create }}**.
  1. Enter a name for the runner:
      * The name must be 2 to 63 characters long.
      * It can only contain lowercase Latin letters, numbers, and hyphens.
      * It must start with a letter and cannot end with a hyphen.
  1. Optionally, enter a random decription for the runner.
  1. Enter the [previously obtained](#gitlab-token) {{ GLR }} token.
  1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) for the runner.

      {% include [sa-runner-info](sa-runner-info.md) %}

  1. Optionally, add [labels](../../resource-manager/concepts/labels.md) to break runners into logical groups.
  1. Under **{{ ui-key.yacloud.gitlab.label_autoscale-section }}**, specify:

      {% include [runner-workers](../../_includes/managed-gitlab/runner-workers.md) %}

  1. Optionally, add labels for the worker.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, select a computing resource configuration.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure the boot disk:
      * Select the [disk type](../../compute/concepts/disk.md#disks_types).
      * Specify the disk size.
  1. Optionally, select or create a service account for the worker.

      {% include [sa-worker-info](sa-worker-info.md) %}

  1. Optionally, select a [security group](../../vpc/concepts/security-groups.md).
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}