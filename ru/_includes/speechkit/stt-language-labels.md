Сервис {{ speechkit-short-name }} в ходе распознавания речи автоматически определяет язык в каждом отдельном предложении.

Чтобы настроить автоматическое определение языка, в параметре `language_code` метода `LanguageRestrictionOptions()` укажите значение `auto`:

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

Если одно предложение состоит из слов на разных языках, то язык может быть определен неверно. Для улучшения результатов добавьте список ожидаемых языков как подсказку для модели. Например:

{% list tabs group=programming_language %}

- Python 3 {#python}

  ```python
  ...
        language_code=['auto', 'en-US', 'es-ES', 'fr-FR']
  ...
  ```

{% endlist %}

{% note info %}

Определение языка и расстановка языковых меток доступно только в API v3.

{% endnote %}

**Примеры**

**Текст в аудио** | **Транскрибация**
--- | ---
Открой Whats'app | Открой ватсап
Это можно настроить в Windows Hello или другом сервисе | Это можно настроить в виндс хеллоу или другом сервисе
Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, я люблю гулять по улице и есть мороженое | Men koʻchada sayr qilishni va muzqaymoq isteʼmol qilishni yaxshi koʻraman, я люблю гулять по улице и есть мороженое