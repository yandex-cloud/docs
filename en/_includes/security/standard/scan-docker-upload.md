[Auto scans](../../../container-registry/operations/scanning-docker-image.md#automatically) of Docker images on push are critical for early detection and elimination of vulnerabilities to ensure secure deployment of containers. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select the appropriate registry in **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Navigate to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure Docker image scans on push are enabled.

{% endlist %}

**Guides and solutions to use:**

[Guide on scanning Docker images on push](../../../container-registry/operations/scanning-docker-image.md#automatically).