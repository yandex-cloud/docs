# {{ speechkit-full-name }} speech recognition service releases

{{ speechkit-name }} provides updates based on the system model and version.

For more information about speech recognition methods, see [About technology](stt/index.md).

## Current version {#current}

### Release on September 6, 2023 {#060923}

New changes to `general:rc`:

* Fixed the issue with English words appearing in a recognized Russian model.
* Improved the general quality of recognition for Russian.
* Improved recognition quality for the Russian model as per user requests.
* Improved the general quality of recognition for Uzbek.

[Audio classifiers](stt/analysis.md) added to `general:rc` in the service [release on August 15, 2023](#150823) are now available in the `general` model.

## Previous versions {#previous}

### Release on August 15, 2023 {#150823}

The `general:rc` model now supports [audio classifiers](stt/analysis.md).

### Release on July 20, 2023 {#200723}

Resampling fixed, new dialog metrics now available in the `general` model.

### Release on July 7, 2023 {#070723}

New changes to `general:rc`:

* Two-channel audio resampling bug fixed in [API v3](stt-v3/api-ref/grpc/).
* Dialog metrics can now be calculated for speech analytics. Metric calculation is set up using the `speech_analysis` option in the [`StreamingOptions`](stt-v3/api-ref/grpc/stt_service#StreamingOptions) message.

### Release on June 13, 2023 {#130623}

Fixed switching to English during Russian speech recognition in `general:rc`.

### Release on June 7, 2023 {#070623}

New changes to `general:rc`:

* Improved the recognition accuracy for Uzbek, German, French, Dutch, Italian, Polish, and Hebrew.
* Added number [normalization](stt/normalization.md) for Uzbek.
* Added support for [splitting text into phrases](stt/eou.md) using [`eou_update`](stt-v3/api-ref/grpc/stt_service.md#StreamingResponse) in FullData mode.

### Release on May 25, 2023 {#250523}

Upgrades to the [May 17, 2023 release](#170523) are now available in the `general` model.

### Release on May 17, 2023 {#170523}

New changes to `general:rc`:

* Improved the general quality of recognition for Russian.
* Improved recognition quality for the Russian model as per user requests.
* Improved recognition quality for Uzbek, German, French, Dutch, Italian, and Polish.
* Added support for a [new recognition language](stt/models.md): Hebrew (`he-HE`).


### Release on April 14, 2023 {#140423}

Improved recognition quality for abbreviations in Russian on client scenarios for the `general:rc` model.

### Release on March 16, 2023 {#070323}

Upgrades to the [release on March 7, 2023](#070323) are now available in the `general` model.

### Release on March 7, 2023 {#070323}

For the `general:rc` model:

1. Improved recognition quality for Uzbek.
1. Added support for number normalization when recognizing speech in English, German, French, Italian, Spanish, and Turkish. Number normalization is also available for Kazakh speech recognition in test mode.

### Release on February 8, 2023 {#080223}

1. The first version of Uzbek speech recognition is now available in the `general:rc` model for all API versions. Under some acoustic conditions, Uzbek can be recognized as Kazakh. The issue will be fixed in future model releases.
1. To access the `general:rc` model in [API v3](./stt-v3/api-ref/grpc/), you can now specify this value in the [`model` parameter](./stt-v3/api-ref/grpc/stt_service#RecognitionModelOptions).

### Release on December 20, 2022 {#201222}

In the `general:rc` model:
1. Based on user requests, we improved recognition quality for the names of medications and first, last, and middle names.
1. Slightly improved recognition quality for Kazakh and Turkish.

### Release on October 20, 2022 {#201022}

In the `general:rc` model:
1. Added recognition of Brazilian Portuguese, the language code is `pt-BR`.
1. Improved speech recognition quality for all languages in auto recognition mode.
1. Slightly improved recognition quality for Russian and Kazakh.

### Release on October 5, 2022 {#051022}

Upgrades to the [September 20 release](#200922) are available in the `general` model.

### Release on September 20, 2022 {#200922}

In the `general:rc` model:
* Improved recognition quality for Moscow neighborhoods and medications in Russian.
* Added language classification in auto recognition mode.

The fixes are available for testing.

### Release on June 29, 2022 {#290622}

1. The `general` version of the multi-language model is available.
1. In the `general:rc` and `general` versions, the multi-language model can accept hints about which languages are contained in the speech.
1. Upgrades to `general:rc` [from June 7](#070622) are available in the `general` model for Russian.

### Release on June 7, 2022 {#070622}

1. Improved punctuation placement and recognition of last names in the `general:rc` model.
1. Upgrades of the [release from April 25](#250422) are available in the `general` model.

### Release on April 25, 2022 {#250422}

Changes to the `general:rc` model:

1. Improved recognition of such words as gasification and regasification.
1. Added service feedback when processing OGG-OPUS format was added. If a stream is not a valid audio in OPUS format, the service returns `Invalid_Argument`.

### Release on April 19, 2022 {#190422}

1. Added Turkish language to the multi-language speech recognition model.
1. [A new API version](v3/api-ref/grpc/) is available for {{ speechkit-full-name }} streaming recognition. The old interface will also be supported, but all new features will only be available in API v3.

### Release on March 14, 2022 {#140322}

The [`general:rc` version](#020322) from March 2, 2022 is available under the `general` tag.

### Release on March 2, 2022 {#020322}

Improved recognition of names, addresses, and terms as well as punctuation placement in long sentences and texts with numbers is now available in the `general` model.

The `general:rc` model has undergone further upgrades based on user data.

### Release on February 17, 2022 {#170222}

The current release improved the quality of the Russian-language `general:rc` model in the following areas:

1. Recognition of last and first names, patronymics, and addresses.
1. Recognition of customer-specific terms. The model was enhanced with data from a user request dated February 1, 2022, and corrected based on user data from November 9, 2021.
1. Punctuation in long sentences and texts with numbers.

### Release on February 3, 2022 {#030222}

1. In the `general:rc`, a universal mode (`"auto"` language) is available. In this mode, the model can recognize speech in one of the following languages:
   * Russian
   * Kazakh
   * English
   * German
   * French
   * Finnish
   * Swedish
   * Dutch
   * Polish
   * Portuguese
   * Italian
   * Spanish

1. New languages are also available under their codes. The `general:rc` model uses indication as a hint for language recognition. If a language is specifically indicated, the model uses it as a hint to improve recognition quality. Currently, the hint only affects recognition quality for Russian.

When using `general:rc`, we recommend enabling [auto-tuning](stt/additional-training.md#autotuning).

_Known problems_: in universal mode, recognition quality may deteriorate in the case of continuous speech without pauses.

### Release on January 26, 2022 {#260122}

1. The `general` and `general:rc` recognition models for the Kazakh language are available in streaming and delayed recognition modes.

1. The `general:rc` model now supports a punctuator in streaming and delayed recognition modes.

1. In delayed recognition mode, you can now work with [MP3](https://en.wikipedia.org/wiki/MP3) format.
