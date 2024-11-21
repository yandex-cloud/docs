---
editable: false
sourcePath: en/_api-ref/smartcaptcha/v1/api-ref/Captcha/getSecretKey.md
---

# SmartCaptcha API, REST: Captcha.GetSecretKey {#GetSecretKey}

Returns the secret data of specified Captcha resource.

## HTTP request

```
GET https://smartcaptcha.{{ api-host }}/smartcaptcha/v1/captchas/{captchaId}:getSecretKey
```

## Path parameters

#|
||Field | Description ||
|| captchaId | **string**

Required field. ID of the Captcha resource to return. ||
|#

## Response {#yandex.cloud.smartcaptcha.v1.CaptchaSecretKey}

**HTTP Code: 200 - OK**

```json
{
  "serverKey": "string"
}
```

CaptchaSecretKey object. Contains captcha data that need to keep in secret.

#|
||Field | Description ||
|| serverKey | **string**

Server key of the captcha, see [CAPTCHA keys](/docs/smartcaptcha/concepts/keys). ||
|#