# После установки

Перед началом работы убедитесь, что выполнены все предыдущие инструкции:

1. [Подготовлено окружение](environment-preparation.md).
1. [Настроены параметры инсталляции](setup-install-params.md).
1. [Выполнены шаги установки](installation-steps.md).

После завершения указанных инструкций On-premises Yandex Object Storage установлен и готов к использованию. Вы можете создать первые тенанты и ключи доступа согласно инструкции по управлению продуктом и использовать S3 API:

```bash
aws --endpoint-url https://s3.onprem.local s3 ls
```

#### Что дальше? {#whats-next}

* [Создание тенанта](../quickstart.md#create-tenant)
    * [CLI](../../cli-ref/cli_tenants_create.md)

* [Создание учетных данных S3](../quickstart.md#create-access-key)
    * [CLI](../../cli-ref/cli_service-accounts_create.md)

* [Сценарии обслуживания](../operations/index.md)
* [Использование gRPC API](../api-ref/index.md)
* [Алгоритмы решения проблем](../troubleshooting/problem-solving-algorithms.md)