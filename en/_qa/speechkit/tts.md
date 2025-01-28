# Speech synthesis (TTS)

#### How can I voice long texts? {#long-texts}

To voice a large text, break it into parts in any way convenient for you. The [maximum](../../{{ speechkit-slug }}/concepts/limits.md#speechkit-limits) size of speech synthesis requests is limited to 5,000 characters.

#### How do I configure stress and pronunciation? {#tts-stress-pronunciation}

To adjust the pronunciation of individual words and the text in general, use the [SSML](../../{{ speechkit-slug }}/tts/markup/ssml.md) or [TTS](../../{{ speechkit-slug }}/tts/markup/tts-markup.md) markup.

#### How do I add a pause in text? {#add-pause}

To add a pause to your text, use [TTS markup](../../speechkit/tts/markup/tts-markup#markup-elements). Specify the pause duration in milliseconds in parentheses. A pause will appear where you place the tag. For example: `Start sil<[3000]> continue in 3 seconds`.

Note that the pause is indicated as a recommendation only. {{ speechkit-name }} is designed to generate natural speech.

#### A cURL request does not work in Windows PowerShell {#curl-powershell}

In the Windows PowerShell terminal, the `curl` command is an alias for the [Invoke-WebRequest](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest) system call. 

The {{ yandex-cloud }} documentation provides examples of API calls using the Bash shell syntax. You can run them as is in the Linux console, macOS terminal, or WSL in Windows 10 or higher. To run the examples in Windows PowerShell, you will have to modify them yourself. For more on command equivalents between Bash and PowerShell, as well as tips, see [{#T}](../../overview/concepts/console-syntax-guide.md).

#### What goes into the cost of synthesis? {#tts-cost}

For examples of calculating the usage cost, pricing rules, and effective prices, see [{#T}](../../{{ speechkit-slug }}/pricing.md).
