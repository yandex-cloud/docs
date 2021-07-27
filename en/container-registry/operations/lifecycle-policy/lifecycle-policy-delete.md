---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Deleting a lifecycle policy

To access a [policy](../../concepts/lifecycle-policy.md), use its ID. For information about how to get the policy ID, see [{#T}](lifecycle-policy-list.md).

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Delete the policy by specifying its ID:

      ```
      $ yc container repository lifecycle-policy delete crp6lg1868p3i0emkv1b
      ```

  1. Make sure that the policy was deleted:

      ```
      $ yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
      
      +----+------+---------------+--------+---------+-------------+
      | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
      +----+------+---------------+--------+---------+-------------+
      +----+------+---------------+--------+---------+-------------+
      ```

{% endlist %}

