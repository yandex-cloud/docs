---
title: Security in {{ mgl-full-name }}
description: In this tutorial, you will learn about the security measures available in {{ mgl-name }}.
---

# Security in {{ mgl-name }}

## Detecting vulnerabilities in CI/CD {#vulnerability-detection}

{{ mgl-name }} offers protection of your pipeline with built-in {{ GL }} tools.

The tools available depend on the [{{ GL }} license](https://about.gitlab.com/pricing/) type. The free license offers several security tools, such as [Static Application Security Testing (SAST)](https://docs.gitlab.com/ee/user/application_security/sast/) and [Secret Detection](https://docs.gitlab.com/ee/user/application_security/secret_detection/index.html). You can also develop custom jobs using open-source tools.

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

## Use of pipeline security examples {#security-pipeline-usage}

You can integrate a pipeline into your projects in the following ways:
* Create a pipeline in an individual project and add it to other projects using the [`include` function](https://docs.gitlab.com/ee/ci/yaml/includes.html). This option is available for all license types.
* Use the [`Compliance framework and pipeline` mechanism](https://docs.gitlab.com/ee/user/project/settings/index.html#compliance-frameworks). You can apply it to any of the group's projects. It is available for the `Ultimate` license.
* Copy the pipeline sections to the `.gitlab-ci.yml` files in your projects.

## Extra materials {#additional-content}

See the pipeline security examples prepared as part of [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud-examples/yc-security-solutions-library):
* [Detecting vulnerabilities in CI/CD (`Ultimate` license)](https://github.com/yandex-cloud-examples/yc-webinar-secure-cicd-with-gitlab/tree/main/ultimate_secure_ci_cd).
* [Detecting vulnerabilities in CI/CD (`Free` license)](https://github.com/yandex-cloud-examples/yc-webinar-secure-cicd-with-gitlab/tree/main/free_secure_ci_cd).

## {{ GL }} instance security setup guidelines {#secure-instance}

{% note tip %}

Before configuring an instance, see [general recommendations on {{ GL }} security](https://docs.gitlab.com/ee/security/).

{% endnote %}

Use these sets of recommendations to ensure security of your {{ GL }} instance:
* For audit and analysis of security events, [configure export of audit logs](https://docs.gitlab.com/ee/administration/audit_event_streaming.html) to a third-party event analysis system, e.g., [Splunk](https://www.splunk.com/).
* Sign commits using a [GPG key](https://docs.gitlab.com/ee/user/project/repository/gpg_signed_commits/).
* Arrange for [changes in code to be approved (`approve`)](https://docs.gitlab.com/ee/user/project/merge_requests/approvals/) by at least two people. This will help reduce the number of errors.
* To prevent denial of service, use the [`User and IP rate limits` limitations](https://docs.gitlab.com/ee/user/admin_area/settings/user_and_ip_rate_limits.html).

### Working with Docker from inside {{ GL }} {#using-docker}

* Review the [best practices of secure use of Docker images](https://docs.docker.com/engine/security/).
* Work with Docker [in `non-privileged` mode](https://docs.gitlab.com/runner/security/#usage-of-docker-executor). Use the `cap_add` and `cap_drop` settings to fine-tune the setup of container privileges.
* Use [kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html) to secure your container building processes.
* Do not use `Shell executor`, `Docker-in-Docker`, and `Docker socket binding`: this provides access to `Docker socket` and `privileged mode`. For more information, see [Securing GitLab CI pipelines with Sysbox](https://blog.nestybox.com/2020/10/21/gitlab-dind.html).


### Use cases {#examples-docker}

* [{#T}](../tutorials/image-storage.md)


### Integration with {{ managed-k8s-full-name }} {#using-kubernetes}

* For secure integration, use [{{ GL }} Agent for {{ k8s }}](https://docs.gitlab.com/ee/user/clusters/agent/).
* Do not use [certificate-based integration](https://docs.gitlab.com/ee/user/infrastructure/clusters/) to prevent the use of [service accounts](../../iam/concepts/users/service-accounts.md) with the `cluster-admin` role and the opening of the {{ k8s }} API to the internet.
* To prevent connectivity of {{ GL }} Runner and {{ k8s }}, deploy using the [CI/CD tunnel](https://docs.gitlab.com/ee/user/clusters/agent/ci_cd_tunnel.html).

### Use cases {#examples-k8s}

* [{#T}](../tutorials/gitlab-containers.md)

### Using variables {#using-env-vars}

* [Use the `Protect variable` setting](https://docs.gitlab.com/ee/ci/variables/#protect-a-cicd-variable) to restrict access to variables.
* Use the [`Mask variable` setting](https://docs.gitlab.com/ee/ci/variables/#mask-a-cicd-variable) to mask variables in logs.
* Do not store secrets (such as keys, passwords, API tokens, and so on) in the code. To search for secrets in the code, use the [Secret Scanning](https://docs.gitlab.com/ee/user/application_security/secret_detection/) tool.

### Access management {#access-control}

* Provide access to your projects to a limited number of personnel. Grant employees only the minimum required rights.
* Configure access to projects using [{{ GL }} groups](https://docs.gitlab.com/ee/user/group/).
* Limit project connections only to specific IP addresses and enable two-factor authentication. To do this, go to **Settings** → **General** → **Permissions, LFS, 2FA** in the properties of the appropriate group.
* To grant your company users access to projects, configure [SAML SSO](https://docs.gitlab.com/ee/user/group/saml_sso/).
* If possible, disable the use of `fork`.

### Secure configuration for {{ GL }} Runner {#configuring-runners}

* Use the most isolated and safest [`Docker` and `{{ k8s }}` managers](https://docs.gitlab.com/runner/executors/). We do not recommend using the obsolete `Shell executor`.
* To restrict network access to {{ GL }} Runner, use [security groups](../../vpc/concepts/security-groups.md).
* [Assign a service account to a virtual machine](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to interact with the cloud API from inside jobs. This approach is more secure than specifying credentials via `env`.


### Use cases {#examples-runners}

* [{#T}](../tutorials/install-gitlab-runner.md)