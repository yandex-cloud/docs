# Speech synthesis in the REST API v3

You can use the REST API v3 in {{ speechkit-name }} to synthesize speech if you do not need the benefits of the gRPC API.

The example uses the following synthesis parameters:

* [Voice](../voices.md): `marina`
* Role: `friendly`
* Audio format: WAV (default)

Authentication takes place under a Yandex account or a federated account using an [IAM token](../../../iam/concepts/authorization/iam-token.md). Authentication requires the ID of the folder in which the user has the `{{ roles-speechkit-tts }}` role [to work with {{ speechkit-name }}](../../security/index.md). If you use your service account, you do not need to include the folder ID in the request. For more information about authentication in the {{ speechkit-name }} API, see [{#T}](../../concepts/auth.md).

{% list tabs group=programming_language %}

- cURL {#curl}

   To reproduce this example, you will need the [jq](https://github.com/jqlang/jq) utility to work with JSON files.

   1. Create a file called `request.json` with the following request parameters:

     ```json
     {"text": "Hi, I'm Yandex Speech+Kit. I can turn any text into speech. Now yo+u can, too!", "hints": [{"voice": "marina"}, {"role": "friendly"}]}
     ```

     Where:
     * `text`: Text to synthesize
     * `hints`: List of synthesis parameters:
         * `voice`: Voice for synthesis
         * `role`: Role


   1. Get an IAM token and [folder ID].

     ```bash
     export FOLDER_ID=<folder_ID>
     export IAM_TOKEN=<IAM_token>
  
     curl -H "Authorization: Bearer $IAM_TOKEN" \
          -H "x-folder-id: $FOLDER_ID" \
          -d @request.json https://tts.{{ api-host }}:443/tts/v3/utteranceSynthesis |
       jq -r  '.result.audioChunk.data' |
       while read chunk; do base64 -d <<< "$chunk" >> audio.wav; done
     ```

     Where:
     * `FOLDER_ID`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-speechkit-tts }}` role or higher.
     * `IAM_TOKEN`: IAM token of your [Yandex account](../../../iam/operations/iam-token/create.md) or [federated account](../../../iam/operations/iam-token/create-for-federation.md).


     The synthesized speech will be recorded to the `audio.wav` file.

{% endlist %}