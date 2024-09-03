The `container-registry.images.scanner` role enables scanning Docker images for vulnerabilities, as well as viewing info on registries, Docker images, repositories, the relevant cloud and folder, and the Container Registry quotas.

Users with this role can:
* View the list of [Docker images](../../../container-registry/concepts/docker-image.md) in the registry and info on them, as well as download Docker images from the registry.
* [Start](../../../container-registry/operations/scanning-docker-image.md#manual) and cancel Docker image vulnerability scans, as well as view scan history and the info on scan results.
* View the list of [registries](../../../container-registry/concepts/registry.md), info on them and the [access permissions](../../../iam/concepts/access-control/index.md) granted for them, as well as on the [access policy settings](../../../container-registry/operations/registry/registry-access.md) for IP addresses and the [vulnerability scanner](../../../container-registry/concepts/vulnerability-scanner.md) settings.
* View info on [repositories](../../../container-registry/concepts/repository.md) and the access permissions granted for them.
* View the list of the Docker image auto-delete [policies](../../../container-registry/concepts/lifecycle-policy.md) and info on them.
* View the list of the [testing](../../../container-registry/operations/lifecycle-policy/lifecycle-policy-dry-run.md) results for Docker image auto-delete policies and info on such results.
* View info on the Container Registry [quotas](../../../container-registry/concepts/limits.md#container-registry-quotas).
* View info on the relevant [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `container-registry.viewer` permissions.