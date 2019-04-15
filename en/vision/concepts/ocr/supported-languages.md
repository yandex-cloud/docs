# Supported languages and recognition models

The service provides text recognition based on a model that is trained on a specific set of languages. Some languages are very different from each other (for example, Arabic and Chinese), so different models are used for them.

The model is selected automatically based on the list of languages specified in the `language_codes` property in the analysis feature configuration.

Only one model can be used within a single analysis feature. If you specified languages from different models in the same configuration, some text will not be recognized.

## Models and supported languages {#models}

All text recognition models support Russian and English.

### English-Russian model {#engrus}

This model works best, but supports only two languages:

* `en` — English
* `ru` — Russian

### Latin-Cyrillic model {#latcyr}

This model supports languages with the Latin and Cyrillic alphabets:

* `az` — Azerbaijani
* `ba` — Bashkir
* `be` — Belarusian
* `bg` — Bulgarian
* `bs` — Bosnian
* `cs` — Czech
* `da` — Danish
* `de` — German
* `en` — English
* `es` — Spanish
* `et` — Estonian
* `fi` — Finnish
* `fr` — French
* `hu` — Hungarian
* `id` — Indonesian
* `it` — Italian
* `kk` — Kazakh
* `ky` — Kirghiz
* `lt` — Lithuanian
* `lv` — Latvian
* `mt` — Maltese
* `nl` — Dutch
* `no` — Norwegian
* `pl` — Polish
* `pt` — Portuguese
* `ro` — Romanian
* `ru` — Russian
* `sk` — Slovak
* `sl` — Slovenian
* `sv` — Swedish
* `tg` — Tajik
* `tr` — Turkish
* `tt` — Tatar
* `uz` — Uzbek
* `vi` — Vietnamese

### Other models {#others}

Other models only support a single basic language plus Russian and English:

* `ar`, `en`, `ru` — Arabic
* `el`, `en`, `ru` — Greek
* `he`, `en`, `ru` — Hebrew
* `hy`, `en`, `ru` — Armenian
* `ja`, `en`, `ru` — Japanese
* `ka`, `en`, `ru` — Georgian
* `ko`, `en`, `ru` — Korean
* `th`, `en`, `ru` — Thai
* `zh`, `en`, `ru` — Chinese

#### What's next

* [View known restrictions for the current version](known-issues.md)
* [Try out text recognition with an image](../../operations/ocr/text-detection.md)

