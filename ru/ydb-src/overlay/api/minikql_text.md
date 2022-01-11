В данном документе описывается текстовое представление языка miniKQL.
Всё написанное ниже является драфтом и может подвергаться существенным изменениям.

## Описание программы
miniKQL — функциональный декларативный строготипизированный язык с иммутабельными значениями, позволяющий задать набор операций, выполняющихся в одну транзакцию KiKiMR.
miniKQL имеет Haskell-like синтаксис. Программой на языке miniKQL является набор объявлений и выражений в кодировке utf-8. Команды разделяются символом ` ; `.

Тело программы состоит из нескольких частей:

1. Блока декларации внешних параметров (может отсутствовать). В блоке декларации необходимо описать все внешние параметры и их типы, используя ключевое слово ExternalParam. %%
v1 = ExternalParam Int32;
v2 = ExternalParam String;
Перед выполнением программы необходимо сбайндить внешние параметры с их значениями, передав компилятору текстовый файл вида: 
```
v1 101
v2 "abacaba”
```
В самой программе внешние параметры используются как обычные переменные. Передача более сложных структур: 
```
v1 = ExternalParam [] Int32; -- List of Int32.
v2 = ExternalParam [] ("m1" : Int32, "m2" : String); -- List of Struct.
----------
v1 [3, 5, 7]
v2 [("m1": 1, "m2": "a"), ("m1": 2, "m2": "b")]
```
2. Самой программы. Состоит из объявлений переменных, чтений/записей из/в базу, различных операций над переменными.

## Объявление переменных
Сразу отметим, что “переменные” на самом деле не переменные, а константные (как и в Haskell), знак “=“ обозначает “связывание" имени переменной со значением.  Однажды использованное имя нельзя “пересвязать”, все значения иммутабельны.

Формальная конструкция для объявления переменных типов Data и Key:
`<name> = literalType <body>;`

Указываются тип, имя и тело литерала. Телом литерала является strip-нутая строка от пробела после literalType и до символа ` ; `. Парсится тело литерала соответствующим типу литерала образом.
Например:
```
f = Bool True;
x = Int32 5;
y = UInt64 10;
s = String “15”;
k = DbKey /tag1/tag2:value2/tag3:*value3; 
-- типы значений тегов берутся из схемы:
-- : для static tag
-- :* для dynamic
```
**Грамматика**
Легенда:
 * {} — 0 или более раз
 * [] - 0 или 1 раз
 * () — группировка
 * | — или

```
digit = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
decimal = digit{digit}
hexit = digit | A | B | C | D | E | F
hexadecimal = hexit{hexit}

literalType = boolType | integerType | keyType | stringType
boolType = Bool
stringType = String
integerType = Int32 | UInt32 | Int64 | UInt64
keyType = DbKey | DocKey

literal = boolLiteral | integerLiteral | keyLiteral | stringLiteral | ExternalParam
boolLiteral = True | False
stringLiteral = "{stringElement}"
stringElement = printableCharNoDoubleQuota | charEscapeSeq
integerLiteral = int32Literal | uint32Literal | int64Literal | uint64Literal
int32Literal = [-] decimal | 0x hexadecimal
uint32Literal = int32Literal U
int64Literal = int32Literal L
uint64Literal = uint32Literal L

keyLiteral = /{tag/}
tag = tagname[(:|:*)value]
tagname = // здесь разумное ограничение на tagname.
value = // здесь разумное ограничение на value.
```
## Представление типов и работа с ними

### Data
_Types_: Int32, Int64, UInt32, UInt64, Bool, String.

Считаем дата-литералы встроенными в язык:
1, 0x1 — Int32
1U, 0x1U — UInt32
1L, 0x1L — Int64
1UL, 0x1UL — UInt64
True — Bool
"aaa" — String

```
x = Int32 32;
y = UInt32 32;
k = x + 19;
s = String "aaa";
```
### List 
_Type_: List
_Methods_: len, skip, take, append, extend, ...

List -- гомогенный контейнер, т.е. содержит в себе элементы только одного типа. Поэтому при создании пустого листа необходимо задавать его тип. Оперировать с листом необходимо через методы этого типа.
```
l1 = ["asdf", "fdsa"];
l2 = [] Int32;
x = len l2; -- 0
l3 = append l2 10;
```

### Struct 
_Type_: Struct
_Methods_: getMember, addMember

Struct -- гетерогенный контейнер. По имени можно извлечь/положить значение.

```
s = (); // Empty struct.
s1 = addMember s “member” 1;
s2 = (“member1”: 12, “member2”: “hi");  -- имена полей (member) — всегда строки.
val = getMember s2  “fieldname1”; -- 12
```
### Dict 
_Type_: Dict
_Methods_: contains, lookup
_Built-ins_: createHashedDict, createSortedDict

Все ключи одного типа (причём из Data) и все значения одного типа.
Создание и работа с Dict:
```
d = {2: 2L, 3: 3L}; -- {key1: val1, key2: val2, …}
has = contains d 2; -- True
val = lookup d 3; -- <3L>
```
### Optional 
_Type_: Opt
_Methods_: coalesce, exist, ifPresent

Создание и работа с Opt:
```
o1 = <> Int32;
f1 = exist o1; -- False.
val = coalesce o1 5; -- val == 5.

someVar = Int32 12;
o2 = <someVar>;
f2 = ifPresent o2 "true" "false"; -- will be "true".
```
### DbKey и DocKey 
_Types_: DbKey, DocKey
_Consts_: RootDbKey, RootDocKey, DbKey, DocKey
_Methods_: addDynamicTag, addStaticTag, addScalarTag

Для работы с ключами есть методы, которые позволяют создавать ключ на основе уже существующего ключа.
Также есть две константы RootDbKey и RootDocKey типов DbKey и DocKey, обозначающие ключ корня базы и ключ корня документа.
Создание DbKey (с DocKey аналогично):
```
someVal = 2 + 2;
parentKey = RootDbKey;
dbk1 = addDynamicTag parentKey "tagname1" someVal;
dbk2 = addStaticTag parentKey "tagname2" 4;
dbk3 = addScalarTag parantKey "tagname3";
```
Можно определять ключ через строковое представление:
```
k = DbKey /tag1/tag2:someVal2/tag3:*someVal3/;
```
: -- static, :* -- dynamic.

Возможно, стоит добавить возможность использование tagid вместо tagname (например, так):
```
dbk = addDynamicTag RootDbKey #tagid someVal;
```
## Различные операции
### Арифметические операции 
Можно производить только над Data (и должно поддерживаться типом): ` +, -, *, /, % `

Для ` +, -, * ` результатом является Data, 

для ` /, % ` -- Opt of Data.

### Операции сравнения 
Любые два значения типа Data можно сравнивать: ` ==, <=, <, >, >=, /= `
Результатом сравнения является Bool.

Также на == и /= можно сравнить Opt of Data с Opt of Data и Opt of Data с Data.

```
f1 = 1 < 2; -- True
o = <12>; -- Opt
x = 13;
f2 = o /= x; -- True
```
### Логические операции 
_Keywords_: and, or, xor, not
and, or, xor, not — работают с Bool, на выходе Bool.
```
f1 = Bool True;
f2 = Bool False;
f3 = f1 and f2; // False.
```
## Разное
### map, reduce и лямбды
_KeyWords_: _, map, reduce, sort, filter, ...
На входе List и лямбды. На выходе List.

Haskell-style: 
`\x y -> x + y`

Scala-style: 
```
// simple
(x : Int, y : Int) => x + y
// multiline
(x : Int, y : Int) => { 
    val xx = 2 * x
    val yy = 2 * y
    xx + yy
}
```
Лично мне больше нравится синтаксис Scala, можно что-то такое использовать:
```
(x, y) => x + y;

(x, y) => {
    xx = 2 * x;
    yy = 2 * y;
    xx + yy;
}
```

Map, sort
```
l = [1, 2, 3, 4];
l2 = map l (x) => {x + 1;}; -- символ _ -- переданный элемент.
l3 = sort l (x) => {-x}; -- сортировка в обратном порядке.
```
### If-then-else 
_KeyWords_: if, then, else
```
if 2 < 4 then "true" else "false";
```
### Макросы 
/// TODO функции вместо макросов

## Работа с базой
### Read
На входе -- DbKey. На выходе empty Opt или Opt of Opt of Data.

```
k = DbKey /tag1/tag2:someVal2/;
res = read k;
```
### Range Read
```
k = DbKey /t1/t2/t3/;
subk1 = DbKey /t4/;
subk2 = DbKey /t5/;
subkeys = ("subk1": subk1, "subk2": subk2);
res = readrange k t5 <initValue> <termValue> subkeys; 
```
TODO: как работать с subkey в ProgramBuilder?

### Write
Запись/обновление данных по ключу. Писать можно только Data или Opt of Data (для нескалярных тегов).
```
k = DbKey /t1/t2/;
payload = Int32 4;
write k payload;
```
### Erase
Удаление данных по ключу.
```
k = DbKey /t1/t2/;
erase k;
```
## Пример
Пример простой программы, которая по двум userId (задаются внешними параметрами) возвращает имя старшего из них по информации из базы.

ext_params.txt
```
userId1 12345
userId2 54321
```
program
```
userId1 = ExternalParam UInt64;
userId2 = ExternalParam UInt64;

k1 = DbKey /userinfo/ages_and_names:userId1/;
k2 = DbKey /userinfo/ages_and_names:userId2/;

// Делаем Read'ы по ключам k1 и k2. 
res1 = read k1;
res2 = read k2;
// Обработка ответа...
// Пусть в результате обработки ответа получены две структуры s1 и s2 вида { "name" : String, "age" : UInt32 }

age1 = getMember s1 "age";
age2 = getMember s2 "age";

elderName = if age1 > age2
    then getMember s1 "name"
    else getMember s2 "name";

// Делаем Write elderName.
// ...
```
