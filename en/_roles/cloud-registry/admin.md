
The `cloud-registry.admin` role enables managing artifacts, registries, and access to registries, as well as viewing info on the {{ cloud-registry-name }} quotas.

Users with this role can:
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for [registries](../../cloud-registry/concepts/registry.md), folders within registries, and [artifacts](../../cloud-registry/concepts/artifacts/index.md), as well as modify such permissions.
* View and modify registry access policies.
* View info on registries, as well as create, modify, and delete registries, along with all data inside them.
* View info on artifacts, as well as create, modify, download, and delete them.
* Create and delete folders within registries.
* Delete the revision history for [Docker images](../../cloud-registry/concepts/artifacts/docker.md) within registries.
* Scan registry artifacts for vulnerabilities.
* View and edit vulnerability scanning settings for artifacts.
* View vulnerability scanning results.
* View info on registry [lifecycle policies](../../cloud-registry/concepts/lifecycle-policy.md) as well as create, modify, or delete such policies and test them in `dry run` mode.
* View info on the {{ cloud-registry-name }} quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `cloud-registry.editor` permissions.