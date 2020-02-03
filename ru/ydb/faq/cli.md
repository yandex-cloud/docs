# F.A.Q. по консольному клиенту

## Как вернуть читаемый utf-8 текст в csv/tsv режимах консольного клиента? {#how-to-return-a-readable-utf-8-text-in-a-csv-tsv-modes-console-client}
В этом режиме все значения в колонках заэкранированы (C-escaped), чтобы строку таблицы можно было однозначно разбить на колонки по символам табуляции. Привести текст обратно к читабельному виду можно с помощью `UnescapeC` из Аркадийного С++ или вот так из Python:

``` python
>>> print '\xD0\xBF\xD0\xBE\xD1\x80\xD0\xBD\xD0\xBE'.decode('utf-8')
порно
>>> print '\\xD0\\xBF\\xD0\\xBE\\xD1\\x80\\xD0\\xBD\\xD0\\xBE'.decode('string_escape').decode('utf-8')
порно
```
