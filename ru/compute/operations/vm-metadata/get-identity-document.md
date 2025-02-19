---
title: Как получить идентификационный документ виртуальной машины
description: Следуя данной инструкции, вы сможете получить идентификационный документ виртуальной машины.
---

# Получить идентификационный документ виртуальной машины

При создании виртуальной машины формируется [идентификационный документ](../../concepts/metadata/identity-document.md) (identity document), в котором хранятся сведения об этой ВМ: идентификаторы ВМ, продукта Marketplace, образа диска и т.д.

Чтобы запросить идентификационный документ:

1. Подключитесь к ВМ:

   ```bash
   ssh <IP-адрес_ВМ>
   ```

1. Выполните команду, чтобы получить идентификационный документ в [формате](../../../compute/concepts/vm-metadata.md#metadata-formats) Google Compute Engine:

   ```bash
   curl \
     --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document
   ```

   Пример ответа:

   ```json
   {"instanceId":"fhmm5252k8vl********","productCodes":null,"imageId":"fd8evlqsgg4e********","productIds":["f2e3ia802lab********"],"createdAt":"2023-05-29T09:46:59Z","version":"2023-03-01"}
   ```

{% note info %}

Если ВМ была создана до 09.06.2023 и вы не можете получить идентификационный документ, остановите и снова запустите ВМ.

{% endnote %}

## Проверить подпись идентификационного документа {#check-id-signature}

[Сервис метаданных](../../../compute/concepts/vm-metadata.md) виртуальной машины кроме самого идентификационного документа предоставляет его криптографические подписи.

Вы можете использовать эти подписи для проверки происхождения, подлинности и целостности документа. Для этого:

{% list tabs %}

- RSA

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите RSA-подпись из метаданных ВМ и сохраните ее в файл `rsa2048`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/rsa > rsa2048
     ```

  1. Создайте файл `certificate` и добавьте в него публичный сертификат:

     
     ```text
     -----BEGIN CERTIFICATE-----
     MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
     BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
     SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
     K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
     81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
     F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
     RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
     wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
     MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
     cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
     TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
     co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
     w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
     0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
     r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
     -----END CERTIFICATE-----
     ```




  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl smime -verify -in rsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     Если подпись верна, появится сообщение `Verification successful`.

- DSA

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите dsa2048-подпись из метаданных ВМ и сохраните ее в файл `dsa2048`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/dsa > dsa2048
     ```

  1. Создайте файл `certificate` и сохраните в него публичный сертификат:

     
     ```text
     -----BEGIN CERTIFICATE-----
     MIIERjCCA+ugAwIBAgIULIUmuptqf9Pz7nMGMHeW+BPNneYwCwYJYIZIAWUDBAMC
     MAAwHhcNMjMwNjA3MDY1NjI0WhcNMzMwNjA0MDY1NjI0WjAAMIIDRjCCAjkGByqG
     SM44BAEwggIsAoIBAQDFyteKPnUOauqiHzsLCw2Z//c1IjSqVVPpIbETQ1NUCsUI
     o6+at1VkxJ76K/HqvFlhC87nSGWuQMgflQXcVIEQ8c0wnQGRj4lwkkjm8WClo4xv
     t/FsNyv4uEcPgcz45A2YxE4+5odjicKMCz4pPW+kc9t4BiKw4I9uGySBhA1p21e+
     fmR4AzDSHdHGRlvlYOfYANZlVeWm+qLsb+VfyeETTOD+ooMA9Y4ue3dw2l8Clib8
     WummF2PNRnnOeEFGbwZErtdObla2TjdNzFWc6QWo1EcqqkBXG1TutY/FgNcTj+Ps
     nFoUu4ZIy7o8p8YgzyffSCQbP5ppRGpfh4DuIS+vAiEA8tkwKyKmcCxTWnpRNWlY
     O6kUanHgEQczpLtP3mDvcdUCggEAMhbW4syX5p7X1qs0OnFCLcd4tYA2DnR1dLu3
     ZPusUh6c9+cH3ICEnK22KB1nplMAHDyXjtV2rCvIGlNUcT6OkSulnkvNE185cfM0
     UKofG4t6VJNpa8bngF7Ccyf6QBPcUzigHv+QDQDZuA4k3IcQp0hC9ppOaN6J9rKp
     5cSPyLzJ2vyY6mG650omxgnwG4OGZSRX8c1JN/MvIj79m3LqM7civ8l6ljnC+LNm
     1T7mcgZcf9iYc5+OWICoeDtFUdr+qsNIXonIMku6FpJu0pBgVgE6GI+nD4oaXSQS
     bckxB24DEYvTlVALuXqPS8MZyQZz5ltoI8xnbEOMqtU3IPox1AOCAQUAAoIBADcS
     Pt2SC+cGUCKNhrPquESB2/dZKUDuyEtYIYMidfoyoBGhz2QuqOqf5tEcLY9gCeMP
     NxmaXW1AQtcAX/+tyCZrVxEc31btW3alLmu/NtKxmb6PRshsASI/LIE1wH82TV8C
     4ymFDyKUGCb5AWN+Ziv5AP5/6Q08awQ7YAuz/sw0xOMqDuUfYkLerPEuQg5Sozs0
     DWucS/ex7l+VqNAZUBZykta961bhplIDTRG05YD3Lz0w/WIBMdZzzolA7F3jgFJg
     rCfZwQeDbf1iorfxRS5DqR0Vt7XE6/yqRUzDjOMctKY68jLZGFfOfTQ9iX2R9K/f
     7kJPxaHnA+WWo13ExwGjUzBRMB0GA1UdDgQWBBTj+x+t2VJhAWI57o9xRwMOeTFj
     mzAfBgNVHSMEGDAWgBTj+x+t2VJhAWI57o9xRwMOeTFjmzAPBgNVHRMBAf8EBTAD
     AQH/MAsGCWCGSAFlAwQDAgNIADBFAiAX2ABj/9ea1Q4ssAgIGkA4vJywoUoT4Sbg
     LFFIJGlNWgIhAO0b749SY5+6UMEOLsxgvNzKKcv58BKADfBdJAXE6fRk
     -----END CERTIFICATE-----
     ```



  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl smime -verify -in dsa2048 -inform PEM -certfile certificate -noverify | tee document
     ```

     Если подпись верна, появится сообщение `Verification successful`.

- Base64

  1. Подключитесь к ВМ:

     ```bash
     ssh <IP-адрес_ВМ>
     ```

  1. Получите base64-подпись из метаданных ВМ и сохраните ее в файл `signature`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/base64 | \
         base64 -d >> signature
     ```

  1. Получите идентификационный документ и сохраните его в файл `document`:

     ```bash
     curl \
       --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/vendor/identity/document > document
     ```

  1. Создайте файл `certificate` и сохраните в него публичный сертификат:

     ```text
     -----BEGIN CERTIFICATE-----
     MIIC4TCCAcmgAwIBAgIUP0zcGO1MeRwze8VdSMEt/OdBXoIwDQYJKoZIhvcNAQEL
     BQAwADAeFw0yMzA2MDcwNjU4MTBaFw0zMzA2MDQwNjU4MTBaMAAwggEiMA0GCSqG
     SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDw6TvAvrbJvY4tzIIuDnLEVfRUW4BZJD3y
     K8fyyxXrYDvC69RKCKk9+TQhnUOLhZNlDST4HFfSPlakOjXUduyJE5M1EmoLAstN
     81aP3TejseDavxmaNijXRsa9E731T5H+zo44PgAHfQJmiD7rtcr+QOIosKUB2dwp
     F2acp9hLKd389BfNctziG0Oxq7hlISTDBnhzBg7eKuqWtShjVW5RqQvp3bARfUPa
     RWdYjmZvR+AnmozV1SGnpAnatzhnF6tNAb5XSEw49tumsX1D4A11J6mtrafO6bsP
     wdIPwy9W15iCszUNlFcdBaZhESc34VbyCyLMvA5T0Uj1FJHz1RFlAgMBAAGjUzBR
     MB0GA1UdDgQWBBQq0z6Vcmjcn8wnRTwKGSm5YGas9TAfBgNVHSMEGDAWgBQq0z6V
     cmjcn8wnRTwKGSm5YGas9TAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUA
     A4IBAQBplippQ/Pxn7AkuwOTSwSTeJ7S+rMSb6iSL9chNHetanft0Ikr5BDsSrd6
     TeHV0sEMilDIjX0EjSNHwYtYrDPk6cGjkzDTYb6/U10c5Xhwi0g7/lMH/RPihPz5
     co80VEqXWlgfgHuE7/cAiTJ61PiFD9oI494bQcIISQNDfbUUiYfn32+8nK20rn8C
     w7PbGoIv6zz6A0c6DJT7yXJF5sAHgX4M03Oi9edzQ077ZOboXSuUKe4VfHIpjTjZ
     0sM/NbG5BFstyetVc3FZOGWGukTRb0C0GSASOm6hCyh5ctmpwlS4menc/OAx9BYO
     r9ZBjEa0oLFVV0pP5Tj4Gf1DDpuJ
     -----END CERTIFICATE-----
     ```

  1. Извлеките из сертификата публичный ключ и сохраните его в файл `key`:

     ```bash
     openssl x509 -pubkey -noout -in certificate >> key
     ```

  1. Проверьте подпись и сохраните содержимое документа в файл `document`:

     ```bash
     openssl dgst -sha256 -verify key -signature signature document
     ```

     Если подпись верна, появится сообщение `Verified OK`.

{% endlist %}

Сопоставьте идентификационный документ из метаданных ВМ с документом, сохраненным в файле:

```bash
curl http://169.254.169.254/latest/vendor/instance-identity/document | \
openssl dgst -sha256
```

```bash
openssl dgst -sha256 < document
```

Если хеш совпадает, идентификационный документ, сохраненный в файле, соответствует документу в метаданных ВМ.