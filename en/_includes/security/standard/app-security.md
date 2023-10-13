# 9. Application security

### Recommendations for protecting your application against bots {#protecting-recommendations}

#### 9.1 {{ captcha-full-name }} is used {#use-smartcaptcha}

To mitigate the risks associated with automated attacks on applications, we recommend using [{{ captcha-full-name }}](/services/smartcaptcha). The service checks user requests with its ML algorithms and only shows tasks to those users whose requests it considers suspicious. You do not have to place the **"I’m not a robot"** button on the page.

{% list tabs %}

- Performing a check in the management console

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ captcha-full-name }}**.
  1. Make sure at least one CAPTCHA is [created](../../../smartcaptcha/operations/create-captcha.md) for your application.

{% endlist %}

**Guides and solutions to use:**

[Guide on creating a CAPTCHA in {{ captcha-full-name }}](../../../smartcaptcha/operations/create-captcha.md).

### Recommendations on building a secure pipeline {#pipeline-recommendations}

{{ yandex-cloud }} allows customers to achieve compliance of software they develop at all [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), provided that they follow the guidelines given in this section. When using [{{ mgl-full-name }}](../../../managed-gitlab/), a customer automatically achieves [SLSA Level 2 compliance](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 9.2 Docker image scans on push to {{ container-registry-full-name }} {#upload-policy}

[Auto scans](../../../container-registry/tutorials/image-auto-scan.md) of Docker images on push are critical for early detection and elimination of vulnerabilities to ensure secure deployment of containers. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

{% list tabs %}

- Performing a check in the management console

  1. In the [management console]({{ link-console-main }}), select the folder that the registry with Docker images belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Choose a registry or [create](../../../container-registry/operations/registry/registry-create.md) a new one.
  1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
  1. Click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}** and set up scanning:
     * **{{ ui-key.yacloud.cr.registry.field_scan-on-upload }}**: Enable automatic Docker image scan on push to the registry.
     * **{{ ui-key.yacloud.cr.registry.label_repositories }}**: Select one of the scanning options:
        * **{{ ui-key.yacloud.cr.registry.label_all-repositories }}** to scan all repositories in the registry.
        * **{{ ui-key.yacloud.cr.registry.label_only-selected }}** to only scan those selected from the list:
           1. Click **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
           1. Specify the repositories from the list.
           1. Click **Save**.
  1. Click **Save changes**.

{% endlist %}

**Guides and solutions to use:**

[Guide on scanning Docker images on push](../../../container-registry/operations/scanning-docker-image.md#automatically).

#### 9.3 Regular scanning of Docker images stored in {{ container-registry-name }} {#periodic-scan}

Scheduled scanning of Docker images is an automated process that checks containerized images for vulnerabilities and compliance with security standards. Such scans are regular and automatic to ensure the consistency of image checks for vulnerabilities and maintain a high security level in the long run. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

We recommend setting up a schedule for scans to be run at least once a week.

{% list tabs %}

- Performing a check in the management console

  1. In the [management console]({{ link-console-main }}), select the folder that the registry with Docker images belongs to.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Choose a registry or [create](../../../container-registry/operations/registry/registry-create.md) a new one.
  1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab.
  1. Click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Under **Scheduled Docker image scans**, click **Add scan rule**.
  1. Select `Scan` and one of the scanning options:
     * **{{ ui-key.yacloud.cr.registry.label_all-repositories }}** to scan all registry repositories.
     * **{{ ui-key.yacloud.cr.registry.label_only-selected }}** to scan only selected repositories:
        1. Click **{{ ui-key.yacloud.cr.registry.button_select-repositories }}**.
        1. Select the appropriate repositories from the list.
        1. Click **Save**.
  1. Specify the frequency of Docker image scans.
  1. Click **Save changes**.

{% endlist %}

**Guides and solutions to use:**

[Guide on scheduled scanning of Docker images](../../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 9.4 Containerized images used in production environments have the last scan date a week ago or less {#last-scan-date}

Checking Docker images used in production environments with the last scan date a week ago or less ensures that you continuously monitor and update security measures, eliminating potential vulnerabilities that might have occurred since the last scan. This also helps you make sure you are not deploying containers with recently detected vulnerabilities and enhance the security level. You can automate this process by [setting up a schedule](#periodic-scan) in the vulnerability scanner.

{% list tabs %}

- Performing a check via the CLI

  Run the command below to search for containerized images with the last scan date a week ago or less:

  ```bash
  export ORG_ID=<organization_ID>
  for CLOUD_ID in $(yc resource-manager cloud list --organization-id=${ORG_ID} --format=json | jq -r '.[].id');
  do for FOLDER_ID in $(yc resource-manager folder list --cloud-id=$CLOUD_ID --format=json | jq -r '.[].id');
  do for REGISTRY_ID in $(yc container registry list --folder-id $FOLDER_ID --format=json | jq -r '.[].id');
  do for IMAGE_ID in $(yc container image list --registry-id $REGISTRY_ID --format=json | jq -r '.[].id';)
  do LAST_SCAN_DATE=$(yc container image get-last-scan-result --image-id $IMAGE_ID --format=json 2>/dev/null | jq -r '.scanned_at');
  [ ! -z "$LAST_SCAN_DATE" ] && [ $(date --date "$LAST_SCAN_DATE" +'%s') -lt $(date --date '7 days ago' +'%s') ] && echo "Regitry ID - $REGISTRY_ID, Image ID - $IMAGE_ID, Last scan date - $LAST_SCAN_DATE"
  done;
  done;
  done;
  done
  ```

{% endlist %}

#### 9.5 Software artifacts are built using attestations {#provenance-attestation}

Attestations are used when building software artifacts to ensure a secure and verifiable record of an artifact's origin, integrity, and SBOM compliance. This helps ensure the artifact reliability throughout its lifecycle. A software bill of materials (SBOM) is required to secure a supply chain, manage vulnerabilities, comply with requirements, assess risks, ensure transparency, and respond to incidents in an effective way.

With {{ mgl-name }}, attestations are easier to use, as the service has a feature for generating a [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). An SBOM can be generated using [syft](https://github.com/anchore/syft), a third-party software tool.

{% list tabs %}

- Manual check

  Make sure that artifact attestation is performed while building an application.

{% endlist %}

**Guides and solutions to use:**

[Gitlab guide for software artifact attestation](https://docs.gitlab.com/ee/ci/runners/configure_runners.html#artifact-attestation).

#### 9.6 Ensuring artifact integrity {#pipeline-artifacts-cosign}

Signing artifacts enhances security to ensure your software validity, integrity, reliability, and compliance with the requirements.

{% list tabs %}

- Manual check

  Make sure that artifacts are signed while building an application.

{% endlist %}

**Guides and solutions to use:**

You can sign artifacts within a pipeline using [Cosign](https://github.com/sigstore/cosign), a third-party command line utility for signing [artifacts](https://docs.sigstore.dev/signing/quickstart/), images, and [in-to-to attestations](https://github.com/in-toto/attestation/tree/main/spec/predicates), and then upload them to {{ container-registry-full-name }}.

#### 9.7 Artifacts are checked when deployed in {{ managed-k8s-full-name }} {#k8s-artifacts}

To ensure the reliability, security, and compatibility of applications in [{{ managed-k8s-name }}](../../../managed-kubernetes/), a service for automatic scaling and deployment of applications, you need to minimize the risk of issues, vulnerabilities, and failures during your application deployment and runtime. To do this, use [signatures and signature verification](../../../container-registry/tutorials/sign-with-cosign.md) in {{ managed-k8s-name }} with Cosign and [Kyverno](../../../managed-kubernetes/operations/applications/kyverno.md).

{% list tabs %}

- Manual check

  Make sure that artifacts are verified while building an application.

{% endlist %}

**Guides and solutions to use:**

[Guide on setting up the artifact signature](../../../container-registry/tutorials/sign-with-cosign.md).

#### 9.8 Protected templates of a secure pipeline are used {#pipeline-blocks}

When working with {{ mgl-name }}, make sure you use built-in GitLab security mechanisms to secure your pipeline. The following [options of pipeline usage](../../../managed-gitlab/concepts/security.md#security-pipeline-usage) are available for your projects:

* Creating a pipeline in an individual project and connecting it to other projects using the [`include` function](https://docs.gitlab.com/ee/ci/yaml/includes.html). Available for all license types.
* Using the [`Compliance framework and pipeline` mechanism](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks) that you can run in any group project. Available for the `Ultimate` license.
* Copying pipeline sections to `.gitlab-ci.yml` files in your projects.