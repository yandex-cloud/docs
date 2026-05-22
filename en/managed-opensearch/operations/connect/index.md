---
title: Pre-configuring a {{ OS }} cluster connection in {{ mos-full-name }}
description: In this tutorial, you will learn how to pre-configure a database connection in a {{ OS }} cluster.
keywords:
  - connecting OpenSearch clusters
  - OpenSearch cluster
  - OpenSearch
---

# Pre-configuring a {{ OS }} cluster connection


You can connect to {{ mos-name }} cluster hosts with the `DATA` [role](../../concepts/host-roles.md#data):

* Over the internet, if you configured public access to the host group you need.

* Over the internet using a [special FQDN](./fqdn.md#special-fqdns) if you configured public access to the host group with the `DASHBOARDS` [role](../../concepts/host-roles.md#dashboards).

* From {{ yandex-cloud }} VMs residing in the same [virtual network](../../../vpc/concepts/network.md).


Regardless of the connection method, {{ mos-name }} only supports cluster host connections with an [SSL certificate](#ssl-certificate).


## Configuring security groups {#security-groups}

{% include notitle [Configuring security groups](../../../_includes/mdb/mos/configuring-security-groups.md) %}


## Getting an SSL certificate {#ssl-certificate}

To use an encrypted connection, get an SSL certificate:

{% include [install-certificate](../../../_includes/mdb/mos/install-certificate.md) %}

## What's next {#whats-next}

* [Get the FQDN of the host](./fqdn.md) you want to connect to.
* [Connect](./clients.md) to the cluster from a Docker container.
* [Integrate](./code-examples.md) the cluster connection into your application code.
* [Configure SAML authentication](../saml-authentication.md).
