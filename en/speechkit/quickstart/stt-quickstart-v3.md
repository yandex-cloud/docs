# How to recognize streaming audio in {{ speechkit-short-name }}

In this section, you will learn how to use {{ speechkit-short-name }} [API v3]((../../stt-v3/api-ref/grpc/)) to recognize speech in real time from a ready-made file in [LPCM](../formats.md#LPCM) format.

To use the API, the `grpcurl` utility is required.

## Getting started {#before-you-begin}

1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Install the [grpcurl utility](https://github.com/fullstorydev/grpcurl#installation).
1. Install the [jq utility](https://stedolan.github.io/jq/) for piped processing of JSON files.

   ```bash
   sudo apt update && sudo apt install jq
   ```

   {% note info %}
   
   You can implement streaming audio recognition in {{ speechkit-short-name }} both using the specified utilities and in other ways.
   
   {% endnote %}

1. Download a [sample](https://{{ s3-storage-host }}/speechkit/speech.pcm) audio file for recognition.

## Speech recognition {#speech-recognition}

To recognize speech from a file in [streaming mode](../stt/streaming.md):

1. Go to the directory hosting the cloned {{ yandex-cloud }} API repository and create your working files there:

   * File with a part that initiates streaming requests to the API:

      {% cut "stt_req.json" %}

      ```json
      {
         "sessionOptions": {
           "recognitionModel": {
               "audioFormat": {
                   "rawAudio": {
                       "audioEncoding": "LINEAR16_PCM",
                       "sampleRateHertz": 8000,
                       "audioChannelCount": 1
                   }
               },
               "textNormalization": {
                   "textNormalization": "TEXT_NORMALIZATION_ENABLED",
                   "profanityFilter": true,
                   "literatureText": false
               },
               "languageRestriction": {
                   "restrictionType": "WHITELIST",
                   "languageCode": [
                       "ru-RU"
                   ]
               },
               "audioProcessingType": "REAL_TIME"
           }
         }
      }
      ```

      {% endcut %}

      Parts of streaming audio are additionally written to the file with the script below.

   * Speech recognition script:

      {% cut "script.sh" %}

      ```bash
      split -d -b 4000 <audio file path> part
      for i in $(ls part*)
      do
        base64 $i -o $i.bb
        DATA=$(cat "$i".bb)
        jq -n --arg data $DATA '{"chunk":{"data":$data}}' >> stt_req.json
      done
      rm part*
      jq . -c stt_req_full.json | \
      grpcurl -H "authorization: Bearer ${IAM_TOKEN}" \
          -H "x-folder-id: ${FOLDER_ID}" \
          -d @ \
          -proto yandex/cloud/ai/stt/v3/stt_service.proto \
          stt.api.cloud.yandex.net:443 speechkit.stt.v3.Recognizer/RecognizeStreaming | \
      jq -r '
          if .finalRefinement != null then
            .finalRefinement.normalizedText.alternatives[0].text
          elif .partial != null then
            .partial.alternatives[0].text
          elif .final != null then
            .final.alternatives[0].text
          else
            .audioCursors.finalIndex end'
      ```

      {% endcut %}

1. Run the following commands:

   ```bash
   export FOLDER_ID=<folder ID>
   export IAM_TOKEN=<IAM token>
   chmod 755 script.sh
   ./script.sh
   ```

   Where:

   * `FOLDER_ID`: Folder ID received [before starting](index.md#before-you-begin). If you are using the service account's IAM token, do not specify the folder ID in your request: the service uses the folder where the service account was created.
   * `IAM_TOKEN`: IAM token received [before starting](index.md#before-you-begin).

Recognized text will be output with intermediate and final recognition results:

```text
null
hello
hello
hello world
Hello world
null
null
1
```

#### See also {#what-is-next}

* [Learn more about the API v3](../../stt-v3/api-ref/grpc/)
* [Authentication in the API](../concepts/auth.md)
* [{#T}](../stt/models.md)
* [{#T}](../stt/api/streaming-examples-v3.md)
