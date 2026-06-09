# Установка External Secrets Operator с поддержкой {{ lockbox-name }}


[External Secrets Operator](https://yandex.cloud/ru/marketplace/products/yc/external-secrets) — оператор {{ k8s }}, который интегрирует внешние системы управления секретами, такие как [{{ lockbox-name }}](../../../lockbox/index.md), AWS Secrets Manager, Azure Key Vault, HashiCorp Vault, Google Secrets Manager и другие. Оператор считывает информацию из внешних [API](../../../glossary/rest-api.md) и автоматически вводит значения в {{ k8s }} Secret.

External Secrets Operator с поддержкой {{ lockbox-name }} позволяет настроить синхронизацию [секретов {{ lockbox-name }}](../../../lockbox/concepts/secret.md) с [секретами](../../concepts/encryption.md) [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

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

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка External Secrets Operator с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [External Secrets Operator с поддержкой {{ lockbox-name }}](https://yandex.cloud/ru/marketplace/products/yc/external-secrets) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `external-secrets-operator-space`). Если вы оставите пространство имен по умолчанию, External Secrets Operator может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `sa-key.json`.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с приложением External Secrets Operator выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_external-secrets.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_external-secrets.helmChart.tag }} \
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

* [{#T}](../../tutorials/kubernetes-lockbox-secrets.md).

## См. также {#see-also}

* [Описание External Secrets Operator](https://external-secrets.io/v0.8.1/provider/yandex-lockbox/).
* [Документация {{ lockbox-name }}](../../../lockbox/index.md).