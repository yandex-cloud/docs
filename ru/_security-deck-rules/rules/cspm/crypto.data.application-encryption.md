### Используется шифрование данных на уровне приложения {#application-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | crypto.data.application-encryption ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Если шифрование на уровне приложения внедрено, отметьте проверку как выполненная.

{% endnote %}

Для шифрования данных на уровне приложения (client-side encryption) перед их отправкой в бакет Yandex Object Storage вы можете использовать следующие подходы:

* Интеграция Object Storage с сервисом Key Management Service для шифрования данных на уровне приложения (client-side encryption). Подробнее смотрите в разделе «Рекомендуемые криптографические библиотеки».

* Шифрование данных на уровне приложения перед отправкой их в Object Storage с помощью сторонних библиотек. При использовании сторонних библиотек и собственных способов управления ключами следует убедиться, что схема работы, используемые алгоритмы и длины ключей соответствуют требованиям регуляторов.

#### Инструкции и решения по выполнению

Для шифрования данных на уровне приложения (client-side encryption) рекомендуется использовать следующие библиотеки:

* AWS Encryption SDK и его интеграцию с KMS: https://yandex.cloud/ru/docs/kms/tutorials/encrypt/aws-encryption-sdk
* Google Tink и ее интеграцию с KMS: https://yandex.cloud/ru/docs/kms/tutorials/encrypt/google-tink
* SDK Yandex Cloud вместе с любой другой криптографической библиотекой, совместимой с PCI DSS или другими стандартами, применяемыми в вашей компании: https://yandex.cloud/ru/docs/kms/tutorials/encrypt/sdk

Сравнение библиотек представлено в разделе Какой способ шифрования выбрать документации KMS: https://yandex.cloud/ru/docs/kms/tutorials/encrypt