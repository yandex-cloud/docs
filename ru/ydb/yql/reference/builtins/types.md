---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Функции для работы с типами

## FormatType {#formattype}

Сериализация типа в человекочитаемую строку. Это полезно для отладки, а также будет использоваться в последующих примерах данного раздела. Подробнее о функции читайте в [документации](../misc/type_string.md).

## ParseType {#parsetype}

Построение типа по строке с его описанием. Подробнее о функции читайте в [документации](../misc/type_string.md).

**Примеры**

```sql
SELECT FormatType(ParseType("List<Int32>"));  -- List<int32>
```

## TypeOf {#typeof}

Получение типа значения, переданного в аргумент.

**Примеры**

```sql
SELECT FormatType(TypeOf("foo"));  -- String
```

```sql
SELECT FormatType(TypeOf(AsTuple(1, 1u))); -- Tuple<Int32,Uint32>
```

## InstanceOf {#instanceof}

Возвращает экземпляр указанного типа, который можно использовать только для получения типа результата выражения с его использованием.

Если этот экземпляр останется в графе вычислений на этапе окончания оптимизации, то оптимизация будет завершена с ошибкой.

**Примеры**

```sql
SELECT FormatType(TypeOf(
    InstanceOf(ParseType("Int32")) +
    InstanceOf(ParseType("Double"))
)); -- Double, because "Int32 + Double" returns Double
```

## DataType {#datatype}

Возвращает тип для примитивных типов данных по его имени.

**Примеры**

```sql
SELECT FormatType(DataType("Bool")); -- Bool
```

## OptionalType {#optionaltype}

Добавляет в переданный тип возможность содержать NULL.

**Примеры**

```sql
SELECT FormatType(OptionalType(DataType("Bool"))); -- Bool?
```

## ListType и StreamType {#listtype}

Строит тип списка или потока по переданному типу элемента.

**Примеры**

```sql
SELECT FormatType(ListType(DataType("Bool"))); -- List<Bool>
```

## DictType {#dicttype}

Строит тип словаря по переданным типам ключа (первый аргумент) и значения (второй аргумент).

**Примеры**

```sql
SELECT FormatType(DictType(
    DataType("String"),
    DataType("Double")
)); -- Dict<String,Double>
```

## TupleType {#tupletype}

Строит тип кортежа по переданным типам элементов.

**Примеры**
```sql
SELECT FormatType(TupleType(
    DataType("String"),
    DataType("Double"),
    OptionalType(DataType("Bool"))
)); -- Tuple<String,Double,Bool?>
```

## StructType {#structtype}

Строит тип структуры по переданным типам элементов. Для указания имен элементов используется стандартный синтаксис именованных аргументов.

**Примеры**

```sql
SELECT FormatType(StructType(
    DataType("Bool") AS MyBool,
    ListType(DataType("String")) AS StringList
)); -- Struct<'MyBool':Bool,'StringList':List<String>>
```

## VariantType {#varianttype}

Возвращает тип варианта по низлежащему типу (структуры или кортежа).

**Примеры**

```sql
SELECT FormatType(VariantType(
  ParseType("Struct<foo:Int32,bar:Double>")
)); -- Variant<'bar':Double,'foo':Int32>
```

## ResourceType {#resourcetype}

Возвращает тип ресурса по переданной строковой метке.

**Примеры**

```sql
SELECT FormatType(ResourceType("Foo")); -- Resource<'Foo'>
```

## CallableType {#callabletype}

Строит тип вызываемого значения по следующим аргументам:

Обязательные:

1. Число опциональных аргументов (если все обязательные — 0).
2. Тип результата.

Все последующие аргументы `CallableType` трактуются как типы аргументов вызываемого значения со сдвигом на два обязательных (третий аргумент `CallableType` описывает тип первого аргумента вызываемого значения).

**Примеры**

```sql
SELECT FormatType(CallableType(
  1, -- optional args count
  DataType("Double"), -- result type
  DataType("String"), -- arg #1 type
  OptionalType(DataType("Int64")) -- arg #2 type
)); -- Callable<(String,[Int64?])->Double>
```

## GenericType, UnitType и VoidType {#generictype}

Возвращают одноименные типы данных. Аргументов нет, так как они ничем не параметризуются.

**Примеры**

```sql
SELECT FormatType(VoidType()); -- Void
```

## OptionalItemType, ListItemType и StreamItemType {#optionalitemtype}

Выполняют действие, обратное [OptionalType](#optionaltype), [ListType](#listtype) и [StreamType](#streamtype) — возвращают тип элемента по типу соответствующего контейнера.

**Примеры**

```sql
SELECT FormatType(ListItemType(
  ParseType("List<Int32>")
)); -- Int32
```

## DictKeyType и DictPayloadType {#dictkeytype}

Возвращают тип ключа или значения по типу словаря.

**Примеры**

```sql
SELECT FormatType(DictKeyType(
  ParseType("Dict<Int32,String>")
)); -- Int32
```

## TupleElementType {#tupleelementtype}

Возвращает тип элемента кортежа по типу кортежа и индексу элемента (индекс с нуля).

**Примеры**

```sql
SELECT FormatType(TupleElementType(
  ParseType("Tuple<Int32,Double>"), "1"
)); -- Double
```

## StructMemberType {#structmembertype}

Возвращает тип элемента структуры по типу структуры и имени элемента.

**Примеры**

```sql
SELECT FormatType(StructMemberType(
  ParseType("Struct<foo:Int32,bar:Double>"), "foo"
)); -- Int32
```

## CallableResultType и CallableArgumentType {#callableresulttype}

`CallableResultType` возвращает тип результата по типу вызываемого значения, а `CallableArgumentType` — тип аргумента по типу вызываемого значения и его индексу (индекс с нуля).

**Примеры**

```sql
$callable_type = ParseType("(String,Bool)->Double");
SELECT FormatType(CallableResultType(
    $callable_type
)), -- Double
FormatType(CallableArgumentType(
    $callable_type, 1
)); -- Bool
```

## VariantUnderlyingType {#variantunderlyingtype}

Выполняет действие, обратное [VariantType](#varianttype) — возвращает низлежащий тип по типу варианта.

**Примеры**

```sql
SELECT FormatType(VariantUnderlyingType(
  ParseType("Variant<foo:Int32,bar:Double>")
)), -- Struct<'bar':Double,'foo':Int32>
FormatType(VariantUnderlyingType(
  ParseType("Variant<Int32,Double>")
)); -- Tuple<Int32,Double>
```
