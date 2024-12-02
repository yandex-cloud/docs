* `aws-v1-http-endpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `enabled`.
* `aws-v1-http-token` — обеспечивает доступ к получению через метаданные AWSv1 (IMDSv1) токена [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), подключенного к ВМ. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос на получение токена завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `disabled`.

  {% note info %}

  Формат IMDSv1 имеет ряд недостатков со стороны безопасности, поэтому по умолчанию параметр `aws-v1-http-token` выключен (`disabled`). Наиболее критичный недостаток IMDSv1 — повышенный риск реализации некоторых атак, например [SSRF](https://portswigger.net/web-security/ssrf) (подробнее в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)). Для изменения поведения по умолчанию этого параметра обратитесь в [поддержку]({{ link-console-support }}).

  Наиболее безопасным методом получения токена в {{ yandex-cloud }} является использование формата [Google Compute Engine](../../compute/operations/vm-info/get-info.md#gce-metadata) (он использует дополнительный заголовок для защиты от SSRF).

  {% endnote %}

* `gce-http-endpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `enabled`.
* `gce-http-token` — обеспечивает доступ к получению через метаданные Google Compute Engine токена сервисного аккаунта, подключенного к ВМ. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос на получение токена завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `enabled`.

Получить значения параметров сервиса метаданных вы можете вместе с [информацией о ВМ](../../compute/operations/vm-info/get-info.md#outside-instance) с помощью [CLI](../../cli/cli-ref/compute/cli-ref/instance/get.md) и [API](../../compute/api-ref/Instance/get.md).