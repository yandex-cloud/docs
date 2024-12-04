# Creating a simple assistant

This example shows how to create an [assistant](../../concepts/assistant/index.md) to store your conversations with {{ gpt-pro }} RC.

{% list tabs group=instructions %}

- SDK {#sdk}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) to it the `ai.assistants.editor` and `ai.languageModels.user` roles.
  1. [Get](../../../iam/operations/api-key/create.md) an API key for the service account and save it.
  1. You can install the {{ ml-sdk-name }} library using the [pip](https://pip.pypa.io/en/stable/) package manager:

     ```bash
     pip install yandex-cloud-ml-sdk
     ```

  1. Create a file named `simple-assistant.py` and add the following code to it:

     {% include [simple-assistant](../../../_includes/foundation-models/examples/simple-assistant.md) %}

  1. Run the created file:

     ```bash
     python3 simple-assistant.py
     ```

{% endlist %}

#### See also {#see-also}

* [{#T}](./create-with-searchindex.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/assistants) 