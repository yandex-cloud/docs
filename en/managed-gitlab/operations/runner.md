# Working with a managed runner

{% include [gl-runners-preview](../../_includes/managed-gitlab/gl-runners-preview.md) %}

{% include [gl-runners-intro](../../_includes/managed-gitlab/gl-runners-intro.md) %}

{% include [note-payment](../../_includes/managed-gitlab/note-payment.md) %}

## Getting a GitLab Runner token {#gitlab-token}

You can get a token when creating a {{ GLR }} in {{ GL }}. You specify this token when [creating a runner](#create) in your {{ mgl-name }} instance and use it to authenticate the runner in {{ GL }}.

{% include [get-token](../../_includes/managed-gitlab/get-token.md) %}

## Creating a runner {#create}

{% include [runner-create](../../_includes/managed-gitlab/runner-create-console.md) %}

## Updating a runner {#update}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the {{ mgl-name }} instance containing the runner you want to update.
  1. Select the **{{ ui-key.yacloud.gitlab.title_runners }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the runner and select **{{ ui-key.yacloud.common.edit }}**.
  1. Enter a new name and description for the runner.
  1. Select or create a [service account](../../iam/concepts/users/service-accounts.md) for the runner.

      {% include [sa-runner-info](../../_includes/managed-gitlab/sa-runner-info.md) %}

  1. Add [labels](../../resource-manager/concepts/labels.md) to break runners into logical groups.
  1. Change the scaling settings:

      {% include [runner-workers](../../_includes/managed-gitlab/runner-workers.md) %}

  1. Add labels for the worker.
  1. Select a new configuration of the worker computing resources.
  1. Change the [type](../../compute/concepts/disk.md#disks_types) and size of the boot disk.
  1. Select or create a service account for the worker.

      {% include [sa-worker-info](../../_includes/managed-gitlab/sa-worker-info.md) %}

  1. Select the [security group](../../vpc/concepts/security-groups.md).
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting a runner {#delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the {{ mgl-name }} instance to delete the runner from.
  1. Select the **{{ ui-key.yacloud.gitlab.title_runners }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}** next to the runner you want to delete.
  1. In the window that opens, click **{{ ui-key.yacloud.gitlab.runners_popup-confirm_button_delete }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](../concepts/index.md#managed-runners)
* [{#T}](../tutorials/install-gitlab-runner.md)