# Recognition result normalization

Normalization is converting (post-processing) the text that results from running a {{ speechkit-full-name }} speech recognition model. It is carried out based on the parameters specified in the API requests.

{% note info %}

Normalization is not done in auto language (`auto` [language code](models.md#languages)) recognition mode.

{% endnote %}

You can use the following normalization levels:

* Representing dates and time in numeric format.
* Converting numbers from dictionary to numeric format.
* Capitalizing the beginning of a sentence and proper nouns.
* Profanity masking.
* Formatting phone numbers, e.g., `7(999)123-45-67` instead of `7 999 123 45 67`.
* Adding punctuation marks.


{% note warning %}

Rules for the presentation of normalized text may change. Please consider this during integration and stay tuned for [updates](../release-notes-stt.md).

{% endnote %}


## Managing normalization parameters {#control}



### API v1 {#api-v1}

* [REST API v1 for synchronous recognition](api/request-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable, set `rawResults=true` |

### API v2 {#api-v2}

* [gRPC API v2 for streaming recognition](api/streaming-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `config.specification.profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable, set `config.specification.rawResults=true` |

* [REST API v2 for asynchronous recognition](api/transcribation-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `config.specification.profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable, set `config.specification.rawResults=true` |
| Capitalizing the beginning of a sentence and proper nouns. Adding punctuation marks | `config.specification.literature_text=true` |

### API v3 {#api-v3}


To enable normalization, set the `text_normalization=TEXT_NORMALIZATION_ENABLED` parameter in the [API](../stt-v3/api-ref/grpc/Recognizer/index.md). Some options are activated by additional parameters if you set `text_normalization=TEXT_NORMALIZATION_ENABLED`.

| Normalization level | API parameter |
| :----- | :------|
| Representing dates and time in numeric format | `text_normalization=TEXT_NORMALIZATION_ENABLED` |
| Converting numbers from dictionary to numeric format | `text_normalization=TEXT_NORMALIZATION_ENABLED` |
| Formatting phone numbers | `text_normalization=TEXT_NORMALIZATION_ENABLED`. To disable this level only, additionally specify `phone_formatting_mode=PHONE_FORMATTING_MODE_DISABLED`. |
| Profanity masking | `profanity_filter=true` with `text_normalization` enabled |
| Capitalizing the beginning of a sentence and proper nouns. Adding punctuation marks | `literature_text=true` with `text_normalization` enabled |