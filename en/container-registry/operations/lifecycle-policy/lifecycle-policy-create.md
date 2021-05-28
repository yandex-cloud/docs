# Creating a lifecycle policy

To create a lifecycle policy, specify the [repository ID](../repository/repository-list.md#repository-get).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [lifecycle restrictions](../../../_includes/container-registry/lifecycle-restrictions.md) %}

  1. Set [policy rules](../../concepts/lifecycle-policy.md#lifecycle-rules) and save them to a file named `rules.json`.

     {% include [lifecycle-rules](../../../_includes/container-registry/lifecycle-rules.md) %}

  1. Create a lifecycle policy by running the command with the following parameters:
     * `repository-id`: ID of the repository.
     * `name`: Policy name (optional).

       {% include [name-format](../../../_includes/name-format.md) %}

     * `description`: Description of the lifecycle policy (optional).

     * `rules`: Path to the file with the policy description.

     {% note info %}

     The default policy is created with the `DISABLED` status. It is possible (but not recommended) to create an active policy directly by setting the `--active` flag, or [to enable a policy](../../operations/lifecycle-policy/lifecycle-policy-update.md#update-status) after it is created.

     {% endnote %}

     ```bash
     yc container repository lifecycle-policy create \
       --repository-id crp3cpm16edqql0t30s2 \
       --name test-policy \
       --description "disabled lifecycle-policy for tests" \
       --rules ./rules.json
     id: crp6lg1868p3i0emkv1b
     name: test-policy
     repository_id: crp3cpm16edqql0t30s2
     description: disabled lifecycle-policy for tests
     status: DISABLED
     created_at: "2020-05-28T15:05:58.143719Z"
     rules:
     - description: remove prod images older than 60 days except 20 last ones
       expire_period: 5184000s
       tag_regexp: prod
       retained_top: "20"
     - description: remove all test and untagged images older than 48 hours
       expire_period: 172800s
       tag_regexp: test.*
       untagged: true
     ```

     The `expired_period` parameter value in the response is displayed in seconds. This is a technical constraint, the format will be changed.

  1. Make sure that the policy is created by running the command with the following parameter:
     * `repository-id`: ID of the repository.

     ```bash
     yc container repository lifecycle-policy list --repository-id crp3cpm16edqql0t30s2
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     |          ID          |    NAME     |    REPOSITORY ID     |  STATUS  |       CREATED       |          DESCRIPTION           |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     | crp6lg1868p3i0emkv1b | test-policy | crp3cpm16edqql0t30s2 | DISABLED | 2020-05-28 15:05:58 | disabled lifecycle-policy for  |
     |                      |             |                      |          |                     | tests                          |
     +----------------------+-------------+----------------------+----------+---------------------+--------------------------------+
     ```

{% endlist %}