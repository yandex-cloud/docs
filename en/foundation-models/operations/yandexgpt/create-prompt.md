---
title: How to send a request in prompt mode to {{ yagpt-full-name }}
description: Follow this guide to learn how to use {{ yagpt-full-name }} in prompt mode.
---

# Sending a request in prompt mode

To generate text in [prompt mode](../../concepts/index.md#working-mode), send a request to the model using the [completion](../../text-generation/api-ref/TextGeneration/completion.md) method or [{{ ml-sdk-full-name }}](../../sdk/index.md).

## Getting started {#before-begin}

{% list tabs group=programming_language %}

- SDK {#sdk}

  To use the examples of requests using SDK:

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

{% endlist %}


## Request to a model via the REST API {#request}

{% list tabs group=programming_language %}

- cURL {#curl}
  
  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Create a file with the request body, e.g., `body.json`:
  
     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
       "completionOptions": {
         "stream": false,
         "temperature": 0.1,
         "maxTokens": "1000"
       },
       "messages": [
         {
           "role": "system",
           "text": "Translate the text"
         },
         {
           "role": "user",
           "text": "To be, or not to be: that is the question."
         }
       ]
     }
     ```
  
     Where:
  
     {% include [api-parameters](../../../_includes/foundation-models/yandexgpt/api-parameters.md) %}
  
  1. Send a request to the model by running this command:
  
     ```bash
     export FOLDER_ID=<folder_ID>
     export IAM_TOKEN=<IAM_token>
     curl \
       --request POST \
       --header "Content-Type: application/json" \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --header "x-folder-id: ${FOLDER_ID}" \
       --data "@<path_to_JSON_file>" \
       "https://llm.{{ api-host }}/foundationModels/v1/completion"
     ```
  
     Where:
  
     * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
     * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).
  
     {% cut "Result:" %}
  
     ```json
     {
       "result": {
         "alternatives": [
           {
             "message": {
               "role": "assistant",
               "text": "To be, or not to be: that is the question."
             },
             "status": "ALTERNATIVE_STATUS_FINAL"
           }
         ],
         "usage": {
           "inputTextTokens": "28",
           "completionTokens": "10",
           "totalTokens": "38"
         },
         "modelVersion": "06.12.2023"
       }
     }
     ```

     {% endcut %}

- Python {#python}

  1. Create a file named `test.py` with the model request code:

     ```python
     import requests
     import argparse
     
     URL = "https://llm.api.cloud.yandex.net/foundationModels/v1/completion"
     
     def run(iam_token, folder_id, user_text):    
         # Building a request
         data = {}
         # Specifying model type
         data["modelUri"] = f"gpt://{folder_id}/yandexgpt"
         # Configuring options
         data["completionOptions"] = {"temperature": 0.3, "maxTokens": 1000}
         # Specifying context for the model
         data["messages"] = [
             {"role": "system", "text": "Correct errors in the text."},
             {"role": "user", "text": f"{user_text}"},
         ]
         
         # Sending the request
         response = requests.post(
             URL,
             headers={
                 "Accept": "application/json",
                 "Authorization": f"Bearer {iam_token}"
             },
             json=data,
         ).json()
     
         #Printing the result
         print(response)
     
     if __name__ == '__main__':
         parser = argparse.ArgumentParser()
         parser.add_argument("--iam_token", required=True, help="IAM token")
         parser.add_argument("--folder_id", required=True, help="Folder id")
         parser.add_argument("--user_text", required=True, help="User text")
         args = parser.parse_args()
         run(args.iam_token, args.folder_id, args.user_text)
     ```

  1. Run the `test.py` file, providing the [IAM token](../../../iam/concepts/authorization/iam-token.md) and [folder ID](../../../resource-manager/operations/folder/get-id.md) values:

     ```bash
     export IAM_TOKEN=<IAM_token>
     export FOLDER_ID=<folder_ID>
     export TEXT='Erors wont corrct themselfs'
     python test.py \
       --iam_token ${IAM_TOKEN} \
       --folder_id ${FOLDER_ID} \
       --user_text ${TEXT}
     ```

     {% cut "Result:" %}

     ```text
     {'result': {'alternatives': [{'message': {'role': 'assistant', 'text': 'Errors will not correct themselves.'}, 'status': 'ALTERNATIVE_STATUS_FINAL'}], 'usage': {'inputTextTokens': '29', 'completionTokens': '9', 'totalTokens': '38'}, 'modelVersion': '07.03.2024'}}
     ```

     {% endcut %}

{% endlist %}

## Request to a model via the gRPC API {#request-grpc}

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [yandexgpt-sdk-entire-generation-block](../../../_includes/foundation-models/yandexgpt/yandexgpt-sdk-entire-generation-block.md) %}

- Python {#python}

  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

  1. Clone the {{ yandex-cloud }} API repository by entering the code into a notebook cell:

     ```bash
     git clone https://github.com/yandex-cloud/cloudapi
     ```

  1. Use the `pip` package manager to install the `grpcio-tools` package:

     ```bash
     pip install grpcio-tools
     ```

  1. Go to the folder hosting the cloned {{ yandex-cloud }} API repository:

     ```bash
     cd <path_to_cloudapi_folder>
     ```

  1. Create the `output` folder:

     ```bash
     mkdir output
     ```

  1. Generate the client interface code:

     ```bash
     python -m grpc_tools.protoc -I . -I third_party/googleapis \
       --python_out=output \
       --grpc_python_out=output \
         google/api/http.proto \
         google/api/annotations.proto \
         yandex/cloud/api/operation.proto \
         google/rpc/status.proto \
         yandex/cloud/operation/operation.proto \
         yandex/cloud/validation.proto \
         yandex/cloud/ai/foundation_models/v1/text_generation/text_generation_service.proto \
         yandex/cloud/ai/foundation_models/v1/text_common.proto
     ```

  1. In the `output` folder, create a file named `test.py` with the model request code:

     ```python
     # coding=utf8
     import argparse
     import grpc
     
     import yandex.cloud.ai.foundation_models.v1.text_common_pb2 as pb
     import yandex.cloud.ai.foundation_models.v1.text_generation.text_generation_service_pb2_grpc as service_pb_grpc
     import yandex.cloud.ai.foundation_models.v1.text_generation.text_generation_service_pb2 as service_pb
     
     def run(iam_token, folder_id, user_text):
         cred = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('llm.api.cloud.yandex.net:443', cred)
         stub = service_pb_grpc.TextGenerationServiceStub(channel)
     
         request = service_pb.CompletionRequest(
             model_uri=f"gpt://{folder_id}/yandexgpt",
             completion_options=pb.CompletionOptions(
                 max_tokens={"value": 2000}, 
                 temperature={"value": 0.5}
             ),
         )
         message_system = request.messages.add()
         message_system.role = "system"
         message_system.text = "Correct errors in the text."
     
         message_user = request.messages.add()
         message_user.role = "user"
         message_user.text = user_text
     
         it = stub.Completion(request, metadata=(
             ('authorization', f'Bearer {iam_token}'),
         ))
         for response in it:
             for alternative in response.alternatives:
                 print (alternative.message.text)
     
     if __name__ == '__main__':
         parser = argparse.ArgumentParser()
         parser.add_argument("--iam_token", required=True, help="IAM token")
         parser.add_argument("--folder_id", required=True, help="Folder id")
         parser.add_argument("--user_text", required=True, help="User text")
         args = parser.parse_args()
         run(args.iam_token, args.folder_id, args.user_text)
     ```

  1. Run the `test.py` file, providing the [IAM token](../../../iam/concepts/authorization/iam-token.md) and [folder ID](../../../resource-manager/operations/folder/get-id.md) values:

     ```bash
     export IAM_TOKEN=<IAM_token>
     export FOLDER_ID=<folder_ID>
     export TEXT='Erors wont corrct themselfs'
     python output/test.py \
       --iam_token ${IAM_TOKEN} \
       --folder_id ${FOLDER_ID} \
       --user_text ${TEXT}
     ```

     {% cut "Result:" %}

     ```text
     Errors will not correct themselves.
     ```

     {% endcut %}

{% endlist %}

### Streaming request via the gRPC API {#stream}

{% list tabs group=programming_language %}

- SDK {#sdk}

  If the `run_stream` method is used, the server will provide not just the final text generation result but intermediate results as well. Each intermediate response contains the whole generation result that is currently available. Until the final response is received, the generation results may change as new messages arrive.

  The difference the `run_stream` method makes can be seen most directly when creating and processing large texts.

  1. Create a file named `generate-text.py` and paste the following code into it:

      {% include [yandexgpt-stream-sdk](../../../_includes/foundation-models/examples/yandexgpt-stream-sdk.md) %}

      Where:

      {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      {% include [yandexgpt-model-version-sdk-info](../../../_includes/foundation-models/yandexgpt/yandexgpt-model-version-sdk-info.md) %}

  1. Run the created file:

      ```bash
      python3 generate-text.py
      ```

      Result:

      ```text
      Alternative(role='assistant', text='O', status=<AlternativeStatus.PARTIAL: 1>)
      Alternative(role='assistant', text='Errors will not correct themselves.', status=<AlternativeStatus.FINAL: 3>)
      ```

- Python {#python}

  With the `stream` parameter enabled, the server will provide not just the final text generation result but intermediate results as well. Each intermediate response contains the whole generation result that is currently available. Until the final response is received, the generation results may change as new messages arrive. 

  The difference the `stream` parameter makes can be seen most directly when creating and processing large texts.

  {% note warning %}

  The `stream` parameter is not available for the model's [asynchronous mode](async-request.md).

  {% endnote %}

  Generate the gRPC client interface code as described in [this guide](#request-grpc). At _Step 6_, generate a file named `test.py` with the code to access the model.

  ```python
  # coding=utf8
  import argparse
  import grpc

  import yandex.cloud.ai.foundation_models.v1.text_common_pb2 as pb
  import yandex.cloud.ai.foundation_models.v1.text_generation.text_generation_service_pb2_grpc as service_pb_grpc
  import yandex.cloud.ai.foundation_models.v1.text_generation.text_generation_service_pb2 as service_pb

  def run(iam_token, folder_id, user_text):
      cred = grpc.ssl_channel_credentials()
      channel = grpc.secure_channel('llm.api.cloud.yandex.net:443', cred)
      stub = service_pb_grpc.TextGenerationServiceStub(channel)

      request = service_pb.CompletionRequest(
              model_uri=f"gpt://{folder_id}/yandexgpt",
              completion_options=pb.CompletionOptions(
                  max_tokens={"value": 2000},
                  temperature={"value": 0.5},
                  stream=True
              ),
          )
          message_system = request.messages.add()
          message_system.role = "system"
          message_system.text = "Correct errors in the text."
      
          message_user = request.messages.add()
          message_user.role = "user"
          message_user.text = user_text
      
          it = stub.Completion(request, metadata=(
              ('authorization', f'Bearer {iam_token}'),
          ))             
          
          for response in it:
              print(response)

  if __name__ == '__main__':
      parser = argparse.ArgumentParser()
      parser.add_argument("--iam_token", required=True, help="IAM token")
      parser.add_argument("--folder_id", required=True, help="Folder id")
      parser.add_argument("--user_text", required=True, help="User text")
      args = parser.parse_args()
      run(args.iam_token, args.folder_id, args.user_text)
  ```

  {% cut "Result:" %}

  ```text
  alternatives {
    message {
      role: "assistant"
      text: "E"
    }
    status: ALTERNATIVE_STATUS_PARTIAL
  }
  usage {
    input_text_tokens: 29
    completion_tokens: 1
    total_tokens: 30
  }
  model_version: "07.03.2024"

  alternatives {
    message {
      role: "assistant"
      text: "Errors will not correct themselves."
    }
    status: ALTERNATIVE_STATUS_FINAL
  }
  usage {
    input_text_tokens: 29
    completion_tokens: 9
    total_tokens: 38
  }
  model_version: "07.03.2024"
  ```

  {% endcut %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/yandexgpt/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)