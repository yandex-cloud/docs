---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Testing a lifecycle policy

A dry run lets you check which Docker images meet the policy rules. Docker images are not actually deleted during dry runs.

For a dry run of a [policy](../../concepts/lifecycle-policy.md), you need its ID. For information about how to get the policy ID, see [{#T}](lifecycle-policy-list.md).

{% note warning %}

The maximum number of [Docker images](../../concepts/docker-image.md) per [repository](../../concepts/repository.md) that a dry run can check is 50,000. In this case, an active policy with the same rules deletes all Docker images that are suitable for deletion.

{% endnote %}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    To test a lifecycle policy:

    1. Perform a dry run of the policy:

        ```
        $ yc container repository lifecycle-policy dry-run crp6lg1868p3i0emkv1b
        
        dry_run_lifecycle_policy_result_id: crpn27glo1k8r81dveq2
        lifecycle_policy_id: crp6lg1868p3i0emkv1b
        run_at: "2020-05-29T07:30:02.704Z"
        affected_images_count: "1"
        ```

    1. Get a list of policy dry runs:

        ```
        $ yc container repository lifecycle-policy list-dry-run-results crp6lg1868p3i0emkv1b
        
        +----------------------+----------------------+-----------------------+---------------------+
        |      RESULT ID       | LIFECYCLE POLICY ID  | AFFECTED IMAGES COUNT |       RUN AT        |
        +----------------------+----------------------+-----------------------+---------------------+
        | crpn27glo1k8r81dveq2 | crp6lg1868p3i0emkv1b |                     1 | 2020-05-29 07:30:02 |
        +----------------------+----------------------+-----------------------+---------------------+
        ```

    1. Get information about the results of [policy](../../concepts/lifecycle-policy.md) dry runs. Use the `RESULT ID` parameter from the previous item:

        ```
        $ yc container repository lifecycle-policy get-dry-run-result crpn27glo1k8r81dveq2
        
        dry_run_lifecycle_policy_result_id: crpn27glo1k8r81dveq2
        lifecycle_policy_id: crp6lg1868p3i0emkv1b
        run_at: "2020-05-29T07:30:02.704Z"
        affected_images_count: "1"
        ```

    1. Get a list of Docker images to be deleted according to the policy rules. Use the `dry_run_lifecycle_policy_result_id` parameter from the previous item:

        ```
        $ yc container repository lifecycle-policy list-dry-run-affected-images crpn27glo1k8r81dveq2
        
        +----------------------+---------------------+-----------------------------+-------+-----------------+
        |          ID          |       CREATED       |            NAME             | TAGS  | COMPRESSED SIZE |
        +----------------------+---------------------+-----------------------------+-------+-----------------+
        | crphc7nnrvhlg73oeiv5 | 2019-01-17 17:00:48 | crp2hlbs67tj4ggrfodb/ubuntu |  111  | 64.1 MB         |
        +----------------------+---------------------+-----------------------------+-------+-----------------+
        ```

{% endlist %}

