# {{ mgl-name }} advantages over a custom {{ GL }} Community Edition installation

_Custom installation_ is a self-managed {{ GL }} installed on a server or local computer. Below we discuss the custom installation of [{{ GL }} Community Edition](https://about.gitlab.com/install/ce-or-ee/).

{{ mgl-name }} supports [approval rules](approval-rules.md), while Community Edition does not. Approval rules provide an alternative to the [Approval Rules]({{ gl.docs }}/ee/user/project/merge_requests/approvals/rules.html) tool in {{ GL }} Enterprise Edition.

The custom installation is installed and administered manually. It is more costly compared to {{ mgl-name }} support. Service administration offers the following benefits:

* {{ GL }} can be [deployed](../operations/instance/instance-create.md) with a single click. The deployment automatically generates an SSL certificate.
* {{ yandex-cloud }} regularly maintains [{{ GL }} instances](index.md#instance) and upgrades the {{ GL }} version.
* {{ yandex-cloud }} regularly creates instance [backups](backup.md) according to the schedule specified in the instance settings.

## What's next {#whats-next}

* [Try {{ mgl-full-name }}]({{ link-console-main }}/link/managed-gitlab/).
* Migrate your projects from a custom installation to {{ mgl-name }} and reduce your service administration costs. For more information, see [{#T}](migration.md).
