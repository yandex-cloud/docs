# API method description

Generates speech from received text.

## HTTP request {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

## Parameters in the request body {#body_params}

All parameters must be URL-encoded. The maximum size of the POST request body is 15 KB.

| Parameter | Description |
| ----- | ----- |
| text | **string**<br>UTF-8 encoded text to be converted to speech.<br>You can only use one `text` and `ssml` field.<br>For homographs, place a `+` before the stressed vowel. For example, `contr+ol` or `def+ect`.<br>To indicate a pause between words, use `-`.<br>Maximum string length: 5000 characters. |
| ssml | **string**<br>Text in [SSML format](ssml.md) to be converted into speech.<br>You can only use one `text` and `ssml` fields. |
| lang | **string**<br>Language.<br/>Acceptable values:<ul><li>`ru-RU` (default) — Russian.</li><li>`en-US` — English.</li><li>`tr-TR` — Turkish.</li></ul> |
| voice | **string**<br>Preferred speech synthesis voice from the [list](voices.md). Default value: `oksana`.<br/>For more information about choosing a voice, see [{#T}](./index.md#voices). |
| emotion | (deprecated) **string**<br>The emotional tone of the voice. This feature is supported only when you select Russian (`ru-RU`) with `jane` or `omazh`.<br/>Accepted values:<ul><li>`good`: Friendly.</li><li>`evil`: Irritated.</li><li>`neutral` (default): Emotionless.</li></ul> |
| speed | **string**<br>Rate (speed) of synthesized speech.<br/>The rate of speech is set as a decimal number in the range from `0.1` to `3.0`. Where:<ul><li>`3.0` — Fastest rate.</li><li>`1.0` (default) — Average human speech rate.</li><li>`0.1` — Slowest speech rate.</li></ul> |
| format | **string**<br>The format of the synthesized audio.<br/>Acceptable values:<ul><li>`lpcm` — Audio file is synthesized in [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format with no WAV header. Audio properties:<ul><li>Sampling — 8, 16, or 48 kHz, depending on the value of the `sampleRateHertz` parameter.</li><li>Bit depth — 16-bit.</li><li>Byte order — Reversed (little-endian).</li><li>Audio data is stored as signed integers.</li></ul></li><li>`oggopus` (default) — Data in the audio file is encoded using the OPUS audio codec and compressed using the OGG container format ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul> |
| sampleRateHertz | **string**<br>The sampling frequency of the synthesized audio.<br/>Used if `format` is set to `lpcm`. Acceptable values:<ul><li>`48000` (default) — Sampling rate of 48 kHz.</li><li>`16000` — Sampling rate of 16 kHz.</li><li>`8000` — Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>ID of the folder that you have access to. Required for authorization with a user account (see the <a href="../../iam/api-ref/UserAccount/index#representation">UserAccount</a> resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

## Response {#response}

If speech synthesis is successful, the response contains the binary content of the audio file. The output data format depends on the value of the `format` parameter.

## Examples {#examples}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

### Convert text to speech in OggOpus format {#ogg}

In this example, the text "Hello world" is synthesized and recorded as an audio file.

By default, data in the audio file is encoded using the OPUS audio codec and compressed using the OGG container format ([OggOpus](https://wiki.xiph.org/OggOpus)).

{% list tabs %}

- cURL

  ```bash
  $ export FOLDER_ID=b1gvmob95yysaplct532
  $ export IAM_TOKEN=CggaATEVAgA...
  $ curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       --data-urlencode "text=Hello World" \
       -d "lang=en-US&folderId=${FOLDER_ID}" \
       "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
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
        const string iamToken = "CggaATEVAgA..."; // Specify the IAM token.
        const string folderId = "b1gvmob95yysaplct532"; // Specify the folder ID.

        HttpClient client = new HttpClient();
        client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
        var values = new Dictionary<string, string>
        {
          { "text", "Hello World" },
          { "lang", "en-US" },
          { "folderId", folderId }
        };
        var content = new FormUrlEncodedContent(values);
        var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
        var responseBytes = await response.Content.ReadAsByteArrayAsync();
        File.WriteAllBytes("speech.ogg", responseBytes);
      }
    }
  }
  ```

- Python 3

  1. Create a file (for example, `test.py`), and add the following code to it:

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
              'lang': 'en-US',
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

  1. Execute the created file by passing arguments with the IAM token, folder ID, text, and name of the file for audio recording:

      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --output speech.ogg --text "Hello World"
      ```

- PHP

  ```php
  <?

  $token = 'CggaATEVAgA...'; # IAM token
  $folderId = "b1gvmob95yysaplct532"; # ID of the folder
  $url = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize";

  $post = "text=" . urlencode("Hello World") . "&lang=en-US&folderId=${folderId}";
  $headers = ['Authorization: Bearer ' . $token];
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

{% endlist %}

### Convert text to speech in WAV format {#wav}

In this example, we synthesize the submitted text in LPCM format with a sampling rate of 48kHz and save it to the file `speech.raw`. This file is then converted to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

1. Synthesize a file in LCPM format:

    {% list tabs %}

    - cURL

      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -o speech.raw \
          --data-urlencode "text=Hello World" \
          -d "lang=en-US&folderId=${FOLDER_ID}&format=lpcm&sampleRateHertz=48000" \
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
            const string iamToken = "CggaATEVAgA..."; // Specify the IAM token.
            const string folderId = "b1gvmob95yysaplct532"; // Specify the folder ID.

            HttpClient client = new HttpClient();
            client.DefaultRequestHeaders.Add("Authorization", "Bearer " + iamToken);
            var values = new Dictionary<string, string>
            {
              { "text", "Hello World" },
              { "lang", "en-US" },
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

      1. Create a file (for example, `test.py`), and add the following code to it:

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
                  'lang': 'en-US',
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

      1. Execute the created file by passing arguments with the IAM token, folder ID, text, and name of the file for audio recording:

          ```bash
          $ export FOLDER_ID=b1gvmob95yysaplct532
          $ export IAM_TOKEN=CggaATEVAgA...
          $ python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --output speech.raw --text "Hello World"
          ```

    - PHP

      ```php
      <?

      const FORMAT_PCM = "lpcm";
      const FORMAT_OPUS = "oggopus";

      $token = 'CggaATEVAgA...'; # IAM token
      $folderId = "b1gvmob95yysaplct532"; # ID of the folder
      $url = "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize";
      $post = "text=" . urlencode("Hello World") . "&lang=en-US&folderId=${folderId}&sampleRateHertz=48000&format=" . FORMAT_PCM;
      $headers = ['Authorization: Bearer ' . $token];
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

2. Convert the file to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

    ```bash
    $ sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
    ```

### Convert text to speech in SSML format {#ssml}

In this example, the submitted text is in [SSML format](ssml.md).

The text is synthesized and recorded as an audio file. By default, data in the audio file is encoded using the OPUS audio codec and compressed using the OGG container format ([OggOpus](https://wiki.xiph.org/OggOpus)).

{% list tabs %}

- Bash

    1. Create a file (for example, `text.xml`) and enter text in SSML format:

        {% include [ssml-example](../../_includes/speechkit/ssml-example.md) %}

    2. Send a request with the text to the server. Pass the text in the `ssml` parameter. In this example, the contents of the file are read using the [cat](https://en.wikipedia.org/wiki/Cat_(Unix)) utility:

        ```bash
        $ export FOLDER_ID=b1gvmob95yysaplct532
        $ export IAM_TOKEN=CggaATEVAgA...
        $ curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          --data-urlencode "ssml=`cat text.xml`" \
          -d "lang=ru-RU&folderId=${FOLDER_ID}" \
          "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
        ```

{% endlist %}

