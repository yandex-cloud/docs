# SmartCaptcha API, REST: Captcha.GetSecretKey

Returns the secret data of specified Captcha resource.

## HTTP request

```
GET https://smartcaptcha.api.cloud.yandex.net/smartcaptcha/v1/captchas/{captchaId}:getSecretKey
```

## Path parameters

#|
||Field | Description ||
|| captchaId | **string**

Required field. ID of the Captcha resource to return.

The maximum string length in characters is 50. ||
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

Server key of the captcha, see [CAPTCHA keys](../../concepts/keys.md). ||
|#