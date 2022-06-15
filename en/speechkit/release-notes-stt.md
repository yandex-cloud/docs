# Recognition releases

{{ speechkit-name }} provides updates based on the system model and version.

For more information about speech recognition methods, see [About technology](stt/index.md).

## Current version {#current}

1. Improved surname recognition and punctuation quality in `general:rc` model. 
1. [Previous release](#250422) changes available in `general` model.

## Previous versions {#previous}

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
   * Danish
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

1. In delayed recognition mode, you can now work with [MP3]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/MP3){% else %}(https://en.wikipedia.org/wiki/MP3){% endif %} format.
