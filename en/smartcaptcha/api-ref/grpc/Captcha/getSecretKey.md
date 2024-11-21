---
editable: false
sourcePath: en/_api-ref-grpc/smartcaptcha/v1/api-ref/grpc/Captcha/getSecretKey.md
---

# SmartCaptcha API, gRPC: CaptchaService.GetSecretKey {#GetSecretKey}

Returns the secret data of specified Captcha resource.

## gRPC request

**rpc GetSecretKey ([GetCaptchaRequest](#yandex.cloud.smartcaptcha.v1.GetCaptchaRequest)) returns ([CaptchaSecretKey](#yandex.cloud.smartcaptcha.v1.CaptchaSecretKey))**

## GetCaptchaRequest {#yandex.cloud.smartcaptcha.v1.GetCaptchaRequest}

```json
{
  "captchaId": "string"
}
```

#|
||Field | Description ||
|| captchaId | **string**

Required field. ID of the Captcha resource to return. ||
|#

## CaptchaSecretKey {#yandex.cloud.smartcaptcha.v1.CaptchaSecretKey}

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