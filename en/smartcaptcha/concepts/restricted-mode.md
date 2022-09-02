# {{ captcha-name }} restricted mode

{{ captcha-name }} will run in restricted mode unless your billing account's [status](../../billing/concepts/billing-account-statuses) is `ACTIVE` or `TRIAL_ACTIVE`.

In restricted mode, the response to all [validation requests](../quickstart.md#check-answer) will be `ok` whereas the {{ captcha-name }} widget may display a message saying **{{ captcha-full-name }} is restricted on the page**.

{{ captcha-name }} will automatically restore full functionality when your account's status changes to `ACTIVE` or `TRIAL_ACTIVE`.