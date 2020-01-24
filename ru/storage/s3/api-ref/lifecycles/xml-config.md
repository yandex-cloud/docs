# Конфигурация жизненных циклов объектов в бакете

{{ objstorage-name }} позволяет управлять [жизненными циклами объектов](../../../concepts/lifecycles.md) в бакете. Для загрузки конфигурации жизненных циклов в {{ objstorage-name }} необходимо сформировать XML-документ, описанный в этом разделе. При скачивании существующей конфигурации, вы получите документ такого же формата.

Общий вид конфигурации:

```xml
<LifecycleConfiguration>
    <Rule>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
           <Prefix>префикс_ключа</Prefix>
        </Filter>

        <Transition>
            <StorageClass>Идентификатор класса хранилища</StorageClass>
            <!-- <Date> или <Days> -->
        </Transition>
        ...
        <Expiration>
            <!-- <Date> или <Days> -->
        </Expiration>
        ...
    </Rule>
    <Rule>
      ...
    </Rule>
    ...
</LifecycleConfiguration>
```

Конфигурация может содержать до 1000 правил.

## Элементы {#elements}

Элемент | Описание
----- | -----
`Date` | Дата исполнения правила.<br/><br/>Формат — [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DD`. Время — всегда 00:00 UTC.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Date`.
`Days` | Интервал исполнения правила.<br/><br/>Задается количеством дней после загрузки объекта.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Days`.
`Expiration` | Правило для удаления объекта из {{ objstorage-name }}.<br/><br/>Содержит элемент `Days` или `Date`, который определяет сроки исполнения действия.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration`.
`Filter` | Фильтр объектов.<br/><br/>Содержит не более одного элемента `Prefix`. Если установить пустой фильтр `<Filter></Filter>`, то правило применяется ко всем объектам в бакете.<br/><br/>Путь: `LifecycleConfiguration\Rule\Filter`.
`ID` | Уникальный идентификатор правила.<br/><br/>Длина до 255 символов. Необязательный параметр, который можно использовать для поиска правила в конфигурации.<br/><br/>Путь: `LifecycleConfiguration\Rule\ID`.
`LifecycleConfiguration` | Корневой элемент XML-документа.<br/><br/>Может содержать до 1000 элементов `Rule`.<br/><br/>Путь: `LifecycleConfiguration`.
`Prefix` | Префикс ключа.<br/><br/>Используется для фильтрации объектов, попадающих под действие правила.<br/><br/>Примеры префиксов для ключа `some/long/object/key`: `some`, `some/`, `some/lo`.<br/><br/>Фильтр может содержать только один префикс.<br/><br/>Путь:`LifecycleConfiguration\Rule\Filter\Prefix`.
`Rule` | Описание правила.<br/><br/>Объекты, попадающие под действие правила задаются элементом `Filter`. Действия над объектами определяются элементами `Transition` и `Expiration`. Действий каждого типа может быть несколько.<br/><br/>Путь: `LifecycleConfiguration\Rule`.
`Status` | Статус правила.<br/><br/>Правило можно активировать, установив `<Status>Enabled</Status>`, или отключить, установив `<Status>Disabled</Status>`.<br/><br/>Путь: `LifecycleConfiguration\Rule\Status`.
`StorageClass` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Путь: `LifecycleConfiguration\Rule\Transition\StorageClass`.
`Transition` | Правило для изменения [класса хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Содержит элемент `StorageClass`, который определяет целевой класс хранилища, а также элемент `Date` или `Days`, который определяет срок исполнения действия.<br/><br/>Переместить объекты можно только из стандартного в холодное хранилище.<br/><br/>Путь: `LifecycleConfiguration\Rule\Transition\`.

## Пример {#example}

Приведенное ниже правило для всех объектов, загруженных в бакет, задает:

- Перемещение в холодное хранилище через 30 дней после загрузки в {{ objstorage-name }}.
- Удаление из {{ objstorage-name }} через 365 дней после загрузки.

```xml
<LifecycleConfiguration>
    <Rule>
        <Status>Enabled</Status>
        <Filter>
           <Prefix></Prefix>
        </Filter>
        <Transition>
            <StorageClass>COLD</StorageClass>
            <Days>30</Days>
        </Transition>
        <Expiration>
            <Days>365</Days>
        </Expiration>
    </Rule>
</LifecycleConfiguration>
```
