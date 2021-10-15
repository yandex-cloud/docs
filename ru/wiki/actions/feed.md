# RSS-лента новостей

Блок `feed` позволяет встроить на страницу RSS-ленту записей из [Этушки](https://my.at.yandex-team.ru/) или внешних источников.

## Вызов блока {#feed-call}

Показать записи из Этушки:
```
{{feed url="http://my.at.yandex-team.ru/rss/popular.xml" notitlelink=1 max=5 nomark=1 time=1 dateformat="d.m H:M" today=1}}
```

Показать записи внешнего сайта:
```
{{feed url="http://rss.newsru.com/top/big/" nodesc="1" max=3 nomark=1 time=1 dateformat="d.m"}} 
```

## Параметры блока {#feed-params}

Параметр | Описание
--- | ---
`url` | Адрес RSS-ленты.
`notitlelink` | Не делать заголовок элемента RSS-ленты ссылкой.
`max`\|`limit` | Максимальное количество записей в RSS-ленте.
`nomark` | По умолчанию RSS-лента отображается в рамке (`nomark = 0`). Чтобы скрыть рамку, укажите значение `nomark = 1`.
`title` | Заголовок RSS-ленты.
`time` | Параметр отображения даты публикации записи. Чтобы скрыть дату, укажите `time = 0`.
`dateformat` | Формат отображения даты (метод [strftime](https://docs.python.org/2/library/datetime.html#strftime-strptime-behavior)).
`today` | Укажите `today = 1`, чтобы отобразить флаг `сегодня` напротив записей, опубликованных за день. Флаг отобразится работает, если параметр `time = 1`.