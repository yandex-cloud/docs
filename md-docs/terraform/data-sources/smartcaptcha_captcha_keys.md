[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Smart Captcha > Data Sources > smartcaptcha_captcha_keys

# yandex_smartcaptcha_captcha_keys (DataSource)

CaptchaKeys object. Contains captcha keys.


## Arguments & Attributes Reference

- `captcha_id` (String). ID of the Captcha resource to return.
- `client_key` (*Read-Only*) (String). Client key of the captcha, see [CAPTCHA keys](../../smartcaptcha/concepts/keys.md).
- `id` (String). ID of the Captcha resource to return.
- `server_key` (*Read-Only*) (String). Server key of the captcha, see [CAPTCHA keys](../../smartcaptcha/concepts/keys.md).
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).