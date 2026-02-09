---
title: '{{ yandex-cloud }} Security Baseline'
description: This section contains the list of security requirements that are part of the {{ yandex-cloud }} Security Baseline rule set.
---

# {{ yandex-cloud }} Security Baseline

{% include [note-preview](../../../_includes/note-preview.md) %}

This rule set contains security baseline controls which are available for all users and helps protect cloud infrastructure and applications deployed on Yandex Cloud platform.

These controls help ensure a minimum baseline to lower security risks in the cloud infrastructure:

Requirement ID | [Security standard](../../../security/standard/all.md) requirement | [CSPM](../cspm.md) rule check ID
--- | --- | ---
`IAM1` | [Identity Federation (Single Sign-On, SSO) is configured)](../../../security/standard/all.md#saml-federation) | `cspm.access.uses-federation` 
`IAM22` | [No public access for resources in the organization](../../../security/standard/all.md#public-access) | `cspm.access.public-access`
`NET3` | [Security groups do not contain overly broad access rules](../../../security/standard/all.md#access-rule) | `cspm.network.network-firewall-scope`
`ENV1` | [Use of the serial console is controlled or disabled](../../../security/standard/all.md#serial-console) | `cspm.access.serial-console`
`CRYPT13` | [{{ lockbox-full-name }} is used in the organization for secure secret storage](../../../security/standard/all.md#secrets-lockbox) | `cspm.crypto.secrets-lockbox`
`CRYPT14` | [{{ lockbox-name }} secrets are used for {{ serverless-containers-full-name }} and {{ sf-full-name }}](../../../security/standard/all.md#secrets-serverless-functions) | `cspm.crypto.secrets-serverless`
`AUDIT2` | [{{ at-full-name }} events are exported to SIEM systems](../../../security/standard/all.md#events) | `cspm.o11y.logs-exported-to-siem`
`AUDIT8` | [Data-plane events are monitored](../../../security/standard/all.md#data-plane-events) | `cspm.o11y.data-plane-events`
`APPSEC2` | [Docker images are scanned upon upload to {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | `cspm.appsec.upload-policy`
`APPSEC3` | [Periodic scanning of Docker images stored in {{ container-registry-name }} is performed](../../../security/standard/all.md#periodic-scan) | `cspm.appsec.periodic-scan`
`APPSEC9` | [A {{ sws-full-name }} security profile is used](../../../security/standard/all.md#use-sws) | `cspm.appsec.use-sws`
`APPSEC11` | [Advanced Rate Limiter is used](../../../security/standard/all.md#use-arl) | `cspm.appsec.use-arl`
`K8S8` | [One of the three latest {{ k8s }} versions is used and updates are monitored](../../../security/standard/all.md#version-update) | `cspm.k8s.version-update`
`K8S12` | [Audit log collection is configured for incident investigations](../../../security/standard/all.md#audit-logs) | `cspm.k8s.audit-logs`