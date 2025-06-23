# {{ speechkit-full-name }} release notes: Speech recognition

{{ speechkit-name }} provides updates based on the system model and version.

For more information about speech recognition methods, see [About technology](stt/index.md).



## Release as of 24/04/2025 {#240425}

Updates to `general:rc`:

* Improved recognition quality for Uzbek.
* Improved recognition quality for medical topics in Russian.

## Release as of 11/04/2025 {#110425}

`general:rc` updates are now available in the `general` model.

## Release as of 05/03/2025 {#050325}

Improved recognition quality for Uzbek and Russian in `general:rc`.

## Release as of 17/12/24 {#171224}

Improved recognition quality for Uzbek and Kazakh in `general:rc`.

## Release as of 10/12/24 {#101224}

Updates to `general:rc` effective December 3 are now available in `general`.

## Release as of 03/12/2024 {#031224}

In `general:rc`, fixed and improved error messages when using unsupported recognition languages and audio formats.

## Release as of 31/10/24 {#311024}

Improved recognition quality for Uzbek and Turkish in `general:rc`.

## Release as of 09/08/24 {#090924}

Updates to `general:rc`:

* Improved recognition quality for Uzbek and Kazakh.
* You can now restrict recognition languages by specifying multiple values in the `language_restriction` field.

## Release as of 26/06/24 {#260624}

The `general:rc` updates of [June 3](#030624) are now available in the `general` model.

Improved recognition quality for Uzbek in `general:rc`.

## Release as of 03/06/24 {#030624}

As requested by users, `general:rc` recognition quality was improved for abbreviations and medical terms in Russian.

## Release as of 23/04/24 {#230424}

The `general:rc` updates of [April 9](#090424) are now available in the `general` model.

## Release as of 09/04/24 {#090424}

Changed the format of [classifiers](stt/analysis.md) in the `general:rc` model. The `formal_greeting`, `informal_greeting`, `formal_farewell`, `informal_farewell`, `insult`, and `profanity` classifiers now return results as a probability of positives. The `answerphone` and `negative` classifiers now return only the probability of positives instead of the probability of belonging to two classes.

## Release as of 27/03/24 {#273224}

All `general:rc` updates of [February 28](#280224) are now available in the `general` model.

Updates to `general:rc`:

* Improved recognition quality for Uzbek.
* Improved [speaker labeling](stt/speaker-labeling.md) in recognition results.

## Release as of 28/02/24 {#280224}

Updates to `general:rc`:

* Improved recognition quality for Uzbek.
* As requested by users, recognition quality was improved for medications, car models, and tobacco products in Russian.

## Release as of 27/02/24 {#270224}

All `general:rc` updates are now available in the `general` model.

## Release as of 12/01/24 {#120124}

Added support for [speaker labeling](stt/speaker-labeling.md) in recognition results in `general:rc`.

## Release as of 12/01/24 {#120124}

Improved recognition quality for Uzbek in `general:rc`.

## Release as of 29/12/23 {#291223}

Updates to `general:rc`:

1. Fixed [normalization](stt/normalization.md) errors for certain number representations (e.g., fifteen hundred ⟶ 1500).
1. Added support for the following [classifiers](stt/analysis.md#classifier):

   * `gender`. Returns probability values for the `male` and `female` classes.
   * `negative`. Returns probability values for the `negative` and `not_negative` classes.
   * `answerphone`. Returns probability values for the `answerphone` and `not_answerphone` classes.

1. Added classifier positives for partial recognition results (`ON_PARTIAL` event).

## Release as of 22/11/23 {#221123}

All `general:rc` updates are now available in the `general` model.

## Release as of 10/11/23 {#101123}

Updates to `general:rc`:

* Russian speech recognition model has been updated.
* As requested by users, recognition quality was improved for names of cities in Kazakhstan.
* The quality of normalization of speech recognition results in the Kazakh language has been enhanced.
* Internal server errors that occur when working with small audio fragments have been fixed.

## Release as of 06/09/23 {#060923}

Updates to `general:rc`:

* Fixed the issue with English words appearing in a recognized Russian model.
* Improved the general quality of recognition for Russian.
* Improved recognition quality for the Russian model as per user requests.
* Improved the general quality of recognition for Uzbek.

[Audio classifiers](stt/analysis.md) added to `general:rc` in [August 15, 2023 release](#150823) are now available in the `general` model.

## Release as of 15/08/23 {#150823}

Added support for [audio classifiers](stt/analysis.md) in `general:rc`.

## Release as of 20/07/23 {#200723}

Resampling fixed, new dialog metrics now available in the `general` model.

## Release as of 07/07/23 {#070723}

Updates to `general:rc`:

* Two-channel audio resampling bug fixed in [API v3](stt-v3/api-ref/grpc/).
* Dialog metrics can now be calculated for speech analytics. Metric calculation is set up using the `speech_analysis` option in the [`StreamingOptions`](stt-v3/api-ref/grpc/Recognizer/recognizeStreaming#speechkit.stt.v3.StreamingOptions) message.

## Release as of 13/06/23 {#130623}

Fixed switching to English during Russian speech recognition in `general:rc`.

## Release as of 07/06/23 {#070623}

Updates to `general:rc`:

* Improved the recognition accuracy for Uzbek, German, French, Dutch, Italian, Polish, and Hebrew.
* Added number [normalization](stt/normalization.md) for Uzbek.
* Added support for [splitting text into phrases](stt/eou.md) using [`eou_update`](stt-v3/api-ref/grpc/Recognizer/recognizeStreaming.md#speechkit.stt.v3.StreamingResponse) in FullData mode.

## Release as of 25/05/23 {#250523}

Upgrades to [May 17 release](#170523) are now available in the `general` model.

## Release as of 17/05/23 {#170523}

Updates to `general:rc`:

* Improved the general quality of recognition for Russian.
* Improved recognition quality for the Russian model as per user requests.
* Improved recognition quality for Uzbek, German, French, Dutch, Italian, and Polish.
* Added support for a [new recognition language](stt/models.md): Hebrew (`he-HE`).

## Release as of 14/04/23 {#140423}

Improved recognition quality for abbreviations in Russian based on client scenarios for the `general:rc` model.

## Release as of 16/03/23 {#070323}

Upgrades to the [March 7 release](#070323) are now available in the `general` model.

## Release as of 07/03/23 {#070323}

For the `general:rc` model:

1. Improved recognition quality for Uzbek.
1. Added support for number normalization when recognizing speech in English, German, French, Italian, Spanish, and Turkish. Number normalization is also available for Kazakh speech recognition in test mode.

## Release as of 08/02/23 {#080223}

1. The first version of Uzbek speech recognition is now available in the `general:rc` model for all API versions. Under some acoustic conditions, Uzbek can be recognized as Kazakh. The issue will be fixed in future model releases.
1. To access the `general:rc` model in [API v3](./stt-v3/api-ref/grpc/), you can now specify this value in the [`model` parameter](./stt-v3/api-ref/grpc/Recognizer/recognizeStreaming#speechkit.stt.v3.RecognitionModelOptions).

## Release as of 20/12/22 {#201222}

For the `general:rc` model:
1. Based on user requests, we improved recognition quality for the names of medications and first, last, and middle names.
1. Slightly improved recognition quality for Kazakh and Turkish.

## Release as of 20/10/22 {#201022}

For the `general:rc` model:
1. Added recognition of Brazilian Portuguese, the language code is `pt-BR`.
1. Improved speech recognition quality for all languages in auto recognition mode.
1. Slightly improved recognition quality for Russian and Kazakh.

## Release as of 05/10/22 {#051022}

Upgrades to the [September 20 release](#200922) are available in the `general` model.

## Release as of 20/09/22 {#200922}

For the `general:rc` model:
* Improved recognition quality for Moscow neighborhoods and medications in Russian.
* Added language classification in auto recognition mode.

The fixes are available for testing.

## Release as of 29/06/22 {#290622}

1. The `general` version of the multi-language model is now available.
1. In the `general:rc` and `general` versions, the multi-language model can accept hints as to which languages are present in the speech.
1. Upgrades to `general:rc` [of June 7](#070622) are available in the `general` model for Russian.

## Release as of 07/06/22 {#070622}

1. Improved punctuation placement and recognition of last names in the `general:rc` model.
1. [April 25 release](#250422) upgrades are available in the `general` model.

## Release as of 25/04/22 {#250422}

Updates to the `general:rc` model:

1. Improved recognition of such words as gasification and regasification.
1. Added service feedback when processing OGG-OPUS format was added. If a stream is not a valid audio in OPUS format, the service returns `Invalid_Argument`.

## Release as of 19/04/22 {#190422}

1. Added Turkish language to the multi-language speech recognition model.
1. [A new API version](v3/api-ref/grpc/) is available for {{ speechkit-full-name }}streaming recognition. The old interface will also be supported, but all new features will only be available in API v3.

## Release as of 14/03/22 {#140322}

The March 2, 2022 [`general:rc`](#020322) version is available under the `general` tag.

## Release as of 02/03/22 {#020322}

The `general` model now offers improved recognition of names, addresses, and terms as well as punctuation placement in long sentences and texts with numbers.

The `general:rc` model has undergone further upgrades based on user data.

## Release 17.02.22 {#170222}

The current release improved the quality of the Russian-language `general:rc` model in the following areas:

1. Recognition of last and first names, patronymics, and addresses.
1. Recognition of customer-specific terms. The model was enhanced with data from a user request dated February 1, 2022, and corrected based on user data from November 9, 2021.
1. Punctuation in long sentences and texts with numbers.

## Release 3.02.22 {#030222}

1. The `general:rc` model now supports the universal mode (`"auto"` language). In this mode, the model can recognize speech in one of the following languages:
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

1. New languages are also available under their own codes. The `general:rc` model uses an indication as a hint for language recognition. If the language is indicated explicitly, the model will use it as a hint to improve the recognition quality. Currently, a hint only affects the quality of recognition of Russian.


_Known problems_: in universal mode, recognition quality may deteriorate in the case of continuous speech without pauses.

## Release 26.01.22 {#260122}

1. The `general` and `general:rc` recognition models for the Kazakh language are available in streaming and delayed recognition modes.

1. The `general:rc` model now supports a punctuator in streaming and delayed recognition modes.

1. In delayed recognition mode, you can now work with [MP3](https://en.wikipedia.org/wiki/MP3) format.

