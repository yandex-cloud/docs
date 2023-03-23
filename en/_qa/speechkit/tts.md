# Speech synthesis (TTS)

#### How can I voice long texts? {#long-texts}

To voice a large text, break it into parts in any way convenient for you.
The [limit](../../speechkit/concepts/limits.md#speechkit-limits) on the size of a speech synthesis request is 5000 characters.

#### How do I set up stress and pronunciation? {#tts-stress-pronunciation}

To adjust the pronunciation of individual words and text in general, use [SSML](../../speechkit/tts/ssml.md).

#### Is it possible to test premium voices? {#premium-voices}

You can try voices named **Alena** and **Filipp** on the [service page](/services/speechkit#demo).

For more information about pricing for premium voices, see the [documentation](../../speechkit/pricing.md#prices).

#### Error: unsupported content-type: application/json {#content-type}

The `unsupported content-type: application/json` error occurs if you set the `application/json` type that is not supported for transmitted text in the standard `content-type` header.

To perform speech synthesis, use one of the supported types:
* `application/x-www-form-urlencoded`
* `multipart/form-data`

For a description of the API method, see the [documentation](../../speechkit/tts/request.md).

#### Voices change in the voiced text {#voices-change}

If voices in the voiced text are different, check what voice is specified in the request. Each voice has its own main language. To specify a voice that is suitable for your text, use [a list of available voices](../../speechkit/tts/voices.md).

#### SSML error saying "Error during parsing XML" {#ssml-err}

Make sure you do not use SSML in the `text` parameter. If you specify text in SSML format, use the [appropriate parameter](../../speechkit/tts/request.md#body_params).

#### How do I add a pause in text? {#add-pause}

To set a pause in your text, add a sil tag. Specify the pause duration in milliseconds in parentheses. A pause will appear where you place the tag. For example: `Start sil<[3000]> continue in 3 seconds`.

#### A cURL request doesn't work in Windows PowerShell {#curl-powershell}

In Windows PowerShell `curl` is, by default, an alias for an [Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest) system call. To repeat the [example from the documentation](../../speechkit/tts/request.md#ssml), use the code:

`Invoke-WebRequest -Method 'Post' -H @{'Authorization' = 'Bearer your_token'} -Body "lang=ru-RU&folderId= your_folder_id&ssml=$([System.Net.WebUtility]::UrlEncode($(Get-Content -Path C:\curl\new.xml)))" -OutFile C:\curl\output.ogg "https://tts.{{ api-host }}/speech/v1/tts:synthesize"`

#### Premium voices start stuttering on long texts {#premium-stutter}

The development team is aware of the issue and is working on fixing it. For now, to voice long texts, break them into shorter fragments.

#### What goes into the cost of using the service? {#tts-cost}

You can find examples of calculating the usage cost, pricing rules, and effective prices in the [documentation](../../speechkit/pricing.md).
