# Translation of special characters and HTML markup

The {{ translate-name }} API returns the response body in JSON format. Therefore, when translating text that contains HTML markup and other special characters, some of these characters may be converted to [Unicode](https://datatracker.ietf.org/doc/html/rfc7159#section-7). For example, to prevent the double quote (`"`) from marking the end of the text, it is replaced with the six-character sequence: `\u0022`.

If you send the following request to the model:

{% include [html-req1](../../_untranslatable/translate/html-req1.md) %}

The response will return with the converted characters:

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

To get the text with the markup you need, convert the JSON file using a function in the relevant language or any other specialized tool. Here is an example of such a conversion in Python using the `requests` library:

{% include [html-req2](../../_untranslatable/translate/html-req2.md) %}

Result:

```txt
[{'text': '<b>Dear colleagues!</b> I wish you a happy holiday!', 'detectedLanguageCode': 'ru'}]
```
