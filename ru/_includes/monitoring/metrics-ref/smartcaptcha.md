Имя метрики пишется в метку `name`.

Общие метки для всех метрик {{ captcha-name }}:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `smartcaptcha`
captcha | Идентификатор [капчи](../../../smartcaptcha/concepts/validation.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений [дополнительного задания](../../../smartcaptcha/concepts/tasks.md#additional-task). |
| `smartcaptcha.captcha.advanced.refresh_count`<br>`IGAUGE`, штуки | Количество обновлений дополнительного задания. |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания. |
| `smartcaptcha.captcha.checkbox.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений [основного задания](../../../smartcaptcha/concepts/tasks.md#main-task) с типом `Чекбокс`. |
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
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, штуки | Количество событий неуспешной [валидации пользователя](../../../smartcaptcha/concepts/validation.md). |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, штуки | Количество событий успешной валидации пользователя. |