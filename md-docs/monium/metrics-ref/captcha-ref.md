[Документация Yandex Cloud](../../index.md) > [Monium](../index.md) > [Метрики](../metrics/overview.md) > [Справочник метрик](index.md) > SmartCaptcha

# Метрики Yandex SmartCaptcha


В этом разделе описаны метрики сервиса [SmartCaptcha](../../smartcaptcha/index.md), поставляемые в Monium Metrics.

Метрики сервиса SmartCaptcha автоматически передаются в [Monium](../metrics/overview.md) в [проект каталога](*monium-folder-project), в котором находится капча.

Если вы просматриваете метрики в интерфейсе сервиса или переходите к графику из [сервисного дашборда](../operations/dashboard/service-dashboards.md), значение метки `service` используется без подчеркиваний.

Если вы создаете запрос в Monium в [разделе метрик](../metrics/metric-explorer.md#add-graph) или в редакторе алерта, укажите проект каталога с ресурсом (`project = folder__<идентификатор_каталога>`), `cluster = default` и `service = __<идентификатор_сервиса>__`.


Имя метрики пишется в метку `name`.

Общие метки для всех метрик SmartCaptcha:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `smartcaptcha`
captcha | Идентификатор [капчи](../../smartcaptcha/concepts/validation.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений [дополнительного задания](../../smartcaptcha/concepts/tasks.md#additional-task). |
| `smartcaptcha.captcha.advanced.refresh_count`<br>`IGAUGE`, штуки | Количество обновлений дополнительного задания. |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания. |
| `smartcaptcha.captcha.checkbox.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений [основного задания](../../smartcaptcha/concepts/tasks.md#main-task) с типом `Чекбокс`. |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, штуки | Количество показов основного задания с типом `Чекбокс`. |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, штуки | Количество успешных решений основного задания с типом `Чекбокс`. |
| `smartcaptcha.captcha.image.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений дополнительного задания с типом `Распознавание текста`. |
| `smartcaptcha.captcha.image.refresh_count`<br>`IGAUGE`, штуки | Количество обновлений дополнительного задания с типом `Распознавание текста`. |
| `smartcaptcha.captcha.image.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания с типом `Распознавание текста`. |
| `smartcaptcha.captcha.kaleidoscope.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений дополнительного задания с типом `Калейдоскоп`. |
| `smartcaptcha.captcha.kaleidoscope.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания с типом `Калейдоскоп`. |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений основного задания всех типов. |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, штуки | Количество показов основного задания всех типов. |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, штуки | Количество успешных решений основного задания всех типов. |
| `smartcaptcha.captcha.silhouette.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений дополнительного задания с типом `Силуэты`. |
| `smartcaptcha.captcha.silhouette.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания с типом `Силуэты`. |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, штуки | Количество показов основного задания с типом `Слайдер`. |
| `smartcaptcha.captcha.slider.success_count`<br>`IGAUGE`, штуки | Количество успешных решений основного задания с типом `Слайдер`. |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, штуки | Количество событий неуспешной [валидации пользователя](../../smartcaptcha/concepts/validation.md). |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, штуки | Количество событий успешной валидации пользователя. |

[*monium-folder-project]: Проект Monium с идентификатором `folder__<идентификатор_каталога>` создается автоматически для каждого каталога и содержит телеметрию его ресурсов.