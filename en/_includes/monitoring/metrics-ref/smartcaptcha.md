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
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, count | Number of successful extra challenge attempts. |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, count | Number of failed extra challenge attempts. |
| `smartcaptcha.captcha.advanced.refresh_count`<br>`IGAUGE`, count | Number of times the additional challenge was refreshed. |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, count | Number of times the `checkbox` type main challenge was shown. |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, count | Number of times the `slider` type main challenge was shown. |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, count | Number of successful `checkbox` type main challenge attempts. |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, count | Number of times the main challenge was shown, all types. |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, count | Number of successful main challenge attempts, all types. |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, count | Number of failed main challenge attempts, all types. |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, count | Number of successful user validation events. |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, count | Number of failed user validation events. |