# Security in {{ mgl-name }}

## Detecting vulnerabilities in CI/CD {#vulnerability-detection}

{{ mgl-name }} offers protection of your pipeline with built-in {{ GL }} tools.

The tools available depend on the [{{ GL }} license type](https://about.gitlab.com/pricing/). The free license offers several security tools, such as [Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/) and [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html). You can also develop custom jobs using open-source tools.

See the table for a complete list of pipeline security tools with respective licenses:

Pipeline security tools | Free | Premium | Ultimate
--- | :---: | :---: | :---:
[API Fuzzing](https://docs.gitlab.com/ee/user/application_security/api_fuzzing/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Cluster Image Scanning](https://docs.gitlab.com/ee/user/application_security/cluster_image_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Container Scanning](https://docs.gitlab.com/ee/user/application_security/container_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Dependency Scanning](https://docs.gitlab.com/ee/user/application_security/dependency_scanning/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Dynamic Application Security Testing (DAST)](https://docs.gitlab.com/ee/user/application_security/dast/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[License Compliance](https://docs.gitlab.com/ee/user/compliance/license_compliance/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)
[Security Dashboard](https://docs.gitlab.com/ee/user/application_security/security_dashboard/index.html) | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg)
[Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/index.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)

As {{ mgl-name }} develops, the list may change.

## Pipeline security usage examples {#security-pipeline-usage}

The following options of pipeline usage are available for your projects:
* Create a pipeline in an individual project and add it to other projects using the [`include` function](https://docs.gitlab.com/ee/ci/yaml/includes.html). Available for all license types.
* Use the [`Compliance framework and pipeline` mechanism](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks). You can run it in any group project. Available for the `Ultimate` license.
* Copy pipeline sections to the `.gitlab-ci.yml` file of your projects.

## Extra materials {#additional-content}

See examples of pipeline security prepared as part of [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security):
* [Detecting vulnerabilities in CI/CD (`Ultimate` license)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/ultimate_secure_ci_cd).
* [Detecting vulnerabilities in CI/CD (`Free` license)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/free_secure_ci_cd).

## Recommendations on security settings for a {{ GL }} instance {#secure-instance}

{% note tip %}

Before configuring an instance, see [general recommendations on {{ GL }} security](https://docs.gitlab.com/ee/security/).

{% endnote %}

Use these sets of recommendations to ensure security of your {{ GL }} instance:
* For audit and analysis of security events, [configure export of audit logs](https://docs.gitlab.com/ee/administration/audit_event_streaming.html) to a third-party event analysis system, for example, [{{ mes-full-name }}](../../managed-elasticsearch/) or [Splunk](https://www.splunk.com/).
* Sign commits using a [GPG key](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/).
* Organize the [`approval` of changes to code](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/) by at least two people. This will help reduce the number of errors.

### Working with Docker from inside {{ GL }} {#using-docker}

* Review [best practices on the secure operation of Docker images](https://docs.docker.com/engine/security/).
* Operate Docker [in `non-privileged` mode](https://docs.gitlab.com/runner/security/#usage-of-docker-executor). Use the `cap_add` and `cap_drop` settings to fine-tune the setup of container privileges.
* For building secure containers, use [kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html).
* Do not use `shell executor`, `Docker-in-Docker`, and `Docker socket binding` because this gives access to `Docker socket` and `privileged mode`. For more information, see [Securing GitLab CI pipelines with Sysbox](https://blog.nestybox.com/2020/10/21/gitlab-dind.html).

### Integration with {{ managed-k8s-full-name }} {#using-kubernetes}

* For secure integration, use [{{ GL }} Agent for {{ k8s }}](https://docs.gitlab.com/ee/user/clusters/agent/).
* To make it impossible to use [service accounts](../../iam/concepts/users/service-accounts.md) with the `cluster-admin` role and open the {{ k8s }} API to the internet, do not use [certificate-based integration](https://docs.gitlab.com/ee/user/infrastructure/clusters/).
* To prevent connectivity of {{ GL }} Runner and {{ k8s }}, deploy using the [CI/CD tunnel](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_tunnel.html).

### Using variables {#using-env-vars}

* To restrict access to variables, [use the `Protect variable` setting](https://docs.gitlab.com/ee/ci/variables/#protect-a-cicd-variable).
* To mask variables in logs, use the [`Mask variable` setting](https://docs.gitlab.com/ee/ci/variables/#mask-a-cicd-variable).
* Do not store secrets (such as keys, passwords, API tokens, and so on) in the code. To search for secrets in the code, use the [Secret Scanning](https://docs.gitlab.com/ee/user/application_security/secret_detection/) tool.

### Access differentiation {#access-control}

* Provide access to your projects to a limited number of personnel. Grant employees only the minimum required rights.
* Configure access to projects using [{{ GL }} groups](https://docs.gitlab.com/ee/user/group/).
* Limit project connections only to specific IP addresses and enable two-factor authentication. To do this, go to **Settings** → **General** → **Permissions, LFS, 2FA** in the properties of the appropriate group.
* To grant your company users access to projects, configure [SAML SSO](https://docs.gitlab.com/ee/user/group/saml_sso/).
* If possible, disable `fork` usage.

### Secure configuration of a {{ GL }} instance {#securing-instance}

* If possible, for your instance, [limit network access](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/secure_ci_cd/secure_ci_cd_with_webinar/gitlab_instance_sec_checklist/gitlab_instance_isolate.md) to your cloud.
* To prevent denial of service, use the [`User and IP rate limits`](https://docs.gitlab.com/ee/user/admin_area/settings/user_and_ip_rate_limits.html).

### Secure configuration for {{ GL }} Runner {#configuring-runners}

* Use the most isolated and safest [`Docker` and `{{ k8s }}` executors](https://docs.gitlab.com/runner/executors/). We do not recommend using the deprecated `Shell executor`.
* To restrict network access to {{ GL }} Runner, use [security groups](../../vpc/concepts/security-groups.md).
* [Assign a service account to a virtual machine](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to interact with the cloud API from inside jobs. This approach is more secure than specifying credentials via `env`.