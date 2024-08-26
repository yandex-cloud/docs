Сервис {{ speechkit-short-name }} позволяет в ходе распознавания речи автоматически определять язык речи и возвращать вместе с результатами распознавания языковые метки, содержащие вероятность правильного определения языка.
Чтобы настроить автоматическое определение языка, необходимо в параметре `language_code` метода `LanguageRestrictionOptions()` указать значение `auto`:

{% list tabs group=programming_language %}

- Python 3 {#python}

    ```python
	    language_restriction=stt_pb2.LanguageRestrictionOptions(
            restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
            language_code=['auto']
        )
    ```

{% endlist %}

Языковые метки содержат код языка и вероятность правильности его определения:
```yaml
    language_code: "ru-RU" probability: 0.91582357883453369
```


{% note info %}

Определение языка и расстановка языковых меток доступно только в gRPC API v3.

{% endnote %}
