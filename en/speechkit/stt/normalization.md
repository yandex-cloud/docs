# Recognition result normalization

Normalization is converting (post-processing) the text that results from running a {{ speechkit-full-name }} speech recognition model. It is carried out based on the parameters specified in the API requests.

{% note info %}

Normalization is not done in auto language recognition mode (the `auto` [language code](models.md#languages)).

{% endnote %}

You can use the following normalization levels:

* Representing dates and time in numeric format.
* Converting numbers from dictionary to numeric format.
* Capitalizing words at the beginning of a sentence and proper nouns.
* Profanity masking.
* Formatting phone numbers, for example, `7 999 123 45 67` to `7(999)123-45-67`.
* Adding punctuation marks.


{% note warning %}

Rules for the presentation of normalized text may change. Please consider this during integration and stay tuned for [updates](../release-notes-stt.md).

{% endnote %}


## Managing normalization parameters {#control}


### API v2 {#api-v2}

* [gRPC API v2 for streaming recognition](api/streaming-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `config.specification.profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable it, set `config.specification.rawResults=true`. |

* [REST API v2 for synchronous recognition](api/request-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable it, set `rawResults=true`. |

* [REST API v2 for asynchronous recognition](api/transcribation-api.md).

| Normalization level | API parameter |
| :----- | :------|
| Profanity masking | `config.specification.profanityFilter=true` |
| Converting numbers from dictionary to numeric format | Enabled by default. To disable it, set `config.specification.rawResults=true`. |
| Capitalizing words at the beginning of a sentence and proper nouns. Adding punctuation marks | `config.specification.literature_text=true` |


### API v3 {#api-v3}

To enable normalization, set `text_normalization=TEXT_NORMALIZATION_ENABLED`. Some options are activated by additional parameters if you set `text_normalization=TEXT_NORMALIZATION_ENABLED`.

| Normalization level | API parameter |
| :----- | :------|
| Representing dates and time in numeric format | `text_normalization=TEXT_NORMALIZATION_ENABLED` |
| Converting numbers from dictionary to numeric format | `text_normalization=TEXT_NORMALIZATION_ENABLED` |
| Formatting phone numbers | `text_normalization=TEXT_NORMALIZATION_ENABLED`. To disable this level only, additionally set `phone_formatting_mode=PHONE_FORMATTING_MODE_DISABLED`. |
| Profanity masking | `profanity_filter=true` if the `text_normalization` parameter is enabled. |
| Capitalizing words at the beginning of a sentence and proper nouns. Adding punctuation marks | `literature_text=true` if the `text_normalization` parameter is enabled. |
