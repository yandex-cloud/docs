# How to get information about the number of challenges used over a certain period



## Case description {#case-description}

You need to get information about the number of challenges used over a certain period.

## Solution {#case-resolution}

You can find the approximate number of challenges in the **{{ ui-key.yacloud.common.monitoring }}** section and select the desired period using the time filter.

Description of monitoring charts:

* `Checkbox captcha shows`: Number of displays of the standard **I'm not a robot** button.
* `Checkbox captcha results`: Number of responses.
* `Advanced challenge shows`: Number of challenge displays.
* `Advanced challenge results`: Number of responses in the pop-up window.
* `Validate results`: Number of validations, the total number of responses.

You only pay for `Validate results`. To learn more about the relevant pricing, see [this article](../../../smartcaptcha/pricing.md).

You cannot use Monitoring to find out the exact number of requests; however, you can use the {{ billing-name }} itemization for this, if you enable product breakdown. There, you can see all requests to {{ captcha-name }}, whether successful or not. 

You can export detailed information to a CSV file by clicking **{{ ui-key.yacloud_billing.billing.account.detail.button_export }}**. The exported file will include data on {{ captcha-name }} requests for each day, accurate to individual requests.