# Synthesize speech from SSML text using API v1

The example shows how you can synthesize speech from [SSML](../ssml.md) text to an [OggOpus](../../formats.md) file using the [API v1](../request.md).

The example uses the following synthesis parameters:
* [Language](../index.md#langs): Russian.
* [Voice](../voices.md): `jane`.
* Other parameters were left with their default values.

The text file is read using the [cat](https://en.wikipedia.org/wiki/Cat_(Unix)) utility.

The Yandex account or federated account are authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md). If you use your service account, you don't need to pass the folder ID in the request. For more information about authentication in the {{speechkit-name}} API, see [{#T}](../../concepts/auth.md).

{% list tabs %}

- Bash

   1. Create a file (for example, `text.xml`) and enter text in the SSML format:

      {% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

   1. Send a request with the text to the server:

      ```bash
      export FOLDER_ID=<folder ID>
      export IAM_TOKEN=<IAM token>
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        --data-urlencode "ssml=`cat text.xml`" \
        -d "lang=ru-RU&voice=jane&folderId=${FOLDER_ID}" \
        "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
      ```

      Where:

      * `FOLDER_ID`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md).
      * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
      * `ssml`: File with text marked up according to [SSML](../ssml.md) rules.
      * `lang`: [Language](../index.md#langs) of the text.

   The synthesized speech will be written to the `speech.ogg` file in the folder from which you sent your request.

{% endlist %}

#### See also {#see-also}

* [{#T}](../request.md)
* [{#T}](tts-wav.md)
* [{#T}](tts-ogg.md)
* [{#T}](../../concepts/auth.md)