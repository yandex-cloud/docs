# Интеграция с сервисами Yandex Cloud


Вы можете использовать [секреты](secret.md) Yandex Lockbox в следующих сервисах Yandex Cloud:
* [Yandex Cloud Functions](#functions).
* [Yandex Connection Manager](#conn-manager).
* [Yandex Managed Service for Kubernetes](#managed-kubernetes).
* [Yandex Serverless Containers](#containers).

## Yandex Cloud Functions {#functions}

Если для работы [функции](../../functions/concepts/function.md) Cloud Functions требуются чувствительные данные, такие как пароли доступа к БД или [статические ключи доступа](../../iam/concepts/authorization/access-key.md), используйте секреты Yandex Lockbox для передачи таких данных в функцию. Это позволит предотвратить несанкционированный доступ третьих лиц к чувствительным данным.

Чтобы функция Cloud Functions могла получить доступ к данным, хранящимся в секрете Yandex Lockbox, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться функция.

## Yandex Connection Manager {#conn-manager}

[Подключения](../../metadata-hub/concepts/connection-manager.md) Connection Manager и секреты Yandex Lockbox c параметрами подключений к базам данных создаются автоматически при создании кластера управляемых баз данных в Yandex Cloud, если поддержка Connection Manager настроена на уровне облака. 

Секреты, созданные автоматически при создании кластера, нельзя ни редактировать, ни удалять — они изменяются автоматически при редактировании настроек пользователя в кластере управляемой базы данных. Имена таких секретов совпадают с идентификаторами соответствующих подключений.

## Yandex Managed Service for Kubernetes {#managed-kubernetes}

По умолчанию Kubernetes хранит секреты в открытом виде. Если ваш [кластер Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) использует [секреты](../../managed-kubernetes/concepts/encryption.md), настройте синхронизацию секретов кластера с секретами Yandex Lockbox с помощью инструмента [External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/). Это позволит защитить чувствительные данные от несанкционированного доступа третьих лиц.

Для того чтобы инструмент External Secrets Operator мог получить доступ к данным, хранящимся в секрете Yandex Lockbox, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), созданному при установке External Secrets Operator.

## Yandex Serverless Containers {#containers}

Чтобы обезопасить от несанкционированного доступа [API-ключи](../../iam/concepts/authorization/api-key.md), токены, пароли к базам данных и другие чувствительные данные, которые используются [контейнерами](../../serverless-containers/concepts/container.md) Serverless Containers, храните эти чувствительные данные в секретах Yandex Lockbox.

Для того чтобы контейнер Serverless Containers мог получить доступ к данным, хранящимся в секрете Yandex Lockbox, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет запускаться контейнер.


#### Полезные ссылки {#see-also}

* [Передать секреты Yandex Lockbox в функцию](../../functions/operations/function/lockbox-secret-transmit.md).
* [Создание подключения Connection Manager](../../metadata-hub/operations/create-connection.md).
* [Синхронизация с секретами Yandex Lockbox в Managed Service for Kubernetes](../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md).
* [Передать секреты Yandex Lockbox в контейнер](../../serverless-containers/operations/lockbox-secret-transmit.md).
* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](../../managed-gitlab/tutorials/gitlab-lockbox-integration.md).

## Примеры использования {#examples}

* [Синхронизация с секретами Yandex Managed Service for Kubernetes](../tutorials/kubernetes-lockbox-secrets.md)  
* [Построение пайплайна CI/CD с использованием serverless-продуктов](../tutorials/ci-cd-serverless.md)
* [Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью CLI](../tutorials/static-key-in-lockbox/console.md)
* [Создание интерактивного serverless-приложения с использованием WebSocket](../tutorials/websocket-app.md)
* [Автоматическое копирование объектов из одного бакета Yandex Object Storage в другой](../tutorials/bucket-to-bucket-copying.md)
* [Развертывание отказоустойчивой архитектуры с прерываемыми виртуальными машинами](../tutorials/nodejs-cron-restart-vm.md)
* [Безопасная передача пароля в скрипт инициализации](../tutorials/secure-password-script/index.md)
* [Загрузка данных из Яндекс Директ в витрину Yandex Managed Service for ClickHouse® с использованием Yandex Cloud Functions, Yandex Object Storage и Yandex Data Transfer](../tutorials/data-transfer-direct-to-mch.md)