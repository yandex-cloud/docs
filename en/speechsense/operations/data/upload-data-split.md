---
title: Uploading long audio files with splitting via the gRPC API
description: Follow this guide to upload long audio files to {{ speechsense-name }} by splitting them into chunks via the gRPC API.
---

# Uploading long audio files with splitting via the gRPC API

Use this guide to upload data to {{ speechsense-name }} for speech recognition and analysis via API. This example uses the following parameters:

* [Audio format](../../concepts/formats.md): WAV.
* Connection type: Single-channel audio with splitting enabled.
* gRPC API method: [TalkService.UploadBadge](../../api-ref/grpc/Talk/uploadBadge.md).
* The dialog metadata is stored in `metadata.json`.

{% include [authentication](../../../_includes/speechsense/data/authentication.md) %}

You can discover {{ speechsense-name }} features using a quick audio data upload via the [management console](upload-audio-console.md).

If you want to upload the chat text instead of voice call audio, follow [this guide](upload-chat-text.md).

## Getting started {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

To prepare for uploading audio recordings:

1. [Create a connection](../connection/create.md#create-one-channel-audio-connection) of the **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** type with the **{{ ui-key.yc-ui-talkanalytics.connections.additional.split.title }}** option enabled.

   If you want to upload [linked dialogs](../../concepts/dialogs.md#related-dialogs), add the `ticket_id` string key to the connection's general metadata. The dialogs will be linked by this key.

1. [Create a project](../project/create.md) with the new connection.

   This project and connection is where the audio recordings of dialogs will be uploaded.

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

## Uploading data {#upload-data}

{% note warning %}

{% include [data-format](../../../_includes/speechsense/data/data-format.md) %}

{% include notitle [max-duration](../../../_includes/speechsense/data/max-duration.md) %}

{% include notitle [max-dialog-string](../../../_includes/speechsense/data/max-dialog-string.md) %}

The only way to upload single-channel audio split into chunks is by calling [TalkService.UploadBadge](../../api-ref/grpc/Talk/uploadBadge.md).

The supported audio formats are [WAV](../../concepts/formats.md#wav) and [MP3](../../concepts/formats.md#mp3).

{% endnote %}

1. {% include [interface-code-generation](../../../_includes/speechsense/data/interface-code-generation.md) %}
1. In the `upload_data` folder, create the `upload_grpc.py` Python script to upload your data to a {{ speechsense-name }} connection. The file will be transferred via chunks:

   ```python
   import argparse
   import datetime
   import json
   from typing import Dict

   import grpc

   from yandex.cloud.speechsense.v1 import talk_service_pb2
   from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
   from yandex.cloud.speechsense.v1 import audio_pb2


   # Configure the chunk size
   CHUNK_SIZE_BYTES = 1 * 1024 * 1024


   def upload_audio_requests_iterator(connection_id: str, metadata: Dict[str, str], audio_path: str):
       # Transfer the general dialog metadata
       yield talk_service_pb2.StreamTalkRequest(
           metadata=talk_service_pb2.TalkMetadata(
               connection_id=connection_id,
               fields=metadata
           )
       )

       # Transfer the audio metadata
       yield talk_service_pb2.StreamTalkRequest(
           audio=audio_pb2.AudioStreamingRequest(
               audio_metadata=audio_pb2.AudioMetadata(
                   container_audio=audio_pb2.ContainerAudio(
                       container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType.CONTAINER_AUDIO_TYPE_WAV
                   )
               )
           )
       )

       with open(audio_path, mode='rb') as fp:
           data = fp.read(CHUNK_SIZE_BYTES)
           while len(data) > 0:
               # Transfer the audio file's next byte chunk
               yield talk_service_pb2.StreamTalkRequest(
                   audio=audio_pb2.AudioStreamingRequest(
                       chunk=audio_pb2.AudioChunk(data=data)
                   )
               )
               data = fp.read(CHUNK_SIZE_BYTES)


   def upload_talk(connection_id: str, metadata: Dict[str, str], token: str, audio_path: str):
       # Establish a connection with the server
       credentials = grpc.ssl_channel_credentials()
       channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
       talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

       # Transfer a request iterator and get a response from the server
       response = talk_service_stub.UploadBadge(
           upload_audio_requests_iterator(connection_id, metadata, audio_path),
           metadata=[('authorization', token)]
       )

       print(f'Badge id: {response.id}')


   if __name__ == '__main__':
       parser = argparse.ArgumentParser()

       parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
       parser.add_argument('--key-type', required=False, help='Key type', choices=['iam-token', 'api-key'], default='iam-token', type=str)
       parser.add_argument('--connection-id', required=True, help='Connection Id', type=str)
       parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
       parser.add_argument('--meta-path', required=False, help='Talk metadata json', type=str, default=None)
       args = parser.parse_args()

       # Default values to use if metadata is not defined
       if args.meta_path is None:
           now = datetime.datetime.now().isoformat()
           metadata = {
               'operator_name': 'Operator',
               'operator_id': '1111',
               'client_name': 'Client',
               'client_id': '2222',
               'date': str(now),
               'direction_outgoing': 'true',
               'language': 'ru-ru'
           }
       else:
           with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)

       if args.key_type == 'iam-token':
           token = f'Bearer {args.key}'
       elif args.key_type == 'api-key':
           token = f'Api-Key {args.key}'

       upload_talk(args.connection_id, metadata, token, args.audio_path)
      ```

1. In the `upload_data` directory, create a file named `metadata.json` with your conversation metadata:

   ```json
   {
       "operator_name": "<agent_name>",
       "operator_id": "<agent_ID>",
       "client_name": "<customer_name>",
       "client_id": "<customer_ID>",
       "date": "<start_date>",
       "language": "<language>",
       <additional_connection_parameters>
   }
   ```

   The file's fields must match the parameters of the connection you are uploading audio recordings to. The template above shows the required fields for **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** type connections. If you added other parameters to the connection, specify them in the `metadata.json` file; e.g., to upload [linked dialogs](../../concepts/dialogs.md#related-dialogs), add the following parameter to your file:

   ```json
   {
      ...
      "ticket_id": "<task_number>"
   }
   ```

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}

1. Run the `upload_grpc.py` script with the following parameters:

   ```bash
   python3 upload_grpc.py \
      --audio-path <audio_file> \
      --meta-path <metadata> \
      --connection-id <connection_ID> \
      --key ${API_KEY}
   ```

   Where:

   * `--audio-path`: Path to the file with the dialog audio.
   * `--meta-path`: Path to the file with the dialog metadata.
   * `--connection-id`: ID of the connection you upload the data to.
   * `--key`: API key for authentication. If using an IAM token, specify the `IAM_TOKEN` environment variable instead of `API_KEY`.

1. If the script runs successfully, you will get a string with `Badge id`. Processing dialogs takes a while, so they will appear in the {{ speechsense-name }} console with a delay.
