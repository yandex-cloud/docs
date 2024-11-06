---
editable: false
sourcePath: ru/_api-ref/datalens/function-ref/IMAGE.md
---

# IMAGE



#### Синтаксис {#syntax}


```
IMAGE( src [ , width [ , height [ , alt ] ] ] )
```

#### Описание {#description}
Позволяет вставить в таблицу изображение, расположенное по адресу `src`. Ширина (`width`) и высота (`height`) изображения указываются в пикселях. Если для одного из размеров указано значение `NULL`, он рассчитывается автоматически пропорционально размеру другой стороны. Если для обоих размеров указано значение `NULL`, изображение вставляется с исходными размерами. В случае проблем с загрузкой изображения функция выводит альтернативный текст `alt`.



Допускается добавление изображений с доменов `*.yandex.ru`, `*.yandex.net`, `yastat.net`, `yastatic.net` или `storage.yandexcloud.net`. Самый простой способ — загрузить и опубликовать изображение в [Yandex Object Storage](../../storage/quickstart.md) (ознакомьтесь с [правилами тарификации](../../storage/pricing.md#prices-storage) сервиса).





**Типы аргументов:**
- `src` — `Строка`
- `width` — `Целое число`
- `height` — `Целое число`
- `alt` — `Строка`


**Возвращаемый тип**: `Разметка`

#### Примеры {#examples}


```
IMAGE('https://storage.yandexcloud.net/functions********/nature-01.jpg', 250, 150, 'alt-text-1')
```

```
IMAGE('https://storage.yandexcloud.net/functions********/nature-02.jpg', NULL, NULL, 'alt-text-2')
```




#### Поддержка источников данных {#data-source-support}

`ClickHouse 21.8`, `Файлы`, `Google Sheets`, `Microsoft SQL Server 2017 (14.0)`, `MySQL 5.7`, `Oracle Database 12c (12.1)`, `PostgreSQL 9.3`, `Яндекс Документы`, `YDB`.
