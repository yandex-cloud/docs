The `name` label contains the metric name.

Labels shared by all {{ captcha-name }} metrics:

| Label | Value |
| --- | --- |
service | Service ID: `smartcaptcha`
captcha | [Captcha](../../../smartcaptcha/concepts/validation.md) ID |
host | [Domain](../../../smartcaptcha/concepts/domain-validation.md) name |

Service metrics:

| Metric name<br>Type, units | Description |
| --- | --- |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, count | Number of successful attempts to solve an extra challenge |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, count | Number of failed attempts to solve an extra challenge |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, count | Number of times the main challenge of the `checkbox` type was shown. |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, count | Number of times the main challenge of the `slider` type was shown. |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, count | Number of successful attempts to solve the main challenge of the `checkbox` type |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, count | Number of times the main challenge of all types was shown. |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, count | Number of successful attempts to solve the main challenge of all types |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, count | Number of failed attempts to solve the main challenge of all types |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, count | Number of successful user validation events |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, count | Number of failed user validation events |