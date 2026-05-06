---
title: Security in {{ mgl-full-name }}
description: In this guide, you will learn about the security measures available in {{ mgl-name }}.
---

# Security in {{ mgl-name }}

## Detecting vulnerabilities in CI/CD {#vulnerability-detection}

{{ mgl-name }} uses {{ GL }}’s built-in tools to protect your pipelines.

The available tools depend on your [{{ GL }} license type](https://about.gitlab.com/pricing/). The free license offers several security tools, such as [Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/) and [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html). You can also develop custom jobs using open-source tools.

See the table below for a complete list of pipeline security tools by license type:

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

As {{ mgl-name }} evolves, the tool list may change.

## Use of pipeline security examples {#security-pipeline-usage}

You can integrate a pipeline into your projects in the following ways:
* Create a pipeline in an individual project and add it to other projects using the [`include` function](https://docs.gitlab.com/ee/ci/yaml/includes.html). This option is available for all license types.
* Use the [`Compliance framework and pipeline` mechanism](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks). You can apply it to any of the group's projects. It is available for the `Ultimate` license.
* Copy the pipeline sections to the `.gitlab-ci.yml` files in your projects.

## Additional resources {#additional-content}

Check out the pipeline security examples prepared as part of [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library):
* [Detecting vulnerabilities in CI/CD (`Ultimate` license)](https://github.com/yandex-cloud-examples/yc-webinar-secure-cicd-with-gitlab/tree/main/ultimate_secure_ci_cd).
* [Detecting vulnerabilities in CI/CD (`Free` license)](https://github.com/yandex-cloud-examples/yc-webinar-secure-cicd-with-gitlab/tree/main/free_secure_ci_cd).

## Best practices for {{ GL }} instance security configuration {#secure-instance}

{% note tip %}

Before configuring an instance, review the [general {{ GL }} security recommendations](https://docs.gitlab.com/ee/security/).

{% endnote %}

Use these recommendations to ensure security of your {{ GL }} instance:
* For audit and analysis of security events, [configure export of audit logs](https://docs.gitlab.com/ee/administration/audit_event_streaming.html) to a third-party event analysis system, e.g., [Splunk](https://www.splunk.com/).
* Sign your commits using a [GPG key](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/).
* Ensure that at least two team members [`approve` code changes](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/). This will help reduce the number of errors.
* To prevent denial of service, use the [`User and IP rate limits` limitations](https://docs.gitlab.com/ee/user/admin_area/settings/user_and_ip_rate_limits.html).

### Working with Docker from inside {{ GL }} {#using-docker}

* Review the [best practices of secure use of Docker images](https://docs.docker.com/engine/security/).
* Work with Docker [in `non-privileged` mode](https://docs.gitlab.com/runner/security/#usage-of-docker-executor). Use the `cap_add` and `cap_drop` settings to fine-tune the setup of container privileges.
* Use [kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html) for secure container builds.
* Do not use `Shell executor`, `Docker-in-Docker`, and `Docker socket binding`: this provides access to `Docker socket` and `privileged mode`. For more information, see [Securing GitLab CI pipelines with Sysbox](https://blog.nestybox.com/2020/10/21/gitlab-dind.html).


### Use cases {#examples-docker}

* [{#T}](../tutorials/image-storage.md)


### Integration with {{ managed-k8s-full-name }} {#using-kubernetes}

* For secure integration, use [{{ GL }} Agent for {{ k8s }}](https://docs.gitlab.com/ee/user/clusters/agent/).
* Do not use [certificate-based integration](https://docs.gitlab.com/ee/user/infrastructure/clusters/) to prevent using [service accounts](../../iam/concepts/users/service-accounts.md) with the `cluster-admin` role and exposing the {{ k8s }} API to the internet.
* To prevent tight coupling between {{ GL }} Runner and {{ k8s }}, use deployment via a [CI/CD tunnel](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_tunnel.html).

### Use cases {#examples-k8s}

* [{#T}](../tutorials/gitlab-containers.md)

### Using variables {#using-env-vars}

* [Use the `Protect variable` setting](https://docs.gitlab.com/ee/ci/variables/#protect-a-cicd-variable) to restrict access to variables.
* Use the [`Mask variable` setting](https://docs.gitlab.com/ee/ci/variables/#mask-a-cicd-variable) to mask variables in logs.
* Do not store secrets, such as keys, passwords, and API tokens, in code. Use [Secret Scanning](https://docs.gitlab.com/ee/user/application_security/secret_detection/) to detect secrets in your code.

### Access control {#access-control}

* Grant access to your projects only to a limited number of team members. Follow the principle of least privilege when granting access.
* Use [{{ GL }} groups](https://docs.gitlab.com/ee/user/group/) to configure project access.
* Restrict project access to specific IP addresses and enable two-factor authentication. To do this, go to **Settings** → **General** → **Permissions, LFS, 2FA** in the target group's settings.
* To grant your organization's users access to projects, configure [SAML SSO](https://docs.gitlab.com/ee/user/group/saml_sso/).
* If possible, disable the use of `fork`.

### Secure {{ GL }} Runner configuration {#configuring-runners}

* Use the most isolated and secure [`Docker` and `{{ k8s }}` executors](https://docs.gitlab.com/runner/executors/). We do not recommend using the deprecated `Shell executor`.
* To restrict network access to {{ GL }} Runner, use [security groups](../../vpc/concepts/security-groups.md).
* [Assign service accounts to a virtual machine](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to securely work with cloud APIs within jobs. This approach is more secure than providing credentials via `env`.


### Use cases {#examples-runners}

* [{#T}](../tutorials/install-gitlab-runner.md)