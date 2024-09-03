The `container-registry.editor` role enables managing registries, Docker images, repositories, and their settings.

Users with this role can:
* View the list of [registries](../../container-registry/concepts/registry.md) and info on them, as well as create, modify, and delete them.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for registries, as well as on the [access policy settings](../../container-registry/operations/registry/registry-access.md) for IP addresses.
* View info on the [vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md) settings, as well as create, modify, and delete scan rules.
* View the list of [Docker images](../../container-registry/concepts/docker-image.md) in the registry and info on them, as well as create, download, modify, and delete them.
* [Start](../../container-registry/operations/scanning-docker-image.md#manual) and cancel Docker image vulnerability scans, as well as view scan history and the info on scan results.
* View info on [repositories](../../container-registry/concepts/repository.md) and the access permissions granted for them, as well as create and delete repositories.
* View the list of the Docker image auto-delete [policies](../../container-registry/concepts/lifecycle-policy.md) and info on them, as well as create, modify, and delete such policies.
* [Test](../../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) the Docker image auto-delete policies, view the list of testing results and the info on such results.
* View info on the Container Registry [quotas](../../container-registry/concepts/limits.md#container-registry-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `container-registry.viewer` permissions.