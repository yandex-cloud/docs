---
title: Deleting a Python package from a {{ cloud-registry-name }} registry
description: Follow this guide to delete a Python package from a {{ cloud-registry-name }}  registry.
---

# Deleting a Python package from a registry

You can delete a [Python package](../../concepts/artifacts/python.md) from a {{ cloud-registry-name }} [registry](../../concepts/registry.md).

To delete a Python package, you need the `cloud-registry.admin` [role](../../security/index.md) or higher.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the registry is located.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Select the registry you want to delete the package from.
    1. In the left-hand panel, select ![cube](../../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.cloud-registry.title_registry-artifacts }}**.
    1. Click on the ![folder](../../../_assets/console-icons/folder-open.svg) artifact name.
    1. Find the package version in the list.
    1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the package and select **{{ ui-key.yacloud.common.delete }}**.
    1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    {% note info %}
    
    You can find the artifact ID through the [management console]({{ link-console-main }}) in **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
     
    {% endnote %}

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

    To delete a Python package, use the [delete](../../api-ref/Artifact/delete.md) REST API method for the [Artifact](../../api-ref/Artifact/index.md) resource or the [ArtifactService/Delete](../../api-ref/grpc/Artifact/delete.md) gRPC API call.

{% endlist %}

## Automatic deletion of old versions {#lifecycle-policy}

To automatically delete old package versions, use [lifecycle policies](../../concepts/lifecycle-policy.md). For more information, see [{#T}](../../tutorials/lifecycle-policy-examples.md).

Example of a policy for Python packages:

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

#### See also {#see-also}

* [{#T}](push.md)
* [{#T}](pull.md)
* [{#T}](../../tutorials/lifecycle-policy-examples.md)
* [{#T}](../../concepts/lifecycle-policy.md)
