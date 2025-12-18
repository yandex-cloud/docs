# How to enable automated punctuation in the recognized text


## Case description {#case-description}

You need to enable automated punctuation in the recognized text.

## Solution {#case-resolution}

The automatic punctuation feature is currently available across four tools of ours: REST API v1 for synchronous recognition, REST API v2 for asynchronous recognition, gRPC API v2 for streaming recognition, and API v3.

{% list tabs %}

- REST API v1
  
  Use the `config.specification.literature_text` property to manage the automatic punctuation. For acceptable values, see [this {{ speechkit-name }} API specification section](../../../{{ speechkit-slug }}/stt/api/transcribation-api.md#sendfile-params).

- REST API v2
  
  Use the `x-normalize-partials` property to manage the automatic punctuation. When set to `true`, you get intermediate recognition results, i.e., parts of recognized utterance, in a normalized format: numbers as digits, profanity filter enabled, etc. For acceptable values, see [this {{ speechkit-name }} API specification section](../../../{{ speechkit-slug }}/stt/api/streaming-api.md#additional-settings).

- gRPC API v2
  
  Use the `TEXT_NORMALIZATION_ENABLED` property to manage the automatic punctuation. It actually enables the text normalization mode and adds punctuation marks. For acceptable values, see [this {{ speechkit-name }} API specification section](../../../{{ speechkit-slug }}/stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile.md#speechkit.stt.v3.TextNormalizationOptions).

- API v3
  
  Use the `literature_text=true` property to manage the automatic punctuation (`text_normalization` should be enabled). In addition to inserting punctuation marks, this mode capitalizes the first letter of sentences and proper nouns. For acceptable values, see [this {{ speechkit-name }} API specification section](../../../{{ speechkit-slug }}/stt/api/streaming-api.md#additional-settings).
  
{% endlist %}

{% note warning %}

Text normalization is currently unavailable in synchronous recognition mode.

{% endnote %}
