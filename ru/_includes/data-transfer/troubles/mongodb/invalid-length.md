### Прерывание трансфера с ошибкой: cursor.Decode returned error {#invalid-length}

Текст ошибки:

```text
cursor.Decode returned error: invalid length
```

Такая ошибка может возникать при использовании типов бинарных данных `unsigned_byte(2) Binary` и `unsigned_byte(3) UUID`, которые в соответствии со [спецификацией BSON](https://bsonspec.org/spec.html) помечены как устаревшие (deprecated).

Пример использования типа `unsigned_byte(2) Binary`:

```text
Binary.createFromBase64('<строка в Base64>', 2)
```

**Решение:** Для корректной работы трансфера используйте бинарный подтип 0 вместо подтипа 2 и бинарный подтип 4 вместо подтипа 3.

Например, после замены выражения выше на `Binary.createFromBase64('<строка в Base64>', 0)` ошибка не возникает.
