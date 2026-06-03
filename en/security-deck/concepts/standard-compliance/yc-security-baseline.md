---
title: Basic security rules for the {{ yandex-cloud }} cloud platform
description: This section provides a list of control rules from the {{ yandex-cloud }} basic security rule set.
---

# {{ yandex-cloud }} basic security rules

{% include [note-preview](../../../_includes/note-preview.md) %}

This rule set contains the basic security checks for protection of the cloud infrastructure and applications deployed in {{ yandex-cloud }}.

These rules help mitigate risks from basic security threats in cloud environments:

#|
|| Requirement ID | [Security standard](../../../security/standard/all.md) requirement | Check ID in the [{{ cspm-name }} module](../cspm.md) ||
|| **Authentication and access management** (IAM) {align="center"} | > | > ||
|| IAM5 | [Only appropriate administrators can manage IAM group membership](../../../security/standard/all.md#iam-admins) | [cspm.access.user-groups-access](../../rules-reference/cspm.md#user-groups-access) ||
|| IAM22 | [There is no public access to resources within the organization](../../../security/standard/all.md#public-access) | [cspm.access.public-access](../../rules-reference/cspm.md#public-access) ||
|| IAM27 | [Access permissions of users and service accounts are regularly audited using the {{ sd-full-name }} {{ ciem-name }}](../../../security/standard/all.md#ciem-access-control) | [cspm.access.check-bindings](../../rules-reference/cspm.md#access-check-bindings) ||
|| **Network security** (NET) {align="center"} | > | > ||
|| NET3 | [Security groups have no access rule that is too broad](../../../security/standard/all.md#access-rule) | [cspm.network.network-firewall-scope](../../rules-reference/cspm.md#network-firewall-scope) ||
|| **Secure virtual environment configuration** (ENV) {align="center"} | > | > ||
|| ENV1 | [A serial console is either used under control or not used](../../../security/standard/all.md#serial-console) | [cspm.access.serial-console](../../rules-reference/cspm.md#serial-console) ||
|| **Data encryption and key management** (CRYPT) {align="center"} | > | > ||
|| CRYPT9 | [{{ kms-short-name }} keys are stored in a hardware security module (HSM)](../../../security/standard/all.md#keys-hsm) | [cspm.crypto.keys-hsm](../../rules-reference/cspm.md#keys-hsm) ||
|| CRYPT13 | [The organization uses {{ lockbox-full-name }} for secure secret storage](../../../security/standard/all.md#secrets-lockbox) | [cspm.crypto.secrets-lockbox](../../rules-reference/cspm.md#secrets-lockbox) ||
|| CRYPT14 | [For {{ serverless-containers-full-name }} and {{ sf-full-name }}, {{ lockbox-name }}](../../../security/standard/all.md#secrets-serverless-functions) secrets are used | [cspm.crypto.secrets-serverless](../../rules-reference/cspm.md#secrets-serverless) ||
|| **Collecting, monitoring, and analyzing audit logs** (AUDIT) {align="center"} | > | > ||
|| AUDIT1 | [{{ at-full-name }} is enabled at the organization level](../../../security/standard/all.md#audit-trails) | [cspm.o11y.audit-trails-no-errors](../../rules-reference/cspm.md#o11y-audit-trails-no-errors) ||
|| AUDIT8 | [Data events are monitored](../../../security/standard/all.md#data-plane-events) | [cspm.o11y.data-plane-events](../../rules-reference/cspm.md#data-plane-events) ||
|| **Application security** (APPSEC) {align="center"} | > | > ||
|| APPSEC1 | [{{ captcha-full-name }} is used](../../../security/standard/all.md#use-smartcaptcha) | [cspm.appsec.use-smartcaptcha](../../rules-reference/cspm.md#use-smartcaptcha) ||
|| APPSEC2 | [Docker images are scanned when uploaded to {{ container-registry-full-name }}](../../../security/standard/all.md#upload-policy) | [cspm.appsec.secure-registry](../../rules-reference/cspm.md#secure-registry) ||
|| APPSEC3 | [Docker images stored in {{ container-registry-name }} are regularly scanned](../../../security/standard/all.md#periodic-scan) | [cspm.appsec.periodic-scan](../../rules-reference/cspm.md#periodic-scan) ||
|| APPSEC9 | [A {{ sws-full-name }} profile is used](../../../security/standard/all.md#use-sws) | [cspm.appsec.use-sws](../../rules-reference/cspm.md#use-sws) ||
|| APPSEC10 | [A web application firewall is used](../../../security/standard/all.md#use-waf) | [cspm.appsec.use-waf](../../rules-reference/cspm.md#use-waf) ||
|| APPSEC11 | [Advanced Rate Limiter is used](../../../security/standard/all.md#use-arl) | [cspm.appsec.use-arl](../../rules-reference/cspm.md#use-arl) ||
|| **{{ k8s }} security** (K8S) {align="center"} | > | > ||
|| K8S8 | [One of the three latest {{ k8s }} versions is used, updates are monitored](../../../security/standard/all.md#version-update) | [cspm.k8s.version-update](../../rules-reference/cspm.md#version-update) ||
|| K8S11 | [A {{ k8s }} security policy is used](../../../security/standard/all.md#security-standards) | [cspm.k8s.kspm](../../rules-reference/cspm.md#k8s-kspm) ||
|| K8S12 | [Audit log collection is set up for incident investigation](../../../security/standard/all.md#audit-logs) | [cspm.k8s.audit-logs](../../rules-reference/cspm.md#audit-logs) ||
|#
