Доступны следующие опции:

* `awsV1HttpEndpoint` — обеспечивает доступ к метаданным с использованием формата AWS (IMDSv1). Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `enabled`.

    {% note info %}

    По умолчанию параметр `awsV1HttpEndpoint` включен (`enabled`), но мы советуем выключить его. Формат IMDSv1 имеет ряд недостатков со стороны безопасности. Наиболее критичный — повышенный риск реализации некоторых атак, например [SSRF](https://portswigger.net/web-security/ssrf) (подробнее в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/)).

    {% endnote %}

* `gceHttpEndpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `404 Not Found`. Значение по умолчанию: `enabled`.
