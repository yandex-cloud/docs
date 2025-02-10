#  Speech synthesis in WAV format using the API v1


The example shows how you can use the [API v1](../request.md) to synthesize speech from text in [TTS markup](../markup/tts-markup.md) to a [WAV file](https://en.wikipedia.org/wiki/WAV).

The example uses the following synthesis parameters:
* Synthesized audio file [format](../../formats.md): LPCM with a sample rate of 48,000 Hz, [WAV](https://en.wikipedia.org/wiki/WAV) container.
* [Language](../index.md#langs): Russian
* [Voice](../voices.md): `filipp`

Conversion and recording the result in WAV are performed using the [SoX](http://sox.sourceforge.net/) utility.

The Yandex account or federated account are authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md). If using a service account, you do not need to include the folder ID in the request. To learn more about {{ speechkit-name }} API authentication, see [{#T}](../../concepts/auth.md).

1. Synthesize a file in LPCM format:

   {% list tabs group=programming_language %}

   - cURL {#curl}

     Submit a text-to-speech conversion [request](../request.md):

     ```bash
     read -r -d '' TEXT << EOM
     > I'm Yandex Speech+Kit.
     > I can turn any text into speech.
     > Now y+ou can, too!
     EOM
     export FOLDER_ID=<folder_ID>
     export IAM_TOKEN=<IAM_token>
     curl \
       --request POST \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --output speech.raw \
       --data-urlencode "text=${TEXT}" \
       --data "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
       https://tts.{{ api-host }}/speech/v1/tts:synthesize
     ```

     Where:

     * `TEXT`: Text for synthesis in [TTS markup](../markup/tts-markup.md).
     * `FOLDER_ID`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
     * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
     * `lang`: Text [language](../index.md#langs).
     * `voice`: [Voice](../voices.md) for speech synthesis.
     * `format`: Synthesized audio file [format](../../formats.md).
     * `sampleRateHertz`: Sample rate of the [LPCM](../../formats.md#LPCM) audio file.

   - C# {#csharp}

     Submit a text-to-speech conversion [request](../request.md):

     ```c#
     using System;
     using System.Collections.Generic;
     using System.Net.Http;
     using System.Threading.Tasks;
     using System.IO;

     namespace TTS
     {
       class Program
       {
         static void Main()
         {
           Tts().GetAwaiter().GetResult();
         }

         static async Task Tts()
         {
           const string iamToken = "<IAM_token>";
           const string folderId = "<folder_ID>";

           HttpClient client = new HttpClient();
           client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
           var values = new Dictionary<string, string>
           {
             { "text", "I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!" },
             { "lang", "ru-RU" },
             { "voice", "filipp" },
             { "folderId", folderId },
             { "format", "lpcm" },
             { "sampleRateHertz", "48000" }
           };
           var content = new FormUrlEncodedContent(values);
           var response = await client.PostAsync("https://tts.{{ api-host }}/speech/v1/tts:synthesize", content);
           var responseBytes = await response.Content.ReadAsByteArrayAsync();
           File.WriteAllBytes("speech.raw", responseBytes);
         }
       }
     }
     ```

     Where:

     * `iamToken`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
     * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
     * `text`: Text for synthesis in [TTS markup](../markup/tts-markup.md).
     * `lang`: Text [language](../index.md#langs).
     * `voice`: [Voice](../voices.md) for speech synthesis.
     * `format`: Synthesized audio file [format](../../formats.md).
     * `sampleRateHertz`: Sample rate of the [LPCM](../../formats.md#LPCM) audio file.

   - Python 3 {#python}

     * Create a file (e.g., `test.py`), and add the following code to it:

       ```python
       import argparse
       import requests

       def synthesize(folder_id, iam_token, text):
           url = 'https://tts.{{ api-host }}/speech/v1/tts:synthesize'
           headers = {
               'Authorization': 'Bearer ' + iam_token,
           }

           data = {
               'text': text,
               'lang': 'ru-RU',
               'voice': 'filipp',
               'folderId': folder_id,
               'format': 'lpcm',
               'sampleRateHertz': 48000,
           }

           with requests.post(url, headers=headers, data=data, stream=True) as resp:
               if resp.status_code != 200:
                   raise RuntimeError("Invalid response received: code: %d, message: %s" % (resp.status_code, resp.text))

               for chunk in resp.iter_content(chunk_size=None):
                   yield chunk


       if __name__ == "__main__":
           parser = argparse.ArgumentParser()
           parser.add_argument("--token", required=True, help="IAM token")
           parser.add_argument("--folder_id", required=True, help="Folder id")
           parser.add_argument("--text", required=True, help="Text for synthesize")
           parser.add_argument("--output", required=True, help="Output file name")
           args = parser.parse_args()

           with open(args.output, "wb") as f:
               for audio_content in synthesize(args.folder_id, args.token, args.text):
                   f.write(audio_content)
          ```

          Where:

          * `lang`: Text [language](../index.md#langs).
          * `voice`: [Voice](../voices.md) for speech synthesis.
          * `format`: Synthesized audio file [format](../../formats.md).
          * `sampleRateHertz`: Sample rate of the [LPCM](../../formats.md#LPCM) audio file.

     * Run the created file:

       ```bash
       export FOLDER_ID=<folder_ID>
       export IAM_TOKEN=<IAM_token>
       python3 test.py
         --token ${IAM_TOKEN}
         --folder_id ${FOLDER_ID}
         --output speech.raw
         --text "I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!"
       ```

       Where:

       * `FOLDER_ID`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
       * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
       * `--output`: Name of the file for the audio.
       * `--text`: Text for synthesis in [TTS markup](../markup/tts-markup.md).

   - PHP {#php}

     Submit a text-to-speech conversion [request](../request.md):

     ```php
     <?php

     $token = '<IAM_token>'; # Specify an IAM token.
     $folderId = "<folder_ID>"; #: Specify a folder ID.

     $url = "https://tts.{{ api-host }}/speech/v1/tts:synthesize";
     $headers = ['Authorization: Bearer ' . $token];
     $post = array(
         'text' => "I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!",
         'folderId' => $folderId,
         'lang' => 'ru-RU',
         'voice' => 'filipp',
         'format' => 'lpcm',
         'sampleRateHertz' => '48000');

     $ch = curl_init();

     curl_setopt($ch, CURLOPT_AUTOREFERER, TRUE);
     curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
     curl_setopt($ch, CURLOPT_URL, $url);
     curl_setopt($ch, CURLOPT_FOLLOWLOCATION, TRUE);
     curl_setopt($ch, CURLOPT_HEADER, false);
     if ($post !== false) {
         curl_setopt($ch, CURLOPT_POST, 1);
         curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
     }
     curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

     $response = curl_exec($ch);
     if (curl_errno($ch)) {
         print "Error: " . curl_error($ch);
     }
     if (curl_getinfo($ch, CURLINFO_HTTP_CODE) != 200) {
         $decodedResponse = json_decode($response, true);
         echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
         echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
     } else {
         file_put_contents("speech.raw", $response);
     }
     curl_close($ch);
     ```

     Where:

     * `token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
     * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
     * `text`: Text for synthesis in [TTS markup](../markup/tts-markup.md).
     * `lang`: Text [language](../index.md#langs).
     * `voice`: [Voice](../voices.md) for speech synthesis.
     * `format`: Synthesized audio file [format](../../formats.md).
     * `sampleRateHertz`: Sample rate of the [LPCM](../../formats.md#LPCM) audio file.

   {% endlist %}

1. Convert the resulting file to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

   ```bash
   sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
   ```

#### See also {#see-also}

* [{#T}](../request.md)
* [{#T}](tts-ogg.md)
* [{#T}](tts-ssml.md)
* [{#T}](../../concepts/auth.md)
