# Performing speech recognition using the Cloud STT API

Speech recognition (Speech-to-Text, STT) is the process of converting speech to text. In this speech recognition scenario, {{ cloud-stt-api-name }} is used.

Three options for speech recognition are considered:

- Streaming recognition: Lets you get real-time recognition results suitable for audio recognition <q>on the fly</q>.
- Long audio recognition: Used to recognize audio files up to {{ stt-long-fileSize }} in size and with a maximum duration of {{ stt-long-audioLength }}. It is well suited for cases where the response speed is not critical.
- Short audio recognition: Used to recognize audio files up to {{ stt-short-fileSize }} in size with a maximum duration of {{ stt-short-audioLength }} and no more than {{ stt-short-channelsCount }} channels.

Take a look at different {{ cloud-stt-api-name }} use cases:

1. [{#T}](#satisfy-dependencies).
1. [{#T}](#generate-client-library-code).
1. [{#T}](#authorization).
1. [{#T}](#streaming-audio-recognition).
1. [{#T}](#long-audio-recognition).
1. [{#T}](#short-audio-recognition).
1. [{#T}](#results).

## Before you start {#before-you-begin}

1. If you don't have a service account, [create one](../iam/quickstart-sa.md#create-sa).

1. Get an [API key](../iam/operations/api-key/create.md) for your service account.

1. Get [static access keys](../iam/operations/sa/create-access-key.md) to your {{ objstorage-name }}.

1. [Create a bucket in {{ objstorage-name }}](../storage/operations/buckets/create.md) and name it `audio-examples`.

1. [Grant the service account permission](../storage/operations/buckets/edit-acl.md) to read and write data in the `audio-examples` bucket.

1. [Create a project](../datasphere-old/operations/projects/create.md) in {{ ml-platform-name }} and open it.

1. [Clone](../datasphere-old/operations/projects/work-with-git.md#clone) the Git repository that contains the {{ yandex-cloud }} API source code:

    ```text
    https://github.com/yandex-cloud/cloudapi
    ```

1. Clone the Git repository that contains the notebooks with the {{ yandex-cloud }} API usage examples:

    ```text
    https://github.com/yandex-cloud/examples
    ```

1. Wait until cloning is complete. It may take some time.

    Once the operation is complete, folders of the cloned repositories will appear in the **File Browser** section.

1. Open the `/examples/speechkitpro/recognize_api/` folder and then the `recognize_api.ipynb` notebook.

## Install dependencies {#satisfy-dependencies}

1. Select the first cell by clicking to the left of it:

    ```python
    %pip install grpcio-tools
    ```

1. Run this cell. To do this, choose **Run → Run Selected Cells** or press **Shift** + **Enter**.

    {% include [safe-state](../_includes/datasphere/safe-state.md) %}

1. Wait for the operation to complete.

## Generate the client library code {#generate-client-library-code}

1. Select the second cell of the notebook and run it:

    ```bash
    #!:bash
    python3 -m grpc_tools.protoc -I cloudapi -I cloudapi/third_party/googleapis --python_out=. --grpc_python_out=. google/api/http.proto google/api/annotations.proto yandex/cloud/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v2/stt_service.proto
    ```

1. Wait for the operation to complete.

## Specify data required for authentication {#authorization}

1. Enter your API key in the third cell of the notebook and run it:

    ```python
    API_KEY = '<API key>'
    ```

1. Specify the keys for the service account's static access to {{ objstorage-name }} in the fourth cell of the notebook and run it:

    ```python
    AWS_ACCESS_KEY_ID = '<key id>'
    AWS_SECRET_ACCESS_KEY = '<secret key>'
    ```

## Use streaming audio recognition {#streaming-audio-recognition}

Streaming mode lets you simultaneously send audio for recognition and get recognition results within the same connection. For more information, see [{#T}](../speechkit/stt/streaming.md).

In the **Streaming audio recognition** section, the files from the folder with audio recordings are analyzed one by one. For each file:

1. In the first request to the Cloud STT API, the specification is passed: the type of model used, the audio recording language, the sample rate, and so on.
1. The contents of the file are divided into parts `CHUNK_SIZE` bytes in size. They are passed in requests to {{ cloud-stt-api-name }}.
1. The recognition results of all parts of the file are combined and output.

To start streaming speech recognition:

1. Select all the cells in the **Streaming audio recognition** section by holding **Shift** and clicking to the left of the desired cells.
1. Run the selected cells.
1. Wait for the operation to complete.

As a result, the audio recordings from the `/examples/speechkitpro/recognize_api/audio/` folder are recognized. To select a different folder, change the code in the notebook cell:

```python
audio_dir = Path('examples', 'speechkitpro', 'recognize_api', 'audio')
```

## Send long audio recordings for recognition {#long-audio-recognition}

Long audio recognition is recommended when the response time is not critical. This method is [slightly cheaper](../speechkit/pricing.md) than other recognition methods and is suitable for multi-channel audio files up to {{ stt-long-fileSize }} in size.

An audio recording is considered long if it meets the following conditions:

1. The file size is larger than {{ stt-short-fileSize }}.
1. It's longer than {{ stt-short-audioLength }}.
1. The number of audio channels is greater than {{ stt-short-channelsCount }}.

For more information, see [{#T}](../speechkit/stt/transcribation.md).

In the **Long audio recognition** section, the following operations are performed:

1. Setting up a connection to the `audio-examples` S3 bucket.
1. Uploading long audio files to the bucket.
1. For each file uploaded to the bucket:
    1. A link to be used when calling {{ cloud-stt-api-name }} is created. In response, the API returns the recognition operation ID.
    1. The status of the operation with the specified ID is checked in the loop.
    1. If the recognition operation is complete, the recognized text is extracted from the results of the request to {{ cloud-stt-api-name }}.

To recognize long audio files:

1. Select all the cells with the code in the **Long audio recognition** section:
1. Run the selected cells.
1. Wait for the operation to complete.

## Send short audio recordings for recognition {#short-audio-recognition}

Recognition of short audio recordings is fast and suitable for small single-channel audio files.

An audio recording is considered short if it meets the following conditions:

1. Maximum file size: {{ stt-short-fileSize }}.
1. Maximum length: {{ stt-short-audioLength }}.
1. Maximum number of audio channels: {{ stt-short-channelsCount }}.

For more information, see [{#T}](../speechkit/stt/request.md).

In the **Short audio recognition** section, the following operations are performed:

1. Analyzing the files from the folder with audio recordings.
1. Each file is passed in its entirety in a request to {{ cloud-stt-api-name }}.
1. In response, {{ cloud-stt-api-name }} returns the recognized text.

To recognize short audio files:

1. Select all cells with code in the **Short audio recognition** section:
1. Run the selected cells.
1. Wait for the operation to complete.

## Review the recognition results {#results}

The results of file recognition are strings like:

```text
<file name>: <recognized text>
```

Depending on the recognition method you select, the file output order and results may differ.

