# Invoking a container

You can invoke a container:

* Over [HTTPS](#https).
* Using a [{{ sf-full-name }} trigger](../../functions/concepts/trigger/index.md).
* Using [{{ api-gw-full-name }} extensions](../../api-gateway/concepts/extensions/containers.md).

{% note info %}

If you want any user to be able to invoke a container without passing the authorization header, [make it public](./access-rights.md#public).

{% endnote %}

## HTTPS {#https}

After creating the container, you'll get the invocation link. Send an HTTPS request by passing an [IAM token](../../iam/concepts/authorization/iam-token.md) in the `Authorization` header:

```
curl -H "Authorization: Bearer $(yc iam create-token)" https://bba3fva6ka5g********.containers.yandexcloud.net/hello
```

### Getting an invocation link {#link}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), go to the folder where the container is located.
  1. Select **{{ serverless-containers-name }}**.
  1. Select the container. The invocation link is in the **Link to invoke** field.

- CLI

  To get an invocation link, run the command:

  ```
  yc serverless container get <container_name>
  ```

  Result:

  ```
  id: flh7r96juaqq********
  folder_id: aoek6qrs8tjh********
  created_at: "2021-08-17T07:53:10.219Z"
  name: my-beta-container
  description: my beta container description
  url: https://flh7r96juaqq********.containers.cloud-preprod.yandex.net/
  status: ACTIVE
  ```

  The invocation link is in the `url` field.

{% endlist %}

