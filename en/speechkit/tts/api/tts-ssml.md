# Speech synthesis from SSML text using API v1


With the [API v1](../request.md), you can synthesize speech from text marked up using [SSML](../markup/ssml.md) to an [OggOpus](../../formats.md) file.

The example uses the following synthesis parameters:

* [Language](../index.md#langs): Russian.
* [Voice](../voices.md): `jane`.
* Other parameters are left at their defaults.

The text file is read using the [cat](https://en.wikipedia.org/wiki/Cat_(Unix)) utility.

The Yandex account or federated account are authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md). If using a service account, you do not need to include the folder ID in the request. To learn more about {{ speechkit-name }} API authentication, see [{#T}](../../concepts/auth.md).

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Create a file, e.g., `text.xml`, and add into it this text in SSML format:

     {% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

  1. Send a request with the text to the server:

     ```bash
     export FOLDER_ID=<folder_ID>
     export IAM_TOKEN=<IAM_token>
     curl \
       --request POST \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data-urlencode "ssml=`cat text.xml`" \
       --data "lang=ru-RU&voice=jane&folderId=${FOLDER_ID}" \
       "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
     ```

     Where:

     * `FOLDER_ID`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
     * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
     * `ssml`: File with text marked up according to [SSML](../markup/ssml.md) rules.
     * `lang`: Text [language](../index.md#langs).

  The synthesized speech will be written to the `speech.ogg` file in the folder you sent your request from.

{% endlist %}

#### See also {#see-also}

* [{#T}](../request.md)
* [{#T}](tts-wav.md)
* [{#T}](tts-ogg.md)
* [{#T}](../../concepts/auth.md)