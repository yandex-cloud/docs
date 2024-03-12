Common labels for all {{ captcha-name }} metrics:

| Label | Value |
| --- | --- |
| service | Service ID: `smartcaptcha` |
| captcha | [Captcha](../../../smartcaptcha/concepts/validation.md) ID |
| host | [Domain](../../../smartcaptcha/concepts/domain-validation.md) name |

Service metrics:

| Metric name<br>Type, units of measurement | Description |
| --- | --- |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, number | Number of successful attempts to solve an extra task |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, number | Number of failed attempts to solve an extra task |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, number | Number of displays of the main task of the `checkbox` type |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, number | Number of displays of the main task of the `slider` type |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, number | Number of successful attempts to solve the main task of the `checkbox` type |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, number | Number of displays of the main task of all types |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, number | Number of successful attempts to solve the main task of all types |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, number | Number of failed attempts to solve the main task of all types |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, number | Number of successful user validation events |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, number | Number of failed user validation events |