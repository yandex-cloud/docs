---
title: Versioning in {{ mtr-name }}
description: This section lists the supported {{ TR }} versions and describes how they are upgraded in {{ mtr-name }}.
---

# Versioning in {{ mtr-name }}

## Available {{ TR }} versions {#available-versions}

{{ mtr-name }} supports the following {{ TR }} versions:

#|
|| **{{ TR }} version** | **Release notes** ||
|| `461` | [Version description](https://trino.io/docs/current/release/release-461.html) ||
|| `468` | [Version description](https://trino.io/docs/current/release/release-468.html) ||
|| `476` | [Version description](https://trino.io/docs/current/release/release-476.html) ||
|| `483` | [Version description](https://trino.io/docs/current/release/release-483.html) ||
|#

When creating a cluster, version `483` is used by default.

## Version update {#update}

In {{ mtr-name }}, you can upgrade or downgrade {{ TR }} to [any supported version](../concepts/versions.md#available-versions). Before doing so, review the [{{ TR }} release notes](https://trino.io/docs/current/release.html) and test the new version on a test cluster.

Updates and fixes within one version are installed automatically during [maintenance](maintenance.md).

To change your {{ TR }} version, follow [this guide](../operations/cluster-version-update.md).
