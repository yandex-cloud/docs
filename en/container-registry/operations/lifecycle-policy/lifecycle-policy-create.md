# Creating a lifecycle policy

To create a lifecycle policy, specify the [repository name](../repository/repository-list.md#repository-get).

{% list tabs %}

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
     * `name`: Policy name (optional).

       {% include [name-format](../../../_includes/name-format.md) %}

     {% note info %}

     The default policy is created with the `DISABLED` status. We do not recommend creating an active policy with the `--active` flag right away.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy create \
       --repository-name crp3cpm16edqql0t30s2/ubuntu \
       --name test-policy \
       --description "disabled lifecycle-policy for tests" \
       --rules ./rules.json
     ```

     Command output:

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

     Where `repository-name` is the repository name.

     Result:

     ```bash
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
     |                      |             |                      |          |                     | tests                          |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     ```

     {% note tip %}

     You can [test the lifecycle policy](lifecycle-policy-dry-run.md) to check what [Docker images](../../concepts/docker-image.md) comply with the policy rules. Docker images are not actually deleted during dry runs.

     {% endnote %}

- API

  To create a lifecycle policy, use the [Create](../../api-ref/grpc/lifecycle_policy_service.md#Create) method for the [LifecyclePolicyService](../../api-ref/grpc/lifecycle_policy_service.md) resource.

{% endlist %}