[Документация Yandex Cloud](../../../index.md) > [On-premises Yandex Object Storage](../../index.md) > Версия 26.3 > [Установка и настройка](index.md) > После установки

# После установки

Перед началом работы убедитесь, что выполнены все предыдущие инструкции:

1. [Подготовлено окружение](environment-preparation.md).
1. [Настроены параметры инсталляции](setup-install-params.md).
1. [Выполнены шаги установки](installation-steps.md).

## Проверьте результат установки {#check-installation}

После завершения плейбука Ansible оператор продолжает установку компонентов внутри кластера. Подключитесь к первому мастер-хосту из `inventory.ini` и проверьте состояние:

```bash
kubectl get nodes
kubectl get pods -n argocd
kubectl get pods -n yc-storage-operator
kubectl get instances.storage.yandex.cloud
kubectl get updaterequests.storage.yandex.cloud
```

Дождитесь следующих результатов:

* Все узлы кластера Kubernetes перешли в статус `Ready`.
* Поды ArgoCD и `yc-storage-operator` перешли в статус `Running`.
* Ресурс `Instance` перешел в статус `ready`.
* Все ресурсы `UpdateRequest` перешли в статус `Done`.

Если возникли проблемы, обратитесь к статье [Устранение неисправностей при установке](../troubleshooting/installation-errors.md).

## Начните работу {#start-using}

После проверки On-premises Yandex Object Storage готов к использованию. [Создайте тенант](../quickstart.md#create-tenant) и [ключи доступа](../quickstart.md#create-access-key), настройте AWS CLI и выполните запрос к S3 API:

```bash
aws --endpoint-url https://s3.onprem.local s3 ls
```

#### Что дальше? {#whats-next}

* [Создание тенанта](../quickstart.md#create-tenant)
    * [CLI](../../cli-ref/cli_tenants_create.md)

* [Создание учетных данных S3](../quickstart.md#create-access-key)
    * [CLI](../../cli-ref/cli_access-keys_create.md)

* [Сценарии обслуживания](../operations/index.md)
* [Использование gRPC API](../api-ref/index.md)
* [Алгоритмы решения проблем](../troubleshooting/problem-solving-algorithms.md)