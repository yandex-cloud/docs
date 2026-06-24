---
title: Service connections in {{ vpc-full-name }}
description: In this tutorial, you will learn what service connections (Private Endpoints) are used in {{ vpc-full-name }}.
keywords:
  - service connection
  - private endpoint
  - private link
---

# Service connections in {{ vpc-full-name }}


**Service connection** (VPC private endpoint) enables cloud resources within {{ vpc-short-name }} to connect to {{ yandex-cloud }} services over the internal network without using [public IP addresses](address.md#public-addresses).

{{ yandex-cloud }} services remain accessible via both public IPs and service connections. 

Service connections are regional and distributed across availability zones. If there is a failure in one zone, traffic is automatically rerouted to other zones.

Bandwidth for an individual service connection is not guaranteed and depends on the current workload on the target service. For stable operation, monitor usage via [monitoring](../metrics.md) and adhere to [limits in place](./limits.md#vpc-limits).

A service connection can be divided into two parts:

* A **private endpoint** (PE) represents (connects) the target service within {{ vpc-short-name }}. It is implemented within {{ vpc-short-name }}. This is a common part for all types of service connections.
* **Provider** stands for integration implemented on the target service side to interact with the private endpoint.

## How to use service connections {#pe-notes1}

Within a single [virtual network](./network.md#network), you can create service connections of [different types](#pe-services), but only one connection per type. Creating two or more connections of the same type is not allowed.

The private endpoint is assigned an IP address from the subnets' CIDR ranges in the {{ vpc-short-name }} network where the service connection is being created. Once you service connection is created, all cloud resources in that network gain IP connectivity to the target service.

Upon creation, every private endpoint automatically gets a **PE record**, which is an A-type DNS record with a special FQDN for that service connection. For example, for [{{ objstorage-short-name }}](../../storage/), the PE record would be `storage.pe.yandexcloud.net`.

Optionally, you can also create a **Primary record**, i.e., an A-type DNS record for the service's public FQDN. It will also include the internal IP address allocated for the service connection. This is defined by the `private-dns-records-enabled` parameter. For [{{ objstorage-short-name }}](../../storage/), the Primary record would be `storage.yandexcloud.net`.

These A-type DNS records are created in the [internal service zone](../../dns/concepts/dns-zone.md#service-zones).

When using [{{ interconnect-name }}](../../interconnect/), the service connection is accessible via [private connections](../../interconnect/concepts/priv-con.md), just like other {{ vpc-short-name }} resources. To access the service connection via FQDN from outside {{ yandex-cloud }}, configure A-type records on your corporate DNS server so that the service's FQDN resolves to the corresponding service connection IP address.

## Service connection types {#pe-services}

Currently, you can create service connections for the following cloud services:

| **Service name** | **Creation method** | **PE record** | **Primary record** |
| --- | --- | --- | --- |
| [{{ objstorage-short-name }}](../../storage/) | [UI, CLI, {{ TF }}](../operations/private-endpoint-create.md) | `storage.pe.yandexcloud.net` | `storage.yandexcloud.net` |
| [{{ cloud-registry-name }}](../../cloud-registry) | [Contacting support](../operations/private-endpoint-create-support.md) | `registry.pe.yandexcloud.net` | `registry.yandexcloud.net` |
| [{{ ai-studio-name }}](../../ai-studio/concepts/) | [Contacting support](../operations/private-endpoint-create-support.md) | `ai.pe.api.cloud.yandex.net` | `ai.api.cloud.yandex.net` |
| [{{ mtr-name }}](../../managed-trino) | [Contacting support](../operations/private-endpoint-create-support.md) | `trino.pe.yandexcloud.net`, `*.trino.pe.yandexcloud.net` | - |
| [{{ serverless-containers-name }}](../../serverless-containers) |  [Contacting support](../operations/private-endpoint-create-support.md) | `*.containers.pe.yandexcloud.net` | `*.containers.yandexcloud.net` |
| [{{ sf-name }}](../../functions) | [Contacting support](../operations/private-endpoint-create-support.md) | `functions.pe.yandexcloud.net` | `functions.yandexcloud.net` |
| Public API Gateway | [Contacting support](../operations/private-endpoint-create-support.md) | `-` | `*.api.cloud.yandex.net` |
| [AI Studio MCP Gateway](https://aistudio.yandex.ru/docs/ai-studio/mcp-gateway/api-ref/) |  [Contacting support](../operations/private-endpoint-create-support.md) | `*.mcpgw.serverless.pe.yandexcloud.net` | `*.mcpgw.serverless.yandexcloud.net` |

## How to use certain types of service connections {#pe-notes2}

### {{ objstorage-name }} {#pe-s3}

#### Bucket policies

To allow access to {{ objstorage-short-name }} only from {{ vpc-short-name }} via a service connection, you must apply the following access policy to the bucket:

{% include [policy-scheme-json](../../_includes/vpc/policy-scheme-json.md) %}

### {{ cloud-registry-name }} {#pe-cr}

Before creating a service connection for {{ cloud-registry-name }}, you must first create a service connection for {{ objstorage-name }}.

### Public API Gateway {#pe-pubapi}

This PE type currently has the following limitations:
1. PE-record-only access is not supported. When creating this PE type, you must always ensure Primary record creation.
1. The following services are not supported when accessed via PE:
   * [Certificate Manager](../../certificate-manager/)
   * [Lockbox](../../lockbox/)
   * [Cloud Backup](../../backup/)
   * [Object Storage S3 API](../../storage/s3/)


## Examples of connecting to services without a VPC PE {#no-pe-examples}

* [{#T}](../tutorials/storage-vpc-access.md)
* [{#T}](../tutorials/vpc-cr-access.md)

