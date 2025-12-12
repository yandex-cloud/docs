# Working with an AI assistant in {{ speechsense-name }}

You can use an [AI assistant](../../../speechsense/concepts/assistants.md) to retrieve information from a dialog by connecting it to audio conversations and chats. This tutorial explains how to connect an agent to chats and uses a conversation between a travel agency and a customer as an example.

To retrieve information you need from a chat using an AI assistant:

1. [Get your cloud ready](#before-you-begin).
1. [Set up the infrastructure](#infrastructure-prepare).
1. [Create an AI assistant](#create-assistant).
1. [Upload data to the project](#load-data).
1. [Review the AI assistant's output in the {{ speechsense-name }} interface](#result-console).
1. [Get the dialog information using the API](#result-api).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

The user must [have](../../../billing/security/index.md#set-role) the `billing.accounts.editor`, `billing.accounts.admin`, or `billing.accounts.owner` role for the billing account to manage it.

{% include [note-managing-roles](../../../_includes/mdb/note-managing-roles.md) %}

### Required paid resources {#paid-resources}

* {{ speechsense-name }}: Number of characters in each text conversation (see [{{ speechsense-name }} pricing](../../../speechsense/pricing.md)).
* AI assistant: Text generation (see [{{ foundation-models-full-name }} pricing](../../../ai-studio/pricing.md)). Charges for using the assistant will apply as soon as you enable it.

## Set up your infrastructure {#infrastructure-prepare}

### Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the relevant folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Name the [service account](../../../iam/concepts/users/service-accounts.md), e.g., `speechsense`.
    1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Create an API key for the service account {#create-key}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Select the `speechsense` service account.
  1. In the top panel, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, select `yc.speech-sense.use`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the ID and secret key for later.

      {% note alert %}

      After you close this dialog, the key value will no longer be available.

      {% endnote %}

{% endlist %}

### Create a space and link a billing account {#create-space}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

    1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
    1. Click **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
    1. Enter a name for the [space](../../../speechsense/concepts/resources-hierarchy.md#space).
    1. Click **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
    1. [Link a billing account](../../../speechsense/operations/space/link-ba.md) to the space to pay for {{ speechsense-name }}.

{% endlist %}

### Add the service account to the space {#add-sa-to-space}

{% include notitle [prepare-cloud](../../_tutorials_includes/speechsense-integration/prepare-cloud.md#add-sa-to-space) %}

### Create a connection for a chat {#create-connection}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

    1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
    1. Go to the space of your choice.
    1. Navigate to the **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** tab.
    1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}** → **{{ ui-key.yc-ui-talkanalytics.connections.template.default.name }}**.
    1. Specify a connection name, e.g., `chats-default-metadata`.
    1. Select the **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}** data type.
    1. Click **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
    1. On the page that opens, click **ID** in the top-left corner to copy the ID of the connection you created. Save this ID as you will need it later to [upload data to the project](#load-data).

{% endlist %}

### Create a project {#create-project}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

    1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
    1. Go to the space of your choice.
    1. Click ![create](../../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
    1. Enter a project name, e.g., `chats-travel-agency`.
    1. Under **{{ ui-key.yc-ui-talkanalytics.connections.connection }}**, click **{{ ui-key.yc-ui-talkanalytics.projects.add-connection }}** and select the `chats-default-metadata` connection.
    1. Click **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
    1. On the page that opens, click **ID** in the top-left corner to copy the ID of the project you created. Save this ID as you will need it later to [work with the API](#result-api).

{% endlist %}

## Create an AI assistant {#create-assistant}

{% list tabs group=instructions %}

- {{ speechsense-name }} UI {#speechsense}

    1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
    1. Go to the space you need and select the `chats-travel-agency` project.
    1. Select the **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}** tab.
    1. Click **Create assistant**.
    1. Configure the new assistant:

        1. Enter `Dialog subject` as the name.
        1. Under **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}**, enter this prompt:

            ```text
            You are analyzing a conversation between a call center agent and customer. Pay close attention when generating a response.
            Determine the subject of the customer’s inquiry by selecting one from this list: Visa, Country, Guided Tours.
            If nothing of the above is suitable, put "Other"."
            ```

        1. Select the `YandexGPT 5.1 Pro` model.

        1. Under **Output**, specify:

            * Field name: `Subject`.
            * Field type: `String`.
            * Description: `Most suitable subject`.

    1. Enable the **{{ ui-key.yc-ui-talkanalytics.assistants.applying }}** section to activate the assistant.

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Upload data to the project {#load-data}

{% include [software](../../../_includes/speechsense/data/software.md) %}

1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}
1. Go to the directory hosting the {{ yandex-cloud }} API repository, create a directory named `upload_data`, and generate the client interface code in it. Then, go to the `upload_data` directory:

    ```bash
    cd ~/cloudapi/ && \
    mkdir upload_data && \
    python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
         --python_out=./upload_data/ \
         --grpc_python_out=./upload_data/ \
         google/api/http.proto \
         google/api/annotations.proto \
         yandex/cloud/api/operation.proto \
         google/rpc/status.proto \
         yandex/cloud/operation/operation.proto \
         yandex/cloud/validation.proto \
         yandex/cloud/speechsense/v1/*.proto \
         yandex/cloud/speechsense/v1/*/*.proto
    cd upload_data
    ```

1. In the `upload_data` folder, create the `upload_text.py` Python script to upload the chat conversation to {{ speechsense-name }}:

    ```python
    import argparse
    import json
    from typing import Dict
    import grpc

    from yandex.cloud.speechsense.v1 import talk_service_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
    from yandex.cloud.speechsense.v1 import text_pb2
    from google.protobuf.timestamp_pb2 import Timestamp

    def upload_talk(connection_id: str, metadata: Dict[str, str], api_key: str, text_data):
       credentials = grpc.ssl_channel_credentials()
       channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)

       talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

       messageList = []
       for message in text_data['messages']:
          timestamp = Timestamp()
          timestamp.FromJsonString(value=str(message['timestamp']))
          messageProto = text_pb2.Message(
             user_id=str(message['user_id']),
             text=text_pb2.TextPayload(text=str(message['text'])),
             timestamp=timestamp
          )
          messageList.append(messageProto)

       # Forming a request to the API
       request = talk_service_pb2.UploadTextRequest(
          metadata=talk_service_pb2.TalkMetadata(
             connection_id=str(connection_id),
             fields=metadata),
          text_content=text_pb2.TextContent(
             messages=messageList)
       )

       # Authentication type: API key
       response = talk_service_stub.UploadText(request, metadata=(
          ('authorization', f'Api-Key {api_key}'),
       ))

       # Displaying the dialog ID
       print(f'Dialog ID: {response.talk_id}')

    if __name__ == '__main__':
       parser = argparse.ArgumentParser()
       parser.add_argument('--key', required=True, help='API key', type=str)
       parser.add_argument('--connection-id', required=True, help='Connection ID', type=str)
       parser.add_argument('--text-path', required=True, help='JSON with text chat data', type=str)
       parser.add_argument('--meta-path', required=False, help='JSON with the dialog metadata', type=str, default=None)
       args = parser.parse_args()

       with open(args.meta_path, 'r') as fp:
          metadata = json.load(fp)

       with open(args.text_path, 'r') as fp:
          text_data = json.load(fp)
       upload_talk(args.connection_id, metadata, args.key, text_data)
    ```

1. In the `upload_data` folder, create a file named `metadata.json` with your conversation metadata:

    ```json
    {
       "operator_name": "Sarah",
       "operator_id": "24",
       "client_name": "Michael",
       "client_id": "145",
       "date": "2025-12-01T12:34:19+03:00",
       "direction_outgoing": "false",
       "language": "ru-ru"
    }
    ```

1. In the `upload_data` folder, create a file named `chat.json` with your text messages:

    ```json
    {
       "messages": [
          {
             "user_id": 145,
             "text" : "Hi there! Do you sell guided tours?",
             "timestamp" : "2025-12-01T12:34:19+03:00"
          },
          {
             "user_id": 24,
             "text" : "Hi Michael. Yes, we are offering guided tours to Europe and Asia. What destinations are you interested in?",
             "timestamp" : "2025-12-01T12:35:45+03:00"
          },
          {
             "user_id": 145,
             "text" : "Which Asian countries can I visit without a visa?",
             "timestamp" : "2025-12-01T12:37:14+03:00"
          },
          {
             "user_id": 24,
             "text" : "South Korea.",
             "timestamp" : "2025-12-01T12:38:55+03:00"
          },
          {
             "user_id": 145,
             "text" : "Thank you, I’ll think about it. Bye.",
             "timestamp" : "2025-12-01T12:41:21+03:00"
          },
          {
             "user_id": 24,
             "text" : "Goodbye.",
             "timestamp" : "2025-12-01T12:41:50+03:00"
          }
       ]
    }
    ```

1. Specify the service account's API key:

    ```bash
    export API_KEY=<secret_part_of_API_key>
    ```

1. Run the `upload_text.py` script:

    ```bash
    python3 upload_text.py \
       --text-path chat.json \
       --meta-path metadata.json \
       --connection-id <connection_ID> \
       --key ${API_KEY}
    ```

    Result:

    ```
    Dialog ID: audh5bbnrstk********
    ```

    Save the ID of the dialog you created as you will need it later to [work with the API](#result-api).

## Review the AI assistant's output in the {{ speechsense-name }} interface {#result-console}

To view the dialog subject selected by the AI assistant:

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space you need and select the `chats-travel-agency` project.
1. On the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab, enable **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}**.

Below the dialog line, you will see a line indicating the `Guided Tours` subject. This is the subject the AI assistant has selected as the most suitable one for the dialog.

## Get the dialog information using the API {#result-api}

### Get the AI assistant and its field IDs {#get-field-id}

{% list tabs group=instructions %}

- REST API {#api}

    Call the [Assistants.List](../../../speechsense/api-ref/Assistants/list.md) method and run the following request, e.g., via {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --url 'https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/list' \
        --data '{
                  "projectId": "<project_ID>"
                }'
    ```

    Result:

    ```json
    {
      "assistants": [
        {
          "id": "eagdf4es87u0********",
          "project_id": "eags34o1skdi********",
          "model_id": "YGPT_LITE",
          "name": "Dialog subject",
          "description": "",
          "prompt": "You are analyzing a conversation between a call center agent and customer. Pay close attention when generating a response. \nDetermine the subject of the customer’s inquiry by selecting one from this list: Visa, Country, Guided Tours. \nIf nothing of the above is suitable, put "Other"."
          "fields": [
            {
              "id": "eagldsqk9fp4********",
              "name": "Subject",
              "description": "Most suitable subject.",
              "type": "ASSISTANT_FIELD_TYPE_STRING"
            }
          ],
          "enabled": true,
          "labels": {},
          "created_at": "2025-11-13T23:38:00.686738Z",
          "created_by": "ajegrmkclceh********",
          "modified_at": "2025-11-14T01:32:48.358727Z",
          "modified_by": "ajegrmkclceh********"
        }
      ]
    }
    ```

- gRPC API {#grpc-api}

    Call the [AssistantsService.List](../../../speechsense/api-ref/grpc/Assistants/list.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

    ```bash
    grpcurl \
      -format json \
      -import-path ~/cloudapi/ \
      -import-path ~/cloudapi/third_party/googleapis/ \
      -proto ~/cloudapi/yandex/cloud/speechsense/v1/assistants_service.proto \
      -rpc-header "Authorization: Api-Key $API_KEY" \
      -d '{
            "project_id": "<project_ID>"
          }' \
      api.speechsense.yandexcloud.net:443 \
      yandex.cloud.speechsense.v1.AssistantsService.List
    ```

    Result:

    ```json
    {
      "assistants": [
        {
          "id": "eagdf4es87u0********",
          "projectId": "eags34o1skdi********",
          "modelId": "YGPT_LITE",
          "name": "Dialog subject",
          "prompt": "You are analyzing a conversation between a call center agent and customer. Pay close attention when generating a response. \nDetermine the subject of the customer’s inquiry by selecting one from this list: Visa, Country, Guided Tours. \nIf nothing of the above is suitable, put "Other"."
          "fields": [
            {
              "id": "eagldsqk9fp4********",
              "name": "Subject",
              "description": "Most suitable subject.",
              "type": "ASSISTANT_FIELD_TYPE_STRING"
            }
          ],
          "enabled": true,
          "createdAt": "2025-11-13T23:38:00.686738Z",
          "createdBy": "ajegrmkclceh********",
          "modifiedAt": "2025-11-14T01:32:48.358727Z",
          "modifiedBy": "ajegrmkclceh********"
        }
      ]
    }
    ```

{% endlist %}

Save the values of these fields:

* `assistants.id`: ID of the `Dialog subject` AI assistant.
* `assistants.fields.id`: ID of the `Subject` field.

### Get the dialog information {#get-dialog-info}

{% list tabs group=instructions %}

- REST API {#api}

    Call the [Talk.Get](../../../speechsense/api-ref/Talk/get.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --url 'https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get' \
        --data '{
                  "projectId": "<project_ID>",
                  "talkIds": [
                    "string"
                  ],
                  "resultsMask": 
                    {
                      "paths": [
                        "assistants"
                      ]
                    }
                }'
    ```

    Result:

    ```json
    {
      "talk": [
        {
          "id": "audh5bbnrstk********",
          "organization_id": "********",
          "space_id": "f3fuclf1kufs********",
          "connection_id": "eagojm8e3bfv********",
          "project_ids": [
            "eags34o1skdi********"
          ],
          ...
          "assistants": {
            "assistant_results": [
              {
                "assistant_id": "eagdf4es87u0********",
                "results": [
                  {
                    "field_id": "eagldsqk9fp4********",
                    "string_result": "Guided Tours"
                  }
                ]
              }
            ]
          },
          ...
        }
      ]
    }
    ```

    To find the dialog subject value, search the result by the [previously saved](#get-field-id) AI assistant and field IDs. This value is indicated in the `talk.assistants.assistant_results.results.string_result` field: `Guided Tours`.

- gRPC API {#grpc-api}

    Call the [TalkService.Get](../../../speechsense/api-ref/grpc/Talk/get.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/speechsense/v1/talk_service.proto \
        -rpc-header "Authorization: Api-Key $API_KEY" \
        -d '{
              "project_id": "<project_ID>",
              "talk_ids": [
                <dialog_ID>
              ],
              "results_mask": 
                {
                  "paths": [
                    "assistants"
                  ]
                }
            }' \
        api.speechsense.yandexcloud.net:443 \
        yandex.cloud.api.speechsense.v1.TalkService.Get
    ```

    Result:

    ```json
    {
      "talk": [
        {
          "id": "audh5bbnrstk********",
          "organizationId": "********",
          "spaceId": "f3fuclf1kufs********",
          "connectionId": "eagojm8e3bfv********",
          "projectIds": [
            "eags34o1skdi********"
          ],
          ...
          "assistants": {
            "assistantResults": [
              {
                "assistantId": "eagdf4es87u0********",
                "results": [
                  {
                    "fieldId": "eagldsqk9fp4********",
                    "stringResult": "Guided Tours"
                  }
                ]
              }
            ]
          },
          ...
        }
      ]
    }
    ```

    To find the dialog subject value, search the result by the [previously saved](#get-field-id) AI assistant and field IDs. This value is indicated in the `talk.assistants.assistantResults.results.stringResult` field: `Guided Tours`.

{% endlist %}

## Delete resources {#clear-out}

Some resources are not free of charge. To stop paying for them, [delete the {{ speechsense-name }} project](../../../speechsense/operations/project/delete.md) if you no longer need it. The AI assistant will be deleted when you delete the project.
