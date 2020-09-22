# DECLARE

Объявляет типизированное [именованное выражение](expressions.md#named-nodes), значение для которого будет передано отдельно от текста запроса.
 
**Синтаксис**

```sql
DECLARE $named-node AS data_type;
```
1. Ключевое слово `DECLARE`.
1. `$named-node` — именованное выражение, по которому можно будет обращаться к переданному значению.
1. Ключевое слово `AS`.
1. `data_type` — тип данных [в виде строки в принятом формате](../misc/type_string.md).

Принимает на вход только сериализуемые типы данных:

* [Примитивные типы](../types/primitive.md).
* [Опциональные типы](../types/optional.md). 
* [Контейнеры](../types/containers.md) за исключением `Stream<Type>`.
* `Void` — единственный поддерживаемый [специальный тип](../types/special.md).

**Пример**

```sql
DECLARE $x AS String;
DECLARE $y AS String?;
DECLARE $z AS List<String>;

SELECT $x, $y, $z;
```
