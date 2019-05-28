# API method description

Generates speech for the received text.

## HTTP request {#http_request}

```
POST https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize
```

## Parameters in the request body {#body_params}

All parameters must be URL-encoded. The maximum size of the POST request body is 15 KB.

| Parameter | Description |
| ----- | ----- |
| `text` | Required parameter.<br/>UTF-8 encoded text to be converted into speech.<br/>For homographs, use `+` before the stressed vowel. For example, `con+trol` or `de+fect`.<br/>To indicate a pause between words, use `-`.<br/>Maximum string length: 5000 characters. |
| `lang` | Language.<br/>Acceptable values:<ul><li>`ru-RU` (default) — Russian.</li><li>`en-US` — English.</li><li>`tr-TR` — Turkish.</li></ul> |
| `voice` | The voice for the synthesized speech.<br/>You can choose one of the following voices:<ul><li>Female voice: `alyss`, `jane`, `oksana` and `omazh`.</li><li>Male voice: `zahar` and `ermil`.</li></ul>Default value of the parameter: `oksana`. |
| `emotion` | Emotional tone of the voice.<br/>Acceptable values:<ul><li>`good` —  Cheerful and friendly.</li><li>`evil` — Irritated.</li><li>`neutral` (default) — Without emotion.</li></ul> |
| `speed` | The rate (tempo) of the synthesized speech.<br/>The speech rate is set as a decimal number in the range from `0.1` to `3.0`. Where:<ul><li>`3.0` — Fastest rate.</li><li>`1.0` (default) — Average human speech rate.</li><li>`0.1` — Slowest speech rate.</li></ul> |
| `format` | The format of the synthesized audio.<br/>Acceptable values:<ul><li>`lpcm` — Audio file is synthesized in the [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format with no WAV header. Audio characteristics:<ul><li>Sampling — 8, 16, or 48 kHz, depending on the `sampleRateHertz` parameter value.</li><li>Bit depth — 16-bit.</li><li>Byte order — Reversed (little-endian).</li><li>Audio data is stored as signed integers.</li></ul></li><li>`oggopus` (default) — Data in the audio file is encoded using the OPUS audio codec and compressed using the OGG container format ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul> |
| `sampleRateHertz` | The sampling frequency of the synthesized audio.<br/>Used if `format` is set to `lpcm`. Acceptable values:<ul><li>`48000` (default) — Sampling rate of 48 kHz.</li><li>`16000` — Sampling rate of 16 kHz.</li><li>`8000` — Sampling rate of 8 kHz.</li></ul> |
| `folderId` | <p>ID of the folder that you have access to. Required for authorization with a user account (see the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

## Response {#response}

If speech synthesis is successful, the response contains the binary content of the audio file. The output data format depends on the value of the `format` parameter.

## Examples {#examples}

### Convert text to speech in Ogg format {#ogg}

In this example, the text "Hello world" is synthesized and recorded as an audio file.

By default, data in the audio file is encoded using the OPUS audio codec and compressed using the OGG container format ([OggOpus](https://wiki.xiph.org/OggOpus)).

---

**[!TAB cURL]**

```bash
$ export FOLDER_ID=b1gvmob95yysaplct532
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     --data-urlencode "text=Hello World" \
     -d "lang=en-US&folderId=${FOLDER_ID}" \
     "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" > speech.ogg
```

**[!TAB C#]**

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

**[!TAB Python]**

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

**[!TAB PHP]**

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
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
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

---

### Convert text to speech in WAV format {#wav}

In this example, the submitted text is synthesized in the LPCM format with a sampling rate of 48kHz and saved to a `speech.raw` file. This file is then converted to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

1. Synthesize a file in LCPM format:

    ---

    **[!TAB cURL]**

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

    **[!TAB C#]**

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
            { 'format': 'lpcm' },
            { 'sampleRateHertz': 48000 }
          };
          var content = new FormUrlEncodedContent(values);
          var response = await client.PostAsync("https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize", content);
          var responseBytes = await response.Content.ReadAsByteArrayAsync();
          File.WriteAllBytes("speech.raw", responseBytes);
        }
      }
    }
    ```

    **[!TAB Python]**

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

    **[!TAB PHP]**

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
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
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

    ---

2. Convert the file to WAV format using the [SoX](http://sox.sourceforge.net/) utility.

    ```bash
    $ sox -r 48000 -b 16 -e signed-integer -c 1 speech.raw speech.wav
    ```

