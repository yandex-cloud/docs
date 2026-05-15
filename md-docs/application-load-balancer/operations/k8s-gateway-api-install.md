# Установить Gateway API Application Load Balancer для Managed Service for Kubernetes

# Установка Gateway API

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../tools/gwin/index.md).

{% endnote %}

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) — набор ресурсов [API](../../glossary/rest-api.md), моделирующих сетевое взаимодействие в [кластере Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). Среди них `GatewayClass`, `Gateway`, `HTTPRoute` и другие.

В сервисе Managed Service for Kubernetes Gateway API запускает [Yandex Application Load Balancer](../index.md) и необходимые вспомогательные ресурсы, когда пользователь Kubernetes объявляет ресурс `Gateway` в кластере Managed Service for Kubernetes.

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), необходимый для работы Gateway API.
1. [Назначьте сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor` — для создания необходимых ресурсов.
   * `vpc.publicAdmin` — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
   * `certificate-manager.admin` — для работы с [сертификатами](../../certificate-manager/concepts/index.md#types), зарегистрированными в сервисе [Yandex Certificate Manager](../../certificate-manager/index.md).
   * `compute.viewer` — для использования [узлов](../../managed-kubernetes/concepts/index.md#node-group) кластера Managed Service for Kubernetes в [целевых группах](../concepts/target-group.md) балансировщика.
1. Создайте для сервисного аккаунта [авторизованный ключ](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните ключ в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта_для_Gateway_API> \
     --output sa-key.json
   ```

1. [Убедитесь](../../managed-kubernetes/operations/connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../vpc/operations/security-group-add-rule.md).

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![Marketplace](../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
  1. В разделе **Доступные для установки приложения** выберите [Gateway API](https://yandex.cloud/ru/marketplace/products/yc/gateway-api) и нажмите кнопку **Перейти к установке**.
  1. Задайте настройки приложения:
     * **Пространство имен** — создайте новое [пространство имен](../../managed-kubernetes/concepts/index.md#namespace) (например, `gateway-api-space`). Если вы оставите пространство имен по умолчанию, Gateway API может работать некорректно.
     * **Название приложения** — укажите название приложения.
     * **Идентификатор каталога** — выберите каталог, в котором нужно создавать балансировщики.
     * **Идентификатор сети** — выберите [облачную сеть](../../vpc/concepts/network.md#network), в которой нужно [располагать балансировщики](../concepts/application-load-balancer.md#lb-location).
     * **Идентификатор подсети 1**, **Идентификатор подсети 2**, **Идентификатор подсети 3** — выберите [подсети](../../vpc/concepts/network.md#subnet), в которых нужно [располагать балансировщики](../concepts/application-load-balancer.md#lb-location).
     * **Ключ сервисного аккаунта** — вставьте содержимое файла `sa-key.json` или создайте новый [ключ](../../iam/concepts/authorization/key.md) [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).
  1. Нажмите кнопку **Установить**.
  1. Дождитесь перехода приложения в статус `Deployed`.

{% endlist %}

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Gateway API выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gateway-api/gateway-api-helm/gateway-api \
     --version v0.7.3 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set folderId='<идентификатор_каталога>' \
     --set networkId='<идентификатор_облачной_сети>' \
     --set subnet1Id='<идентификатор_подсети_1>' \
     --set subnet2Id='<идентификатор_подсети_2>' \
     --set subnet3Id='<идентификатор_подсети_3>' \
     --set-file saKeySecretKey='<путь_к_файлу_sa-key.json>' \
     gateway-api ./gateway-api/
   ```

   В команде укажите сеть и ее подсети, в которых нужно [располагать балансировщики](../concepts/application-load-balancer.md#lb-location).

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Gateway API может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gateway-api-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Автоматическое обновление приложения {#auto-update}

Версия приложения Gateway API 0.6.0 содержит обновление версии CRD Gateway API с [0.6.2](https://github.com/kubernetes-sigs/gateway-api/releases/tag/v0.6.2) до [1.2.1](https://github.com/kubernetes-sigs/gateway-api/releases/tag/v1.2.1). Если вы обновляете Gateway API с версии 0.5.0 и ниже до версии 0.6.0, то при установке из Helm-чарта будет выполнено автоматическое обновление CRD Gateway API и всех зависимых ресурсов в кластере Managed Service for Kubernetes. Обновление безопасно, то есть ресурсы Application Load Balancer не будут удалены или пересозданы.

Автоматическое обновление с версии 0.5.0 и ниже происходит следующим образом:

1. Выполняется проверка наличия в кластере пользовательских ресурсов `GRPCRoute` или `ReferenceGrant`. Если они обнаружены, то обновление не выполняется во избежание конфликтов, так как в новой версии CRD этих ресурсов несовместимы с прежней версией. Обновление можно выполнить вручную (см. ниже).
1. Останавливается контроллер Gateway API, количество реплик уменьшается до нуля.
1. Удаляется CRD ресурсов `GRPCRoute` и применяются CRD остальных зависимых ресурсов Gateway API новой версии.
1. Запускается контроллер Gateway API, количество реплик восстанавливается до прежнего.

Чтобы отключить автоматическое обновление CRD, добавьте параметр команды установки Helm-чарта `--set crdsAutoUpgrade=false`. В этом случае ваши ресурсы будут обновлены, но CRD Gateway API нужно будет обновить вручную. Файл CRD можно взять из папки `crds` архива Helm-чарта.

{% cut "Обновление Gateway API вручную" %}

1. Сделайте резервную копию ресурсов Gateway API.
1. Остановите контроллер Gateway API.
1. Удалите все ресурсы `GRPCRoute` в кластере.
1. Примените новые версии CRD-ресурсов Gateway API. Файл CRD можно взять из папки `crds` архива Helm-чарта.
1. Запустите контроллер Gateway API.
1. Измените значение версии `apiVersion` на `gateway.networking.k8s.io/v1` в спецификации ваших ресурсов `GRPCRoute` и примените ее.
1. Установите новую версию Helm-чарта.

{% endcut %}

## Примеры использования {#examples}

* [Настройка Gateway API](../../managed-kubernetes/tutorials/marketplace/gateway-api.md).

## См. также {#see-also}

* [Описание проекта Gateway API](https://gateway-api.sigs.k8s.io/).
* [Описание и конфигурация Gateway API](../tools/k8s-gateway-api/index.md) в документации Application Load Balancer.