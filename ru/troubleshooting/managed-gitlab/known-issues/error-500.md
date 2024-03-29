# Устранение ошибки HTTP 500 в {{ mgl-name }}


## Описание проблемы {#issue-description}

* При попытке открыть веб-интерфейс инстанса {{ mgl-name }} отображается сообщение об ошибке HTTP 500 или HTTP 502.

## Решение {#issue-resolution}

Наиболее популярная причина этой проблемы заключается в исчерпании инстансом {{ mgl-name }} свободного места на диске.
Большое количество дискового пространства могут занимать образы контейнеров и сборочные артефакты.

{% note info %}

При создании инстанса {{ mgl-name }} по умолчанию включена опция «Удалять образы без тегов при обслуживании».
Эта опция позволяет выполнять периодическое удаление тех образов, на которые не ссылаются сборочные манифесты.

{% endnote %}

Для решения проблемы на текущий момент понадобится [создать запрос в техническую поддержку]({{ link-console-support }}).
Перед очисткой и удалением данных инженеры технической поддержки создадут снимок диска с данными инстанса {{ mgl-name }} для возможности отката и восстановления данных.
Также по вашему запросу инженеры могут увеличить размер диска с данными.

При создании запроса просим указать следующую информацию:

1. Идентификатор инстанса {{ mgl-name }}.
2. Что именно нужно сделать - запустить глубокую очистку данных или увеличить размер диска с данными.
