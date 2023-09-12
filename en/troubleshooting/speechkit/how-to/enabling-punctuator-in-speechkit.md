# Enabling automated punctuation in the recognized text

## Issue description {#case-description}
You need to enable automated punctuation (i.e., the punctuator) in the recognized text.

## Solution {#case-resolution}
The punctuator is available in the following recognition modes:

1. In gRPC API, the punctuator is enabled by the `TEXT_NORMALIZATION_ENABLED` option. This option enables the text normalization mode that mostly adds punctuation marks. Acceptable option values are given in [this](../../../speechkit/stt-v3/api-ref/grpc/stt_service.md#TextNormalizationOptions) SpeechKit API specification section.

2. In the asynchronous recognition REST API, the punctuator functionality is enabled by the `config.specification.literature_text` option. It enables the text normalization mode that mostly adds punctuation marks. Acceptable option values are given in [this](../../../speechkit/stt/api/transcribation-api.md#sendfile-params) SpeechKit API specification section.

3. In the streaming recognition REST API, the punctuator is enabled by the `x-normalize-partials` option. If this flag is `true`, you can get intermediate recognition results (parts of a recognized utterance) in a normalized format: numerals are returned as numbers, the profanity filter is enabled, etc. Acceptable option values are given in [this](../../../speechkit/stt/api/streaming-api.md#additional-settings) SpeechKit API specification section.

{% note info %}

Text normalization is currently unavailable in the synchronous recognition mode.

{% endnote %}