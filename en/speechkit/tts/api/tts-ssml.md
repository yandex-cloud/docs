# Synthesize speech from SSML text using API v1

In this example, [API v1](../request.md) is used for synthesis, text is marked up according to [SSML rules](../ssml.md).

The synthesized speech will be recorded to an [OggOpus](../../formats.md) audio file.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

{% list tabs %}

- Bash

   1. Create a file (for example, `text.xml`) and enter text in the SSML format:

      {% include [ssml-example](../../../_includes/speechkit/ssml-example.md) %}

   1. Send the request with the text to the server, specifying the [folder ID](../../../resource-manager/operations/folder/get-id.md) and [IAM token](../../../iam/concepts/authorization/iam-token.md) in its parameters. Pass the text in the `ssml` parameter. In this example, the contents of the file are read using the [cat](https://en.wikipedia.org/wiki/Cat_(Unix)) utility:

      ```bash
      export FOLDER_ID=<folder ID>
      export IAM_TOKEN=<IAM token>
      curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        --data-urlencode "ssml=`cat text.xml`" \
        -d "lang=ru-RU&folderId=${FOLDER_ID}" \
        "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
      ```

{% endlist %}
