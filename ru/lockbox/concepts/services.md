---
title: "Интеграция {{ lockbox-full-name }} с сервисами {{ yandex-cloud }}"
description: "Из статьи вы узнаете, в каких сервисах {{ yandex-cloud }} можно использовать секреты {{ lockbox-name }}."
---

# Интеграция с сервисами {{ yandex-cloud }}


Вы можете использовать [секреты](./secret.md) {{ lockbox-name }} в следующих сервисах {{ yandex-cloud }}:
* [{{ sf-full-name }}](#functions).
* [{{ connection-manager-full-name }}](#conn-manager).
* [{{ managed-k8s-full-name }}](#managed-kubernetes).
* [{{ serverless-containers-full-name }}](#containers).

## {{ sf-full-name }} {#functions}

Если для работы [функции](../../functions/concepts/function.md) {{ sf-name }} требуются чувствительные данные, такие как пароли доступа к БД, [статические ключи доступа](../../iam/concepts/authorization/access-key.md) или [OAuth-токен](../../iam/concepts/authorization/oauth-token.md), используйте секреты {{ lockbox-name }} для передачи таких данных в функцию. Это позволит предотвратить несанкционированный доступ третьих лиц к чувствительным данным.

Чтобы функция {{ sf-name }} могла получить доступ к данным, хранящимся в секрете {{ lockbox-name }}, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться функция.

## {{ connection-manager-full-name }} {#conn-manager}

[Подключения](../../metadata-hub/concepts/connection-manager.md) {{ connection-manager-name }} и секреты {{ lockbox-name }} c параметрами подключений к базам данных создаются автоматически при создании кластера управляемых баз данных в {{ yandex-cloud }}, если поддержка {{ connection-manager-name }} настроена на уровне облака. 

Секреты, созданные автоматически при создании кластера, нельзя ни редактировать, ни удалять — они изменяются автоматически при редактировании настроек пользователя в кластере управляемой базы данных. Имена таких секретов совпадают с идентификаторами соответствующих подключений.

## {{ managed-k8s-full-name }} {#managed-kubernetes}

По умолчанию {{ k8s }} хранит секреты в открытом виде. Если ваш [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) использует [секреты](../../managed-kubernetes/concepts/encryption.md), настройте синхронизацию секретов кластера с секретами {{ lockbox-name }} с помощью инструмента [External Secrets Operator](https://external-secrets.io/latest/provider/yandex-lockbox/). Это позволит защитить чувствительные данные от несанкционированного доступа третьих лиц.

Для того чтобы инструмент External Secrets Operator мог получить доступ к данным, хранящимся в секрете {{ lockbox-name }}, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), созданному при установке External Secrets Operator.

## {{ serverless-containers-full-name }} {#containers}

Чтобы обезопасить от несанкционированного доступа [API-ключи](../../iam/concepts/authorization/api-key.md), токены, пароли к базам данных и другие чувствительные данные, которые используются [контейнерами](../../serverless-containers/concepts/container.md) {{ serverless-containers-name }}, храните эти чувствительные данные в секретах {{ lockbox-name }}.

Для того чтобы контейнер {{ serverless-containers-name }} мог получить доступ к данным, хранящимся в секрете {{ lockbox-name }}, назначьте [роль](../security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer` на нужный секрет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого будет запускаться контейнер.


#### См. также {#see-also}

* [{#T}](../../functions/operations/function/lockbox-secret-transmit.md).
* [Создание подключения {{ connection-manager-name }}](../../metadata-hub/operations/create-connection.md).
* [Синхронизация с секретами {{ lockbox-name }} в {{ managed-k8s-name }}](../../managed-kubernetes/tutorials/kubernetes-lockbox-secrets.md).
* [{#T}](../../serverless-containers/operations/lockbox-secret-transmit.md).
* [{#T}](../../managed-gitlab/tutorials/gitlab-lockbox-integration.md).