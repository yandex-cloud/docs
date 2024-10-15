---
title: Service connections in {{ vpc-full-name }}
description: In this tutorial, you will learn what service connections (Private Endpoints) are used in {{ vpc-full-name }}.
keywords:
  - service connection
  - private endpoint
  - private link
---

# Service connections in {{ vpc-full-name }}

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}

A **service connection** (Private Endpoint) provides direct IP connectivity between resources within {{ vpc-short-name }} and {{ yandex-cloud }} services that are hosted outside {{ vpc-short-name }}. 

In this case, direct IP connectivity refers to availability of such services [via {{ vpc-short-name }}](./address.md#internal-addresses) internal IP addresses without using [public IP addresses](address.md#public-addresses).

An example is the [Object Storage](../../storage/) service. 

## Service connection structure {#private-endpoint-architecture}

A service connection can be divided into two parts:

* The client part (Private Endpoint, PE) is responsible for presenting the service in {{ vpc-short-name }}. It is implemented within {{ vpc-short-name }}. This is a common part for all types of service connections.
* The service part (Provider) is responsible for interaction with the client part and is implemented on the service side. This part is unique for each service and service connection type.

A service connection has the following specifications:

* An IP address of a connection in {{ vpc-short-name }} from subnet CIDR ranges in the network you want to create a service connection for.
* Connection type: service to which the connection is made. For a list of available service connection types, see [below](#private-endpoint-types).

When creating a service connection in {{ vpc-short-name }}, the following objects are created:

1. **Internal IP address** to which the created connection is bound.
1. **A type DNS record** with a special FQDN for the service connection being created, e.g., `storage.pe.yandexcloud.net` which will specify the internal IP address allocated for the service connection.
1. Optional. If required, an additional A type DNS record can be created for the public FQDN service. It will also include the internal IP address allocated for the service connection.

Once you create a service connection, all cloud resources that will be added to subnets on the network with this connection will be linked to it through the internal IP address (1). To use the services, you can use either a fully qualified domain name (FQDN) (2) or its part (3). A type DNS records will be created in the [internal service zone](../../dns/concepts/dns-zone.md#service-zones).

To use service connections outside the cloud infrastructure, you need to provide IP connectivity between your infrastructure and {{ yandex-cloud }} using VPN technologies (IPsec, Wireguard, etc.) or [Cloud Interconnect](../../interconnect/) services.

{% note info %}

If you need to access the service connection via FQDN from outside {{ yandex-cloud }}, you must configure the appropriate A records on the corporate DNS server so that the FQDN of the service points to the IP address of the connection.

{% endnote %}

## Service connection types {#private-endpoint-types}

| Service name (Connection type) | API service FQDN |
| --- | --- |
| [{{ objstorage-short-name }}](../../storage/) | {{ s3-storage-host }} |


### Object Storage. Access from {{ vpc-short-name }} {#private-endpoint-storage}

To allow access to {{ objstorage-short-name }} only from {{ vpc-short-name }} via a service connection, you must apply the following access policy to the bucket:

{% include [policy-scheme-json](../../_includes/vpc/policy-scheme-json.md) %}
