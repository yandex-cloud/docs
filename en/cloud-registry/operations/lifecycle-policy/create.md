---
title: Creating a lifecycle policy in {{ cloud-registry-full-name }}
description: Follow this guide to create a lifecycle policy in {{ cloud-registry-name }}.
---

# Creating a lifecycle policy

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Prepare [lifecycle policy rules](../../concepts/lifecycle-policy.md#rule-types) and save them to a file named `rules.json`.

       Here is an example of a `rules.json` file containing a soft delete rule for Docker images with tags more than 30 days old, with a 10-day waiting period:

       ```json
       [
         {
           "path_prefix": "/ubuntu",
           "delete": {
             "type": "SOFT_DELETE",
             "cooldown_period_days": 10,
             "older_than_days": 30
           },
           "docker_filters": {
             "tag_status": "TAGGED"
           }
         }
       ]
       ```

    1. Create a lifecycle policy:

       ```bash
       yc cloud-registry registry lifecycle-policy create \
         --name <policy_name> \
         --description <policy_description> \
         --registry-id <registry_ID> \
         --state <policy_state> \
         --rules <path_to_rules.json>
       ```

       Where:
       * `--name`: Policy name.
       * `--description`: Policy description. This is an optional setting.
       * `--registry-id`: ID of the registry for which you are creating the policy. There are [quotas and limits](../../concepts/limits.md) on the number of lifecycle policies per registry.
       * `--state`: Policy state after creation: `DISABLED` or `ENABLED`.

         {% note info %}
        
          To avoid errors, we recommend creating a policy in `DISABLED` state and enabling it after checking the rules.
        
          {% endnote %}

       * `--rules`: Path to the policy rule file in JSON format.

       Result:

       ```text
       done (1s)
       id: e5oq6cd3fuue********
       name: my-lifecycle-policy
       description: My lifecycle policy
       rules:
         - path_prefix: /ubuntu
           delete:
             type: SOFT_DELETE
             cooldown_period_days: "10"
             older_than_days: "30"
           docker_filters:
             tag_status: TAGGED
       state: DISABLED
       registry_id: e5o6a2blpkb6********
       created_at: "2026-01-21T14:47:01.061840Z"
       modified_at: "2026-01-21T14:47:01.061840Z"
       created_by: bfb7vsfljr3j********
       modified_by: bfb7vsfljr3********
       ```

- API {#api}

    To create a lifecycle policy, use the [Create](../../api-ref/LifecyclePolicy/create.md) REST API method for the [LifecyclePolicy](../../api-ref/LifecyclePolicy/index.md) resource or the [LifecyclePolicyService/Create](../../api-ref/grpc/LifecyclePolicy/create.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../tutorials/lifecycle-policy-examples.md)
* [{#T}](../../concepts/lifecycle-policy.md)

