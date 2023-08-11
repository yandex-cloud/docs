# General procedure for activation

To send requests to the Yandex search database using {{ search-api-full-name }}, you need a [service account](../../iam/concepts/users/service-accounts.md).

## Getting started {#before-you-begin}

{% include [before-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Prepare a service account {#prepare-sa}

### Create a service account {#create-sa}

{% include [create-sa](../../_includes/iam/create-sa-via-console.md) %}

### Assign the required role {#grant-role}

For your service account to send requests, it needs a [role](../../iam/concepts/access-control/roles.md) that allows using {{ search-api-name }}. Assign the service account the `{{ roles-search-api-executor }}` role:

{% include [create-sa](../../_includes/grant-role-console-sa.md) %}

### Create an API key {#create-api-key}

For {{ search-api }} authentication, the service account needs an [API key](../../iam/concepts/authorization/api-key.md). Create an API key for your service account:

{% include [create-console](../../_includes/iam/create-api-key-console.md) %}

To enable {{ search-api }} and use it, follow these steps:

## Registration {#registration}

{% include [registration](../../_includes/search-api/registration.md) %}

## Create a test request {#test-request}

{% include [test-request](../../_includes/search-api/test-request.md) %}


## Set up integration with {{ search-api }} {#results}

1. Learn about the specifics of [authentication](../operations/auth.md) in {{ yandex-cloud }} and set up request sending.
1. Set up response handling depending on [response format](../concepts/response.md).
1. If necessary, [request](../concepts/limits.md) information about hourly limits for the next day.