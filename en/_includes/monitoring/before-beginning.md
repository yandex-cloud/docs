### Before getting started {#before-you-begin}

To try the examples in this section:

1. Make sure you have installed the [cURL](https://curl.haxx.se) utility that is used in the examples.
1. [Get the ID of the folder](../../resource-manager/operations/folder/get-id.md) you are granted the `{{ roles-monitoring-viewer }}` role or higher of.
1. Get an IAM token:
   {% if product == "yandex-cloud" %}* [Instructions](../../iam/operations/iam-token/create.md) for users with a Yandex account.{% endif %}
   * [Instructions](../../iam/operations/iam-token/create-for-sa.md) for a service account.
   * [Instructions](../../iam/operations/iam-token/create-for-federation.md) for a federated account.