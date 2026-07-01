---
title: How to invoke a container in {{ serverless-containers-full-name }}
description: Follow this guide to invoke a container.
---

# Invoking a container

You can invoke a container:
* Over [HTTPS](#https).
* Using a [trigger](../concepts/trigger/index.md).
* Using the [{{ api-gw-full-name }} extension](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

To allow any user to invoke a container without providing an authorization header, [make the container public](./container-public.md).

{% endnote %}

## HTTPS {#https}

After creating the container, you will get an invocation link. Make an HTTPS request by providing an [IAM token](../../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```bash
curl \
  --header "Authorization: Bearer $(yc iam create-token)" \
  https://bba3fva6ka5g********.{{ serverless-containers-host }}/hello
```

{% include [call-limited-by-access-policies-notice](../../_includes/serverless-containers/call-limited-by-access-policies-notice.md) %}