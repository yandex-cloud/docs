### When creating a registry in Yandex Container Registry, keep the safe registry settings by default {#secure-registry}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | appsec.secure-registry ||
|#

#### Description

Without automatic vulnerability scanning, every new Docker image pushed to the registry is added to the inventory unchecked: vulnerable base layers and components, accidentally introduced malicious code, and outdated dependencies all reach the cluster as if nothing happened.

Container Registry can scan images automatically at push and surface the results in the [scan report](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scan-results) — this is the fastest way to learn about a problem before the image is deployed.

**Risks if the rule is not followed:** Without automatic scanning on push, vulnerable images, malicious code, and outdated dependencies can silently reach production clusters — where they may be exploited before anyone notices.

#### Instructions and solutions

Enable scanning on push for every registry:

1. In the [management console](https://console.yandex.cloud/) open the registry settings (Container Registry → registry → **Settings**).
2. Under **Automatic scanning**, enable **Scan Docker images on push**.
3. Review [scan results](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scan-results) for the latest images and address any vulnerabilities found before deploying them.

For new registries, this option is enabled by default — keep it that way.
