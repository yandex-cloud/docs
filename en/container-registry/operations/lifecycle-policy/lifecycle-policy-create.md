# Creating a lifecycle policy

You can only set a [lifecycle policy](../../concepts/lifecycle-policy.md) for a [repository](../../concepts/repository.md). To find out the name of a repository, request a [list of repositories in the registry](../repository/repository-list.md#repository-get).

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the [registry](../../concepts/registry.md) was created.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry and click the row with its name.
  1. Select the repository and click the row with its name.
  1. In the left-hand panel, click ![lifecycle](../../../_assets/container-registry/lifecycle.svg) **{{ ui-key.yacloud.cr.registry.label_lifecycle }}**.
  1. In the top-right corner, click **{{ ui-key.yacloud.common.create }}**.
  1. Set the lifecycle policy parameters:
     * (Optional) **{{ ui-key.yacloud.common.name }}**.
     * (Optional) **{{ ui-key.yacloud.common.description }}**.
     * **{{ ui-key.yacloud.common.label_status }}**: Lifecycle policy status after its creation. We do not recommend creating an `ACTIVE` policy right away.
     * Under **{{ ui-key.yacloud.cr.registry.label_lifecycle-rules }}**, add rules:
       1. Click **{{ ui-key.yacloud.common.add }}**.
       1. Set the rule parameters:

          {% include [lifecycle-rules-console](../../../_includes/container-registry/lifecycle-rules-console.md) %}

          * (Optional) **{{ ui-key.yacloud.common.description }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Prepare [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Create a lifecycle policy by running the command:

     ```bash
     yc container repository lifecycle-policy create \
       --repository-name crp3cpm16edqql0t30s2/ubuntu \
       --name test-policy \
       --description "disabled lifecycle-policy for tests" \
       --rules ./rules.json
     ```

     Where:
     * `repository-name`: Repository name.
     * `rules`: Path to the file with the policy description.
     * `description`: Description of the lifecycle policy (optional).
     * `name`: Policy name (optional). The naming requirements are as follows:

       {% include [name-format](../../../_includes/name-format.md) %}

     {% note info %}

     The default policy is created with the `DISABLED` status. We do not recommend creating an active policy with the `--active` flag right away.

     {% endnote %}

     Result:

     ```bash
     id: crp6lg1868p3i0emkv1b
     name: test-policy
     repository_id: crp3cpm16edqql0t30s2
     ...
     - description: delete all untagged Docker images older than 48 hours
       expire_period: 172800s
       untagged: true
     ```

     The `expired_period` parameter value in the response is displayed in seconds. This is a technical constraint, the format will be changed.
  1. Make sure that the policy is created by running the command:

     ```bash
     yc container repository lifecycle-policy list --repository-name crp3cpm16edqql0t30s2/ubuntu
     ```

     Where `repository-name`: Repository name.

     Result:

     ```bash
     +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
     |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION          |
     +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
     | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for |
     |                      |             |                      |          |                     | tests                         |
     +----------------------+-------------+----------------------+----------+---------------------+-------------------------------+
     ```

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy" {
        name          = "<policy_name>"
        status        = "<policy_status>"
        repository_id = "<repository_id>"

        rule {
          description   = "<rule_description>"
          untagged      = true
          tag_regexp    = ".*"
          retained_top  = 1
          expire_period = "48h"
        }
      }
      ```

      Where:

      * `name`: Policy name.
      * `status`: Policy status; the possible values are `active` and `disabled`.
      * `repository_id`: Repository ID.
      * `rule`: Section with the policy rule. It contains the following parameters:
         * `description`: Description of the rule.
         * `untagged`: If the parameter is set to `true`, the rule applies to any untagged Docker image.
         * `tag_regexp`: Docker image tag for filtering. Java regular expressions are supported. For example, the `test.*` regular expression retrieves all images with tags starting with `test`.
         * `retained_top`: Number of Docker images that are not deleted even if they meet the lifecycle policy rules.
         * `expire_period`: Time after which the lifecycle policy applies to the Docker image. This parameter is formatted as a number and a unit of measure, such as `s`, `m`, `h`, or `d` (seconds, minutes, hours, or days). `expire_period` must be a multiple of 24 hours.

      For more information about the `yandex_container_repository_lifecycle_policy` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/container_repository_lifecycle_policy).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

   This will create a lifecycle policy in the specified repository. You can check the new policy and its configuration using the [management console]({{ link-console-main }}) or this [CLI](../../../cli/quickstart.md) command:

   ```bash
    yc container repository lifecycle-policy list --registry-id <registry_ID>
   ```

- API

  To create a lifecycle policy, use the [Create](../../api-ref/grpc/lifecycle_policy_service.md#Create) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}

{% note tip %}

You can [test the lifecycle policy](lifecycle-policy-dry-run.md) to check what [Docker images](../../concepts/docker-image.md) comply with the policy rules. Docker images are not actually deleted during dry runs.

{% endnote %}