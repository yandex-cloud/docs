# {{ ml-sdk-full-name }}

{{ ai-studio-full-name }} provides {{ ml-sdk-full-name }}, a library of tools and code examples for Python development. {{ ml-sdk-name }} employs a standardized method of working with foundation models and simplifies integration with other {{ yandex-cloud }} services.

The {{ ml-sdk-name }} library implements the synchronous and asynchronous Python interfaces based on gRPC API calls of {{ ai-studio-name }} services. {{ ml-sdk-name }} offers the following features:
* [Text generation](../concepts/generation/index.md) based on any supported [model](../concepts/generation/models.md).
* Working with [embeddings](../concepts/embeddings.md).
* Working with [{{ yagpt-name }}-based classifiers](../concepts/classifier/index.md).
* Creating [AI assistants](../concepts/assistant/index.md).
* Image generation by {{ yandexart-name }}.
* [Fine-tuning](../concepts/tuning/index.md) of text generation models and classifiers.
* Integration with [LangChain](https://www.langchain.com/).

You can check the full list of supported functions, library source code, and use cases on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk).

## Installation {#install}

You can install the {{ ml-sdk-name }} library using the [pip](https://pip.pypa.io/en/stable/) package manager:

```bash
pip install yandex-cloud-ml-sdk
```

## Authentication in {{ ml-sdk-full-name }} {#authentication}

To authenticate in {{ ml-sdk-full-name }}, you need to provide the `YCloudML` object to the model. This object contains the following fields:

* `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are going to use to work with models.
* `auth`: Key, token, or other authentication data to identify the user. You can specify the `auth` field value explicitly or get it automatically from the environment:

    {% list tabs %}

    - Explicitly set value

      If set explicitly, the `auth` field value can be one of the following:

      * `string`: As a string, you can provide:
          * [IAM token](../../iam/concepts/authorization/iam-token.md) of a user or [service account](../../iam/concepts/users/service-accounts.md).
          * Secret part of the service account [API key](../../iam/concepts/authorization/api-key.md).
          * [OAuth token](../../iam/concepts/authorization/oauth-token.md) of a user account.

          The SDK will automatically determine the type of authentication data.
      * Object of one of the following classes:

          * `APIKeyAuth`: Allows you to explicitly set authentication by the provided API key. Example: `auth = APIKeyAuth('<API_key>')`.
          * `IAMTokenAuth`: Allows you to explicitly set authentication by the provided API token. Example: `auth = IAMTokenAuth('<IAM_token>')`.
          * `OAuthTokenAuth`: Allows you to explicitly set authentication by the provided OAuth token. Example: `auth = OAuthTokenAuth('<OAuth_token>')`.
          * `MetadataAuth`: Allows you to explicitly set authentication as the service account specified in the {{ compute-full-name }} VM [metadata](../../compute/concepts/vm-metadata.md). Example: `auth = MetadataAuth()`.
          * `EnvIAMTokenAuth`: Allows you to explicitly set authentication using the IAM token specified in the `YC_TOKEN` or any other environment variable. Example: `auth = EnvIAMTokenAuth()` or `auth = EnvIAMTokenAuth("ENV_VAR")`.

              The SDK obtains the IAM token from this environment variable with each request, so you can occasionally update the IAM token in the environment variable yourself outside the SDK. This authentication option is optimal for use with a [service agent](../../datasphere/operations/community/create-ssa.md) in {{ ml-platform-full-name }} if that service has [access](../../iam/concepts/service-control.md) to other resources in the user's cloud.
          * `YandexCloudCLIAuth`: Allows you to explicitly set authentication as a [user](../../iam/concepts/users/accounts.md) or service account [specified](../../cli/operations/index.md#auth) in the [{{ yandex-cloud }} CLI](../../cli/index.yaml) profile on the user's computer. Example: `auth = YandexCloudCLIAuth()`.
          * `NoAuth`: Specifies that no authentication data will be provided. Example: `auth = NoAuth()`.

          You can get these classes by importing them from the ML SDK library. Here is an example:

          ```python
          from yandex_cloud_ml_sdk.auth import APIKeyAuth
          ```

    - Value obtained from the environment

      If the `auth` field is not explicitly set, the SDK will automatically try to select one of the authentication options in the following order:

      1. Authenticate using the API key from the `YC_API_KEY` environment variable if it is set.
      1. Authenticate using the IAM token from the `YC_IAM_TOKEN` environment variable if it is set.
      1. Authenticate using the OAuth token from the `YC_OAUTH_TOKEN` environment variable if it is set.
      1. If none of these environment variables are set, the SDK will attempt to authenticate using the IAM token of the service account specified in the VM metadata.
      1. Authenticate using the IAM token from the `YC_TOKEN` environment variable if it is set.

          The SDK obtains the IAM token from this environment variable with each request, so you can occasionally update the IAM token in the `YC_TOKEN` environment variable yourself outside the SDK.
      1. If the previous options fail, the SDK will attempt to authenticate using the IAM token of the [user](../../iam/concepts/users/accounts.md) or service account [specified](../../cli/operations/index.md#auth) in the [{{ yandex-cloud }} CLI](../../cli/index.yaml) profile on the user's computer.

    {% endlist %}

    {% note info %}

    The maximum [lifetime](../../iam/concepts/authorization/iam-token.md#lifetime) of an IAM token is 12 hours. Keep this in mind when sending requests with authentication based on an IAM token specified in a string, object of the `IAMTokenAuth` class, or the `YC_IAM_TOKEN` environment variable.

    {% endnote %}

## Usage {#usage}

As input data for the request, {{ ml-sdk-name }} can accept the following types:

* String, e.g., `What is heaven?`
* Dictionary, a data structure similar to [JSON](https://en.wikipedia.org/wiki/JSON), e.g., `{"role": "role", "text": "text"}`.
* {{ ml-sdk-name }} `TextMessage` [class](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/src/yandex_cloud_ml_sdk/_models/completions/message.py) object, e.g., `result[0]`.

    The `result` object of the `TextMessage` class is an array of alternatives from the model's responses. With such an object, you can provide the previous response of the model in your next request.
* Array containing any combination of the above data types, e.g., `["text", {"role": "role", "text": "text"}]`.

The example below will prompt {{ gpt-pro }} with the "What is heaven?" string.

```python
from yandex_cloud_ml_sdk import YCloudML

sdk = YCloudML(
    folder_id="<folder_ID>",
    auth="<authentication_data>",
)

model = sdk.models.completions("yandexgpt")
model = model.configure(temperature=0.5)
result = model.run("What is heaven?")

print(f'{result=}')

print(f'{result[0]=}')

print(f'{result.alternatives[0].role=}')

print(f'{result.alternatives[0].text=}')

print(f'{result.alternatives[0].status=}')
```

Where:

* `folder_id`: [Service account](../../iam/concepts/users/service-accounts.md) [folder ID](../../resource-manager/operations/folder/get-id.md).
* `auth`: Key, token, or other [authentication](#authentication) data to identify the user.

Result:

1. The `result` variable contains an array of alternatives from the model's responses:

    ```text
    GPTModelResult(alternatives=(Alternative(role='assistant', text=’Heaven, in many religions, is the place believed to be the home of God where good people go when they die. It is sometimes imagined to be in the sky, inhabited by angels, souls, saints, and other celestial beings.\n\nThe word _heaven_ can also be used figuratively to mean something sublime, ideal, or divine.', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=14, completion_tokens=83, total_tokens=97), model_version='23.10.2024')
    ```

1. The `result[0]` array element contains the `result.alternatives[0]` object of the {{ ml-sdk-name }} `TextMessage` [class](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/blob/master/src/yandex_cloud_ml_sdk/_models/completions/message.py), which in turn contains the `role`, `text`, and `status` fields:

    ```text
    Alternative(role='assistant', text='Heaven, in many religions, is the place believed to be the home of God where good people go when they die. It is sometimes imagined to be in the sky, inhabited by angels, souls, saints, and other celestial beings.\n\nThe word _heaven_ can also be used figuratively to mean something sublime, ideal, or divine.', status=<AlternativeStatus.FINAL: 3>)
    ```
1. The `result.alternatives[0].role` field states one of these message sender roles:

    * `user`: To send user messages to the model.
    * `system`: To set the query context and define the model's behavior.
    * `assistant`: For responses generated by the model.

    ```text
    assistant
    ```
1. The `result.alternatives[0].text` field contains the message text:

    ```text
    Heaven, in many religions, is the place believed to be the home of God where good people go when they die. It is sometimes imagined to be in the sky, inhabited by angels, souls, saints, and other celestial beings.
    
    The word _heaven_ can also be used figuratively to mean something sublime, ideal, or divine.
    ```
1. The `result.alternatives[0].status` field states the message status. The possible status values include:

    * `UNSPECIFIED`: Status is not defined.
    * `PARTIAL`: Part of the generated text that may change while generation is still in progress.
    * `TRUNCATED_FINAL`: Final generated text where the result exceeds the limits.
    * `FINAL`: Final generated text within the limits.
    * `CONTENT_FILTER`: Generation was stopped because the prompt or generated text contains sensitive data or ethically inappropriate topics.

    ```text
    AlternativeStatus.FINAL: 3
    ```

For more examples of working with {{ ml-sdk-name }}, see the [step-by-step guides for {{ foundation-models-full-name }}](../operations/index.md).