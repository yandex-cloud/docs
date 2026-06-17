# Шифрование в Managed Service for Kubernetes

В Yandex Cloud действует множество [мер обеспечения информационной безопасности](../../security/standarts.md). В том числе реализовано многоуровневое шифрование данных сервиса Managed Service for Kubernetes:

* Данные шифруются при размещении в хранилище Yandex Cloud с помощью системных ключей. Это позволяет защитить данные от компрометации в случае физической кражи дисков из дата-центров Yandex Cloud.
* Данные шифруются при передаче по сети с помощью протокола TLS. Ключи для работы протокола TLS хранятся на хостах, на которых он используется. Это позволяет защитить данные от перехвата.

Используются следующие криптографические алгоритмы:
* симметричные: AES, ChaCha;
* асимметричные: RSA, Ed25519.

Минимальная длина ключа, используемая в симметричных алгоритмах, — 128 бит, в асимметричных — 2048 бит.

Управление этими ключами обеспечивает Yandex Cloud.

## Шифрование с помощью пользовательских симметричных ключей {#kms-keys-encryption}

В Managed Service for Kubernetes поддерживается шифрование с помощью [пользовательских симметричных ключей](../../kms/concepts/key.md) Yandex Key Management Service для следующих ресурсов:
* [Секреты Kubernetes](#k8s-secrets-encryption)
* [Диски для постоянных томов](volume.md#encrypted-disks)

Управление такими ключами происходит на стороне пользователя, что дает дополнительные возможности:

* Аудит [событий](../../kms/at-ref.md), связанных с использованием ключа, с помощью сервиса [Yandex Audit Trails](../../audit-trails/index.md).
* Отслеживание работы с ключами с помощью сервиса [Yandex Monitoring](../../monitoring/index.md).
* [Операции с ключами](../../kms/operations/index.md#symmetric-encryption) — ротация, изменение, деактивация, удаление.
* Гранулярный контроль [прав доступа к ключу](../../kms/security/index.md) на уровне отдельных [аккаунтов Yandex Cloud](../../iam/concepts/users/accounts.md).
* Применение [аппаратного модуля безопасности (HSM)](../../kms/concepts/hsm.md) при необходимости.

    {% note info %}

    В сервисе Managed Service for Kubernetes сервисный аккаунт Yandex Cloud [называется](index.md#service-accounts) облачным сервисным аккаунтом, чтобы избежать путаницы с сервисным аккаунтом Kubernetes.

    {% endnote %}

### Шифрование секретов Kubernetes {#k8s-secrets-encryption}

[_Секрет Kubernetes_](https://kubernetes.io/docs/concepts/configuration/secret/) — конфиденциальная информация, используемая кластером Kubernetes при управлении подами, например, OAuth-ключи, пароли, [SSH-ключи](../../glossary/ssh-keygen.md) и т. д.

По умолчанию секреты кластера хранятся в открытом виде. Если при [создании кластера Managed Service for Kubernetes](../operations/kubernetes-cluster/kubernetes-cluster-create.md) был указан ключ шифрования, то секреты кластера шифруются.

{% note warning %}

Ключ шифрования можно указать только при создании кластера.

Если нужно использовать другой ключ, создайте новый кластер с этим ключом.

{% endnote %}

Процесс шифрования отдельного секрета происходит следующим образом:

1. Kubernetes шифрует секрет с помощью [KMS-провайдера](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/).

1. В процессе шифрования KMS-провайдер обращается к KMS-плагину, который позволяет использовать ключ шифрования, указанный при создании кластера.

    Этот ключ шифрования не используется для непосредственного шифрования секретов. Вместо этого применяется шифрование по схеме [envelope encryption](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/#kms-encryption-and-per-object-encryption-keys), в которой участвует ключ.

    Общее описание схемы приведено в разделе [Шифрование по схеме envelope encryption](../../kms/concepts/envelope.md).

1. В процессе шифрования KMS-плагин обеспечивает взаимодействие с сервисом [Yandex Key Management Service](../../kms/concepts/index.md), в котором хранится ключ шифрования.

    Этот плагин, как и использующий его провайдер, уже установлен в кластер Managed Service for Kubernetes и настроен необходимым образом.

Расшифровка секрета происходит аналогичным образом.

## Примеры использования {#examples}

* [Шифрование секретов в Managed Service for Kubernetes](../tutorials/kms-k8s.md)
* [Установка Ingress-контроллера NGINX с сертификатом из Yandex Certificate Manager](../tutorials/nginx-ingress-certificate-manager.md)
* [Использование зашифрованных дисков для постоянных томов](../operations/volumes/encrypted-disks.md)


* [Синхронизация с секретами Yandex Lockbox](../tutorials/kubernetes-lockbox-secrets.md)

## Полезные ссылки {#see-also}

* [Установка HashiCorp Vault с поддержкой Key Management Service](../operations/applications/hashicorp-vault.md)
* [Использование HashiCorp Vault для хранения секретов](../tutorials/marketplace/hashicorp-vault.md)
* [Шифрование секретов в Managed Service for Kubernetes](../tutorials/kms-k8s.md)
* [Установка External Secrets Operator с поддержкой Yandex Lockbox](../operations/applications/external-secrets-operator.md)
* [Синхронизация с секретами Yandex Lockbox](../tutorials/kubernetes-lockbox-secrets.md)