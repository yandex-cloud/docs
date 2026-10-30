---
title: Updating a TLS certificate chain to access {{ mspqr-full-name }} clusters
description: This section will walk you through the specifics of updating a TLS certificate chain for {{ yandex-cloud }} data platform services, along with the actions you may need to maintain connectivity to publicly accessible {{ mspqr-full-name }} cluster hosts.
---

# Updating a TLS certificate chain in data platform services

{% include [info-page-part1](../../_includes/mdb/update-certificate-chain/info-page-part1.md) %}

During scheduled [maintenance](../concepts/maintenance.md), cluster server certificates will be switched to a new intermediate certificate.


## Upcoming changes {#upcoming-changes}

{% include [info-page-part2](../../_includes/mdb/update-certificate-chain/info-page-part2.md) %}

* The date and time of the specific cluster update will be specified in the appropriate [maintenance task](./cluster-maintenance.md#get-maintenance).


## Possible problems {#possible-impact}

{% include [info-page-part3-1](../../_includes/mdb/update-certificate-chain/info-page-part3-1.md) %}

{% include [info-page-part3-2](../../_includes/mdb/update-certificate-chain/info-page-part3-2.md) %}

## Actions prior to maintenance {#to-do-list}

{% include [info-page-part4](../../_includes/mdb/update-certificate-chain/info-page-part4.md) %}

For more details on certificate installation commands and connection examples, see [this section](./connect.md).


## If your connection drops {#troubleshoot}

{% include [info-page-part5](../../_includes/mdb/update-certificate-chain/info-page-part5.md) %}


#### Useful links {#see-also}

* [{#T}](./connect.md)
* [{#T}](../concepts/maintenance.md)
* [{#T}](./cluster-maintenance.md)