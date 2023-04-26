# Scanning Docker images for vulnerabilities

These instructions describe how to [scan](../concepts/vulnerability-scanner.md) a [Docker image](../concepts/docker-image.md) for vulnerabilities.

{% note warning %}

* The vulnerability database is constantly updated with sources containing information on vulnerabilities.
* For some vulnerabilities, there is no information regarding which package versions they will be fixed in. This is because such information is unavailable from current sources.
* At the moment, you can manually initiate a scan of a Docker image, but we plan to add automatic scanning functionality.
* The number of image scans you can start per cloud is [limited](../concepts/limits.md#container-registry-quotas).

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the parent folder for the registry containing the Docker image.
   1. Select **{{ container-registry-name }}**.
   1. Select the registry containing the Docker image or [create](registry/registry-create.md) a new one and [upload](docker-image/docker-image-push.md) an image to it.
   1. Open the repository with the Docker image.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) next to the desired Docker image and select **Scan**.
   1. Wait for the scan to complete. While the scan is running, the Docker image scan status will be `Running`, and once complete, the status will change to `Ready`.
   1. Review the scan results. To do this, in the row for the selected Docker image, click on the value in the column named **Last scan date**.

   To view Docker image scans, select the image you want and go to the **Scan history** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [cli-install](../../_includes/default-catalogue.md) %}

   1. Get a list of the Docker images in a registry:

      ```bash
      yc container image list --repository-name=<registry ID>/<Docker image name>
      ```

      Result:

      ```bash
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      |          ID          |       CREATED       |            NAME             |  TAGS   | COMPRESSED SIZE |
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      | crpqmsqp5mtbh627i7qs | 2021-02-09 08:57:14 | crpp7p7dovf46626a7k4/ubuntu | example | 27.2 MB         |
      +----------------------+---------------------+-----------------------------+---------+-----------------+
      ```

   1. Start a Docker image scan:

      ```bash
      yc container image scan <image ID>
      ```

      Result:

      ```bash
      done (24s)
      id: che1el9t4t95elduhuq5
      image_id: crpqmsqp5mtbh627i7qs
      scanned_at: "2021-03-16T14:34:02.740521Z"
      status: READY
      vulnerabilities:
        medium: "6"
        low: "13"
        negligible: "3"
      ```

   1. Get detailed information on the scan results:

      ```bash
      yc container image list-vulnerabilities --scan-result-id=<scan result ID>
      ```

      Result:

      ```bash
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
      |  SEVERITY  |      NAME      | PACKAGE  |        VERSION         |          FIXED BY          |                             LINK                              |
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
      | MEDIUM     | CVE-2020-27350 | apt      | 2.0.2ubuntu0.1         | 2.0.2ubuntu0.2             | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27350 |
      | MEDIUM     | CVE-2021-24031 | libzstd  | 1.4.4+dfsg-3           | 1.4.4+dfsg-3ubuntu0.1      | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24031 |
      | MEDIUM     | CVE-2021-24032 | libzstd  | 1.4.4+dfsg-3           | 1.4.4+dfsg-3ubuntu0.1      | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-24032 |
      | MEDIUM     | CVE-2020-29361 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29361 |
      | MEDIUM     | CVE-2020-29362 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29362 |
      | MEDIUM     | CVE-2020-29363 | p11-kit  | 0.23.20-1build1        | 0.23.20-1ubuntu0.1         | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29363 |
      | LOW        | CVE-2019-18276 | bash     | 5.0-6ubuntu1.1         |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-18276 |
      | LOW        | CVE-2019-25013 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-25013 |
      | LOW        | CVE-2020-27618 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-27618 |
      | LOW        | CVE-2020-29562 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-29562 |
      | LOW        | CVE-2020-6096  | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-6096  |
      | LOW        | CVE-2021-20231 | gnutls28 | 3.6.13-2ubuntu1.3      |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20231 |
      | LOW        | CVE-2021-20232 | gnutls28 | 3.6.13-2ubuntu1.3      |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-20232 |
      | LOW        | CVE-2019-20838 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-20838 |
      | LOW        | CVE-2020-10543 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10543 |
      | LOW        | CVE-2020-10878 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-10878 |
      | LOW        | CVE-2020-12723 | perl     | 5.30.0-9build1         | 5.30.0-9ubuntu0.2          | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-12723 |
      | LOW        | CVE-2013-4235  | shadow   | 1:4.8.1-1ubuntu5.20.04 |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-4235  |
      | LOW        | CVE-2019-9923  | tar      | 1.30+dfsg-7            | 1.30+dfsg-7ubuntu0.20.04.1 | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2019-9923  |
      | NEGLIGIBLE | CVE-2016-10228 | glibc    | 2.31-0ubuntu9.1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-10228 |
      | NEGLIGIBLE | CVE-2017-11164 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-11164 |
      | NEGLIGIBLE | CVE-2020-14155 | pcre3    | 2:8.39-12build1        |                            | https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-14155 |
      +------------+----------------+----------+------------------------+----------------------------+---------------------------------------------------------------+
      ```

      To view scans by Docker image, run the command:

      ```bash
      yc container image list-scan-results --repository-name=<Registry ID>/<Docker image name>
      ```

      Result:

      ```bash
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      |          ID          |        IMAGE         |     SCANNED AT      | STATUS |        VULNERABILITIES         |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      | che1el9t4t95elduhuq5 | crpqmsqp5mtbh627i7qs | 2021-03-16 14:34:02 | READY  | medium:6, low:13, negligible:3 |
      +----------------------+----------------------+---------------------+--------+--------------------------------+
      ```

{% endlist %}