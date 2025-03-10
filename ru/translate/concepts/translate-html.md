# Перевод специальных символов и HTML-разметки

API {{ translate-name }} возвращает тело ответа в формате JSON. Поэтому при переводе текста, который содержит HTML-разметку и другие специальные символы, некоторые из этих символов могут быть конвертированы в [юникод](https://datatracker.ietf.org/doc/html/rfc7159#section-7). Например, чтобы кавычка (`"`) не означала конец текста, она заменяется на последовательность из шести символов — `\u0022`.

Если отправить модели следующий запрос:

{% include [html-req1](../../_untranslatable/translate/html-req1.md) %}

В ответе вернется результат с конвертированными символами:

```json
{
  "translations": [
    {
      "text": "\u003cb\u003eDear colleagues!\u003c/b\u003e I wish you a happy holiday!",
      "detectedLanguageCode": "ru"
    }
  ]
}
```

Чтобы получить текст с нужной разметкой, файл JSON необходимо преобразовать с помощью функции нужного языка или любого другого специализированного инструмента. Пример такого преобразования на языке Python с помощью библиотеки `requests`:

{% include [html-req2](../../_untranslatable/translate/html-req2.md) %}

Результат:

```txt
[{'text': '<b>Dear colleagues!</b> I wish you a happy holiday!', 'detectedLanguageCode': 'ru'}]
```
