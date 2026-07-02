[Документация Yandex Cloud](../index.md) > [Yandex Monitoring](index.md) > Начало работы

# Как начать работать с Yandex Monitoring

При помощи этой инструкции вы создадите дашборд и разместите виджеты, которые отображают состояния ресурсов Yandex Cloud.

{% note info %}

Yandex Monitoring автоматически создает сервисные дашборды с набором готовых виджетов, которые отображают состояние ваших облачных ресурсов.

Если у вас нет ресурсов, создайте их (например, виртуальную машину и кластер ClickHouse®), чтобы начать работать с сервисом.

{% endnote %}


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvgvuhu34zple6f3vj?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=TvLdfcPCOHw).



## Создайте новый дашборд {#create-dashboard}

1. На [главной странице](https://monitoring.yandex.cloud) сервиса нажмите **Создать дашборд**.
1. Справа вверху нажмите ![image](../_assets/console-icons/plus.svg) и выберите **Заголовок**.
1. В текстовом поле введите `Кросс-сервисный дашборд`.
1. Нажмите **Сохранить**.
   
   Заголовок позволяет отделить одну секцию дашборда от другой.
1. Сохраните дашборд:
   1. Справа вверху нажмите ![image](../_assets/console-icons/ellipsis.svg) и выберите **Сохранить**.
   1. Введите заголовок дашборда.


## Добавьте виджет сервиса Yandex Compute Cloud {#add-compute-widget}

1. Справа вверху нажмите ![image](../_assets/console-icons/plus.svg) и выберите **График**.
1. Настройте новый график с загрузкой CPU всех виртуальных машин в каталоге, указав в запросе метрику `cpu_usage` сервиса Yandex Compute Cloud. Для этого выберите следующие метки в конструкторе запроса:
    - `service=Compute Cloud`
    - `name=cpu_usage`
    - `resource_id=*`
    - `resource_type=vm`
1. Нажмите **Выполнить запрос**. График отобразится на странице.
1. Вверху рядом с именем дашборда введите имя виджета, например, `CPU on all hosts`.
1. Справа вверху нажмите **Применить**.
1. Вернитесь на страницу редактирования дашборда: вверху нажмите заголовок дашборда, который указали ранее.

## Добавьте виджет сервиса Yandex Managed Service for ClickHouse® {#add-clickhouse-widget}

1. Нажмите ![image](../_assets/console-icons/plus.svg) и выберите **График**.
1. Настройте новый график с количеством свободного места на машинах кластера Yandex Managed Service for ClickHouse®, указав в запросе метрику `disk.free_bytes`. Для этого выберите следующие метки в конструкторе запроса:
    - `service=Managed Service for ClickHouse`
    - `name=disk.free_bytes`
    - `host=*`
    - `resource_id=*`
    - `resource_type=cluster`

1. Нажмите **Выполнить запрос**.
1. Укажите имя виджета, например, `Free space on ClickHouse hosts`.
1. Примените изменения и вернитесь на страницу редактирования дашборда. 

## Сохраните созданный дашборд {#save-dashboard}

1. При необходимости измените размер виджетов и разместите их в произвольном порядке на дашборде.
1. Справа вверху нажмите ![image](../_assets/console-icons/floppy-disk.svg) **Сохранить**.

В результате вы создали дашборд с виджетами, которые отображают состояние ресурсов из разных сервисов Yandex Cloud.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._