# Speech synthesis in OggOpus format using API v1

With the [API v1](../request.md), you can synthesize speech from text with [TTS markup](../markup/tts-markup.md) to an [OggOpus](../../formats.md) file.

The example uses the following synthesis parameters:

* [Language](../index.md#langs): Russian.
* [Voice](../voices.md): `filipp`.
* Other parameters were left with their default values.

The Yandex account or federated account are authenticated using an [IAM token](../../../iam/concepts/authorization/iam-token.md). If you use your service account, you do not need to include the folder ID in the request. For more information about authentication in the {{ speechkit-name }} API, see [{#T}](../../concepts/auth.md).

{% list tabs %}

- cURL

   Send the [request](../request.md) to convert speech to text:

   ```bash
   read -r -d '' TEXT << EOM
   > I'm Yandex Speech+Kit.
   > I can turn any text into speech.
   > Now y+ou can, too!
   EOM
   export FOLDER_ID=<folder ID>
   export IAM_TOKEN=<IAM token>
   curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=${TEXT}" \
     -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}" \
     "https://tts.{{ api-host }}/speech/v1/tts:synthesize" > speech.ogg
   ```

   Where:

   * `TEXT`: Text in [TTS markup](../markup/tts-markup.md) for synthesis.
   * `FOLDER_ID`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md).
   * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `lang`: [Language](../index.md#langs) of the text.
   * `voice`: [Voice](../voices.md) for speech synthesis.

   The synthesized speech will be written to the `speech.ogg` file in the directory from which you sent your request.

- C#

   Send the [request](../request.md) to convert speech to text:

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
         const string iamToken = "<IAM token>"; // Specify the IAM token.
         const string folderId = "<folder ID>"; // Specify the folder ID.

         HttpClient client = new HttpClient();
         client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
         var values = new Dictionary<string, string>
         {
           { "text", "I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too! },
           { "lang", "ru-RU" },
           { "voice", "filipp" },
           { "folderId", folderId }
         };
         var content = new FormUrlEncodedContent(values);
         var response = await client.PostAsync("https://tts.{{ api-host }}/speech/v1/tts:synthesize", content);
         var responseBytes = await response.Content.ReadAsByteArrayAsync();
         File.WriteAllBytes("speech.ogg", responseBytes);
       }
     }
   }
   ```

   Where:

   * `iamToken`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `TEXT`: Text in [TTS markup](../markup/tts-markup.md) for synthesis.
   * `lang`: [Language](../index.md#langs) of the text.
   * `voice`: [Voice](../voices.md) for speech synthesis.

   The synthesized speech will be written to the `speech.ogg` file in the directory from which you sent your request.

- Python 3

   1. Create a file (for example, `test.py`), and add the following code to it:

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
             'folderId': folder_id
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

   * `lang`: [Language](../index.md#langs) of the text.
   * `voice`: [Voice](../voices.md) for speech synthesis.

   1. Run the created file:

      ```bash
      export FOLDER_ID=<folder ID>
      export IAM_TOKEN=<IAM token>
      python test.py
        --token ${IAM_TOKEN} \
       --folder_id ${FOLDER_ID} \
       --output speech.ogg \
       --text "I'm Yandex Sp+eechKit. I can turn any text into speech. Now y+ou can, too!
      ```

      Where:

      * `FOLDER_ID`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md).
      * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
      * `--output`: Name of the file for audio recording.
      * `--text`: Text in [TTS markup](../markup/tts-markup.md) for synthesis.

      The synthesized speech will be written to the `speech.ogg` file in the directory where you executed the file.

- PHP

   Send the [request](../request.md) to convert speech to text:

   ```php
   <?php

   $token = '<IAM token>'; # Specify an IAM token.
   $folderId = "<folder ID>"; # Specify a folder ID.

   $url = "https://tts.{{ api-host }}/speech/v1/tts:synthesize";
   $headers = ['Authorization: Bearer ' . $token];
   $post = array(
       'text' => "I'm Yandex Sp+eech kit. I can turn any text into speech. Now y+ou can, too!",
       'folderId' => $folderId,
       'lang' => 'ru-RU',
       'voice' => 'filipp');

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
       file_put_contents("speech.ogg", $response);
   }
   curl_close($ch);
   ```

   Where:

   * `token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
   * `folderId`: [Folder ID](../../../resource-manager/operations/folder/get-id.md).
   * `TEXT`: Text in [TTS markup](../markup/tts-markup.md) for synthesis.
   * `lang`: [Language](../index.md#langs) of the text.
   * `voice`: [Voice](../voices.md) for speech synthesis.

   The synthesized speech will be written to the `speech.ogg` file in the directory from which you sent your request.

{% endlist %}

#### See also {#see-also}

* [{#T}](../request.md)
* [{#T}](tts-wav.md)
* [{#T}](tts-ssml.md)
* [{#T}](../../concepts/auth.md)