# Uploading chat conversations

You can upload text messages from a customer's, support agent's, or bot's chat conversations using the {{ speechsense-name }} API. This will allow you to analyze the messages, e.g., in [{{ speechsense-name }} reports](../../concepts/reports/index.md).

Text messages must be submitted in JSON format. To upload data, you will also need a separate JSON file with conversation metadata.

An [IAM token](../../../iam/concepts/authorization/iam-token.md) or [IAM key](../../../iam/concepts/authorization/api-key.md) is used to [authenticate](../../api-ref/authentication.md) the service account.

If you want to upload the voice call audio instead of chat text, follow [this guide](upload-data.md).

## Getting started {#before-you-begin}

To use the {{ yandex-cloud }} API, you will need Git, Python 3.6 or higher, and the `grpcio-tools` package. [Learn how to install Python](https://www.python.org/downloads/).

Prepare to upload a chat conversation:

1. [Create a connection](../connection/create.md) of the **Chat** type.
1. [Create a project](../project/create.md) with the new connection.

   Text messages will be uploaded to the project and connection you created.

1. In the management console, [create a service account](../../../iam/operations/sa/create.md).
1. [Add the service account to the namespace](../space/add-user-to-space.md) with the `{{ roles-speechsense-data-editor }}` role. This will allow the service account to upload data to {{ speechsense-name }}.
1. To authenticate to the {{ yandex-cloud }} API, [create an API key](../../../iam/operations/api-key/create.md) or [IAM token](../../../iam/operations/iam-token/create-for-sa.md) for the service account.
1. Clone the [{{ yandex-cloud }} API repository](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Install the `grpcio-tools` package using the [pip](https://pip.pypa.io/en/stable/) package manager:

   ```python
   pip install grpcio-tools
   ```

## Uploading data {#upload-data}

1. Go to the folder hosting the {{ yandex-cloud }} API repository, create a folder named `upload_data`, and generate the client interface code in it. Then open the `upload_data` folder:

   {% list tabs group=programming_language %}

   - Bash {#bash}

      ```bash
      cd <path_to_cloudapi_directory> && \
      mkdir upload_data && \
      python3 -m grpc_tools.protoc -I . \
           --python_out=./upload_data/ \
           --grpc_python_out=./upload_data/ \
           yandex/cloud/speechsense/v1/*
      cd upload_data
      ```

   {% endlist %}

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

   # To authenticate with an IAM token, replace the api_key parameter with iam_token
   def upload_talk(connection_id: str, metadata: Dict[str, str], api_key: str, text_data):
      credentials = grpc.ssl_channel_credentials()
      channel = grpc.secure_channel('api.talk-analytics.yandexcloud.net:443', credentials)

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

      # Generating an API request
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
      # To authenticate with an IAM token, provide the header
      #  ('authorization', f'Bearer {iam_token}'),
      ))

      # Display dialog ID
      print(f'Dialog ID: {response.talk_id}')

   if __name__ == '__main__':
      parser = argparse.ArgumentParser()
      parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
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

1. In the `upload_data` folder, create a file named `metadata.json` with conversation metadata:

   ```json
   {
      "operator_name": "<agent_name>",
      "operator_id": "<agent_ID>",
      "client_name": "<customer_name>",
      "client_id": "<customer_ID>",
      "bot_name": "<bot_name>",
      "bot_id": "<bot_ID>",
      "date": "<start_date>",
      "direction_outgoing": "<outgoing_direction:_true_or_false>",
      "language": "<language>",
      <additional_connection_parameters>
   }
   ```

   The file's fields must match the parameters of the connection you are uploading text messages to. The template above shows the required fields for **Chat** type connections. If you added other parameters to the connection, specify them in the `metadata.json` file.

   Specify the `date` in `YYYY-MM-DDTHH:MM:SS.SSS` format.

1. In the `upload_data` folder, create a file named `chat.json` with your text messages in the following format:

   ```json
   {
      "messages": [
         {
            "user_id": <sender_ID>,
            "text" : "<text_message>",
            "timestamp" : "<message_timestamp>"
         },
         ...
      ]
   }
   ```

   Where:

   * `messages`: Array of text messages. For each message, create a separate object in this array.
   * `user_id`: Sender ID. The ID must match the ID of the customer, agent, or bot in the JSON file with metadata.
   * `timestamp`: Message send time. Use the `YYYY-MM-DDTHH:MM:SS.SSSZ` time format.

1. Specify the service account's API key:

   ```bash
   export API_KEY=<service_account_API_key>
   ```

   If using an IAM token, provide it instead of the API key:

   ```bash
   export IAM_TOKEN=<service_account_IAM_token>
   ```

1. Run the `upload_text.py` script with the parameters you need:

   ```bash
   python3 upload_text.py \
      --text-path chat.json \
      --meta-path metadata.json \
      --connection-id <connection_ID> \
      --key ${API_KEY}
   ```

   Where:

   * `--text-path`: Path to the conversation file.
   * `--meta-path`: Path to the conversation metadata file.
   * `--connection-id`: ID of the connection you upload the data to.
   * `--key`: API key for authentication. If using an IAM token, specify the `IAM_TOKEN` environment variable instead of `API_KEY`.

1. From the {{ speechsense-name }} [home page]({{ link-speechsense-main }}), go to the page of the project you created for text messages. Make sure that you can see the uploaded conversation in the **Dialogs** tab.
