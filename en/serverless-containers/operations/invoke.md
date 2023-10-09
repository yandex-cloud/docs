# Invoking a container

You can invoke a container:
* Over [HTTPS](#https).
* Using a [trigger](../concepts/trigger/index.md).
* Using a [{{ api-gw-full-name }} extension](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

If you want any user to be able to invoke a container without providing the authorization header, [make it public](./container-public.md).

{% endnote %}

## HTTPS {#https}

After creating the container, you will get the invocation link. Make an HTTPS request by sending an [IAM token](../../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.{{ serverless-containers-host }}/hello
```
