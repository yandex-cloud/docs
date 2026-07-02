[Документация Yandex Cloud](../../index.md) > [Yandex DataLens](../index.md) > Вычисляемые поля > Справочник функций > Хеш-функции > SIPHASH64

# SIPHASH64



#### Синтаксис {#syntax}


```
SIPHASH64( value )
```

#### Описание {#description}
Возвращает хеш SipHash64 для `value` в виде целого числа.

**Типы аргументов:**
- `value` — `Строка`


**Возвращаемый тип**: `Целое число`

#### Пример {#examples}

```
SIPHASH64("DataLens") = 6283456972272785891
```


#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `YDB`.