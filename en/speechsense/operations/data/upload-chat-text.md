# Uploading chat conversations

You can upload text messages from a customer's, support agent's, or bot's chat conversations using the {{ speechsense-name }} API. This will allow you to analyze the messages, e.g., in [{{ speechsense-name }} reports](../../concepts/reports/index.md).

Text messages must be submitted in JSON format. To upload data, you will also need a separate JSON file with conversation metadata.

{% include [authentication](../../../_includes/speechsense/data/authentication.md) %}

If you want to upload the voice call audio instead of chat text, follow [this guide](upload-data.md).

## Getting started {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

Prepare to upload a chat conversation:

1. [Create a connection](../connection/create.md#create-chat-connection) of the **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}** type.

   If you want to upload [linked dialogs](../../concepts/dialogs.md#related-dialogs), add the `ticket_id` string key to the connection's general metadata. The chats will be linked by this key.

1. [Create a project](../project/create.md) with the new connection.

   Text messages will be uploaded to the project and connection you created.

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

## Uploading data {#upload-data}

1. {% include [interface-code-generation](../../../_includes/speechsense/data/interface-code-generation.md) %}

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

      # For IAM token authentication, replace the `api_key` parameter with `iam_token`
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
         # For IAM token authentication, provide the header
         #  ('authorization', f'Bearer {iam_token}'),
         ))

         # Displaying the dialog ID
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

1. In the `upload_data` directory , create a file named `metadata.json` with your conversation metadata:

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

   Set the `date` field value in `YYYY-MM-DDTHH:MM:SS.SSS` format.

   The file's fields must match the parameters of the connection you are uploading text messages to. The template above shows the required fields for **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}** type connections. If you added other parameters to the connection, specify them in the `metadata.json` file; e.g., to upload [linked chats](../../concepts/dialogs.md#related-dialogs), add the following parameter to your file:

   ```json
   {
      ...
      "ticket_id": "<task_number>"
   }
   ```

1. In the `upload_data` folder, create a file named `chat.json` with your text messages in the following format:

   ```json
   {
      "messages": [
         {
            "user_id": <message_sender_ID>,
            "text" : "<text_message>",
            "timestamp" : "<message_send_time>"
         },
         ...
      ]
   }
   ```

   Where:

   * `messages`: Array of text messages. For each message, create a separate object in this array.
   * `user_id`: ID of the message sender. The ID must match the ID of the customer, agent, or bot in the JSON file with metadata.
   * `timestamp`: Message send time. Use the `YYYY-MM-DDTHH:MM:SS.SSSZ` time format.

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}

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

1. From the {{ speechsense-name }} [home page]({{ link-speechsense-main }}), go to the page of the project you created for text messages. Make sure you can see the uploaded conversation in the **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** tab.
