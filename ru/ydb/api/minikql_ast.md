### Представление MiniKQL в AST YQL

#### Общая структура программы

В программе YQL используются объекты datasource/datasink для представления операций IO.
В MiniKQL AST не будут использовать операции на datasource/datasink. Таким образом, общий тип программы MiniKQL - List of Void не является полным типом программы YQL (World). С точки зрения YQL программа MiniKQL является чистой.

Смотрите так же:
* ((/kikimr/design/YQL/#strukturaast Структура AST YQL))
* ((/kikimr/design/YQL/#strukturaprogrammy Структура программы YQL))

#### Кодирование тегов схемы

Для тегов схемы базы используются атомы с именами тегов. Для тегов схемы документа используется либо атом с именем - в этом случае схема документа выводится путем автоаллокации тегов в каждом уровне, либо список вида (Tag 'number). Последняя форма допускается и для тегов базы.

#### Кодирование типов данных

Для каждого типа схемы операция вида (TypeName 'atom) создает литерал этого типа. 
Пример:
``` lisp
(let x (ByteString 'aaa))
(let y (Int32 '578))
```
Нужна доработка синтаксиса атомов в области представления произвольных байтов/пустой строки.
Для известных типов (числовых) будет использовано десятичное/шестнадцатеричное представление в атоме, а не байтовое. 

#### Кодирование операций

Каждая операция ProgramBuilder, например, Append, имеет тождественное представление в AST в виде функции
Пример:
``` lisp
(let z (Append (x y))
```
#### Литералы типов, не Data, а также типы

(TypeType), (VoidType), (AnyType), (Void) - все такие типы выражаются функцией без аргументов.
Для DataType есть аргумент - имя типа (DataType 'Int32).
Для скалярного типа схемы - литералы (Null) и (DataType 'Null).
Для структуры пустой литерал имеет вид (Struct) или сразу с набором полей - (Struct type '('name1 field1) '('name2 field2)), где тип предварительно построен как (StructType '('name1 typeOfField1) '('name2 typeOfField2)). Также допустима сокращенная запись (AsStruct '('name1 field1) '('name2 field2)), в этом случае тип структуры выводится из списка полей и их типов.

Списки/Optional/Словарь имеют аналогичный конструктор (List type item1 item2).
Для Optional есть конструктор вида (Nothing elemType) или (Just elem).

По умолчанию все типы/переменные являются dynamic. Для статических структур, например, используемых в параметрах, будет использован другой конструктор - например (StaticStruct ...).

#### Lambda

В некоторых операциях (например, Fold), известно, что один из параметров - lambda. В AST lambda должна быть преобразована в lambda для функции ProgramBuilder-а.

#### Внешние параметры
В программе, которая использует внешние параметры, необходимо использовать тип (Parameter). 
Если параметр является частью ключа, необходимо использовать функцию (AddKeyParameter key 'name).
Пример программы, использующей параметры:
``` lisp
(
(let pgmReturn (List (ListType (VoidType))))
(let kDbRoot (NewDbKey))
(let k1 (AddStaticTag kDbRoot 'someTag1))
(let k2 (AddKeyParameter k1 'keyParam))
(let payload (Parameter 'payloadParam (ByteString)))
(let pgmReturn (Append pgmReturn (WriteDb k2 payload)))
(return pgmReturn)
)
```
Сами внешние параметры создаются с помощью типа (Parameters), который по сути является статической структурой. Добавлять поля к такой структуре можно функцией (AddParameter params 'name value).
Также создать структуру параметров можно функцией (AsParameters '('name1 value1) '(name2 value2)).
Программа, конструирующая параметры:
``` lisp
(
(let payload (ByteString 'iAmParamString))
(let kDbRoot (NewDbKey))
(let key (AddStaticTag kDbRoot 'someTag2))
(let params (Parameters))
(let params (AddParameter params 'payloadParam payload))
(let params (AddParameter params 'keyParam key))
# (let params (AsParameters '('payloadParam payload) '('keyParam key)))
(return params)
)
```
### Примеры программ с форме C++ и AST

#### Запись данных
``` cpp
auto pgmReturn = pgmBuilder.NewEmptyDynamicListOfVoid();
auto kDbRoot = pgmBuilder.NewDbKey();
auto k1 = pgmBuilder.AddScalarTag(kDbRoot, 32);
auto k2 = pgmBuilder.AddScalarTag(k1, 33);
auto k3 = pgmBuilder.AddStaticTag(k2, 35,  pgmBuilder.NewDataLiteral(NScheme::TSmallBoundedByteString::TInstance("xyz")));
auto payload = pgmBuilder.NewDataLiteral(NScheme::TUint32::TInstance(0x45));
pgmReturn = pgmBuilder.Append(pgmReturn, pgmBuilder.WriteDb(k3, payload));
pgm = pgmBuilder.Build(pgmReturn);
```
``` lisp
(
(let pgmReturn (List (ListType (VoidType))))
(let kDbRoot (NewDbKey))
(let k1 (AddScalarTag kDbRoot 'dc1))
(let k2 (AddScalarTag k1 'tag1))
(let k3 (AddStaticTag k2 'tag2 (SmallBoundedByteString 'xyz)))
(let payload (Uint32 '0x45))
(let pgmReturn (Append pgmReturn (WriteDb k3 payload)))
(return pgmReturn)
)
```
#### Чтение данных
``` cpp
auto pgmReturn = pgmBuilder.NewEmptyDynamicListOfVoid();
auto kDbRoot = pgmBuilder.NewDbKey();
auto k1 = pgmBuilder.AddScalarTag(kDbRoot, 32);
auto k2 = pgmBuilder.AddScalarTag(k1, 33);
auto k3 = pgmBuilder.AddStaticTag(k2, 35, pgmBuilder.NewDataLiteral(NScheme::TSmallBoundedByteString::TInstance("xyz")));
auto res = pgmBuilder.ReadDb(k3, NScheme::TUint32::TypeId);
auto payload = pgmBuilder.Coalesce(res, pgmBuilder.NewEmptyOptionalDataLiteral(NScheme::TUint32::TypeId));
auto kDocRoot = pgmBuilder.NewDocKey();
auto k4 = pgmBuilder.AddScalarTag(kDocRoot, 37);
pgmReturn = pgmBuilder.Append(pgmReturn, pgmBuilder.WriteDoc(k4, payload));
pgm = pgmBuilder.Build(pgmReturn);
```
``` lisp
(
(let pgmReturn (List (ListType (VoidType))))
(let kDbRoot (NewDbKey))
(let k1 (AddScalarTag kDbRoot 'dc1))
(let k2 (AddScalarTag k1 'tag1))
(let k3 (AddStaticTag k2 'tag2 (SmallBoundedByteString 'xyz)))
(let res (ReadDb k3 'Uint32))
(let payload (Coalesce res (Nothing (DataType 'Uint32))))
(let kDocRoot (NewDocKey))
(let k4 (AddScalarTag kDocRoot 'TagInDoc))
(let pgmReturn (Append pgmReturn (WriteDoc k4 payload)))
(return pgmReturn)
)
```
#### Чтение интервала данных
``` cpp
auto kDbRoot = pgmBuilder.NewDbKey();
auto k1 = pgmBuilder.AddScalarTag(kDbRoot, 32);
auto k2 = pgmBuilder.AddScalarTag(k1, 33);
auto options = pgmBuilder.GetDefaultReadRangeOptions(NScheme::TSmallBoundedByteString::TypeId);
options.InitValue = pgmBuilder.NewOptional(pgmBuilder.NewDataLiteral(NScheme::TSmallBoundedByteString::TInstance("xyz3")));
options.TermValue = pgmBuilder.NewOptional(pgmBuilder.NewDataLiteral(NScheme::TSmallBoundedByteString::TInstance("xyz7")));
options.Flags = pgmBuilder.NewDataLiteral(NScheme::TUint32::TInstance(
TReadRangeOptions::TFlags::IncludeInitValue | TReadRangeOptions::TFlags::ExcludeTermValue));
options.PayloadStruct = pgmBuilder.AddRangePayload(options.PayloadStruct, "Self", pgmBuilder.NewDbKey(),
    NScheme::TUint32::TypeId);
auto res = pgmBuilder.ReadRangeDb(k2, 35, NScheme::TSmallBoundedByteString::TypeId, options);
auto list = pgmBuilder.Member(res, "List");
auto kDocRoot = pgmBuilder.NewDocKey();
auto pgmReturn = pgmBuilder.Map(list,
   [&](TRuntimeNode item) {
      auto value = pgmBuilder.Member(item, "Value");
      auto k4 = pgmBuilder.AddDynamicTag(kDocRoot, 37, value);
      auto res = pgmBuilder.Member(pgmBuilder.Member(item, "Payloads"), "Self");
      auto payload = pgmBuilder.Coalesce(res, pgmBuilder.NewEmptyOptionalDataLiteral(NScheme::TSmallBoundedByteString::TypeId));
      return pgmBuilder.WriteDoc(k4, payload);
   });

pgm = pgmBuilder.Build(pgmReturn);
```
``` lisp
(
(let kDbRoot (NewDbKey))
(let k1 (AddScalarTag kDbRoot 'dc1))
(let k2 (AddScalarTag k1 'tag1))
(let initValue '('InitValue (SmallBoundedByteString 'xyz3)))
(let termValue '('TermValue (SmallBoundedByteString 'xyz7)))
(let flags '('Flags (| (ReadRangeExcludeTermValue) (ReadRangeIncludeInitValue))))
(let payloadInfo '('Self (NewDbKey)))
(let payloads (NoRangePayloads))
(let payloads (AddRangePayload payloads payloadInfo))
(let rangePayloads '('Payloads payloads))
(let options (ReadRangeOptions 'SmallBoundedByteString initValue termValue flags rangePayloads))
(let res (ReadRangeDb k2 'tag3 'SmallBoundedByteString options))
(let list (Member res 'List))
(let kDocRoot (NewDocKey))
(let pgmReturn (Map list (lambda '(item) (block '(
    (let value (Member item 'Value))
    (let k4 (AddDynamicTag kDocRoot (Tag '37) value))
    (let res (Member (Member item 'Payloads) 'Self))
    (let payload (Coalesce res (Nothing (DataType 'SmallBoundedByteString))))
    (let write (WriteDoc k4 payload))
    (return write)
)))))
(return pgmReturn)
)
```