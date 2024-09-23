# Using the SDK for Node.js functions

To use the [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit), you have to add the [dependency](dependencies.md) `@yandex-cloud/nodejs-sdk` to the Node.js application. The library source code is available on [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

```json
{
  "name": "my-awesome-package",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
      "@yandex-cloud/nodejs-sdk": "latest"
  }
}
```

The SDK (Software Development Kit) helps you manage {{ yandex-cloud }} resources on behalf of the [service account](../../operations/function-sa.md) specified in the function parameters. For example, you can retrieve a list of available clouds:

```js
import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

const { resourcemanager: { cloud_service: { ListCloudsRequest } } } = cloudApi;

export const handler = async function (event, context) {
    const session = new Session({ iamToken: context.token.access_token }); // You do not need to specify the iamToken explicitly: it will be extracted automatically from metadata service
    const client = session.client(serviceClients.CloudServiceClient);
    const response = await client.list(ListCloudsRequest.fromPartial({ pageSize: 200 }))

    return {
        statusCode: 200,
        body: {
            clouds: response.clouds,
        }
    };
};
```
