# Invoking a container in {{ serverless-containers-name }}

You can invoke a container:
* Using [HTTPS](#https).
* Using a [trigger](#trigger).
* Using a [{{ api-gw-full-name }} extension](#extension).

{% include [port-variable-note.md](../../_includes/serverless-containers/port-variable-note.md) %}

## HTTPS {#https}

When calling a container over HTTPS, an HTTP request is passed to the application deployed in the container.

### Filtering message headers {#filter}

When being passed to the container, some HTTP request and response headers change, as described below.

{% list tabs %}

- Request headers

   Removed from a request:

   - "Expect"
   - "Te"
   - "Trailer"
   - "Upgrade"
   - "Proxy-Authenticate"
   - "Authorization"
   - "Connection"
   - "Content-Md5"
   - "Max-Forwards"
   - "Server"
   - "Transfer-Encoding"
   - "Www-Authenticate"
   - "Cookie"

- Response headers

   - Removed from a response:
      - "Host"
      - "Authorization"
      - "User-Agent"
      - "Connection"
      - "Max-Forwards"
      - "Cookie"

   - Cause an error if present in a response:

      - "Proxy-Authenticate"
      - "Transfer-Encoding"
      - "Via"

   - Overwritten by adding the `X-Yf-Remapped-` prefix:
      - "Content-Md5"
      - "Date"
      - "Server"
      - "Www-Authenticate"

{% endlist %}

### IP address of the request source {#ip}

If a request contains the [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) header, the specified IP addresses and the IP address of the client that invoked the container are passed in this header. If not, it only passes the IP address of the client that invoked the container.

## Triggers {#trigger}

When invoking a container using a trigger, the JSON description of a trigger event is passed in the body of an HTTP request to the container. The request source IP is passed in the same way as when [invoking a container using HTTPS](#ip). Learn more about [triggers](trigger/index.md).

## {{ api-gw-full-name }} extension {#extension}

When invoking a container using the {{ api-gw-name }}, the container receives an HTTP request addressed to the API gateway. In this case, the `Host` header specifies the host on which the user accessed the API gateway rather than the container's host. The request source IP is passed in the same way as when [invoking a container using HTTPS](#ip). Learn more about the extension in the [{{ api-gw-full-name }} documentation](../../api-gateway/concepts/extensions/containers.md).
