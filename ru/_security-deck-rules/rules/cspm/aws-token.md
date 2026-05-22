### На ВМ отключено получение IAM-токена через сервис метаданных в формате AWS IMDSv1 {#aws-token}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | aws-token ||
|#

#### Описание

В виртуальных машинах Yandex Compute Cloud доступен [сервис метаданных](https://yandex.cloud/ru/docs/compute/concepts/vm-metadata), предоставляющий сведения об их работе в следующих форматах:

- Google Compute Engine (поддерживаются не все поля).
- Amazon EC2 (поддерживаются не все поля).

Формат Amazon EC2 Instance Metadata Service version 1 (`IMDSv1`) имеет ряд недостатков. Наиболее критичный из них — это риск компрометации токена сервисного аккаунта через сервис метаданных с помощью SSRF-атаки. Подробности в [официальном блоге AWS](https://aws.amazon.com/blogs/security/defense-in-depth-open-firewalls-reverse-proxies-ssrf-vulnerabilities-ec2-instance-metadata-service/).

#### Инструкции и решения по выполнению

Чтобы [получить](https://yandex.cloud/ru/docs/compute/operations/vm-metadata/get-vm-metadata#example5) IAM-токен сервисного аккаунта изнутри ВМ, рекомендуется использовать метаданные в формате Google Compute Engine.

Обязательно отключайте возможность получения IAM-токена через сервис метаданных в формате `IMDSv1`.

**Инструкции и решения по выполнению:**

У обнаруженных ВМ в блоке `metadata_options` задайте параметру [aws_v1_http_token](https://yandex.cloud/ru/docs/compute/api-ref/grpc/Instance/update#yandex.cloud.compute.v1.MetadataOptions) значение `DISABLED`:

```bash
yc compute instance update <идентификатор_или_имя_ВМ> \
  --metadata-options aws-v1-http-token=DISABLED