# Using the SDK for a function in Node.js

To use the [SDK (Software Development Kit)](https://en.wikipedia.org/wiki/Software_development_kit), you need to add the `@yandex-cloud/nodejs-sdk` [dependency](dependencies.md) to the Node.js app. The library source code is available on [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

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

The SDK helps you manage {{ yandex-cloud }} resources using the [service account](../../operations/function-sa.md) specified in the function parameters. For example, you can get a list of available clouds:

```js
import { Session } from '@yandex-cloud/nodejs-sdk';
import { cloudService } from '@yandex-cloud/nodejs-sdk/resourcemanager-v1';

export const handler = async function (event, context) {
    const session = new Session({ iamToken: context.token.access_token }); // You do not need to specify the iamToken explicitly: it will be extracted automatically from metadata service
    const client = session.client(cloudService.CloudServiceClient);
    const response = await client.list(cloudService.ListCloudsRequest.fromPartial({}))

    return {
        statusCode: 200,
        body: {
            clouds: response.clouds,
        }
    };
};
```
