# Fixing the `Code 502 Message Error during function invocation` error


## Issue description {#issue-description}

You used to run your application in a CRI-compatible environment within a container on a VM or a physical server. After you migrated the application to {{ serverless-containers-name }}, you get the `502 Message Error during function invocation` error when invoking it.

## Solution {#issue-resolution}

You may get error 502 when the code running in the container makes an HTTP request that terminates with an error.

Check your container operating log. It may include the full error text mentioning the request in question. If you are unable to find any useful data in your container log, enable [detailed logging](../../../serverless-containers/concepts/logs.md) for your containerized application.

{% note alert %}

When calling a container over HTTPS, certain HTTP headers in the request and response are changed (see [this article](../../../serverless-containers/concepts/invoke.md#filter) for details).

You need to consider these changes when migrating your application to the {{ serverless-containers-name }} environment.

{% endnote %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. Container ID.
1. Date and time of your container call that terminated with an error.
1. Description of the container call: whether the container is called from the third-party application code over the {{ serverless-containers-name }} API or directly, from the [management console]({{ link-console-main }}) or YC CLI.
1. Full text of the error from the {{ serverless-containers-name }} container log.
