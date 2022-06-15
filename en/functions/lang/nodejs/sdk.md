# Using the SDK for Node.js functions

To use [SDK (Software Development Kit)](https://ru.wikipedia.org/wiki/SDK) you need to add [dependency](dependencies.md) `@yandex-cloud/nodejs-sdk` to your Node.js application. You can find the library source code on [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

```
{
  "name": "my-awesome-package",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
      "@yandex-cloud/nodejs-sdk": "latest"
  }
}
```

[Software development kits (SDK)](https://en.wikipedia.org/wiki/SDK) let you interact with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the function. For example, you can get a list of available clouds (similar to the `yc resource-manager cloud list` command):

```js
import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

const { resourcemanager: { cloud_service: { ListCloudsRequest } } } = cloudApi;

export const handler = async function (event, context) {
    const session = new Session({ iamToken: context.token.access_token }); // iamToken is not required to be specified explicitly, it can be extracted automatically from metadata service
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
