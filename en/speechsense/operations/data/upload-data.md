---
title: Uploading audio data
description: Follow this guide to upload audio data to {{ speechsense-name }}
---

# Uploading audio data

Use this guide to upload data for API-based speech analysis to {{ speechsense-name }}. This example uses the following parameters:

* [Audio format](../../concepts/formats.md): WAV.
* The dialog metadata is stored in `metadata_example.json`.

{% include [authentication](../../../_includes/speechsense/data/authentication.md) %}

If you want to upload the chat text instead of voice call audio, follow [this guide](upload-chat-text.md).

## Getting started {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

To prepare for uploading audio recordings:

1. [Create a connection](../connection/create.md#create-audio-connection) of the **Two-channel audio** type.
1. [Create a project](../project/create.md) with the new connection.

   Voice call recordings will be uploaded to the project and connection you created.

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

## Uploading data {#upload-data}

1. {% include [interface-code-generation](../../../_includes/speechsense/data/interface-code-generation.md) %}
1. In the `upload_data` folder, create the `upload_grpc.py` Python script to upload your data to a {{ speechsense-name }} connection as a single message:

      ```python
      import argparse
      import json
      from typing import Dict
      import grpc
      import datetime

      from yandex.cloud.speechsense.v1 import talk_service_pb2
      from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
      from yandex.cloud.speechsense.v1 import audio_pb2

      # For IAM token authentication, replace the `api_key` parameter with `iam_token`
      def upload_talk(connection_id: int, metadata: Dict[str, str], api_key: str, audio_bytes: bytes):
         credentials = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('{{ speechsense-endpoint }}', credentials)
         talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

      # Forming a request to the API
         request = talk_service_pb2.UploadTalkRequest(
            metadata=talk_service_pb2.TalkMetadata(
               connection_id=str(connection_id),
               fields=metadata
            ),
            # Audio format: WAV
            audio=audio_pb2.AudioRequest(
               audio_metadata=audio_pb2.AudioMetadata(
                  container_audio=audio_pb2.ContainerAudio(
                     container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType.CONTAINER_AUDIO_TYPE_WAV
                  )
               ),
               audio_data=audio_pb2.AudioChunk(data=audio_bytes)
            )
         )
         # Authentication type: API key
         response = talk_service_stub.Upload(request, metadata=(
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
         parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
         parser.add_argument('--meta-path', required=False, help='JSON with the dialog metadata', type=str, default=None)
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
               'date_from': '2023-09-13T17:30:00.000',
               'date_to': '2023-09-13T17:31:00.000',
               'direction_outgoing': 'true',
            }
         else:
            with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)

         with open(args.audio_path, 'rb') as fp:
            audio_bytes = fp.read()
         upload_talk(args.connection_id, metadata, args.key, audio_bytes)
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

   * `--audio-path`: Path to the audio file with the dialog.
   * `--meta-path`: Path to the file with the dialog metadata.
   * `--connection-id`: ID of the connection you upload the data to.
   * `--key`: API key for authentication. If using an IAM token, specify the `IAM_TOKEN` environment variable instead of `API_KEY`.
