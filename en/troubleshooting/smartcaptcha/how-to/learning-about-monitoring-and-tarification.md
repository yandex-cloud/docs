# How to get information about the number of checks used over a given period




## Issue description {#case-description}

You need to obtain information on the number of checks used over a specific period.

## Solution {#case-resolution}

You can find the approximate number of checks in the **Monitoring** section and select the desired period using the time filter.


Description of monitoring charts:

* `Checkbox captcha shows`: Number of displays of the standard `I'm not a robot` button.
* `Checkbox captcha results`: Number of responses.
* `Advanced challenge shows`: Number of challenge displays.
* `Advanced challenge results`: Number of responses in the pop-up window.
* `Validate results`: Number of validations, the total number of responses.

You only pay for `Validate results`. To learn more about the pricing rules, see the [documentation](https://cloud.yandex.ru/docs/smartcaptcha/pricing).

You cannot use Monitoring to find out the exact number of requests, but you can use the billing account itemization for this, if you enable product breakdown. The billing account itemization shows all your calls to SmartCaptcha, without splitting across successful and unsuccessful ones.

ou can export detailed billing information to a CSV file by clicking the `Itemization export` button located in the upper-right corner. The exported file will include data on SmartCaptcha requests for each day, accurate to individual requests.