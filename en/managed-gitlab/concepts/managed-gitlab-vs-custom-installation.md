# {{ mgl-name }} advantages over a {{ GL }} Community Edition custom installation

_Custom installation_: {{ GL }} installed on a server or local computer (self-managed {{ GL }}). Below we discuss the custom installation of [{{ GL }} Community Edition](https://about.gitlab.com/install/ce-or-ee/).

{{ mgl-name }} supports [approval rules](approval-rules.md) – a feature not supported by the Community Edition. Approval rules provide an alternative to the [Approval Rules]({{ gl.docs }}/ee/user/project/merge_requests/approvals/rules.html) tool in the {{ GL }} Enterprise Edition.

The custom installation is installed and administered manually. It is more costly compared to {{ mgl-name }} support. Service administration offers the following benefits:

* {{ GL }} [deploys](../operations/instance/instance-create.md) in one click. Deployment also includes automatic SSL certificate generation.
* {{ yandex-cloud }} regularly maintains [{{ GL }} instances](index.md#instance) and updates the {{ GL }} version.
* {{ yandex-cloud }} regularly creates instance [backups](backup.md) according to the schedule you configure at setup.

## What's next {#whats-next}

* [Try {{ mgl-full-name }}]({{ link-console-main }}/link/managed-gitlab/).
* Migrate your projects from a custom installation to {{ mgl-name }} and reduce your service administration costs. For more information about migration, see [{#T}](migration.md).
