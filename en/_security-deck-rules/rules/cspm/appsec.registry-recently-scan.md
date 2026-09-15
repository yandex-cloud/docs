### Container images used in the production environment have the last scan date of one week ago or less {#registry-recently-scan}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | appsec.registry-recently-scan ||
|#

#### Description

Vulnerability databases (CVE) are updated continuously: a base image that scanned clean a month ago may have several known vulnerabilities today, simply because new ones were published.

Rescanning images regularly catches such cases — without it, you have no way to know that an image you are still running has become vulnerable. For most production registries, weekly scanning is the minimum; daily is better.

Yandex Container Registry can run scans automatically on a [schedule](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scheduled).

**Risks if the rule is not followed:** Without regular rescanning, production workloads may run images with known vulnerabilities that were published after the last scan — giving attackers a window to exploit them before they are detected.

#### Instructions and solutions

For each registry used in production:

1. Enable [scheduled scanning](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scheduled) of all Docker images in the registry, with a frequency of at least once a week.
2. After scanning, review the [scan results](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image#scan-results) and rebuild affected images with patched base layers.
3. Integrate scanning into the CI/CD pipeline so that new vulnerabilities are caught at build time as well.
