{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the registry with Docker images.
  1. [Navigate]({{ link-console-main }}/link/container-registry) to **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry.
  1. Navigate to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure Docker image scans on push are enabled.

{% endlist %}

**Guides and solutions to use:**

[Guide on scanning Docker images on push](../../../container-registry/operations/scanning-docker-image.md#automatically).