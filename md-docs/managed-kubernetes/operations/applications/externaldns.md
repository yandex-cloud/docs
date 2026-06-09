# Установка ExternalDNS c Webhook Yandex Cloud DNS


{% note info %}

[ExternalDNS с Webhook Yandex Cloud DNS](https://yandex.cloud/ru/marketplace/products/yc/external-dns-yc-webhook) — замена для продукта ExternalDNS c плагином для Yandex Cloud DNS, который больше не поддерживается издателем и не получает обновления.

{% endnote %}

[ExternalDNS](https://github.com/kubernetes-sigs/external-dns) позволяет автоматически создавать [DNS-записи](../../../dns/concepts/resource-record.md) в [Yandex Cloud DNS](../../../dns/index.md). ExternalDNS делает ресурсы Kubernetes доступными для обнаружения через общедоступные DNS-серверы.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы c Cloud DNS.
1. [Назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `dns.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output key.json
   ```

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [ExternalDNS с Webhook Yandex Cloud DNS](https://yandex.cloud/ru/marketplace/products/yc/external-dns-yc-webhook) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `externaldns-space`). Если вы оставите пространство имен по умолчанию, ExternalDNS может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `key.json` или создайте новый авторизованный ключ для сервисного аккаунта. Сервисный аккаунт должен иметь [роль](../../../iam/concepts/access-control/roles.md) `dns.editor`.
   * **ID каталога** — укажите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [зона Cloud DNS](../../../dns/concepts/dns-zone.md).
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с ExternalDNS выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/externaldns/chart/externaldns \
     --version 0.5.1-b \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set config.folder_id=<идентификатор_каталога_с_DNS-зоной> \
     --set-file config.auth.json=<путь_к_файлу_с_авторизованным_ключом_сервисного_аккаунта> \
     externaldns ./externaldns/
    ```

    Если вы укажете в параметре `namespace` пространство имен по умолчанию, ExternalDNS может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `externaldns-space`).

    {% note info %}
    
    Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
    
    {% endnote %}

## Особенности работы {#features}

Чтобы автоматически создавать DNS-записи с помощью приложения [ExternalDNS с Webhook Yandex Cloud DNS](https://yandex.cloud/ru/marketplace/products/yc/external-dns-yc-webhook):
* С [Ingress-контроллерами](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) не нужны дополнительные настройки.
* Для сервисов типа [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer) необходимо использовать аннотацию `"external-dns.alpha.kubernetes.io/hostname=<ваш_домен>"`.

  Чтобы установить значение TTL для DNS-записи, используйте аннотацию `"external-dns.alpha.kubernetes.io/ttl=<значение_TTL_в_секундах>"`.

## Примеры использования {#examples}

* [Настройка логирования для L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера](../../tutorials/alb-ingress-controller-log-options.md).
* [Развертывание и нагрузочное тестирование gRPC-сервиса с масштабированием](../../tutorials/load-testing-grpc-autoscaling.md).

## См. также {#see-also}

* [Документация ExternalDNS](https://github.com/kubernetes-sigs/external-dns/).