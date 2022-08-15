# Synthesize speech in WAV format using API v1

In this example, we synthesize the submitted text in LPCM format with a sampling rate of 48kHz and save it to the file `speech.raw`. This file is then converted to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

[API v1](../request) is used for synthesis.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

1. Synthesize a file in LCPM format, specifying the [folder ID](../../../resource-manager/operations/folder/get-id.md) and [IAM token](../../../iam/concepts/authorization/iam-token.md) in the parameters:

   {% list tabs %}

   - cURL

      Send the [request](../request.md) to convert speech to text, specifying the following in its parameters:
      * `text`: Text to be recognized with the applied URL encoding.
      * `lang`: [Language](../index.md#langs) of the text.
      * `voice`: [Voice](../voices.md) for speech synthesis.
      * `folderId`: ID of the folder.
      * `IAM_TOKEN`: IAM token.

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
       -o speech.raw \
       --data-urlencode "text=${TEXT}" \
       -d "lang=ru-RU&voice=filipp&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
       https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
      ```

   - C#

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
              { "folderId", folderId },
              { "format", "lpcm" },
              { "sampleRateHertz", "48000" }
            };
            var content = new FormUrlEncodedContent(values);
            var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
            var responseBytes = await response.Content.ReadAsByteArrayAsync();
            File.WriteAllBytes("speech.raw", responseBytes);
          }
        }
      }
      ```

   - Python 3

      * Create a file (for example, `test.py`), and add the following code to it:

         ```python
         import argparse
         import requests


         def synthesize(folder_id, iam_token, text):
             url = 'https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize'
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

      * Execute the created file by passing arguments with the [folder ID](../../../resource-manager/operations/folder/get-id.md), [IAM token](../../../iam/concepts/authorization/iam-token.md), text, and name of the file for audio recording:

         ```bash
         export FOLDER_ID=<folder ID>
         export IAM_TOKEN=<IAM token>
         python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --output speech.raw --text "I'm Yandex SpeechK+it. I can turn any text into speech. Now y+ou can, too!
         ```

   - PHP

      ```php
      <?php

      $token = '<IAM token>'; # Specify an IAM token.
      $folderId = "<folder ID>"; # Specify a folder ID.

      $url = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize";
      $headers = ['Authorization: Bearer ' . $token];
      $post = array(
          'text' => "I'm Yandex Sp+eech kit. I can turn any text into speech. Now y+ou can, too!",
          'folderId' => $folderId,
          'sampleRateHertz' => '48000',
          'lang' => 'ru-RU',
          'voice' => 'filipp',
          'format' => 'lpcm');

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

   {% endlist %}

1. Convert the file to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

   ```bash
   sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
   ```
