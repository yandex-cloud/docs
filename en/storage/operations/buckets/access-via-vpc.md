---
title: Accessing a bucket using a service connection from {{ vpc-full-name }}
description: Follow this guide to set up access to a bucket using a service connection from {{ vpc-name }}.
---

# Accessing a bucket using a service connection from {{ vpc-full-name }}

{% include [vpc-pe-preview](../../../_includes/vpc/pe-preview.md) %}

{% include [intro-access-via-vpc](../../../_includes/storage/intro-access-via-vpc.md) %}

To enable access to a bucket using a service connection from {{ vpc-short-name }}:
1. [Create a {{ vpc-short-name }} service connection](#create-endpoint).
1. [Configure the access policy for the bucket](#setup-policy).

## Create a {{ vpc-short-name }} service connection {#create-endpoint}

{% include [private-endpoint-create-roles](../../../_includes/vpc/private-endpoint-create-roles.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../../_includes/vpc/private-endpoint-create-cli.md) %}

{% endlist %}

Save the service connection ID.

{{ objstorage-name }} buckets are now accessible via the {{ vpc-short-name }} internal IP address without any internet access.

## Configure the access policy for the bucket {#setup-policy}

To restrict access to a bucket to _{{ vpc-short-name }} internal IP addresses only_, assign a bucket policy for the service connection.

{% include [private-endpoint-policy-tabs](../../../_includes/storage/private-endpoint-policy-tabs.md) %}

#### See also {#see-also}

* [{{ vpc-short-name }} service connections](../../../vpc/concepts/private-endpoint.md)
* [Managing {{ vpc-short-name }} service connections](../../../vpc/operations/index.md#private-endpoint)
* [Bucket policy](../../../storage/concepts/policy.md)
* [Connecting to {{ objstorage-name }} from {{ vpc-name }}](../../../storage/tutorials/storage-vpc-access.md)
