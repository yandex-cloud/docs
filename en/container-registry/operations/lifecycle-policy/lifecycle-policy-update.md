# Updating a lifecycle policy

After you create a [lifecycle policy](../../concepts/lifecycle-policy.md), you can edit its rules as well as its status, name, or description.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with the [registry](../../concepts/registry.md).
  1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the [repository](../../concepts/repository.md) and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. In the lifecycle policy row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the lifecycle policy settings:
     * **{{ ui-key.yacloud.common.name }}**.
     * **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yacloud.common.label_status }}**.
     * Under **{{ ui-key.yacloud.cr.registry.label_lifecycle-rules }}**, update the rule settings:

       {% include [lifecycle-rules-console](../../../_includes/container-registry/lifecycle-rules-console.md) %}

       * **{{ ui-key.yacloud.common.description }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. See the description of the [CLI](../../../cli/) command for updating policy settings:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Update the policy settings, e.g., rename the policy:

     ```bash
     yc container repository lifecycle-policy update <policy_ID> \
        --new-name=new-policy
     ```

     To find out the policy ID, get a [list of lifecycle policies in the repository or registry](lifecycle-policy-list.md#lifecycle-policy-list).

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the configuration file and edit the section describing the policy:

     ```hcl
     resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
       name          = "best-policy"
       status        = "active"
       repository_id = "crpfvi6o4ra7********"

       rule {
         description   = "rule for applying policy"
         untagged      = true
         tag_regexp    = ".*"
         retained_top  = 1
         expire_period = "48h"
       }
     }
     ```

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  This will update the lifecycle policy in the specified [repository](../../concepts/repository.md). You can check the policy update using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/) command:

  ```bash
  yc container repository lifecycle-policy list --registry-id <registry_ID>
  ```

- API {#api}

  To update a lifecycle policy, use the [Update](../../api-ref/grpc/LifecyclePolicy/update.md) method for the [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md) resource. Specify the policy ID in the `lifecycle_policy_id` property.

  You can get the list of policies using the [List](../../api-ref/grpc/LifecyclePolicy/list.md) method for the [LifecyclePolicyService](../../api-ref/grpc/LifecyclePolicy/index.md) resource.

{% endlist %}

## Examples {#examples}

### Updating lifecycle policy rules {#update-rules}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Create new [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `new-rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Update the current policy rules by running the command with the following parameter:
     * `new-rules`: Path to the file with the new policy description.

     {% note alert %}

     When you update the policy, all current rules are overwritten and deleted.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3******** --new-rules ./new-rules.json
     ```

     Result:

     ```text
     WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
     id: crp6lg1868p3********
     name: test-policy
     ...
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

{% endlist %}

### Updating a lifecycle policy status {#update-status}

#### Activating a lifecycle policy {#activate}

{% list tabs group=instructions %}

- CLI {#cli}

  To activate a disabled policy, run the command below with the `--activate` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --activate
  ```

  Result:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Disabling a lifecycle policy {#disabled}

{% list tabs group=instructions %}

- CLI {#cli}

  To disable an active policy, run the command below with the `--disable` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --disable
  ```

  Result:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy name {#update-name}

{% list tabs group=instructions %}

- CLI {#cli}

  Update the policy name by running this command:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-name new-policy
  ```

  Where `--new-name` is the new policy name. The naming requirements are as follows:

  {% include [name-format](../../../_includes/name-format.md) %}

  Result:

  ```text
  id: crp6lg1868p3********
  name: new-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy description {#update-description}

{% list tabs group=instructions %}

- CLI {#cli}

  Update the policy description by running this command:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3******** --new-description "new description"
  ```

  Where `--new-description` is the new policy description.

  Result:

  ```text
  id: crp6lg1868p3********
  name: test-policy
  repository_id: crp3cpm16edq********
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}