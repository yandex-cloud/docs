---
title: '{{ sf-full-name }}. FAQ'
description: How do I get my activity logs in {{ sf-full-name }}? Find answers to this and other questions in this article.
---

# General questions about {{ sf-name }}

{% include [logs](../../_qa/logs.md) %}

#### How do I upload a ZIP archive with source code to update a serverless function via CLI? {#version-create}

To create a [function](../concepts/function.md) version from a ZIP file, run this command:

```bash
yc serverless function version create --source-path
```

For more details on uploading code, see [this guide](../../functions/operations/function/version-manage.md).

#### How large can a source code archive be when uploading to {{ sf-name }}? {#file-size}

You can upload a file up to 3.5 MB directly. To [upload  larger files, use {{ objstorage-full-name }}](../../storage/operations/objects/upload.md). For more information, see [this guide](../../functions/operations/function/version-manage.md).

#### I am not the cloud owner, but I was granted access. What permissions/roles do I need to publish a function? {#roles}

To manage function access, you need the `{{ roles-admin }}` or `{{ roles-cloud-owner }}` role. For more information, see [this guide](../security/index.md).

#### How do I access an environment variable in a Node.js function? {#env}

To access environment variables, use the `process.env` global variable. For more information, see [this guide](https://nodejs.org/dist/latest-v8.x/docs/api/process.html#process_process_env).

#### Which Python modules can I use when working with {{ sf-name }}? How do I add new modules? {#python}

You can upload modules in a ZIP archive up to 3.5 MB. To [upload larger files, use {{ objstorage-name }}](../../storage/operations/objects/upload.md). For more information, see [this guide](../quickstart/create-function/python-function-quickstart.md).

#### Calling {{ sf-name }} for Alice skills is free. If I call another of my {{ sf-name }} from a skill function, will that also be free? {#alice-pricing}

Such calls will be subject to fees according to [{#T}](../pricing.md).

#### I want to increase my quotas. How do I determine appropriate values for them? {#quotas}

For more on which quotas to increase and to what extent, see [{#T}](../concepts/limits.md#related-quotas).

{% include [api-duration-format-qa](../../_qa/serverless/api-duration-format-qa.md) %}

#### How do I connect to a managed database from a function? {#connect-to-mdb}

By default, {{ sf-name }} run in isolated IPv4 networks with the [NAT gateway](../../vpc/concepts/gateways.md) enabled.

To connect to a cluster, specify the ID of the cloud network containing the cluster in the function properties. The function will then have access to the internet and user resources in the specified network, including virtual machines. For more on how to connect a function to a cloud network, see [{#T}](../concepts/networking.md).

You can also connect to a database over the internet. Do it by enabling public access to the cluster and setting up an encrypted connection, which is a requirement for access to a database over the internet as per PCI DSS. For an example of connecting to a {{ mmy-name }} cluster, see [{#T}](../../managed-mysql/operations/connect/index.md).

#### Can I assign a static IP address to a function? {#static-ip-address}

No, you cannot assign a static IP address to a function in {{ sf-name }}. The function can run on resources with different IP addresses.

Alternatively, create a {{ compute-full-name }} [virtual machine](../../compute/operations/vm-create/create-linux-vm.md), [assign a static public IP address to it](../../vpc/operations/get-static-ip.md), install the target programming language runtime, and run the code on that VM.

{% note info %}

You can also use an API gateway to call the function via a custom domain.

* [Associating a domain with an API gateway](../../api-gateway/operations/api-gw-domains.md).
* [Configuring a function call](../../api-gateway/concepts/extensions/cloud-functions.md).

{% endnote %}

#### Why do I get a CORS error when trying to access the {{ speechkit-short-name }}, {{ vision-short-name }}, or {{ translate-short-name }} API? {#cors-error}

When calling an API from the web application frontend, you may get the following error:

```text
Access to XMLHttpRequest at '<https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze>'
from origin '...' has been blocked by CORS policy: Response to preflight request doesn't
pass access control check: No 'Access-Control-Allow-Origin'
```

The web application frontend cannot access the APIs of these services directly. AI services do not support cross-domain requests because their APIs do not respond to the `OPTIONS` requests.

To send requests to APIs, [create a function in {{ sf-name }}](../operations/function/function-create.md) and add a handler that will forward requests to {{ speechkit-short-name }}, {{ vision-short-name }}, or {{ translate-short-name }}.

#### Why do I get an `No node can serve the request: Concurrent requests exceeded` error? {#concurrent-requests-exceeded}

When calling a function, the code is not run and the following message gets logged:

```text
429 Message: No node can serve the request: Concurrent requests exceeded
```

The error occurs when you exceed one or more of the following quotas:

* Number of concurrent operations on all functions and their versions per cloud.
* Number of concurrent operations on a single function and its versions.
* Number of concurrent calls for all functions per availability zone.

Check your [current quota consumption]({{ link-console-quotas }}) and request an increase as needed.

#### Why do I see an HTTP 499 error in the function logs? {#error-499}

Your {{ sf-name }} function may log the following message: `Error: Code 499 Message: request cancelled`.

This error means that the client terminated the connection before the function finished processing the request. For example, if the code takes 10 seconds to be executed, but the client spends only 5 seconds to wait for the response, the client will close the connection after 5 seconds and log an HTTP 499 error.

To fix this error:

* Increase the client-side response timeout.
* If you cannot change the client-side timeout, break the long job down into several functions started by timer.

If the error persists, add logging to the code and analyze the logs:

* [Function execution logging in Python](../lang/python/logging.md)
* [Logging to the function execution log](../operations/function/logs-write.md)

#### Why do I get an `No node can serve the request: Too many reschedules` error? {#too-many-reschedules}

When calling a function, the code is not run and the following message gets logged:

```text
Code: 429 Message: No node can serve the request: Too many reschedules
```

The error may occur if a function fails to respond to an HTTP request and terminates. The request is scheduled for a retry, but subsequent attempts fail again causing the call to loop.

To fix the error, bring the function code in line with the [runtime requirements](../concepts/runtime/index.md).

#### How do I add an intermediate CA certificate to a function if TLS verification fails with the `unable to get local issuer certificate` error?

The `certificate verify failed: unable to get local issuer certificate` error usually means that the server the function connects to returns only the end-entity certificate, without the intermediate one. The root certificate that ultimately signs the certificate chain may be available in the [system trust store](../concepts/runtime/environment-variables.md#trusted-certificates), but the client cannot build the chain to the root without the intermediate certificate. This may happen when a new CA reissues the certificate but the server still uses the old intermediate certificate, or when the configuration specifies `cert.pem` instead of `fullchain.pem`.

Here’s what you can do:

1. If it is your server, configure it to return the full certificate chain (`fullchain.pem`). With that done, the verification will succeed without any changes to the function code.

1. If it is a third-party server, add an intermediate certificate on the function side. Do it by adding the intermediate certificate file to the function code and providing it to the HTTP client together with the system certificate bundle. Path to the system certificate bundle in the runtime: `/etc/ssl/certs/ca-certificates.crt`.

   Examples for Python:

   * `requests`: Merge the system bundle (`certifi.where()`) and your certificate into a single file and provide it in the `verify="/path/to/bundle.crt"` parameter. Alternatively, set the `REQUESTS_CA_BUNDLE` [environment variable](../operations/function/environment-variables-add.md) for the function version.

   * `httpx`:

     ```python
     import httpx
     client = httpx.Client(verify="/path/to/bundle.crt")
     ```

   * `aiohttp` or standard `ssl` module:

     ```python
     import ssl
     ctx = ssl.create_default_context(cafile="/etc/ssl/certs/ca-certificates.crt")
     ctx.load_verify_locations("/path/to/intermediate.crt")
     ```

   Use a similar approach for other programming languages: provide the path to the additional certificate via the HTTP client or TLS context parameters and extend the system bundle instead of replacing it.

Please note:

* Do not provide your certificate in the `verify` parameter without first gluing it together with the system bundle; otherwise, it will disrupt trust verification for all other hosts.
* You cannot write the certificate directly into `/etc/ssl/certs/ca-certificates.crt` file inside the function. Connect the certificate via the client parameters as shown above.
