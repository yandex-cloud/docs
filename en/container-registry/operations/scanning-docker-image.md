---
title: "How to scan Docker images for vulnerabilities in {{ container-registry-full-name }}"
description: "This guide describes how you can scan a Docker image for vulnerabilities."
---

# Scanning Docker images for vulnerabilities

You can [scan](../concepts/vulnerability-scanner.md) [Docker images](../concepts/docker-image.md) uploaded to a [registry](../concepts/registry.md) for vulnerabilities. You can do this:
* [{#T}](#manual).
* [{#T}](#automatically).
* [{#T}](#scheduled).

{% note warning %}

* The vulnerability database is constantly updated with sources containing information on vulnerabilities.
* For some vulnerabilities, there is no information regarding which package versions they will be fixed in. This is because such information is unavailable from current sources.
* The number of Docker image scans you can run per [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) is [limited](../concepts/limits.md#container-registry-quotas).

{% endnote %}

## Manually {#manual}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the parent [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for the [registry](../concepts/registry.md) containing the Docker image.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Select the registry containing the Docker image or [create](registry/registry-create.md) a new one and [upload](docker-image/docker-image-push.md) an image to it.
   1. Open the [repository](../concepts/repository.md) with the Docker image.
   1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the Docker image and select **{{ ui-key.yacloud.cr.image.label_start-scan }}**.
   1. Wait for the scan to complete. During the scan, the Docker image scan status will be `{{ ui-key.yacloud.cr.image.label_scan-status-RUNNING }}` and, once completed, it will change to `{{ ui-key.yacloud.cr.image.label_scan-status-READY }}`.
   1. Review the scan results. To do this, in the row of the relevant Docker image, click the value in the **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** column.

   To view Docker image scans, select the relevant image and go to the **{{ ui-key.yacloud.cr.image.label_scan-history }}** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [cli-install](../../_includes/default-catalogue.md) %}

   1. Get a list of the Docker images in a registry:

      ```bash
      yc container image list --repository-name=<registry ID>/<Docker image name>
      ```

      Result:

      ```text
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      |          ID          |       CREATED       |            NAME             |  TAGS   | COMPRESSED SIZE |
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      | crpqmsqp5mtbh627i7qs | 2021-02-09 08:57:14 | crpp7p7dovf46626a7k4/ubuntu | example | 27.2 MB         |
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      ```

   1. Start a Docker image scan:

      ```bash
      yc container image scan <Docker image ID>
      ```

      Result:

      ```text
      done (24s)
      id: che1el9t4t95elduhuq5
      image_id: crpqmsqp5mtbh627i7qs
      ...
        medium: "6"
        low: "13"
        negligible: "3"
      ```

   1. Get detailed information on the scan results:

      ```bash
      yc container image list-vulnerabilities --scan-result-id=<scan result ID>
      ```

      Result:

      ```text
      +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
      |  SEVERITY  |      NAME      | PACKAGE |     VERSION     | FIXED BY |                             LINK                              |
      +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
      ...
      | NEGLIGIBLE | CVE-2016-10228 | glibc   | 2.31-0ubuntu9.1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10228 |
      | NEGLIGIBLE | CVE-2017-11164 | pcre3   | 2:8.39-12build1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-11164 |
      | NEGLIGIBLE | CVE-2020-14155 | pcre3   | 2:8.39-12build1 |          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155 |
      +------------+----------------+---------+-----------------+----------+---------------------------------------------------------------+
      ```

      To view scans by Docker image, run the command:

      ```bash
      yc container image list-scan-results --repository-name=<Registry ID>/<Docker image name>
      ```

      Result:

      ```text
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      | che1el9t4t95elduhuq5 | crpqmsqp5mtbh627i7qs | 2021-03-16 14:34:02 | READY  | medium:6, low:13, negligible:3 |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      ```

- API

   To scan a Docker image, use the [scan](../api-ref/Scanner/scan.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/Scan](../api-ref/grpc/scanner_service.md#Scan) gRPC API call.

   To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilities](../api-ref/grpc/scanner_service.md#ListVulnerabilities) gRPC API call.

{% endlist %}

## On push {#automatically}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder that the registry with Docker images belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Choose a registry or [create](registry/registry-create.md) a new one.
   1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
   1. Click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
   1. Under **{{ ui-key.yacloud.cr.registry.title_scan-on-push }}**, select **{{ ui-key.yacloud.cr.image.label_start-scan }}** and one of the scanning options:
      * `{{ ui-key.yacloud.cr.registry.label_all-repositories }}` to scan all registry repositories.
      * `{{ ui-key.yacloud.cr.registry.label_selected }}` to scan only selected repositories:
         1. Click **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
         1. Select the appropriate repositories from the list.
         1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- API

   To automatically scan Docker images on push to a registry, use the [create](../api-ref/ScanPolicy/create.md) REST API method for the [ScanPolicy](../api-ref/ScanPolicy/) resource or the [ScanPolicyService/Create](../api-ref/grpc/scan_policy_service.md#Create) gRPC API call.

   To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/scanner_service.md#ListVulnerabilities) gRPC API call.

{% endlist %}

## On schedule {#scheduled}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder that the registry with Docker images belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
   1. Choose a registry or [create](registry/registry-create.md) a new one.
   1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
   1. Click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
   1. Under **{{ ui-key.yacloud.cr.registry.title_scheduled-scan }}**, click **{{ ui-key.yacloud.cr.registry.label_add-scan-rule }}**.
   1. Select **{{ ui-key.yacloud.cr.image.label_start-scan }}** and one of the scanning options:
      * `{{ ui-key.yacloud.cr.registry.label_all-repositories }}` to scan all registry repositories.
      * `{{ ui-key.yacloud.cr.registry.label_selected }}` to scan only selected repositories:
         1. Click **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
         1. Select the appropriate repositories from the list.
         1. Click **{{ ui-key.yacloud.common.save }}**.
   1. Specify the frequency of Docker image scans.
   1. Click **{{ ui-key.yacloud.common.save }}**.

- API

   To run scheduled Docker image scans, use the [create](../api-ref/ScanPolicy/create.md) REST API method for the [ScanPolicy](../api-ref/ScanPolicy/) resource or the [ScanPolicyService/Create](../api-ref/grpc/scan_policy_service.md#Create) gRPC API call.

   To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/scanner_service.md#ListVulnerabilities) gRPC API call.

{% endlist %}