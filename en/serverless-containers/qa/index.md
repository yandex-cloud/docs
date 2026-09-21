---
title: '{{ serverless-containers-full-name }}. FAQ'
description: How do I get my activity logs in {{ serverless-containers-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ serverless-containers-name }}

{% include [logs](../../_qa/logs.md) %}

{% include [api-duration-format-qa](../../_qa/serverless/api-duration-format-qa.md) %}

#### Why do I get a `Code 502 Message Error during function invocation` error after migrating an application to {{ serverless-containers-name }}? {#error-502-message-error}

You may get a 502 error when the code inside your container makes an HTTP request that fails with an error.

[View](../operations/logs.md) the container execution log. It may include the full error text mentioning the failing HTTP request. If you cannot find helpful data in the log, [configure](../operations/logs-write.md#structured-logs) structured logging for your containerized application.

{% note info %}

When invoking a container over HTTPS, some request and response HTTP headers may change (see [{#T}](../concepts/invoke.md#filter) for details). Take this into account when migrating your application to {{ serverless-containers-name }}.



{% endnote %}

#### Why do I get a `user container exec format error` error when trying to invoke a container in {{ serverless-containers-name }}? {#error-user-container-exec-format-error}

The issue occurs due to an incompatible [runtime environment](../concepts/runtime.md). 

Rebuild the container for the `--platform=linux/amd64` architecture.

#### How do I fix an out-of-space error? {#error-no-space-left}

{% cut "Example error messages" %}

```
zip I/O error: No space left on device
zip error: Output file write failure (write error on zip file)
```

```
===> executing build script
===> will start 'pip3.** install' in /function/code
...
ERROR: Could not install packages due to an OSError: [Errno 28] No space left on device
```

{% endcut %}

{{ serverless-containers-name }} has [limits](../concepts/limits.md#serverless-containers-limits) on the maximum storage capacity. Limits are technical constraints of the {{ yandex-cloud }} architecture. You cannot change the limits.

If your application requires more space, create a [{{ compute-name }}](/ru/services/compute) VM instance and use it to deploy the application.

#### How do I assign a static IP address to a container? {#how-to-link-static-ip}

You cannot assign a static IP address to a container because the container may run on resources with different addresses.

If your use case strictly requires a static IP address, [create](../../compute/operations/vm-create/create-linux-vm.md) a [{{ compute-name }}](/ru/services/compute) VM instance, [make its public IP address static](../../vpc/operations/set-static-ip.md), and install the runtime environment for your programming language. Then use that VM to run your code.

{% note info %}

You can also use an API gateway to invoke the container using a custom domain. For more information, see the following:

* [Connecting a domain to an API gateway](../../api-gateway/operations/api-gw-domains.md)
* [Calling a container via an API gateway](../../api-gateway/concepts/extensions/containers.md)

{% endnote %}

#### Why do I get a `Permission denied` error with status code `403` when trying to create a container revision? {#error-permission-denied}

{% cut "Example error messages" %}

```
url: https://console.yandex.cloud/folders/b1g*****************/functions/create-trigger; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```
url: https://console.yandex.cloud/folders/b1g*****************//serverless-containers/containers/bba*****************/editor; 
message: Authentication problem: permission denied; 
status: 403; description: Authentication problem: permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

```
url: https://console.yandex.cloud/folders/b1g*****************/api-gateway/create; 
message: Permission denied; status: 403; 
description: Permission denied; code: GATEWAY_REQUEST_ERROR; 
Request ID: ********-****-****-****-************; Trace ID: ****************;
```

{% endcut %}

1. Check user roles. Make sure the service account has a role for the folder or cloud that allows creating resources, such as `{{ roles-editor }}` or higher.
1. Check the cloud status. The cloud status must be `ACTIVE`.
    * If the cloud is `PENDING_DELETION`, you cannot modify its resources. Try to [cancel the pending cloud deletion](../../resource-manager/operations/cloud/delete.md#cancel-delete).
    * If the cloud is suspended, e.g., due to arrears, you resolve the issue causing the suspension.

In most cases, the error occurs because the service account used by the resource lacks permissions to interact with other services. For example, if you see the `Error PERMISSION_DENIED in client lockbox` error, the service account does not have the roles to access {{ lockbox-full-name }} secrets.

If the error occurs when working with a mounted bucket, make sure the service account has the `storage.viewer` role to read bucket data or the `storage.uploader` role to read and write data to the bucket.

If you get this error when working with triggers, make sure the service account associated with the function, container, or trigger has the required roles:

* `{{ roles-functions-invoker }}` to invoke the function, or `{{ roles-serverless-containers-invoker }}` to invoke the container.
* Additional roles for triggers:
    * Trigger for {{ message-queue-short-name }}: `ymq.reader` for the folder hosting the message queue.
    * Trigger for {{ container-registry-short-name }}: `{{ roles-cr-puller }}` to pull Docker images.
    * Trigger for {{ cloud-logging-name }}: `{{ roles-logging-reader }}` for the log group.
    * Trigger for {{ yds-name }}: `yds.editor` for the data stream.
    * Email trigger: `storage.uploader` for the bucket storing email attachments.
    * Dead-letter queue: `ymq.writer` role for the DLQ to write unprocessed messages. This is optional.

{% note info %}

A common pitfall causing this error is assigning a role for the service account as a resource. A role like this does not provide access to other folder resources. To resolve this, assign the role to the service account for a folder or a specific resource.

{% endnote %}
