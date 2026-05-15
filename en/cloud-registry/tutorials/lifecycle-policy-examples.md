---
title: Configuring lifecycle policies in {{ cloud-registry-full-name }}
description: This tutorial provides examples of how to configure lifecycle policies to automate artifact management in a registry.
---

# Configuring lifecycle policies

[Lifecycle policies](../concepts/lifecycle-policy.md) automate the management of artifact storage and deletion in a registry. This tutorial provides examples of setting up policies for various use cases.

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Example 1: Policy for Ubuntu Docker images {#ubuntu-example}

In this example, we create a policy to manage Docker images with the `/ubuntu` path prefix. This policy contains three rules:

1. Hard delete all untagged Docker images older than 7 days.
1. Soft delete tagged Docker images exceeding a count of 10, with a 7-day waiting period.
1. Keep the 5 lastest versions of tagged images.

### Define the rules {#ubuntu-rules}

Create a file named `ubuntu-policy-rules.json` with the following contents:

```json
[
  {
    "path_prefix": "/ubuntu",
    "delete": {
      "type": "HARD_DELETE",
      "older_than_days": 7
    },
    "docker_filters": {
      "tag_status": "UNTAGGED"
    }
  },
  {
    "path_prefix": "/ubuntu",
    "delete": {
      "type": "SOFT_DELETE",
      "cooldown_period_days": 7,
      "version_condition": {
        "versions_count_greater_than": 10
      }
    },
    "docker_filters": {
      "tag_status": "TAGGED"
    }
  },
  {
    "path_prefix": "/ubuntu",
    "keep_by_version": {
      "keep_versions_count": 5
    },
    "docker_filters": {
      "tag_status": "TAGGED"
    }
  }
]
```

1. The first rule (`HARD_DELETE`) permanently deletes all untagged Docker images older than 7 days. This helps clean up the registry of intermediate images created during a build.

1. The second rule (`SOFT_DELETE`) marks tagged Docker images for deletion if the number of images exceeds 10. Docker images remain in the registry during the 7-day cooldown period before they are permanently deleted. This allows you to store the version history with a limited number of versions.

1. The third rule (`keep_by_version`) prevents the deletion of the 5 latest versions of tagged Docker images, even if they match the second rule conditions. This ensures availability of the latest production versions.

{% note info %}

Rules apply in the order of priority, where retention rules (`keep_by_version`) take precedence over deletion rules. This prevents the second rule from deleting the 5 most recent versions.

{% endnote %}

### Create a policy {#ubuntu-policy}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Create a lifecycle policy:

    ```bash
    yc cloud-registry registry lifecycle-policy create \
      --name ubuntu-lifecycle-policy \
      --description "Policy for managing Ubuntu Docker images" \
      --registry-id <registry_ID> \
      --state DISABLED \
      --rules ubuntu-policy-rules.json
    ```

    Where:

    `--name`: Policy name.
    `--description`: Policy description.
    `--registry-id`: ID of the registry you want to create the policy for.
    `--state`: Policy state after creation (`DISABLED`).
    `--rules`: `ubuntu-policy-rules.json` file path.

- API {#api}

    To create a lifecycle policy, use the [Create](../api-ref/LifecyclePolicy/create.md) REST API method for the [LifecyclePolicy](../api-ref/LifecyclePolicy/index.md) resource or the [LifecyclePolicyService/Create](../api-ref/grpc/LifecyclePolicy/create.md) gRPC API call.

{% endlist %}

## Example 2: Java artifact policy {#maven-example}

In this example, we create a policy to manage Java artifacts with the `/com/example/myapp` path prefix. This policy contains two rules:

1. Hard delete all snapshots.
1. Keep the 2 latest snapshots.

### Define the rules {#mavem-rules}

Create a file named `maven-policy-rules.json` with the following contents:

```json
[
  {
    "path_prefix": "/com/example/myapp",
    "delete": {
      "type": "HARD_DELETE",
      "always": true
    },
    "maven_filters": {
      "version_type": "SNAPSHOT"
    }
  },
  {
    "path_prefix": "/com/example/myapp",
    "keep_by_version": {
      "keep_versions_count": 2
    },
    "maven_filters": {
      "version_type": "SNAPSHOT"
    }
  }
]
```

1. The first rule (`HARD_DELETE`) deletes all snapshots of Java artifacts matching the path prefix. This automates the registry clean up of obsolete snapshots, mostly used for development and testing.

1. The second rule (`keep_by_version`) prevents deletion of the 2 most recent snapshots. This secures developer access to the most recently built snapshots even if they are deleted by the first rule.

{% note info %}

The `keep_by_version` rule has a higher priority than the deletion rule. This means the 2 most recent snapshots will be retained even though the first rule should delete all snapshots.

{% endnote %}

### Create a policy {#maven-policy}

{% list tabs group=instructions %}

- CLI {#cli}

    Create a lifecycle policy:

    ```bash
    yc cloud-registry registry lifecycle-policy create \
      --name maven-snapshot-policy \
      --description "Policy for managing snapshots of java artifacts" \
      --registry-id <registry_ID> \
      --state DISABLED \
      --rules maven-policy-rules.json
    ```

    Where:

    `--name`: Policy name.
    `--description`: Policy description.
    `--registry-id`: ID of the registry you want to create the policy for.
    `--state`: Policy state after creation (`DISABLED`).
    `--rules`: `maven-policy-rules.json` file path.

- API {#api}

    To create a lifecycle policy, use the [Create](../api-ref/LifecyclePolicy/create.md) REST API method for the [LifecyclePolicy](../api-ref/LifecyclePolicy/index.md) resource or the [LifecyclePolicyService/Create](../api-ref/grpc/LifecyclePolicy/create.md) gRPC API call.

{% endlist %}

## Recommendations {#recommendations}

* Create policies in `DISABLED` state to test the rules before applying them.
* Use `SOFT_DELETE` for key artifacts so you can restore them during the waiting period.
* Use the `KEEP` rules to explicitly protect artifacts from deletion: the `keep_by_version` and `keep_by_age` rules take precedence over deletion rules and ensure retention of artifacts.
* Use retention rules together with deletion rules to flexibly manage artifacts.

#### See also {#see-also}

* [{#T}](../operations/lifecycle-policy/create.md)
* [{#T}](../concepts/lifecycle-policy.md)
* [{#T}](../concepts/registry.md)
