# 8. Application security

### Recommendations for protecting your application against bots {#protecting-recommendations}

#### 8.1 Use {{ captcha-full-name }} {#use-smartcaptcha}

To mitigate the risks associated with automated attacks on applications, we recommend using [{{ captcha-full-name }}](/services/smartcaptcha). The service checks user requests with its ML algorithms and only shows challenges to those users whose requests it considers suspicious. You do not have to place the **"I’m not a robot"** button on the page.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Make sure at least one CAPTCHA is [created](../../../smartcaptcha/operations/create-captcha.md) for your application.

{% endlist %}

**Guides and solutions to use**:

[Guide on creating a CAPTCHA in {{ captcha-full-name }}](../../../smartcaptcha/operations/create-captcha.md).

### Recommendations on building a secure pipeline {#pipeline-recommendations}

{{ yandex-cloud }} allows customers to achieve compliance of software they develop at all [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), provided that they follow the guidelines given in this section. When using [{{ mgl-full-name }}](../../../managed-gitlab/), a customer automatically achieves [SLSA Level 2 compliance](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 8.2 Implement scanning of Docker images when uploading them to {{ container-registry-full-name }} {#upload-policy}

[Auto scans](../../../container-registry/operations/scanning-docker-image.md#automatically) of Docker images on push are critical for early detection and elimination of vulnerabilities to ensure secure deployment of containers. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select the appropriate registry in **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure Docker image scans on push are enabled.

{% endlist %}

**Guides and solutions to use**:

[Guide on scanning Docker images on push](../../../container-registry/operations/scanning-docker-image.md#automatically).

#### 8.3 Schedule regular scanning of Docker images stored in {{ container-registry-name }} {#periodic-scan}

Scheduled scanning of Docker images is an automated process that checks containerized images for vulnerabilities and compliance with security standards. Such scans are regular and automatic to ensure the consistency of image checks for vulnerabilities and maintain a high security level in the long run. Reports on completed scans provide a brief description of detected vulnerabilities and issues and help you set priorities and eliminate security risks in containerized applications.

We recommend setting up a schedule for scans to be run at least once a week.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the registry with Docker images belongs to.
  1. Select the appropriate registry in **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Go to the **{{ ui-key.yacloud.cr.registry.label_vulnerabilities-scanner }}** tab and click **{{ ui-key.yacloud.cr.registry.button_change-scan-settings }}**.
  1. Make sure that scheduled Docker image scans are enabled with a frequency of at least once a week.

{% endlist %}

**Guides and solutions to use**:

[Guide on scheduled scanning of Docker images](../../../container-registry/operations/scanning-docker-image.md#scheduled).

#### 8.4 Make sure containerized images used in production environments have the last scan date of one week ago or less {#last-scan-date}

Checking Docker images used in production environments with the last scan date not older than a week ensures that you continuously monitor and update security measures, eliminating potential vulnerabilities that might have occurred since the last scan. This also helps you make sure you are not deploying containers with recently detected vulnerabilities and enhance the security level. You can automate this process by [setting up a schedule](#periodic-scan) in the Vulnerability scanner.

{% list tabs group=instructions %}

- Performing a check via the CLI {#cli}

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

#### 8.5 Use attestations when building software artifacts {#provenance-attestation}

Attestations used when building software artifacts help ensure a secure and verifiable record of an artifact's origin, integrity, and SBOM compliance. This helps ensure the artifact reliability throughout its lifecycle. A software bill of materials (SBOM) is required to secure a supply chain, manage vulnerabilities, comply with requirements, assess risks, ensure transparency, and respond to incidents in an effective way.

With {{ mgl-name }}, attestations are easier to use, as the service has a feature for generating a [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). An SBOM can be generated using [syft](https://github.com/anchore/syft), a third-party software tool.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifact attestation is performed while building an application.

{% endlist %}

**Guides and solutions to use**:

[Gitlab guide for software artifact attestation](https://docs.gitlab.com/ee/ci/runners/configure_runners.html#artifact-attestation).

#### 8.6 Ensure artifact integrity {#pipeline-artifacts-cosign}

Signing artifacts enhances security to ensure your software validity, integrity, reliability, and compliance with the requirements.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifacts are signed while building an application.

{% endlist %}

**Guides and solutions to use**:

To sign artifacts within a pipeline, you can use [Cosign](https://github.com/sigstore/cosign), a third-party command line utility for signing [artifacts](https://docs.sigstore.dev/signing/quickstart/), images, and [in-to-to attestations](https://github.com/in-toto/attestation/tree/main/spec/predicates). Then you can upload these artifacts to {{ container-registry-full-name }}.

A special build of Cosign allows you to store the created [digital signature key pair](../../../kms/concepts/asymmetric-signature-key.md) in [{{ kms-full-name }}](../../../kms/quickstart/index.md), sign files and artifacts with the private key of the pair, and verify a digital signature using its public key.

For more information, see [{#T}](../../../container-registry/tutorials/sign-with-cosign.md).

#### 8.7 Verify artifacts on deployment {#artifacts-checked}

To ensure the reliability, security, and compatibility of applications in [{{ managed-k8s-name }}](../../../managed-kubernetes/), a service for automatic scaling and deployment of applications, you need to minimize the risk of issues, vulnerabilities, and failures during your application deployment and runtime. To do this, use [signatures and signature verification](../../../container-registry/tutorials/sign-with-cosign.md) in {{ managed-k8s-name }} with Cosign and [Kyverno](../../../managed-kubernetes/operations/applications/kyverno.md).

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifacts are verified while building an application.

{% endlist %}

**Guides and solutions to use**:

[Guide on setting up the artifact signature](../../../container-registry/tutorials/sign-with-cosign.md).

#### 8.8 Use protected templates of a secure pipeline {#pipeline-blocks}

When working with {{ mgl-name }}, make sure you use built-in GitLab security mechanisms to secure your pipeline. The following [options of pipeline usage](../../../managed-gitlab/concepts/security.md#security-pipeline-usage) are available for your projects:

* Creating a pipeline in an individual project and connecting it to other projects using the [`include` function](https://docs.gitlab.com/ee/ci/yaml/includes.html). This option is available for all license types.
* Using the [`Compliance framework and pipeline` mechanism](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks) that you can run in any group project. It is available for the `Ultimate` license.
* Copying pipeline sections to `.gitlab-ci.yml` files in your projects.

#### 8.9 Use a {{ sws-full-name }} security profile {#use-sws}

[{{ sws-full-name }}](../../../smartwebsecurity/quickstart/index.md) is a service for protection against DDoS attacks and bots at application level L7 of the [OSI model](https://en.wikipedia.org/wiki/OSI_model). {{ sws-name }} [connects](../../../smartwebsecurity/quickstart.md) to {{ alb-full-name }}.

In a nutshell, the service checks the HTTP requests sent to the protected resource against the [rules](../../../smartwebsecurity/concepts/rules.md) configured in the [security profile](../../../smartwebsecurity/concepts/profiles.md). Depending on the results of the check, the requests are forwarded to the protected resource, blocked, or sent to [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) for additional verification.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  * In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check the {{ sws-name }} status.
  * In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  * Make sure you have security profiles created.

{% endlist %}

**Guides and solutions to use**:

[Creating a security profile and connecting it to a virtual host of an L7 load balancer](../../../smartwebsecurity/quickstart.md).

#### 8.10 Use a web application firewall {#use-waf}

To mitigate risks associated with web attacks, we recommend using the {{ sws-full-name }} web application firewall (WAF). A web application firewall analyzes HTTP requests to a web app according to pre-configured rules. Based on the analysis results, certain [actions](../../../smartwebsecurity/concepts/rules.md#rule-action) are applied to HTTP requests.

You can manage the web application firewall using a [WAF profile](../../../smartwebsecurity/concepts/waf.md) that connects to a [security profile](../../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }} as a separate [rule](../../../smartwebsecurity/concepts/rules.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check a security profile for a WAF rule.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Make sure your security profile has a security rule of the **web application firewall** type.

{% endlist %}

**Guides and solutions to use**:

[Creating a WAF profile and connecting it to a security profile in {{ sws-name }}](../../../smartwebsecurity/quickstart/quickstart-waf.md).

#### 8.11 Use Advanced Rate Limiter {#use-arl}

[Advanced Rate Limiter (ARL)](../../../smartwebsecurity/concepts/arl.md) is a module used to monitor and limit web app loads. The module allows you to set a limit on the number of HTTP requests over a certain period of time. All requests above the limit will be blocked. You can set a single limit for all traffic or configure specific limits to segment requests by certain parameters. For the purposes of limits, you can count requests one by one or group them together based on specified characteristics.

You need to connect your ARL profile to the [security profile](../../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }}.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to check for ARL profiles.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../../_assets/smartwebsecurity/arl.svg) **ARL profiles** and make sure you have ARL profiles connected to your security profile.

{% endlist %}

**Guides and solutions to use**:

[Creating an ARL profile and connecting it to a security profile in {{ sws-name }}](../../../smartwebsecurity/quickstart/quickstart-arl.md).

#### 8.12 Set up approval rules {#setup-code-review}

With [{{ mgl-full-name }}](../../../managed-gitlab/index.yaml), you can flexibly set up mandatory [approval rules](../../../managed-gitlab/concepts/approval-rules.md) for adding code to the target project branch. This feature is an alternative to the GitLab Enterprise Edition’s [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) tool and is available regardless of the GitLab [version](https://about.gitlab.com/pricing).

If a [{{ GL }} instance](../../../managed-gitlab/concepts/index.md#instance) has the approval rules enabled, {{ mgl-name }} analyzes approvals from reviewers for compliance with the specified rules. If there are not enough approvals, a thread is created in a merge request that blocks it from being merged to the target branch. Editing the merge request creates or updates a comment in the thread with its current compliance status. Once all the required approvals are obtained, the thread is closed.

If you close a thread manually, it will be created again. If a merge request is approved regardless of the existing rules, users with the `Maintainer` role or higher will receive an email notification about the violated code approval workflow.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your {{ GL }} instance is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the instance you need and click **{{ ui-key.yacloud.common.edit }}** in the top-right corner of the page.
  1. Make sure to select a configured approval rule [configuration](../../../managed-gitlab/concepts/approval-rules.md#packages) in the **{{ ui-key.yacloud.gitlab.field_approval-rules }}** field.

{% endlist %}

**Guides and solutions to use**:

[Enabling approval rules in the {{ GL }} instance](../../../managed-gitlab/operations/approval-rules.md#enable)
