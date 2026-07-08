---
title: Deleting an artifact from {{ cloud-registry-name }}
description: Follow this guide to delete an artifact from a registry in {{ cloud-registry-name }}.
---

# Deleting an artifact from a registry

You can delete the [artifact](../../concepts/artifacts/index.md) from a [registry](../../concepts/registry.md) in {{ cloud-registry-name }}.

To delete an atrifact, you need the `cloud-registry.admin` [role](../../security/index.md) or higher.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Select the registry you want to delete the artifact from.
    1. In the left-hand panel, select ![cube](../../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.cloud-registry.title_registry-artifacts }}**.
    1. Click on the ![folder](../../../_assets/console-icons/folder-open.svg) artifact name.
    1. Find the artifact version in the list.
    1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the artifact and select **{{ ui-key.yacloud.common.delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Get a list of artifacts in the registry:

        ```bash
        yc cloud-registry registry list-artifacts --id <registry_ID>
        ```

        Result:

        ```text
        +----------------------+-------------+--------+------+---------------------+
        |          ID          |    NAME     |  KIND  | PATH |     MODIFIED AT     |
        +----------------------+-------------+--------+------+---------------------+
        | cn172c0ldnh2******** | my-package1 | FOLDER |      | 2026-04-13 14:53:52 |
        | cn1j1rh7k416******** | my-package2 | FOLDER |      | 2026-04-13 14:53:53 |
        | cn1n0ufa7mcq******** | my-package3 | FOLDER |      | 2026-04-13 14:53:54 |
        +----------------------+-------------+--------+------+---------------------+
        ```

    1. Delete the artifact:

        ```bash
        yc cloud-registry artifact delete --id <artifact_ID>
        ```

        Result:

        ```text
        done (1s)
        ```

    1. Make sure the artifact has been deleted:

        ```bash
        yc cloud-registry artifact get --id <artifact_ID>
        ```   

- API {#api}

    To delete an artifact, use the [delete](../../api-ref/Artifact/delete.md) REST API method for the [Artifact](../../api-ref/Artifact/index.md) resource or the [ArtifactService/Delete](../../api-ref/grpc/Artifact/delete.md) gRPC API call.

{% endlist %}

## Automatic deletion of old versions {#lifecycle-policy}

To automatically delete old artifact versions, use [lifecycle policies](../../concepts/lifecycle-policy.md). For more information, see [{#T}](../../tutorials/lifecycle-policy-examples.md).

Policy example:

```json
[
  {
    "path_prefix": ".*",
    "delete": {
      "type": "SOFT_DELETE",
      "cooldown_period_days": 10,
      "version_condition": {
        "versions_count_greater_than": 5
      }
    }
  }
]
```
