Имя метрики пишется в метку `name`.

Общие метки для всех метрик {{ captcha-name }}:

| Метка | Значение |
| --- | --- |
service | Идентификатор сервиса: `smartcaptcha`
captcha | Идентификатор [капчи](../../../smartcaptcha/concepts/validation.md) |
host | Имя [домена](../../../smartcaptcha/concepts/domain-validation.md) |

Метрики сервиса:

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, штуки | Количество успешных решений дополнительного задания. |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений дополнительного задания. |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, штуки | Количество показов основного задания с типом `Чекбокс`. |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, штуки | Количество показов основного задания с типом `Слайдер`. |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, штуки | Количество успешных решений основного задания с типом `Чекбокс`. |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, штуки | Количество показов основного задания всех типов. |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, штуки | Количество успешных решений основного задания всех типов. |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, штуки | Количество неуспешных решений основного задания всех типов. |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, штуки | Количество событий успешной валидации пользователя. |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, штуки | Количество событий неуспешной валидации пользователя. |