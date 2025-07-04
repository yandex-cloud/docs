---
title: How to scan a Docker image for vulnerabilities in {{ container-registry-full-name }}
description: Follow this guide to scan a Docker image for vulnerabilities.
---

# Scanning Docker images for vulnerabilities


You can [scan](../concepts/vulnerability-scanner.md) [Docker images](../concepts/registry.md) pushed to a [registry](../concepts/docker-image.md) for vulnerabilities. You can do this:
* [Manually](#manual).
* [On push](#automatically).
* [On schedule](#scheduled).

{% note warning %}

* The vulnerability database is constantly updated with sources containing information on vulnerabilities.
* For some vulnerabilities, there is no information regarding which package versions they will be fixed in. This is because such information is unavailable from current sources.
* The number of Docker image scans you can run per [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) is [limited](../concepts/limits.md#container-registry-quotas).
* Scanning Docker images for vulnerabilities is [charged](../pricing.md#scanner).

{% endnote %}

## Manually {#manual}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the parent [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) for the [registry](../concepts/registry.md) containing the Docker image.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Select the registry containing the Docker image or [create](registry/registry-create.md) a new one and [push](docker-image/docker-image-push.md) an image to it.
  1. Open the [repository](../concepts/repository.md) with the Docker image.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the Docker image and select **{{ ui-key.yacloud.cr.image.label_start-scan }}**.
  1. Wait for the scan to complete. During the scan, the Docker image scan status will be `{{ ui-key.yacloud.cr.registry.label_scan-status-RUNNING }}` and, once completed, it will change to `{{ ui-key.yacloud.cr.registry.label_scan-status-READY }}`.
  1. Review the scan results. To do this, in the row of the relevant Docker image, click the value in the **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** column.

  To view Docker image scans, select the relevant image and go to the **{{ ui-key.yacloud.cr.image.label_scan-history }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [cli-install](../../_includes/default-catalogue.md) %}

  1. Get a list of the Docker images in a registry:

     ```bash
     yc container image list --repository-name=<registry_ID>/<Docker_image_name>
     ```

     Result:

     ```text
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     |          ID          |       CREATED       |            NAME             |  TAGS   | COMPRESSED SIZE |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     | crpqmsqp5mtb******** | 2021-02-09 08:57:14 | crpp7p7dovf4********/ubuntu | example | 27.2 MB         |
     +----------------------+---------------------+-----------------------------+---------+-----------------+
     ```

  1. Start a Docker image scan:

     ```bash
     yc container image scan <Docker_image_ID>
     ```

     Result:

     ```text
     done (24s)
     id: che1el9t4t95********
     image_id: crpqmsqp5mtb********
     ...
       medium: "6"
       low: "13"
       negligible: "3"
     ```

  1. Get detailed information on the scan results:

     ```bash
     yc container image list-vulnerabilities --scan-result-id=<scan_result_ID>
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
     yc container image list-scan-results --repository-name=<registry_ID>/<Docker_image_name>
     ```

     Result:

     ```text
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     | che1el9t4t95******** | crpqmsqp5mtb******** | 2021-03-16 14:34:02 | READY  | medium:6, low:13, negligible:3 |
     +----------------------+----------------------+---------------------+--------+--------------------------------+
     ```

- API {#api}

  To scan a Docker image, use the [scan](../api-ref/Scanner/scan.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/Scan](../api-ref/grpc/Scanner/scan.md) gRPC API call.

  To get the `scanResultId` scan result ID, use the [getLast](../api-ref/Scanner/getLast) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md) gRPC API call.

  To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md) gRPC API call.

{% endlist %}

## On push {#automatically}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Choose a registry or [create](registry/registry-create.md) a new one.
  1. Navigate to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
  1. Click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Under **{{ ui-key.yacloud.cr.registry.title_scan-on-push }}**, select **{{ ui-key.yacloud.cr.image.label_start-scan }}** and one of the scanning options:
     * `{{ ui-key.yacloud.cr.registry.label_all-repositories }}` to scan all registry repositories.
     * `{{ ui-key.yacloud.cr.registry.label_selected }}` to scan only selected repositories:
       1. Click **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
       1. Select the appropriate repositories from the list.
       1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  To automatically scan Docker images on push to a registry, use the [create](../api-ref/ScanPolicy/create.md) REST API method for the [ScanPolicy](../api-ref/ScanPolicy/) resource or the [ScanPolicyService/Create](../api-ref/grpc/ScanPolicy/create.md) gRPC API call.

  To get the `scanResultId` scan result ID, use the [getLast](../api-ref/Scanner/getLast) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md) gRPC API call.

  To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md) gRPC API call.

{% endlist %}

## On schedule {#scheduled}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Choose a registry or [create](registry/registry-create.md) a new one.
  1. Navigate to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
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

- API {#api}

  To run scheduled Docker image scans, use the [create](../api-ref/ScanPolicy/create.md) REST API method for the [ScanPolicy](../api-ref/ScanPolicy/) resource or the [ScanPolicyService/Create](../api-ref/grpc/ScanPolicy/create.md) gRPC API call.

  To get the `scanResultId` scan result ID, use the [getLast](../api-ref/Scanner/getLast) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/GetLast](../api-ref/grpc/Scanner/getLast.md) gRPC API call.

  To get detailed information about the scan results, use the [listVulnerabilities](../api-ref/Scanner/listVulnerabilities.md) REST API method for the [Scanner](../api-ref/Scanner/) resource or the [ScannerService/ListVulnerabilitiesListVulnerabilities](../api-ref/grpc/Scanner/listVulnerabilities.md) gRPC API call.

{% endlist %}