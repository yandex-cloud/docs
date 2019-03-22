# Конфигурация жизненного цикла объектов в бакете

Для передачи через [HTTP API, совместимый с Amazon S3](../s3/index.md) конфигурация жизненных циклов форматируется в виде XML документа следующего вида:

```
<LifecycleConfiguration>
    <Rule>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
           <Prefix>префикс_ключа</Prefix>
        </Filter>
        <Expiration>
            <!-- <Date> или <Days> -->
        </Expiration>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    …
</LifecycleConfiguration>
```

Конфигурация может содержать до 1000 правил.

## Возможные элементы

Элемент | Описание
----- | -----
`Date` | Дата, в которую [!KEYREF objstorage-name] выполнит действие.<br/><br/>Дата должна соответствовать формату ISO 8601, например, `YYYY-MM-DD`. Время — всегда 00:00 UTC.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Date`.
`Days` | Определяет количество дней после загрузки объекта, когда правило становится применимо.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Days`.
`Expiration` | Содержит элементы `<Days>` и/или `<Date>`, которые определяют сроки удаления объекта из [!KEYREF objstorage-name].<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration`.
`Filter` | Содержит не более одного элемента `Prefix`.<br/><br/>Если установить пустой фильтр `<Filter></Filter>`, то правило применяется ко всем элементам в бакете.<br/><br/>Путь: `LifecycleConfiguration\Rule\Filter`.    
`ID` | Уникальный идентификатор правила.<br/><br/>Длина идентификатора не более 255 символов. Необязательный параметр. Можно использовать для поиска правила в конфигурации.<br/><br/>Путь: `LifecycleConfiguration\Rule\ID`.
`LifecycleConfiguration` | Корневой элемент XML документа. Может содержать до 1000 элементов `<Rule>`.<br/><br/>Путь: `LifecycleConfiguration`.
`Prefix` | Префикс ключа, который используется для фильтрации объектов при применении правила.<br/>Например, для ключа `some/long/object/key` можно использовать любой префикс, независимо от расстановки слешей в его имени. То есть, при использовании любого из префиксов `some`, `some/`, `some/long/obj` и т.д., ключ `some/long/object/key` попадет под действие правила. <br/><br/>Фильтр может содержать только один префик.<br/><br/>Путь:`LifecycleConfiguration\Rule\Filter\Prefix`.
`Rule` | Содержит описание одного правила.<br/><br/>Путь: `LifecycleConfiguration\Rule`.
`Status` |Правило можно активировать, установив `<Status>Enabled</Status>`, или отключить, установив `<Status>Disabled</Status>`.<br/><br/>Путь: `LifecycleConfiguration\Rule\Status`.
