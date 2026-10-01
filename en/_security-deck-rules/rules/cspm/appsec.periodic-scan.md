### When creating a registry in Yandex Container Registry, keep the safe registry settings by default {#periodic-scan}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.periodic-scan ||
|#

#### Description

Yandex Container Registry can scan Docker images for vulnerabilities both when an image is pushed and on a schedule. By default, both options are enabled, and rescanning happens every 7 days, with the option to switch to daily.

Without scheduled rescans, an image that passed scanning on push can become vulnerable later — when a new CVE is discovered in one of its layers — and the cluster will keep running it. Default settings are calibrated to catch this; turning them off requires a deliberate reason.

**Risks if the rule is not followed:** Without scheduled rescanning, images that were clean at push time can silently become vulnerable as new CVEs are published, and the cluster will continue running them — leaving known vulnerabilities undetected and unpatched in production.

#### Instructions and solutions

Make sure that on every registry the following options are enabled (Container Registry → Registry → **Settings** → **Automatic scanning**):

* **Scan Docker images on push** — scans every image at upload.
* **Scan all Docker images in the registry** — periodically rescans existing images. The frequency should be at least weekly; switch to daily for production registries.

Read more in [Vulnerability scanner](https://yandex.cloud/en/docs/container-registry/concepts/vulnerability-scanner) and [Scanning Docker images](https://yandex.cloud/en/docs/container-registry/operations/scanning-docker-image) in the Container Registry documentation.
