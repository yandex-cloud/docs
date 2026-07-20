The `name` label contains the metric name.

Labels shared by all {{ captcha-name }} metrics:

| Label | Value |
| --- | --- |
service | Service ID: `smartcaptcha`
captcha | [Captcha](../../../smartcaptcha/concepts/validation.md) ID |

Service metrics:

| Metric name<br>Type, units | Description |
| --- | --- |
| `smartcaptcha.captcha.advanced.failed_count`<br>`IGAUGE`, count | Number of failed [extra challenge](../../../smartcaptcha/concepts/tasks.md#additional-task) attempts. |
| `smartcaptcha.captcha.advanced.refresh_count`<br>`IGAUGE`, count | Number of times the additional challenge was refreshed. |
| `smartcaptcha.captcha.advanced.success_count`<br>`IGAUGE`, count | Number of successful extra challenge attempts. |
| `smartcaptcha.captcha.checkbox.failed_count`<br>`IGAUGE`, count | Number of failed `checkbox` type [main challenge](../../../smartcaptcha/concepts/tasks.md#main-task) attempts. |
| `smartcaptcha.captcha.checkbox.shows`<br>`IGAUGE`, count | Number of times the `checkbox` type main challenge was shown. |
| `smartcaptcha.captcha.checkbox.success_count`<br>`IGAUGE`, count | Number of successful `checkbox` type main challenge attempts. |
| `smartcaptcha.captcha.image.failed_count`<br>`IGAUGE`, count | Number of failed `text recognition` type extra challenge attempts. |
| `smartcaptcha.captcha.image.refresh_count`<br>`IGAUGE`, count | Number of times the `text recognition` type additional challenge was refreshed. |
| `smartcaptcha.captcha.image.success_count`<br>`IGAUGE`, count | Number of successful `text recognition` type extra challenge attempts. |
| `smartcaptcha.captcha.kaleidoscope.failed_count`<br>`IGAUGE`, count | Number of failed `kaleidoscope` type extra challenge attempts. |
| `smartcaptcha.captcha.kaleidoscope.success_count`<br>`IGAUGE`, count | Number of successful `kaleidoscope` type extra challenge attempts. |
| `smartcaptcha.captcha.precheck.failed_count`<br>`IGAUGE`, count | Number of failed main challenge attempts, all types. |
| `smartcaptcha.captcha.precheck.shows`<br>`IGAUGE`, count | Number of times the main challenge was shown, all types. |
| `smartcaptcha.captcha.precheck.success_count`<br>`IGAUGE`, count | Number of successful main challenge attempts, all types. |
| `smartcaptcha.captcha.silhouette.failed_count`<br>`IGAUGE`, count | Number of failed `silhouettes` type extra challenge attempts. |
| `smartcaptcha.captcha.silhouette.success_count`<br>`IGAUGE`, count | Number of successful `silhouettes` type extra challenge attempts. |
| `smartcaptcha.captcha.slider.shows`<br>`IGAUGE`, count | Number of times the `slider` type main challenge was shown. |
| `smartcaptcha.captcha.slider.success_count`<br>`IGAUGE`, count | Number of successful `silhouettes` type main challenge attempts. |
| `smartcaptcha.captcha.validate.failed_count`<br>`IGAUGE`, count | Number of failed [user validation](../../../smartcaptcha/concepts/validation.md) events. |
| `smartcaptcha.captcha.validate.success_count`<br>`IGAUGE`, count | Number of successful user validation events. |