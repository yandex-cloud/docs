# Supported languages and language models

All text language models support Russian and English.

## English-Russian model {#engrus}

This model works best, but supports only two languages:

* `en`: English
* `ru`: Russian

{% note warning %}

Currently, this model cannot be selected with [automatic language detection](../../operations/ocr/text-detection-image.md#ocr-api-recognition). To use this model, explicitly specify one or both languages in the `languageCodes` property for the [OCR API](../../ocr/api-ref/index.md) or in the `language_codes` property for the [Vision API](../../vision/api-ref/index.md).

{% endnote %}

## Latin-Cyrillic model {#latcyr}

This model supports languages that use Latin and Cyrillic characters:

* `az`: Azerbaijani
* `ba`: Bashkir
* `be`: Belarusian
* `bg`: Bulgarian
* `bs`: Bosnian
* `cs`: Czech
* `cv`: Chuvash
* `da`: Danish
* `de`: German
* `en`: English
* `es`: Spanish
* `et`: Estonian
* `fi`: Finnish
* `fr`: French
* `hu`: Hungarian
* `id`: Indonesian
* `it`: Italian
* `kk`: Kazakh
* `ky`: Kirghiz
* `lt`: Lithuanian
* `lv`: Latvian
* `mt`: Maltese
* `nl`: Dutch
* `no`: Norwegian
* `pl`: Polish
* `pt`: Portuguese
* `ro`: Romanian
* `ru`: Russian
* `sah`: Yakut
* `sk`: Slovak
* `sl`: Slovenian
* `sr`: Serbian
* `sv`: Swedish
* `tg`: Tajik
* `tr`: Turkish
* `tt`: Tatar
* `uz`: Uzbek

## Other models {#others}

Other models only support a single basic language apart from Russian and English:

* `ar`, `en`, `ru`: Arabic
* `el`, `en`, `ru`: Greek
* `he`, `en`, `ru`: Hebrew
* `hy`, `en`, `ru`: Armenian
* `ja`, `en`, `ru`: Japanese
* `ka`, `en`, `ru`: Georgian
* `ko`, `en`, `ru`: Korean
* `th`, `en`, `ru`: Thai
* `vi`, `en`, `ru`: Vietnamese
* `zh`, `en`, `ru`: Chinese

#### What's next {#what-is-next}

* [Learn about known issues for the current version](known-issues.md)
* [Try recognizing text in an image](../../operations/ocr/text-detection-image.md)
