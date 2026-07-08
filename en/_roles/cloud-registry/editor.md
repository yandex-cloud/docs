
The `cloud-registry.editor` role enables managing artifacts, registries, and lifecycle policies, as well as viewing info on the access permissions granted for registries and {{ cloud-registry-name }} quotas.

Users with this role can:
* View info on [registries](../../cloud-registry/concepts/registry.md), as well as create, modify, and delete them.
* View info on [artifacts](../../cloud-registry/concepts/artifacts/index.md), as well as create, modify, download, and delete them.
* Create and delete folders within registries.
* Scan registry artifacts for vulnerabilities.
* View and edit vulnerability scanning settings for artifacts.
* View vulnerability scanning results.
* View registry access policies.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for registries, folders within registries, and artifacts.
* View info on registry [lifecycle policies](../../cloud-registry/concepts/lifecycle-policy.md) as well as create, modify, or delete such policies and test them in `dry run` mode.
* View info on the {{ cloud-registry-name }} quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `cloud-registry.viewer`, `cloud-registry.artifacts.pusher`, and `cloud-registry.artifacts.scanner` permissions.