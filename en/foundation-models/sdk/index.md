# {{ ml-sdk-full-name }}

{{ ai-studio-full-name }} provides {{ ml-sdk-full-name }}, a library of tools and code examples for Python development. {{ ml-sdk-name }} provides a standardized method of working with foundation models and simplifies integration with other {{ yandex-cloud }} services.

The {{ ml-sdk-name }} library implements the synchronous and asynchronous Python interfaces based on gRPC API calls of {{ ai-studio-name }} services. {{ ml-sdk-name }} offers the following features:
* [Text generation](../concepts/yandexgpt/index.md) by {{ yagpt-name }}
* Working with [embeddings](../concepts/embeddings.md)
* Working with [{{ yagpt-name }} based classifiers](../concepts/classifier/index.md)
* Creating [AI assistants](../concepts/assistant/index.md)
* [Image generation](../concepts/yandexart/index.md) by {{ yandexart-name }}
* Integration with [LangChain](https://www.langchain.com/)

You can see the full list of supported functions, library source code, and use cases on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk).

## Installation and usage {#install}

You can install the {{ ml-sdk-name }} library using the [pip](https://pip.pypa.io/en/stable/) package manager:

```bash
pip install yandex-cloud-ml-sdk
```

When initializing the library, you need to specify the [ID of the folder](../../resource-manager/operations/folder/get-id.md) you will use to work with models as well as authentication credentials. {{ ml-sdk-name }} supports the following authentication methods:
* [IAM token](../../iam/operations/iam-token/create.md)
* [API key](../../iam/operations/api-key/create.md) 
* [OAuth token](../../iam/concepts/authorization/oauth-token.md)

The example below will prompt {{ gpt-pro }} with "What is sky?".

```python
from yandex_cloud_ml_sdk import YCloudML

sdk = YCloudML(folder_id="<folder_ID>", auth="<token>")

model = sdk.models.completions('yandexgpt')
model = model.configure(temperature=0.5)
result = model.run("What is sky?")

for alternative in result:
    print(alternative)
```