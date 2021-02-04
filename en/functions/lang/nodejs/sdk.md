# Using the SDK

The runtime environment has a pre-installed library that lets you access the [{{ yandex-cloud }} API](../../../api-design-guide/). To use it, you don't need to add [dependencies](dependencies.md) to your application, except when a library version other than that of the pre-installed one is required. You can find the library source code on [GitHub](https://github.com/yandex-cloud/nodejs-sdk).

[Software development kits (SDK)](https://en.wikipedia.org/wiki/SDK) let you interact with {{ yandex-cloud }} services using the [service account](../../operations/function-sa.md) specified in the function. For example, you can get a list of available clouds (similar to the `yc resource-manager cloud list` command):

```js
const {CloudService} = require("yandex-cloud/api/resourcemanager/v1");

module.exports.handler = async function (event, context) {
    const cloudService = new CloudService();
    const clouds = await cloudService.list({});

    return {
        clouds,
    };
};
```

To make local debugging easier and reduce the volume of the function code to upload, add the `yandex-cloud` package to the `package.json` file in the `devDependencies` section:

```json
{
  "name": "my-app",
  "version": "1.0.0",
  "devDependencies": {
    "yandex-cloud": "^1.4"
  }
}
```

