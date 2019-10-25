# Тестирование

## library/fastcheck


* **Описание:** быстрая валидация синтаксиса YQL запроса, без проверки консистентности типов данных.
* Языки: [C++](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/fastcheck), [Python](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/fastcheck/python).
* [Примеры использования](https://cs.yandex-team.ru/#!yql%2Flibrary%2Ffastcheck,ya.make,,arcadia).

## library/local

* **Описание:** библиотека для написания интеграционных тестов на [pytest](https://wiki.yandex-team.ru/yatool/test/pytest/) с использованием локальных инстансов YQL и YT. Выдает порты поднятых локально HTTP API YQL и YT, с которыми можно работать тем же способом, как собираетесь в production.
* Детали реализации:
  * Имя локального кластера YT в конфиге YQL — `plato`.
  * Никакие токены можно не указывать, т.к. аутентификация выключена.
* Язык: [Python](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/local).
* [Примеры использования](https://cs.yandex-team.ru/#!yql%2Flibrary%2Flocal,ya.make,,arcadia).

## YQL_UDF_TEST

* **Описание:** макрос в [ya.make](https://wiki.yandex-team.ru/yatool/howtowriteyamakefiles/) для тестов c канонизацией на локально запускаемые YQL запросы над данными в файлах с возможностью использовать UDF.
* [Подробная инструкция](../udf/cpp.md#testirovanie), в т.ч. и про другие способы тестирования YQL С++ UDF.
* [Примеры использования](https://cs.yandex-team.ru/#!YQL_UDF_TEST,ya.make,,arcadia).
