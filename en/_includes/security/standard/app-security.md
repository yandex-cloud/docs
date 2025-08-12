# Application security requirements

## 6. Application security {#app-security}

### Bot protection {#protecting-recommendations}

#### 6.1 {{ captcha-full-name }} is used {#use-smartcaptcha}

To mitigate the risks associated with automated attacks on applications, we recommend using [{{ captcha-full-name }}](/services/smartcaptcha). The service checks user requests with its ML algorithms and only shows challenges to those users whose requests it considers suspicious. You do not have to place the **"I’m not a robot"** button on the page.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha_ru }}**.
  1. Make sure at least one CAPTCHA is [created](../../../smartcaptcha/operations/create-captcha.md) for your application.

{% endlist %}

**Guides and solutions to use:**

[Guide on creating a CAPTCHA in {{ captcha-full-name }}](../../../smartcaptcha/operations/create-captcha.md).

### Building a secure pipeline {#pipeline-recommendations}

{{ yandex-cloud }} allows customers to achieve compliance of software they develop at all [Supply-chain Levels for Software Artifacts (SLSA)](https://slsa.dev/), provided that they follow the guidelines given in this section. When using [{{ mgl-full-name }}](../../../managed-gitlab/), a customer automatically achieves [SLSA Level 2 compliance](https://about.gitlab.com/blog/2022/11/30/achieve-slsa-level-2-compliance-with-gitlab/).

#### 6.2 When creating a registry in {{ container-registry-full-name }}, keep the safe registry settings by default {#keep-safe-cr-settings}

When creating a new [registry](../../../container-registry/concepts/registry.md), use the default options to make sure it meets the {{ yandex-cloud }} security standard:

* Docker images are automatically scanned as they are uploaded to the registry.
* Docker images in the registry are regularly re-scanned, i.e., every 7 days with an option to switch to daily scanning in the settings.

**Guides and solutions to use:**

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a registry.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Click **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. In the **{{ ui-key.yacloud.cr.overview.popup-create_field_name }}** field, enter a name for the registry, The naming requirements are as follows:
      
      {% include [name-format](../../name-format.md) %}
  1. Under **{{ ui-key.yacloud.cr.overview.popup-create_field_auto_scan }}**:

      * Keep **{{ ui-key.yacloud.cr.overview.popup-create_scan_push_text }}** enabled to scan Docker images at their upload to the repository.
      * Keep **{{ ui-key.yacloud.cr.overview.popup-create_scan_period_enabled }}** enabled. Adjust the scanning frequency if you need to.

  1. Click **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.

- CLI {#cli}

  To create a registry with safe image scanning settings used by default, run this command:

  ```bash
  yc container registry create \
    --name <registry_name> \
    --secure
  ```

{% endlist %}

#### 6.3 Docker images are scanned when uploaded to {{ container-registry-name }} {#upload-policy}

{% include [scan-docker-upload](scan-docker-upload.md) %}

#### 6.4 Docker images stored in {{ container-registry-name }} are regularly scanned {#periodic-scan}

{% include [scan-docker-periodic](scan-docker-periodic.md) %}

#### 6.5 Container images used in the production environment have the last scan date of one week ago or less {#last-scan-date}

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

#### 6.6 Attestations are used when building artifacts {#provenance-attestation}

Attestations used when building software artifacts help ensure a secure and verifiable record of an artifact's origin, integrity, and SBOM compliance. This helps ensure the artifact reliability throughout its lifecycle. A software bill of materials (SBOM) is required to secure a supply chain, manage vulnerabilities, comply with requirements, assess risks, ensure transparency, and respond to incidents in an effective way.

With {{ mgl-name }}, attestations are easier to use, as the service has a feature for generating a [provenance attestation](https://about.gitlab.com/releases/2022/06/22/gitlab-15-1-released/#slsa-2-attestation-included-for-build-artifacts). An SBOM can be generated using [syft](https://github.com/anchore/syft), a third-party software tool.

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifact attestation is performed while building an application.

{% endlist %}

**Guides and solutions to use:**

[Gitlab guide for software artifact attestation](https://docs.gitlab.com/ee/ci/runners/configure_runners.html#artifact-attestation).

#### 6.7 Artifact integrity is ensured {#pipeline-artifacts-cosign}

{% include [artifacts-cosign](artifacts-cosign.md) %}

#### 6.8 Artifacts are checked for authenticity on deployment {#artifacts-checked}

To ensure the reliability, security, and compatibility of applications in [{{ managed-k8s-name }}](../../../managed-kubernetes/), a service for automatic scaling and deployment of applications, you need to minimize the risk of issues, vulnerabilities, and failures during your application deployment and runtime. To do this, use [signatures and signature verification](../../../container-registry/tutorials/sign-cr-with-cosign.md) in {{ managed-k8s-name }} with Cosign and [Kyverno](../../../managed-kubernetes/operations/applications/kyverno.md).

{% list tabs group=instructions %}

- Manual check {#manual}

  Make sure that artifacts are verified while building an application.

{% endlist %}

**Guides and solutions to use:**

[Guide on setting up the artifact signature](../../../container-registry/tutorials/sign-cr-with-cosign.md).

#### 6.9 Protected secure pipeline templates are used {#pipeline-blocks}

When working with {{ mgl-name }}, make sure you use built-in GitLab security mechanisms to secure your pipeline. You can integrate a pipeline into your projects in the [following ways](../../../managed-gitlab/concepts/security.md#security-pipeline-usage):

* Creating a pipeline in an individual project and connecting it to other projects using the [`include`](https://docs.gitlab.com/ee/ci/yaml/includes.html) function. This option is available for all license types.
* Using the [`Compliance framework and pipeline`](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks) mechanism that you can run in any group project. It is available for the `Ultimate` license.
* Copying pipeline sections to `.gitlab-ci.yml` files in your projects.

#### 6.10 A {{ sws-full-name }} security profile is used {#use-sws}

[{{ sws-full-name }}](../../../smartwebsecurity/quickstart.md) protects you against DDoS attacks, web attacks, and bots at application level L7 of the [OSI model](https://en.wikipedia.org/wiki/OSI_model). {{ sws-name }} [connects](../../../smartwebsecurity/quickstart.md) to {{ alb-full-name }}.

In a nutshell, the service checks the HTTP requests sent to the protected resource against the [rules](../../../smartwebsecurity/concepts/rules.md) configured in the [security profile](../../../smartwebsecurity/concepts/profiles.md). Depending on the results of the check, the requests are forwarded to the protected resource, blocked, or sent to [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) for additional verification.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check the {{ sws-name }} status.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Make sure you have security profiles created.
  1. If you have security profiles, the recommendation is fulfilled. Otherwise, proceed to _Guides and solutions to use_.

- Performing a check via the CLI {#cli}

  Run this command:

  ```bash
  yc smartwebsecurity security-profile list
  ```

  If the command returns information about the existing security profiles, the recommendation is fulfilled. Otherwise, proceed to _Guides and solutions to use_.

{% endlist %}

**Guides and solutions to use:**

[Creating a security profile and connecting it to a virtual host of an L7 load balancer](../../../smartwebsecurity/quickstart.md).

#### 6.11 A web application firewall is used {#use-waf}

To mitigate risks associated with web attacks, we recommend using the {{ sws-full-name }} web application firewall (WAF). A web application firewall analyzes HTTP requests to a web app according to pre-configured rules. Based on the analysis results, certain [actions](../../../smartwebsecurity/concepts/rules.md#rule-action) are applied to HTTP requests.

You can manage the web application firewall using a [WAF profile](../../../smartwebsecurity/concepts/waf.md) that connects to a [security profile](../../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }} as a separate [rule](../../../smartwebsecurity/concepts/rules.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to check a security profile for a WAF rule.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Make sure your security profile has a security rule of the **web application firewall** type.

{% endlist %}

**Guides and solutions to use:**

[Creating a WAF profile and connecting it to a security profile in {{ sws-name }}](../../../smartwebsecurity/quickstart.md#waf).

#### 6.12 Advanced Rate Limiter is used {#use-arl}

[Advanced Rate Limiter (ARL)](../../../smartwebsecurity/concepts/arl.md) is a {{ sws-full-name }} module used to monitor and limit web app loads. It allows you to set a limit on the number of HTTP requests over a certain period of time. All requests above the limit will get blocked. You can set a single limit for all traffic or configure specific limits to segment requests by certain parameters. For the purpose of limits, you can count requests one by one or group them together based on specified property.

You need to connect your ARL profile to the [security profile](../../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }}.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) you want to check for ARL profiles.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../../_assets/smartwebsecurity/arl.svg) **ARL profiles** and make sure you have ARL profiles connected to your security profile.

{% endlist %}

**Guides and solutions to use:**

[Creating an ARL profile and connecting it to a security profile in {{ sws-name }}](../../../smartwebsecurity/quickstart.md#arl).

#### 6.13 Approval rules are configured {#setup-code-review}

With [{{ mgl-full-name }}](../../../managed-gitlab/index.yaml), you can flexibly set up required [approval rules](../../../managed-gitlab/concepts/approval-rules.md) before the code can be added to the target project branch. This feature is an alternative to the GitLab Enterprise Edition’s [Approval Rules](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/rules.html) tool and is available regardless of the GitLab [version](https://about.gitlab.com/pricing).

If a [{{ GL }} instance](../../../managed-gitlab/concepts/index.md#instance) has the approval rules enabled, {{ mgl-name }} analyzes approvals from reviewers for compliance with the specified rules. If there are not enough approvals, a thread is created in a merge request that blocks it from being merged to the target branch. Editing the merge request creates or updates a comment in the thread with its current compliance status. Once all the required approvals are obtained, the thread is closed.

If you close a thread manually, it will be created again. If a merge request is approved regardless of the existing rules, users with the `Maintainer` role or higher will receive an email notification about the violated code approval workflow.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where your {{ GL }} instance is located.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
  1. Select the instance you need and click **{{ ui-key.yacloud.common.edit }}** in the top-right corner of the page.
  1. Make sure to select a configured approval rule [configuration](../../../managed-gitlab/concepts/approval-rules.md#packages) in the **{{ ui-key.yacloud.gitlab.field_approval-rules }}** field.

{% endlist %}

**Guides and solutions to use:**

[Enabling approval rules in the {{ GL }} instance](../../../managed-gitlab/operations/approval-rules.md#enable)

#### 6.14 Trusted and unwanted IP addresses are grouped into lists {#app-sws-lists}

[{{ sws-full-name }}](../../../smartwebsecurity/index.yaml) supports grouping IP addresses into [custom lists](../../../smartwebsecurity/concepts/lists.md#user-rules). Add those lists as [conditions](../../../smartwebsecurity/concepts/conditions.md) in [rules](../../../smartwebsecurity/concepts/rules.md) to allow, block, or forward some traffic to [{{ captcha-name }}](../../../smartcaptcha/index.yaml) during IP address verification.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

  1. Open the {{ yandex-cloud }} console in your browser.
  1. Go to the appropriate folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Navigate to **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
  1. Check that the lists have been created.
  1. If there are such lists, the recommendation is fulfilled. Otherwise, proceed to "Guides and solutions to use".

- Manual check {#manual}

  Contact your account manager to make sure you have {{ sws-name }} lists.

{% endlist %}

**Guides and solutions to use:**

Whitelist and blacklist IP addresses to filter traffic. For more information, see [{#T}](../../../smartwebsecurity/operations/list-create.md).