### ACL by IP address is set up for Yandex Container Registry {#acl-container-registry}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | access.acl-container-registry ||
|#

#### Description

A registry in [Yandex Container Registry](https://yandex.cloud/en/docs/container-registry/) is by default reachable from any IP address — anyone with valid credentials can pull or push images from anywhere on the internet.

[IP-based access control](https://yandex.cloud/en/docs/container-registry/operations/registry/registry-access) lets you restrict pull and push operations on a registry to a specific list of IP addresses or CIDR ranges. This adds a network-level boundary on top of IAM: even if a service account token leaks, an attacker outside the allowed IP ranges still cannot use it to pull images (and learn what runs in your infrastructure) or push backdoored images.

**Risks if the rule is not followed:** Without IP-based access control, a leaked service account token can be used from any location to pull images (exposing your infrastructure inventory) or push backdoored images into the registry, potentially compromising all workloads that use them.

#### Instructions and solutions

Restrict access to the registry to known IP ranges:

1. Determine which IPs need to pull and push images — typically the cluster's egress IPs (NAT gateway), CI/CD runner pools, and a small set of administrator addresses.
2. [Set IP permissions on the registry](https://yandex.cloud/en/docs/container-registry/operations/registry/registry-access) for the `PULL` and `PUSH` actions, listing only those ranges.
3. After saving, verify from an unrelated IP that pull and push are blocked, and from an allowed IP that they still work.

See the [Container Registry documentation](https://yandex.cloud/en/docs/container-registry/concepts/) for details.
