# Updating a lifecycle policy

Once you create a [lifecycle policy](../../concepts/lifecycle-policy.md), you can modify its rules as well as its status, name, or description.

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [registry](../../concepts/registry.md) was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/container-registry/lifecycle.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. In the row with the lifecycle policy you need, click ![image](../../../_assets/options.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the lifecycle policy parameters:
     * **{{ ui-key.yacloud.common.name }}**.
     * **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yacloud.common.label_status }}**.
     * Under **{{ ui-key.yacloud.cr.registry.label_lifecycle-rules }}**, update the rule parameters:

       {% include [lifecycle-rules-console](../../../_includes/container-registry/lifecycle-rules-console.md) %}

     * **{{ ui-key.yacloud.common.description }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. See the description of the CLI command for updating policy parameters:

     ```bash
     yc container repository lifecycle-policy update --help
     ```

  1. Change the policy parameters, such as by renaming it:

     ```bash
     yc container repository lifecycle-policy update <policy ID> \
       --new-name=new-policy
     ```

     To find out the policy ID, get a [list of lifecycle policies in a repository or registry](lifecycle-policy-list.md#lifecycle-policy-list).

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Open the configuration file and edit the fragment with the policy description:

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

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will update the lifecycle policy in the specified repository. You can check that the policy is updated using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
    yc container repository lifecycle-policy list --registry-id <registry_ID>
   ```

- API

  To edit a lifecycle policy, use the [Update](../../api-ref/grpc/lifecycle_policy_service.md#Update) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource. Specify the policy ID in the `lifecycle_policy_id` property.

  You can retrieve a list of policies using the [List](../../api-ref/grpc/lifecycle_policy_service.md#List) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}

## Examples {#examples}

### Updating lifecycle policy rules {#update-rules}

{% list tabs %}

- CLI

  1. Prepare new [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `new-rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Change the policy rules by running the command with the following parameter:
     * `new-rules`: Path to the file with the new policy description.

     {% note alert %}

     Updating the policy completely overwrites all current rules by destroying them.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-rules ./new-rules.json
     ```

     Result:

     ```bash
     WARN: All current lifecycle rules will be overwritten. Are you sure?[y/N] y
     id: crp6lg1868p3i0emkv1b
     name: test-policy
     ...
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

{% endlist %}

### Updating a lifecycle policy status {#update-status}

#### Activate a lifecycle policy {#activate}

{% list tabs %}

- CLI

  Activate a deactivated lifecycle policy by running the command below with the `--activate` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --activate
  ```

  Result:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

#### Disable a lifecycle policy {#disabled}

{% list tabs %}

- CLI

  Deactivate an active policy by running the command below with the `--disable` flag:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --disable
  ```

  Result:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy name {#update-name}

{% list tabs %}

- CLI

  Change the policy name by running the command:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-name new-policy
  ```

  Where `new-name` is the new policy name. The naming requirements are as follows:

  {% include [name-format](../../../_includes/name-format.md) %}

  Result:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: new-policy
  repository_id: crp3cpm16edqql0t30s2
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}

### Updating a lifecycle policy description {#update-description}

{% list tabs %}

- CLI

  Change the policy description by running the command:

  ```bash
  yc container repository lifecycle-policy update crp6lg1868p3i0emkv1b --new-description "new description"
  ```

  Where `new-description`: New policy description.

  Result:

  ```bash
  id: crp6lg1868p3i0emkv1b
  name: test-policy
  repository_id: crp3cpm16edqql0t30s2
  ...
    expire_period: 172800s
    tag_regexp: test.*
    untagged: true
  ```

{% endlist %}