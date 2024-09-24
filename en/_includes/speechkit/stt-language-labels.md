{{ speechkit-short-name }} automatically detects the language during speech recognition and returns language labels along with the recognition results indicating the probability of correct language detection.
To configure automatic language detection, set the `language_code` parameter of the `LanguageRestrictionOptions()` method to `auto`:

{% list tabs group=programming_language %}

- Python 3 {#python}

    ```python
	    language_restriction=stt_pb2.LanguageRestrictionOptions(
            restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
            language_code=['auto']
        )
    ```

{% endlist %}

Language labels contain the language code and specify the probability of its correct detection:
```yaml
    language_code: "ru-RU" probability: 0.91582357883453369
```


{% note info %}

Language detection and setting language labels are only available in gRPC API v3.

{% endnote %}
