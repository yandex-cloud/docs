{% endlist %}

{% note info %}

Определение языка и расстановка языковых меток доступно только в API v3.

{% endnote %}

Сервис {{ speechkit-short-name }} в ходе распознавания речи автоматически определяет язык в каждом отдельном предложении.

Чтобы использовать автоматическое определение языка, в параметре `language_code` метода `LanguageRestrictionOptions()` укажите значение `auto`:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  language_restriction=stt_pb2.LanguageRestrictionOptions(
        restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
        language_code=['auto']
  )
  ```

{% endlist %}

Вместе с результатами распознавания сервис возвращает языковые метки, содержащие код языка и вероятность правильности его определения:

```yaml
language_code: "ru-RU" probability: 0.91582357883453369
```

Если одно предложение состоит из слов на разных языках, то язык может быть определен неверно. Чтобы распознавание было точнее, вместо значения `auto` укажите список ожидаемых языков как подсказку для модели. Например:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  ...
        language_code=['en-US', 'es-ES', 'fr-FR']
  ...
  ```

{% endlist %}

Язык определяется для каждого предложения. Если в предложении встречаются фразы на нескольких языках, они все будут распознаны на наиболее вероятном языке.

**Примеры**

**Текст в аудио** | **Транскрибация**
--- | ---
Открой Whats'app | Открой ватсап
Это можно настроить в Windows Hello или другом сервисе | Это можно настроить в виндс хеллоу или другом сервисе
Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, я люблю гулять по улице и есть мороженое | Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, я люблю гулять по улице и есть мороженое