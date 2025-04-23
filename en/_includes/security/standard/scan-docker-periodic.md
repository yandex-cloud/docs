Scheduled scanning of Docker images is an automated process that checks containerized images for vulnerabilities and compliance with security standards. Such scans are regular and automatic to ensure the consistency of image checks for vulnerabilities and maintain a high security level in the long run. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

We recommend setting up a schedule for scans to be run at least once a week.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select the appropriate registry in **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Navigate to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure that scheduled Docker image scans are enabled with a frequency of at least once a week.

{% endlist %}

**Guides and solutions to use:**

[Guide on scheduled scanning of Docker images](../../../container-registry/operations/scanning-docker-image.md#scheduled).