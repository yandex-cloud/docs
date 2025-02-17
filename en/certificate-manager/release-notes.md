---
title: '{{ certificate-manager-full-name }} release notes'
description: This section contains {{ certificate-manager-name }} release notes.
---

# {{ certificate-manager-full-name }} release notes

## Q4 2024 {#q4-2024}

Enabled [viewing the issue status](operations/managed/cert-create.md#view-statuses) for Let's Encrypt® certificates.

## Q3 2024 {#q3-2024}

* In the management console, added the feature to [export](operations/managed/cert-get-content.md) a certificate, certificate chain, and private key obtained from Let’s Encrypt. Certificates are saved in Base64 encoded text format:
* Added the `GetCertificateContent` event to collect audit logs in [{{ at-name }}](../audit-trails/concepts/events-data-plane.md#certificate-manager) by the _Getting SSL certificate contents_ event.