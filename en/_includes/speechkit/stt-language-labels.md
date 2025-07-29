{% endlist %}

{% note info %}

Language detection and language labels are only available in API v3.

{% endnote %}

{{ speechkit-short-name }} automatically detects language in each sentence during speech recognition.

To use automatic language detection, specify `auto` in the `language_code` parameter of the `LanguageRestrictionOptions()` method:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  language_restriction=stt_pb2.LanguageRestrictionOptions(
        restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
        language_code=['auto']
  )
  ```

{% endlist %}

Along with recognition results, the service returns language labels containing the language code and probability of its correct detection:

```yaml
language_code: "ru-RU" probability: 0.91582357883453369
```

If a sentence contains words in different languages, the language may be detected incorrectly. To make recognition more accurate, replace `auto` with a list of expected languages as a clue for the model. For example:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  ...
        language_code=['en-US', 'es-ES', 'fr-FR']
  ...
  ```

{% endlist %}

The language is recognized for each sentence. If a sentence has phrases in different languages, all of them will be transcribed in the most probable language.

**Examples**

**Text in audio** | **Transcript**
--- | ---
Xiaomi is a Chinese brand | shumi is a chinese brand
_Привет_ is _hi_ in Russian | privet is hi in russian
Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, I like to take a walk outside and have some ice cream | Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, I like to take a walk outside and have some ice cream