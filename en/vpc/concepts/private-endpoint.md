---
title: "Service connections in {{ vpc-full-name }}"
description: "In this tutorial, you will learn what service connections (Private Endpoints) are used in {{ vpc-full-name }}."
keywords:
  - service connection
  - private endpoint
  - private link
---

# Service connections in {{ vpc-full-name }}

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}

A **service connection** (Private Endpoint) provides direct IP connectivity between resources within {{ vpc-short-name }} and {{ yandex-cloud }} services that are hosted outside {{ vpc-short-name }}. 

In this case, direct IP connectivity refers to availability of such services [via {{ vpc-short-name }} internal IP addresses](./address.md#internal-addresses) without using [public IP addresses](address.md#public-addresses).

We can look at the [Object Storage](../../storage/) service as an example. 

## Service connection structure {#private-endpoint-architecture}

A service connection can be divided into two parts:

* The client part (Private Endpoint, PE) is responsible for presenting the service in {{ vpc-short-name }}. It is implemented within {{ vpc-short-name }}. This is a common part for all types of service connections.
* The service part (Provider) is responsible for interaction with the client part and is implemented on the service side. This part is unique for each service and service connection type.

A service connection has the following specifications:

* An IP address of a connection in {{ vpc-short-name }} from subnet CIDR ranges in the network you want to create a service connection for.
* Connection type: service to which the connection is made. For a list of available service connection types, see [below](#private-endpoint-types).

Once a `PE` is there, all the cloud resources that will be connected to subnets within the network where the service connection was created will have IP connectivity with it up to its internal IP address (1). You can use FQDN (2) or (3) to use the services if required. The A type DNS records (2) and (3) will be created in the [internal service zone](../../dns/concepts/dns-zone.md#service-zones).

Once a PE is created, all cloud resources connected to subnets in the service connection network will have IP connectivity with it up to its internal IP address (1).

To use the services, you can use either a fully qualified domain name (FQDN) (2) or its part (3). The A type DNS records (2) and (3) will be created in the internal service zone.

When creating a service connection in {{ vpc-short-name }}, the following objects are created:

1. **Internal IP address** to which the created connection is bound.
1. **A type DNS record** with a special FQDN for the new service connection, e.g., `storage.pe.yandexcloud.net`, which will specify the internal IP address allocated for the service connection.
1. Optional. If required, an additional A type DNS record can be created for the public FQDN service. It will also include the internal IP address allocated for the service connection.

Once you create a service connection, all cloud resources that will be added to subnets on the network with this connection will be linked to it through the internal IP address (1). You can also use a fully qualified domain name (FQDN) (2) or (3) for the services.

To use service connections outside the cloud infrastructure, you need to provide IP connectivity between your infrastructure and {{ yandex-cloud }} using VPN technologies (IPsec, Wireguard, etc.) or [Cloud Interconnect](../../interconnect/) services.

{% note info %}

If you need to access the service connection via FQDN from outside {{ yandex-cloud }}, you must configure the relevant A records on the corporate DNS server so that the FQDN of the service points to the IP address of the connection.

{% endnote %}

## Service connection types {#private-endpoint-types}

| Service name (Connection type) | API service FQDN |
| --- | --- |
| [{{ objstorage-short-name }}](../../storage/) | {{ s3-storage-host }} |


### Object Storage. Access from {{ vpc-short-name }} {#private-endpoint-storage}

To allow access to {{ objstorage-short-name }} only from {{ vpc-short-name }} via a service connection, you must apply the following access policy to the bucket:

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "*",
    "Resource": [
      "arn:aws:s3:::<bucket-name>/*",
      "arn:aws:s3:::<bucket-name>"
    ],
    "Condition": {
      "StringEquals": {
        "yc:private-endpoint-id": "<pe-id>"
      }
    }
  }
}
```

where:

* `<bucket-name>`: Bucket name, e.g., `my-bucket`.
* `<pe-id>`: Service connection ID, e.g., `c23ngt5jy**********`.

