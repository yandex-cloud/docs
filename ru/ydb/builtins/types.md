# Функции для работы с типами

## FormatType

Сериализация типа в человекочитаемую строку. Это полезно для отладки, а также будет использоваться в последующих примерах данного раздела.  [Документация по формату](../misc/type_string.md).


## ParseType

Построение типа по строке с его описанием. [Документация по формату](../misc/type_string.md).

**Примеры:**
``` yql
SELECT FormatType(ParseType("List<Int32>"));  -- List<int32>
```

## TypeOf

Получение типа значения, переданного в аргумент.

**Примеры:**
``` yql
SELECT FormatType(TypeOf("foo"));  -- String
```
``` yql
SELECT FormatType(TypeOf(AsTuple(1, 1u))); -- Tuple<Int32,Uint32>
```

## InstanceOf

Возвращает экземпляр указанного типа, который можно использовать только для получения типа результата выражения с его использованием.

Если этот экземпляр останется в графе вычислений на этапе окончания оптимизации, то оптимизация будет завершена с ошибкой.

**Примеры:**
``` yql
SELECT FormatType(TypeOf(
    InstanceOf(ParseType("Int32")) +
    InstanceOf(ParseType("Double"))
)); -- Double, because "Int32 + Double" returns Double
```

## DataType

Возвращает тип для примитивных типов данных по его имени.

**Примеры:**
``` yql
SELECT FormatType(DataType("Bool")); -- Bool
```

## OptionalType

Добавляет в переданный тип возможность содержать NULL.

**Примеры:**
``` yql
SELECT FormatType(OptionalType(DataType("Bool"))); -- Bool?
```

## ListType и StreamType
<a name="listtype></a><a name="streamtype></a>

Строит тип списка или потока по переданному типу элемента.

**Примеры:**
``` yql
SELECT FormatType(ListType(DataType("Bool"))); -- List<Bool>
```

## DictType

Строит тип словаря по переданным типам ключа (первый аргумент) и значения (второй аргумент).

**Примеры:**
``` yql
SELECT FormatType(DictType(
    DataType("String"),
    DataType("Double")
)); -- Dict<String,Double>
```

## TupleType

Строит тип кортежа по переданным типам элементов.

**Примеры:**
``` yql
SELECT FormatType(TupleType(
    DataType("String"),
    DataType("Double"),
    OptionalType(DataType("Bool"))
)); -- Tuple<String,Double,Bool?>
```

## StructType

Строит тип структуры по переданным типам элементов. Для указания имен элементов используется стандартный синтаксис именованных аргументов.

**Примеры:**
``` yql
SELECT FormatType(StructType(
    DataType("Bool") AS MyBool,
    ListType(DataType("String")) AS StringList
)); -- Struct<'MyBool':Bool,'StringList':List<String>>
```

## VariantType

Возвращает тип варианта по низлежащему типу (структуры или кортежа).

**Примеры:**
``` yql
SELECT FormatType(VariantType(
  ParseType("Struct<foo:Int32,bar:Double>")
)); -- Variant<'bar':Double,'foo':Int32>
```

## ResourceType

Возвращает тип ресурса по переданной строковой метке.

**Примеры:**
``` yql
SELECT FormatType(ResourceType("Foo")); -- Resource<'Foo'>
```

## CallableType

Строит тип вызываемого значения по следующим аргументам:

* Обязательные:

  1. Число опциональных аргументов (если все обязательные — 0).
  2. Тип результата.

* Все последующие аргументы CallableType трактуются как типы аргументов вызываемого значения со сдвигом на два обязательных (третий аргумент CallableType описывает тип первого аргумента вызываемого значения).

**Примеры:**
``` yql
SELECT FormatType(CallableType(
  1, -- optional args count
  DataType("Double"), -- result type
  DataType("String"), -- arg #1 type
  OptionalType(DataType("Int64")) -- arg #2 type
)); -- Callable<(String,[Int64?])->Double>
```

## GenericType, UnitType и VoidType

Возвращают одноименные типы данных. Аргументов нет, так как они ничем не параметризуются.

**Примеры:**
``` yql
SELECT FormatType(VoidType()); -- Void
```

## OptionalItemType, ListItemType и StreamItemType

Выполняют действие, обратное [OptionalType](#optionaltype), [ListType](#listtype) и [StreamType](#streamtype) — возвращают тип элемента по типу соответствующего контейнера.

**Примеры:**
``` yql
SELECT FormatType(ListItemType(
  ParseType("List<Int32>")
)); -- Int32
```

## DictKeyType и DictPayloadType

Возвращают тип ключа или значения по типу словаря.

**Примеры:**
``` yql
SELECT FormatType(DictKeyType(
  ParseType("Dict<Int32,String>")
)); -- Int32
```

## TupleElementType

Возвращает тип элемента кортежа по типу кортежа и индексу элемента (индекс с нуля).

**Примеры:**
``` yql
SELECT FormatType(TupleElementType(
  ParseType("Tuple<Int32,Double>"), 1
)); -- Double
```

## StructMemberType

Возвращает тип элемента структуры по типу структуры и имени элемента.

**Примеры:**
``` yql
SELECT FormatType(StructMemberType(
  ParseType("Struct<foo:Int32,bar:Double>"), "foo"
)); -- Int32
```

## CallableResultType и CallableArgumentType

CallableResultType возвращает тип результата по типу вызываемого значения, а CallableArgumentType — тип аргумента по типу вызываемого значения и его индексу (индекс с нуля).

**Примеры:**
``` yql
$callable_type = ParseType("(String,Bool)->Double");
SELECT FormatType(CallableResultType(
    $callable_type
)), -- Double
FormatType(CallableArgumentType(
    $callable_type, 1
)); -- Bool
```

## VariantUnderlyingType

Выполняет действие, обратное [VariantType](#varianttype) — возвращает низлежащий тип по типу варианта.

**Примеры:**
``` yql
SELECT FormatType(VariantUnderlyingType(
  ParseType("Variant<foo:Int32,bar:Double>")
)), -- Struct<'bar':Double,'foo':Int32>
FormatType(VariantUnderlyingType(
  ParseType("Variant<Int32,Double>")
)); -- Tuple<Int32,Double>
```
