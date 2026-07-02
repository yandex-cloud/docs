[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Установка приложений из Cloud Marketplace > Установка External Secrets Operator

# Установка External Secrets Operator с поддержкой Yandex Lockbox


[External Secrets Operator](https://yandex.cloud/ru/marketplace/products/yc/external-secrets) — оператор Kubernetes, который интегрирует внешние системы управления секретами, такие как [Yandex Lockbox](../../../lockbox/index.md), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager и другие. Оператор считывает информацию из внешних [API](../../../glossary/rest-api.md) и автоматически вводит значения в Kubernetes Secret.

External Secrets Operator с поддержкой Yandex Lockbox позволяет настроить синхронизацию [секретов Yandex Lockbox](../../../lockbox/concepts/secret.md) с [секретами](../../concepts/encryption.md) [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы External Secrets Operator.
1. Назначьте [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) необходимую [роль](../../../lockbox/security/index.md#service-roles):
   * [Для ранее созданного секрета](../../../lockbox/operations/secret-access.md).
   * [Для всех секретов](../../../iam/operations/sa/assign-role-for-sa.md) [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder) или [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
1. Создайте для сервисного аккаунта [авторизованный ключ](../../../iam/concepts/authorization/key.md) и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --output sa-key.json
   ```

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка External Secrets Operator с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [External Secrets Operator с поддержкой Yandex Lockbox](https://yandex.cloud/ru/marketplace/products/yc/external-secrets) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `external-secrets-operator-space`). Если вы оставите пространство имен по умолчанию, External Secrets Operator может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с приложением External Secrets Operator выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/external-secrets/charts/external-secrets \
     --version 2.5.0 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set-file auth.json=<путь_к_файлу_sa-key.json> \
     external-secrets ./external-secrets/
   ```

   Эта команда создаст новое пространство имен, необходимое для работы External Secrets Operator.

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, External Secrets Operator может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `external-secrets-operator-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Примеры использования {#examples}

* [Синхронизация с секретами Yandex Lockbox](../../tutorials/kubernetes-lockbox-secrets.md).

## Полезные ссылки {#see-also}

* [Описание External Secrets Operator](https://external-secrets.io/v0.8.1/provider/yandex-lockbox/).
* [Документация Yandex Lockbox](../../../lockbox/index.md).