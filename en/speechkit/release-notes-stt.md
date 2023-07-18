# {{ speechkit-full-name }} speech recognition service releases

{{ speechkit-name }} provides updates based on the system model and version.

For more information about speech recognition methods, see [About technology](stt/index.md).

## Current version {#current}

### Release on 13/06/23 {#130623}

Fixed switching to English during Russian speech recognition in `general:rc`.

## Previous versions {#previous}

### Release 07/06/23 {#070623}

New changes to `general:rc`:

* Improved the recognition accuracy for Uzbek, German, French, Dutch, Italian, Polish, and Hebrew.
* Added number [normalization](stt/normalization.md) for Uzbek.
* Added support for [splitting text into phrases](stt/eou.md) using [`eou_update`](stt-v3/api-ref/grpc/stt_service.md#StreamingResponse) in FullData mode.

### Release on 25/05/23 {#250523}

Upgrades to the [May 17, 2023 release](#170523) are now available in the `general` model.

### Release on 17/05/23 {#170523}

New changes to `general:rc`:

* Improved the general quality of recognition for Russian.
* Improved the recognition accuracy for the Russian model as per user requests.
* Improved the recognition accuracy for Uzbek, German, French, Dutch, Italian, and Polish.
* Added support for a [new recognition language](stt/models.md): Hebrew (`he-HE`).


### Release on 14/04/2023 {#140423}

Improved recognition quality for abbreviations in Russian on client scenarios for the `general:rc` model.

### Release on 16/03/23 {#070323}

Upgrades to the [release on March 7, 2023](#070323) are now available in the `general` model.

### Release on 07/03/23 {#070323}

For the `general:rc` model:

1. Improved the accuracy of recognition for Uzbek.
1. Added support for number normalization when recognizing speech in English, German, French, Italian, Spanish, and Turkish. Number normalization is also available for Kazakh speech recognition in test mode.

### Release on 08/02/23 {#080223}

1. The first version of Uzbek speech recognition is now available in the `general:rc` model for all API versions. Under some acoustic conditions, Uzbek can be recognized as Kazakh. The issue will be fixed in future model releases.
1. To access the `general:rc` model in [API v3](./stt-v3/api-ref/grpc/), you can now specify this value in the [`model` parameter](./stt-v3/api-ref/grpc/stt_service#RecognitionModelOptions).

### Release 20.12.22 {#201222}

In the `general:rc` model:
1. Based on user requests, we improved recognition quality for the names of medications and first, last, and middle names.
1. Slightly improved the accuracy of recognition for Kazakh and Turkish.

### Release on 20/10/2022 {#201022}

In the `general:rc` model:
1. Added recognition of Brazilian Portuguese, the language code is `pt-BR`.
1. Improved speech recognition quality for all languages in auto recognition mode.
1. Slightly improved the accuracy of recognition for Russian and Kazakh.

### Release 05.10.22 {#051022}

Upgrades to the [September 20 release](#200922) are available in the `general` model.

### Release 20.09.22 {#200922}

In the `general:rc` model:
* Improved recognition quality for Moscow neighborhoods and medications in Russian.
* Added language classification in auto recognition mode.

The fixes are available for testing.

### Release 29.06.22 {#290622}

1. The `general` version of the multi-language model is available.
1. In the `general:rc` and `general` versions, the multi-language model can accept hints about which languages are contained in the speech.
1. Upgrades to `general:rc` [from June 7](#070622) are available in the `general` model for Russian.

### Release 07.06.22 {#070622}

1. Improved punctuation placement and recognition of last names in the `general:rc` model.
1. Upgrades of the [release from April 25](#250422) are available in the `general` model.

### Release 25.04.22 {#250422}

Changes to the `general:rc` model:

1. Improved recognition of such words as gasification and regasification.
1. Added service feedback when processing OGG-OPUS format was added. If a stream isn't valid audio in OPUS format, the service returns `Invalid_Argument`.

### Release 19.04.22 {#190422}

1. Added Turkish language to the multi-language speech recognition model.
1. [A new API version](v3/api-ref/grpc/) is available for {{ speechkit-full-name }} streaming recognition. The old interface will also be supported, but all new features will only be available in API v3.

### Release 14.03.22 {#140322}

The [`general:rc` version](#020322) from March 2, 2022 is available under the `general` tag.

### Release 02.03.22 {#020322}

Improved recognition of names, addresses, and terms as well as punctuation placement in long sentences and texts with numbers is now available in the `general` model.

The `general:rc` model has undergone further upgrades based on user data.

### Release 17.02.22 {#170222}

The current release improved the quality of the Russian-language `general:rc` model in the following areas:

1. Recognition of last and first names, patronymics, and addresses.
1. Recognition of customer-specific terms. The model was enhanced with data from a user request dated February 1, 2022, and corrected based on user data from November 9, 2021.
1. Punctuation in long sentences and texts with numbers.

### Release 3.02.22 {#030222}

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

1. New languages are also available under their codes. The `general:rc` model uses indication as a hint for language recognition. If a language is specifically indicated, the model uses it as a hint to improve recognition quality. Currently, the hint only affects quality recognition for Russian.

When using `general:rc`, we recommend enabling [auto-tuning](stt/additional-training.md#autotuning).

_Known problems_: in universal mode, recognition quality may deteriorate in the case of continuous speech without pauses.

### Release 26.01.22 {#260122}

1. The `general` and `general:rc` recognition models for the Kazakh language are available in streaming and delayed recognition modes.

1. The `general:rc` model now supports a punctuator in streaming and delayed recognition modes.

1. In delayed recognition mode, you can now work with [MP3](https://en.wikipedia.org/wiki/MP3) format.
