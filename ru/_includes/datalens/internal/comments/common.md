## Общая информация {#about}

Комментарий может быть одного из следующих типов:
* **line-x** - линия
* **band-x** - область
* **flag-x** - флаг
* **dot-x-y** - точка

Комментарий определяется следующими параметрами:

* Служебные

  |Параметр|Тип|Описание
  |:---|:---|:---
  |id|`number`|Идентификатор
  |creatorLogin|`string`|Логин пользователя, создавшего комментарий
  |createdDate|`string`|ISO дата создания комментария
  |modifierLogin|`string`|Логин пользователя, который последним редактировал комментарий
  |modifiedDate|`string`|ISO дата последнего редактирования комментария

* Общие:

  |Параметр|Тип|Описание|Обязательный
  |:---|:---|:---|:---
  |feed|`string`|Канал, к которому относится комментарий)|✓
  |date|`string`|ISO дата, к которой относится комментарий|✓
  |dateUntil|`string`|ISO дата конца интервала, к которому относится комментарий (параметр `date` расценивается как начало интервала) (имеет смысл только для типа комментария `band-x`)|
  |type|`string`|Тип комментария|✓
  |text|`string`|Текст|✓
  |meta|`object`|Мета-информация|✓
  |params|`object`|Уточняющие параметры

Мета-информации в зависимости от типа комментария описывается следующим образом:

|Тип комментария|Параметр|Тип|Описание|Обязательный / По умолчанию
|:---|:---|:---|:---|:---
|Все типы|color|`string`|Цвет|`#ffcc00` или цвет линии (для `dot-x-y` )
|line-x|dashStyle|`string`|[Стиль начертания](http://jsfiddle.net/es6ejm5v/embedded/result/)|`solid`
|| width|`number`|Ширина|`2`
|band-x|visible|`boolean`|Видимость|`false`
||zIndex|`number`|Приоритет (в случае наложения)|`0`
|flag-x|y|`number`|Высота|`-30`
||shape|`string`|[Форма](http://jsfiddle.net/rb1zadgd/embedded/result/)|`circlepin`
|dot-x-y|graphId|`string`|ID линии|Обязательный
||visible|`boolean`|Показывать ли тултип|`false`
||fillColor|`string`|Цвет тултипа|`#000000`
||textColor|`string`|Цвет текста в тултипе|`#ffffff`

Для комментария можно задать уточняющие параметры, например:
```
{
    scale: ['d'],
    region: ['*']
}
```
где `*` - значит любое значение.
Параметры также можно задавать в ненормализованном виде (не оборачивая в массив одиночные значения), но в любом случае сохранены они будут в нормализованном виде.