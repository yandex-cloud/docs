# Конфигурация жизненных циклов объектов в бакете

{{ objstorage-name }} позволяет управлять [жизненными циклами объектов](../../../concepts/lifecycles.md) в бакете. Для загрузки конфигурации жизненных циклов в {{ objstorage-name }} необходимо сформировать XML-документ, описанный в этом разделе. При скачивании существующей конфигурации, вы получите документ такого же формата.

Общий вид конфигурации:

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Описание правила</ID>
        <Status>{Enabled|Disabled}</Status>
        <Filter>
            <ObjectSizeGreaterThan>минимальный размер объекта</ObjectSizeGreaterThan>
            <ObjectSizeLessThan>максимальный размер объекта</ObjectSizeLessThan>
            <Prefix>префикс ключа</Prefix>
        </Filter>

        <Transition>
            <StorageClass>Идентификатор класса хранилища</StorageClass>
            <!-- <Date> или <Days> -->
        </Transition>

        <Expiration>
            <!-- <Date> или <Days> -->
            <!-- <ExpiredObjectDeleteMarker> -->
        </Expiration>

        <NoncurrentVersionTransition>
            <StorageClass>Идентификатор класса хранилища</StorageClass>
            <NoncurrentDays>Перенос версий, которые старше указанного количества дней</NoncurrentDays>
        </NoncurrentVersionTransition>

        <NoncurrentVersionExpiration>
            <NoncurrentDays>Удаление версий, которые старше указанного количества дней</NoncurrentDays>
        </NoncurrentVersionExpiration>

        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>Удаление загрузок, не завершенных за указанное количество дней</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
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
`AbortIncompleteMultipartUpload` | Правило для удаления загрузок, не завершенных за указанное количество дней.<br/><br/>Содержит элемент `DaysAfterInitiation`, который определяет срок исполнения правила.<br/><br/>Путь: `LifecycleConfiguration\Rule\AbortIncompleteMultipartUpload\` `DaysAfterInitiation`.
`Date` | Дата исполнения правила.<br/><br/>Формат — [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601), например, `YYYY-MM-DD`. Время — всегда 00:00 UTC.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Date`.
`Days` | Интервал исполнения правила.<br/><br/>Задается количеством дней после загрузки объекта.<br/><br/>Минимальное значение — 1.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration\Days`.
`Expiration` | Правило для удаления объекта из {{ objstorage-name }}.<br/><br/>Содержит элемент `Days` или `Date`, который определяет сроки исполнения действия.<br/>Дополнительно может содержать `ExpiredObjectDeleteMarker` — маркер удаления объекта с истекшим сроком действия, который указывает, удалит ли {{ objstorage-name }} маркер удаления при отсутствии неактивных версий.<br/><br/>Путь: `LifecycleConfiguration\Rule\Expiration`.
`Filter` | Фильтр объектов.<br/><br/>Содержит не более одного элемента каждого типа: `Prefix`, `ObjectSizeGreaterThan`, `ObjectSizeLessThan`.<br/><br/>Если установить пустой фильтр `<Filter></Filter>`, то правило применяется ко всем объектам в бакете.<br/><br/>Путь: `LifecycleConfiguration\Rule\Filter`.
`ID` | Уникальный идентификатор правила.<br/><br/>Произвольный текст длиной до 255 символов, например "Удалить через 20 дней". Необязательный параметр, который можно использовать для поиска правила в конфигурации.<br/><br/>Если идентификатор не указан, то {{objstorage-name}} генерирует его автоматически.<br/><br/>Путь: `LifecycleConfiguration\Rule\ID`.
`LifecycleConfiguration` | Корневой элемент XML-документа.<br/><br/>Может содержать до 1000 элементов `Rule`.<br/><br/>Путь: `LifecycleConfiguration`.
`ObjectSizeGreaterThan` | Минимальный размер объекта в байтах.<br/><br/>Под действие правила попадают объекты, размер которых больше или равен указанному.<br/><br/>Фильтр может содержать только один минимальный размер объекта.<br/><br/>Путь:`LifecycleConfiguration\Rule\Filter\ObjectSizeGreaterThan`.
`ObjectSizeLessThan` | Максимальный размер объекта в байтах.<br/><br/>Под действие правила попадают объекты, размер которых меньше или равен указанному.<br/><br/>Фильтр может содержать только один максимальный размер объекта.<br/><br/>Путь:`LifecycleConfiguration\Rule\Filter\ObjectSizeLessThan`.
`Prefix` | Префикс ключа.<br/><br/>Под действие правила попадают объекты с указанным префиксом ключа.<br/><br/>Примеры префиксов для ключа `some/long/object/key`: `some`, `some/`, `some/lo`.<br/><br/>Фильтр может содержать только один префикс.<br/><br/>Путь:`LifecycleConfiguration\Rule\Filter\Prefix`.
`Rule` | Описание правила.<br/><br/>Объекты, попадающие под действие правила задаются элементом `Filter`. Действия над объектами определяются элементами `Transition` и `Expiration`. Действий каждого типа может быть несколько.<br/><br/>Путь: `LifecycleConfiguration\Rule`.
`Status` | Статус правила.<br/><br/>Правило можно активировать, установив `<Status>Enabled</Status>`, или отключить, установив `<Status>Disabled</Status>`.<br/><br/>Путь: `LifecycleConfiguration\Rule\Status`.
`StorageClass` | [Класс хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Путь: `LifecycleConfiguration\Rule\Transition\StorageClass`.
`Transition` | Правило для изменения [класса хранилища](../../../concepts/storage-class.md) объекта.<br/><br/>Содержит элемент `StorageClass`, который определяет целевой класс хранилища, а также элемент `Date` или `Days`, который определяет срок исполнения действия.<br/><br/>Переместить объекты можно из стандартного (`STANDARD`) в холодное (`COLD`) или ледяное (`ICE`) хранилище, а также из холодного в ледяное хранилище.<br/><br/>Путь: `LifecycleConfiguration\Rule\Transition\`.
`NoncurrentVersionTransition` | Правило для изменения [класса хранилища](../../../concepts/storage-class.md) неактивных версий объекта. Это правило применяется не ко всему объекту, а только к его неактивным версиям.<br/><br/>Содержит элемент `StorageClass`, который определяет целевой класс хранилища, а также элемент `NoncurrentDays`, который определяет срок исполнения действия.<br/><br/>Переместить объекты можно из стандартного (`STANDARD`) в холодное (`COLD`) или ледяное (`ICE`) хранилище, а также из холодного в ледяное хранилище.<br/><br/>Путь: `LifecycleConfiguration\Rule\NoncurrentVersionTransition`.
`NoncurrentVersionExpiration` | Правило для удаления неактивных версий объекта из {{ objstorage-name }}. Это правило применяется не ко всему объекту, а только к его неактивным версиям.<br/><br/>Содержит элемент `NoncurrentDays`, который определяет сроки исполнения действия.<br/><br/>Путь: `LifecycleConfiguration\Rule\NoncurrentVersionExpiration`.

## Пример {#example}

Приведенное ниже правило для всех объектов, загруженных в бакет, задает:

- Перемещение в холодное хранилище через 30 дней после загрузки в {{ objstorage-name }}.
- Удаление из {{ objstorage-name }} через 365 дней после загрузки.
- Удаление из {{ objstorage-name }} незавершенных загрузок через 5 дней после начала загрузки.

```xml
<LifecycleConfiguration>
    <Rule>
        <ID>Переместить и потом удалить</ID>
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
        <AbortIncompleteMultipartUpload>
            <DaysAfterInitiation>5</DaysAfterInitiation>
        </AbortIncompleteMultipartUpload>
    </Rule>
</LifecycleConfiguration>
```
