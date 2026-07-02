[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for Kubernetes](../../index.md) > [Пошаговые инструкции](../index.md) > Установка приложений из Cloud Marketplace > Установка Velero

# Установка Velero


[Velero](https://velero.io/) — это инструмент для резервного копирования, восстановления и миграции объектов [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster), в том числе [постоянных томов](../../concepts/volume.md#persistent-volume). Velero позволяет:
* Защитить данные от потери с помощью гибкой системы резервного копирования.
* Сократить время на восстановление кластера Managed Service for Kubernetes в случае его недоступности.
* Перенести данные с одного кластера Managed Service for Kubernetes на другой.

С помощью драйвера Container Storage Interface инструмент Velero [создает резервные копии](../../tutorials/kubernetes-backup.md) и восстанавливает постоянные тома из моментальных [снимков дисков](../../../compute/concepts/snapshot.md) Yandex Cloud.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для доступа к [Yandex Object Storage](../../../storage/index.md):

   ```bash
   yc iam service-account create --name <имя_сервисного_аккаунта>
   ```

1. [Назначьте сервисному аккаунту роль](../../../iam/operations/sa/assign-role-for-sa.md) `storage.editor`:

   ```bash
   yc resource-manager folder add-access-binding <идентификатор_каталога> \
     --role storage.editor \
     --subject serviceAccount:<идентификатор_сервисного_аккаунта>
   ```

1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

   * Если установка Velero будет выполняться в [консоли управления с помощью Yandex Cloud Marketplace](#marketplace-install), создайте статический ключ в формате JSON и сохраните его в файл `sa-key.json`:

     ```bash
     yc iam access-key create \
       --service-account-name=<имя_сервисного_аккаунта> \
       --format=json > sa-key.json
     ```

   * Если установка Velero будет выполняться с помощью [Helm-чарта](#helm-install), выполните команду и сохраните полученные идентификатор ключа (`key_id`) и секретный ключ (`secret`):

     ```bash
     yc iam access-key create \
       --service-account-name=<имя_сервисного_аккаунта>
     ```

1. [Создайте бакет Object Storage](../../../storage/operations/buckets/create.md).

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. Убедитесь, что квот на количество снимков дисков и их объем достаточно для создания резервной копии данных. Для этого можно использовать [сервис проверки квот](../../../quota-manager/operations/read-quotas.md).

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Velero](https://yandex.cloud/ru/marketplace/products/yc/velero-yc-csi) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) `velero`. Приложение использует его по умолчанию. Если вы оставите пространство имен по умолчанию, Velero может работать некорректно.

     {% note info %}

     Если создать пространство с другим именем, при работе придется задавать его в каждой команде в параметре `--namespace <пространство_имен_приложения_Velero>`.

     {% endnote %}

   * **Название приложения** — укажите название приложения.
   * **Статический ключ для доступа к Object Storage** — скопируйте содержимое файла `sa-key.json` или создайте новый [ключ доступа](../../../iam/concepts/authorization/access-key.md) для сервисного аккаунта. Сервисный аккаунт должен иметь роль `storage.editor`.
   * **Имя бакета Object Storage** — укажите имя бакета Object Storage.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Velero выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/velero/chart/velero \
        --version 8.5.0-5 \
        --untar && \
   helm install \
        --namespace velero \
        --create-namespace \
        --set backupStorageLocationCustom.bucket=<имя_бакета> \
        --set serviceaccountawskeyvalue_generated.accessKeyID=<идентификатор_ключа> \
        --set serviceaccountawskeyvalue_generated.secretAccessKey=<секретный_ключ> \
        velero ./velero/
   ```

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Полезные ссылки {#see-also}

* [Документация Velero](https://velero.io/docs/v1.11/examples/)
* [Резервное копирование кластера Managed Service for Kubernetes в Object Storage](../../tutorials/kubernetes-backup.md)