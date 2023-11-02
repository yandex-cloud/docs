# Uploading audio data

Use this guide to upload data for API-based speech analysis to {{ speechsense-name }}. This example uses the following parameters:

* Audio format: WAV.
* The dialog metadata is stored in `metadata_example.json`.

An [IAM token](../../../iam/concepts/authorization/iam-token.md) or [IAM key](../../../iam/concepts/authorization/api-key.md) is used to [authenticate](../../api-ref/authentication.md) the service account.

## Getting started {#before-you-begin}

To use the API, you will need Git, Python 3.6 or higher, and the `grpcio-tools` package. [How to install Python](https://www.python.org/downloads/).

1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Install the `grpcio-tools` package using the [pip](https://pip.pypa.io/en/stable/) package manager:

   ```python
   pip install grpcio-tools
   ```

## Uploading data {#upload-data}

1. Go to the folder hosting the {{ yandex-cloud }} API repository, create an `upload-data` folder, and generate the client interface code there, then go to the `upload-data` folder:

   ```bash
   cd <path_to_cloudapi_directory> && \
   mkdir upload-data && \
   python3 -m grpc_tools.protoc -I . \
        --python_out=./upload-data/ \
        --grpc_python_out=./upload-data/ \
        yandex/cloud/speechsense/v1/talk_service.proto \
        yandex/cloud/speechsense/v1/audio.proto
   cd upload_data
   ```

1. Set the IAM token:

   ```bash
   export IAM_TOKEN=<IAM token>
   ```

1. In the `upload_data` folder, create an `upload_grpc.py` Python script to upload your data to a {{ speechsense-name }} connection.

   {% include [supported-formats](../../../_includes/speechsense/formats.md) %}

   {% cut "Uploading a file with one message" %}

   	```python
   	import argparse
   	import json
   	from typing import Dict

   	import grpc

   	from yandex.cloud.speechsense.v1 import talk_service_pb2
   	from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
   	from yandex.cloud.speechsense.v1 import audio_pb2


   	def upload_talk(connection_id: int, metadata: Dict[str, str], iam_token: str, audio_bytes: bytes):
	    credentials = grpc.ssl_channel_credentials()
	    channel = grpc.secure_channel('{{ speechsense-endpoint }}', credentials)
	    talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

	    request = talk_service_pb2.UploadTalkRequest(
	      metadata=talk_service_pb2.TalkMetadata(
		 connection_id=str(connection_id),
		 fields=metadata
	      ),
	      # Audio format: WAV
	      audio=audio_pb2.AudioRequest(
		 audio_metadata=audio_pb2.AudioMetadata(
		      container_audio=audio_pb2.ContainerAudio(
		          container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType. CONTAINER_AUDIO_TYPE_WAV
		          )
		      ),
		      audio_data=audio_pb2.AudioChunk(data=audio_bytes)
	      )
	    )
	    # Authorization type: IAM token
	    response = talk_service_stub.Upload(request, metadata=(
		 ('authorization', f'Bearer {iam_token}'),
	    ))
	    # Output the dialog ID
	    print(f'Dialog ID: {response.talk_id}')


   	if __name__ == '__main__':
	    parser = argparse.ArgumentParser()
	    parser.add_argument('--token', required=True, help='IAM token', type=str)
	    parser.add_argument('--connection-id', required=True, help='Connection Id', type=int)
	    parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
	    parser.add_argument('--meta-path', required=False, help='Talk metadata json', type=str,  default=None)
	    args = parser.parse_args()

	    # Default values to be used in case of missing metadata
	    if args.meta_path is None:
		 metadata = {
		      'operator_name': 'Operator',
		      'operator_id': '1111',
		      'client_name': 'Client',
		      'client_id': '2222',
		      'date_from': '2023-09-13T17:30:00.000',
		      'date_to': '2023-09-13T17:31:00.000',
		      'direction_outgoing': 'true',
	    }
	    else:
		 with open(args.meta_path, 'r') as fp:
		      metadata = json.load(fp)

	    with open(args.audio_path, 'rb') as fp:
		      audio_bytes = fp.read()
	    upload_talk(args.connection_id, metadata, args.token, audio_bytes)

   	```

   {% endcut %}

   {% cut "Data streaming" %}


   	```python
   	import argparse
   	import json
   	from typing import Dict

   	import grpc

   	from yandex.cloud.speechsense.v1 import talk_service_pb2
   	from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
   	from yandex.cloud.speechsense.v1 import audio_pb2

   	# Fragment size: 1 MB
   	CHUNK_SIZE_BYTES = 1024
   	
   	def upload_audio_requests_iterator(connection_id: int, metadata: Dict[str, str], audio_path: str):
	    yield talk_service_pb2.StreamTalkRequest(
		metadata=talk_service_pb2.TalkMetadata(
		     connection_id=str(connection_id),
		     fields=metadata
		)
	    )
	    with open(audio_path, mode='rb') as fp:
		data = fp.read(CHUNK_SIZE_BYTES)
		while data != b'':
		     yield talk_service_pb2.StreamTalkRequest(
		        audio=talk_service_pb2.AudioStreamingRequest(
		            audio_metadata=audio_pb2.AudioMetadata(
		                container_audio=audio_pb2.ContainerAudio(
		                    container_audio_type=audio_pb2.ContainerAudio.ContainerAudioTyp  CONTAINER_AUDIO_TYPE_WAV
		                )
		            ),
		            audio_data=audio_pb2.AudioChunk(data=data)
		        )
		     )
		     data = fp.read(CHUNK_SIZE_BYTES)


   	def upload_talk(connection_id: int, metadata: Dict[str, str], iam_token: str, audio_path: str):
	    credentials = grpc.ssl_channel_credentials()
	    channel = grpc.secure_channel('api.talk-analytics.yandexcloud.net:443', credentials)
	    talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

	    # Authorization type: IAM token
	    response = talk_service_stub.UploadAsStream(
		upload_audio_requests_iterator(connection_id, metadata, audio_path),
		metadata=(('authorization', f'Bearer {iam_token}'),)
	    )

	    # Output the dialog ID
	    print(f'Dialog ID: {response.talk_id}')


   	if __name__ == '__main__':
	    parser = argparse.ArgumentParser()
	    parser.add_argument('--token', required=True, help='IAM token', type=str)
	    parser.add_argument('--connection-id', required=True, help='IAM token', type=int)
	    parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
	    parser.add_argument('--meta-path', required=False, help='Talk metadata json', type=str,  default=None)
	    args = parser.parse_args()

	    # Default values to be used in case of missing metadata
	    if args.meta_path is None:
		metadata = {
		    'operator_name': 'Operator',
		    'operator_id': '1111',
		    'client_name': 'Client',
		    'client_id': '2222',
		    'date_from': '2023-09-13T17:30:00.000',
		    'date_to': '2023-09-13T17:31:00.000',
		    'direction_outgoing': 'true',
		}
	    else:
		with open(args.meta_path, 'r') as fp:
		    metadata = json.load(fp)

	    upload_talk(args.connection_id, metadata, args.token, args.audio_path)

   	```

   {% endcut %}

1. Run the `upload_grpc.py` script with the following parameters:

    ```bash
    python3 upload_grpc.py \
        --audio-path <audio_file> \
        --meta-path <metadata> \
        --connection-id <connection_ID> \
        --token-type iam-token \
        --token ${IAM_TOKEN}
    ```

    Where:

    * `audio-path`: Path to the audio file with the dialog.
    * `meta-path`: Path to the file with the dialog metadata.
    * `connection-id`: ID of the connection you upload the data to.
    * `token-type`: Authentication method. Possible values are `iam-token` or `api-key` depending on the used authorization type.
    * `token`: Value of the token used for authorization.
