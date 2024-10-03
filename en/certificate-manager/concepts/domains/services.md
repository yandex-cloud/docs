---
title: Integration of the domain management system with {{ yandex-cloud }} services
description: You can use verified {{ certificate-manager-name }} domains in {{ api-gw-full-name }}.
---

# Integration of the domain management system with {{ yandex-cloud }} services

{% include [preview-stage](../../../_includes/certificate-manager/preview-stage.md) %}


You can use verified {{ certificate-manager-name }} domains in the following {{ yandex-cloud }} services:
* [{#T}](#api-gw)

## {{ api-gw-full-name }} {#api-gw}

If a user confirmed their rights to a domain, they can [indicate](../../../api-gateway/operations/api-gw-domains.md) it as a user domain in {{ api-gw-full-name }}.

With {{ api-gw-full-name }}, you can merge several microservices into a single product. These microservices can be run on VMs and containers or implemented as functions. You can use the domain to access the API.

A certificate linked to the domain is used to provide a TLS connection.

#### See also {#see-also}

[{{ api-gw-full-name }}](../../../api-gateway/)
