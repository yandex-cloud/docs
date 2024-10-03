---
title: Что такое TLS? Обзор Transport Layer Security
description: TLS (Transport Layer Security) – это протокол, который поддерживает защищенную передачу данных между клиентом и сервисом. Чтобы надежно защитить взаимодействие с сервисом, используйте протокол TLS версии 1.2 и выше.
keywords:
  - протокол tls
  - tls
  - transport layer security
---

# Протокол TLS

{{ objstorage-name }} поддерживает защищенную передачу данных между клиентом и сервисом по протоколу Transport Layer Security (TLS). Чтобы надежно защитить взаимодействие с сервисом, используйте протокол TLS версии 1.2 и выше.

Сейчас {{ objstorage-name }} продолжает поддерживать протокол TLS версий 1.0 и 1.1, но в будущем откажется от них, несмотря на [отсутствие известных проблем и уязвимостей](https://datatracker.ietf.org/doc/draft-ietf-tls-oldversions-deprecate/).

Большинство Amazon S3-совместимых клиентов к {{ objstorage-name }} не позволяют явно прописать версию TLS, а используют указанную в системе.

О настройке клиентов для работы с протоколом TLS версии 1.2 читайте в документации:
* [AWS SDK для Java](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/security-java-tls.html).
* [AWS SDK для .NET](https://docs.aws.amazon.com/sdk-for-net/v3/developer-guide/enforcing-tls.html).
* [AWS SDK для JavaScript](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/enforcing-tls.html).