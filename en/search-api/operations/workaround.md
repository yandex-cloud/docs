---
title: '{{ search-api-full-name }} general connection procedure for API v1'
description: Follow this guide to connect to {{ search-api-name }} to use it via API v1.
---

# General connection procedure

To submit queries to the Yandex search database using {{ search-api-full-name }} via API v1, configure a [service account](../../iam/concepts/users/service-accounts.md). 

Follow these steps to set up {{ search-api }} to operate via API v1:

1. [Get your cloud ready](#before-you-begin).
1. [Prepare a service account](#prepare-sa).
1. [Sign up to {{ search-api-name }}](#registration).
1. [Create a test request](#test-request).
1. [Set up integration with {{ search-api }}](#results).


## Get your cloud ready {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare a service account {#prepare-sa}

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-sa](../../_includes/iam/create-sa-via-console-without-role.md) %}

{% endlist %}

### Assign a role {#grant-role}

[Assign](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) to the service account the `{{ roles-search-api-executor }}` [role](../security/index.md#search-api-executor) it needs to query {{ search-api-name }} via API v1.

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-sa](../../_includes/grant-role-console-sa.md) %}

{% endlist %}

### Create an API key {#create-api-key}

The service account will need a {{ search-api }} [API key](../../iam/concepts/authorization/api-key.md) for [authentication](./auth.md) in API v1. Create an API key for the service account:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-console](../../_includes/iam/create-api-key-console.md) %}  

{% endlist %}

## Sign up to {{ search-api-name }} {#registration}

To use the API v1 interface, you must register in {{ search-api-name }}:

{% include [registration](../../_includes/search-api/registration.md) %}

## Create a test request {#test-request}

{% include [test-request](../../_includes/search-api/test-request.md) %}


## Set up integration with {{ search-api }} {#results}

1. Learn about [authentication](./auth.md) in API v1 and configure querying.
1. Configure response handling based on the response format in [XML](../concepts/response.md) or [HTML](../concepts/html-response.md).
1. If necessary, [request](../concepts/limits.md) information about hourly limits for the next 24 hours.