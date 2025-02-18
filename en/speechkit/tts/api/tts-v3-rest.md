# Speech synthesis in the REST API v3

You can use the REST API v3 in {{ speechkit-name }} to synthesize speech if you do not need the benefits of the gRPC API.

The example uses the following synthesis parameters:

* [Voice](../voices.md): `marina`
* Role: `friendly`
* Audio format: WAV (default)

Authentication takes place under a Yandex account or a federated account using an [IAM token](../../../iam/concepts/authorization/iam-token.md). Authentication requires the ID of the folder in which the user has the `{{ roles-speechkit-tts }}` role [to work with {{ speechkit-name }}](../../security/index.md). If using a service account, you do not need to include the folder ID in the request. To learn more about {{ speechkit-name }} API authentication, see [{#T}](../../concepts/auth.md).

{% list tabs group=programming_language %}

- cURL {#curl}

  To reproduce this example, you will need the [jq](https://github.com/jqlang/jq) utility to work with JSON files.

  1. Create the `request.json` file with the following request parameters:

    ```json
    {"text": "Hi! I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!", "hints": [{"voice": "marina"}, {"role": "friendly"}]}
    ```

    Where:
    * `text`: Text to synthesize
    * `hints`: List of synthesis parameters:
        * `voice`: Voice for synthesis
        * `role`: Role

  1. Get the folder ID and the IAM token for the account you will use with {{ speechkit-name }}, and include them in the request headers.

    ```bash
    export FOLDER_ID=<folder_ID>
    export IAM_TOKEN=<IAM_token>

    curl \
      --header "Authorization: Bearer $IAM_TOKEN" \
      --header "x-folder-id: $FOLDER_ID" \
      --data @request.json https://{{ api-host-sk-tts }}:443/tts/v3/utteranceSynthesis | \
      jq -r  '.result.audioChunk.data' | \
      while read chunk; do base64 -d <<< "$chunk" >> audio.wav; done
    ```

    Where:
    * `FOLDER_ID` is the [ID of the folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-speechkit-tts }}` role or higher.
    * `IAM_TOKEN`: IAM token of your [Yandex account](../../../iam/operations/iam-token/create.md) or [federated account](../../../iam/operations/iam-token/create-for-federation.md).

    The synthesized speech will be Base64 encoded and saved to a file named `audio.wav`.

{% endlist %}
