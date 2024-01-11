# Domain validation

When creating a CAPTCHA, a list of domains is specified it will be hosted on. By default, {{ captcha-name }} validates domain names and allows using the CAPTCHA only on websites that are on the list.

You can disable domain validation, but this poses a high security risk: the CAPTCHA can be added to any website and anyone can use your [key](./keys.md). In this case, you should perform domain validation on your own server yourself. Disabling validation may be useful if the list of domains is too long, frequently updated, or unknown.

To disable domain validation when [creating](../operations/create-captcha.md) or editing a CAPTCHA, enable the **{{ ui-key.yacloud.smartcaptcha.label_no-hostname-check }}** option.

If domain validation is off, check the `host` field value in the [service response](./validation.md#service-response) and reject any results you get from unknown sources.

In some cases, the service may return an empty value in the `host` field:

* The [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) is blocked. If so, the service returns `"status": "ok"` even in response to bot queries.
* {{ captcha-name }} could not identify the website name due to an internal failure. In this case, the empty `host` can be treated as a trusted one.
