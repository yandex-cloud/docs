# Recognition releases

{{ speechkit-name }} provides updates based on the system model and version.

For more information about speech recognition methods, see [About technology](stt/index.md).

## Current version {#current}

### Release 17.02.22 {#170222}

The current release improved the quality of the Russian-language `general:rc` model as follows:

1. Recognition of surnames, first names, patronymic names, and addresses.
1. Recognition of customer-specific terms. The model was added data at the user's request as of February 1, 2022, and adjustments according to the user's data as of November 9, 2021.
1. Punctuation in long sentences and texts containing numbers.

## Previous versions {#previous}

### Release 3.02.22 {#030222}

1. The `general:rc` model now supports universal mode (`"auto"` language). In this mode, the model can recognize speech in one of the following languages:
   * Russian
   * Kazakh
   * English
   * German
   * French
   * Finnish
   * Swedish
   * Danish
   * Polish
   * Italian
   * Spanish

1. New languages are also available under their own codes. The `general:rc` model uses an indication as a hint for language recognition. If the language is indicated explicitly, the model will use it as a hint to improve the recognition quality. Currently, a hint only affects the quality of recognition of Russian.

When using `general:rc`, we recommend that you enable [autotuning](stt/additional-training.md#autotuning).

_Known issues_: In universal mode, the recognition quality may degrade when recognizing continuous speech without pauses.

### Release 26.01.22 {#260122}

1. The `general` and `general:rc` recognition models for the Kazakh language are available in streaming and delayed recognition modes.

1. The `general:rc` model now supports a punctuator in streaming and delayed recognition modes.

1. In delayed recognition mode, you can now work with [MP3](https://en.wikipedia.org/wiki/MP3) format.
