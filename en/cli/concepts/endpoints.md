---
title: Connecting {{ yandex-cloud }} CLI to endpoints
description: In this article, you will learn which endpoints the {{ yandex-cloud }} CLI connects to and how to check a connection.
---

# Connecting the CLI to {{ yandex-cloud }} endpoints

An _endpoint_ is the address the CLI uses to communicate with the API of a specific {{ yandex-cloud }} service. The endpoints you use depend on the command you run.

As soon as you run `yc init`, the CLI connects to the regional `https://{{ api-host }}` endpoint to fetch the current list of endpoints used by the services. Then, the CLI contacts endpoints used for authentication and profile configuration. After the initialization, the CLI selects an endpoint based on which service the command belongs to.

To retrieve the complete list of available {{ yandex-cloud }} endpoints and ports, run the following request:

```bash
curl https://{{ api-host }}/endpoints
```

The response contains the IDs of services and their endpoint addresses:

```json
{
  "endpoints": [
    {
      "id": "<service_ID>",
      "address": "<endpoint_address>:<port>"
    }
  ]
}
```

{% note tip %}

Do not use a static copy of this list because its data may change as new services and endpoints get added. For details on the response format, see [{#T}](../../api-design-guide/concepts/endpoints.md).

{% endnote %}

## Access through a firewall or proxy server {#network-access}

If outgoing connections are restricted by a firewall, allow access to `{{ api-host }}` and the endpoints of the services you are expecting to use. Use the ports specified in the response to `https://{{ api-host }}/endpoints`.

Authentication via a browser will also require the user to have access to `https://{{ auth-main-host }}` and identity provider domains.

If {{ yandex-cloud }} is accessed through a proxy server, [configure the HTTPS_PROXY environment variable](index.md#cli-via-proxy).

## Checking connections {#check-connections}

To look up the endpoints `yc init` connects to, enable detailed gRPC logging:


```bash
yc init --debug-grpc
```



Connection addresses are logged in the lines labeled `original dial target` and `Dialing`. A successful connection is logged as `successfully connected`.

The `--debug-grpc` parameter outputs detailed information about gRPC connections. To view the general command execution log, use the `--debug` parameter. For more on these parameters, see [{#T}](./core-properties.md).

{% note warning %}

The debug log may contain data pertaining to requests. Do not share them with other users until you remove tokens and other sensitive information.

{% endnote %}

#### Useful links {#see-also}

[{#T}](../../api-design-guide/concepts/endpoints.md)
