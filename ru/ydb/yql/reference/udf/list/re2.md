---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Re2 UDF

**Список функций**

* ```Re2::Grep(String) -> (String?) -> Bool```
* ```Re2::Match(String) -> (String?) -> Bool```
* ```Re2::Capture(String) -> (String?) -> Struct<_1:String?,foo:String?,...>```
* ```Re2::FindAndConsume(String) -> (String?) -> List<String>```
* ```Re2::Replace(String) -> (String?, String) -> String?```
* ```Re2::Count(String) -> (String?) -> Uint32```
* ```Re2::Options([CaseSensitive:Bool?,DotNl:Bool?,Literal:Bool?,LogErrors:Bool?,LongestMatch:Bool?,MaxMem:Uint64?,NeverCapture:Bool?,NeverNl:Bool?,OneLine:Bool?,PerlClasses:Bool?,PosixSyntax:Bool?,Utf8:Bool?,WordBoundary:Bool?]) -> Struct<CaseSensitive:Bool,DotNl:Bool,Literal:Bool,LogErrors:Bool,LongestMatch:Bool,MaxMem:Uint64,NeverCapture:Bool,NeverNl:Bool,OneLine:Bool,PerlClasses:Bool,PosixSyntax:Bool,Utf8:Bool,WordBoundary:Bool>```

В силу ограничений библиотеки Pire, связанных с оптимизацией для эффективной проверки строк на соответствие регулярным выражениям, бывают ситуации, когда решить задачу с помощью [Pire UDF](pire.md) неоправданно сложно или невозможно. Для таких ситуаций мы добавили ещё один модуль для работы с регулярными выражениями на основе [google::RE2](https://github.com/google/re2), где предоставляется более широкий ассортимент возможностей ([см. официальную документацию](https://github.com/google/re2/wiki/Syntax)).

По умолчанию UTF-8 режим включается автоматически, если регулярное выражение является валидной строкой в кодировке UTF-8, но не является валидной ASCII-строкой. Вручную настройками библиотеки re2 можно управлять с помощью передачи результата функции `Re2::Options` вторым аргументом другим функциям модуля, рядом с регулярным выражением.

{% note alert %}

Все обратные слеши в регулярных выражениях (если они записаны в строке с кавычками) нужно удваивать, так как стандартные строковые литералы в SQL рассматриваются как С-escaped строки. Также можно записывать регулярное выражение в форме raw строки `@@regexp@@` — в этом случае удвоение слешей не требуется.

{% endnote %}

**Примеры**

```sql
$value = "xaaxaaxaa";
$options = Re2::Options(false AS CaseSensitive);
$match = Re2::Match("[ax]+\\d");
$grep = Re2::Grep("a.*");
$capture = Re2::Capture(".*(?P<foo>xa?)(a{2,}).*");
$replace = Re2::Replace("x(a+)x");
$count = Re2::Count("a", $options);

SELECT
  $match($value) AS match,
  $grep($value) AS grep,
  $capture($value) AS capture,
  $capture($value)._1 AS capture_member,
  $replace($value, "b\\1z") AS replace,
  $count($value) AS count;

/*
- match: `false`
- grep: `true`
- capture: `(_0: 'xaaxaaxaa', _1: 'aa', foo: 'x')`
- capture_member: `"aa"`
- replace: `"baazaaxaa"`
- count:: `6`
*/
```

## Re2::Grep / Re2::Match {#match}

Если вынести за скобки детали реализации и синтаксиса регулярных выражений, эти функции полностью аналогичны [аналогичным функциям](pire.md#match) из модулей Pire. При прочих равных и отсутствии каких-либо специфических предпочтений мы рекомендуем пользоваться `Pire::Grep / Pire::Match`.

## Re2::Capture {#capture}

В отличие от [Pire::Capture](pire.md#capture) в `Re2:Capture` поддерживаются множественные и именованные группы захвата (capturing groups).
Тип результата: структура с полями типа `String?`.

* Каждое поле соответствует группе захвата с соответствующим именем.
* Для неименованных групп генерируются имена вида: `_1`, `_2` и т.д.
* В результат всегда включается поле `_0`, в котором доступна вся совпавшая с регулярным выражением подстрока.

Подробнее про работу со структурами в YQL см. в [разделе про контейнеры](../../types/containers.md).

## Re2::FindAndConsume {#findandconsume}

Ищет все вхождения регулярного выражения в переданный текст и возвращает список значений, соответствующих обрамленной в круглые скобки части регулярного выражения для каждого вхождения.

## Re2::Replace {#replace}

Работает следующим образом:

* Во входной строке (первый аргумент) все непересекающиеся подстроки, совпавшие с регулярным выражением, заменяются на указанную строку (второй аргумент).
* В строке с заменой можно использовать содержимое групп захвата (capturing groups) из регулярного выражения с помощью ссылок вида: `\\1`, `\\2` и т.д. Ссылка `\\0` обозначает всю совпавшую с регулярным выражением подстроку.

## Re2::Count {#count}

Возвращает количество совпавших с регулярным выражением непересекающихся подстрок во входной строке.
