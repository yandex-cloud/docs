# Установка Chaos Mesh


[Chaos Mesh](https://chaos-mesh.org/) — это платформа с открытым исходным кодом, которая позволяет симулировать отказы и нарушения в работе кластера Kubernetes. Симуляцию можно проводить на разных стадиях разработки и тестирования, а также после релиза. Вы можете использовать Chaos Mesh, чтобы найти потенциальные угрозы, устранить их и настроить политики безопасности (например, с помощью приложения [Kyverno](kyverno.md)).

{% note warning %}

Проверяйте сценарии отказов сначала на тестовом кластере, чтобы не нарушить работоспособность основного кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Создайте](../kubernetes-cluster/kubernetes-cluster-create.md) кластер Managed Service for Kubernetes.
1. [Создайте](../node-group/node-group-create.md) группу узлов с оперативной памятью не менее 14 ГБ.
1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Chaos Mesh с поддержкой Yandex Cloud](https://yandex.cloud/ru/marketplace/products/yc/chaos-mesh) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:

   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `chaos-mech-space`). Если вы оставите пространство имен по умолчанию, Chaos Mesh может работать некорректно.
   * **Название приложения** — укажите название приложения.

1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Chaos Mesh выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/chaos-mesh/chart/chaos-mesh \
     --version 2.8.0 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     chaos-mesh ./chaos-mesh/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Chaos Mesh может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `chaos-mesh-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

Актуальную версию Helm-чарта можно посмотреть на [странице приложения](https://yandex.cloud/ru/marketplace/products/yc/chaos-mesh#docker-images).

## Веб-интерфейс и авторизация в Chaos Mesh {#interface-and-authorization}

После установки вы можете начать работу с Chaos Mesh в его веб-интерфейсе и пройти авторизацию. Для этого:

1. [Подключитесь к вашему кластеру](../connect/index.md#kubectl-connect).
1. Перенаправьте адрес `http://localhost:8080` на интерфейс Chaos Mesh:

   ```bash
   kubectl port-forward service/chaos-dashboard 8080:2333 \
      --namespace <пространство_имен>
   ```

   В команде укажите пространство имен, выбранное при установке приложения.

   Результат:

   ```text
   Forwarding from 127.0.0.1:8080 -> 2333
   Forwarding from [::1]:8080 -> 2333
   ```

1. Перейдите в браузере по адресу [http://localhost:8080](http://localhost:8080). Откроется веб-интерфейс Chaos Mesh с окном авторизации.
1. Для авторизации нужны учетная запись и токен Kubernetes. Получите их одним из двух способов:

   * [Создайте учетную запись и токен](https://chaos-mesh.org/docs/manage-user-permissions/) для Chaos Mesh. Для учетной записи можно настроить права доступа в конкретном пространстве имен.
   * Для кластеров версии Kubernetes 1.24 или выше используйте сервисный аккаунт Kubernetes и создайте токен для этого сервисного аккаунта:

      1. Посмотрите список доступных сервисных аккаунтов Kubernetes:

         ```bash
         kubectl get serviceAccounts
         ```

         У каждого аккаунта свой набор прав доступа.

      1. Выберите нужный аккаунт и создайте токен:

         ```bash
         kubectl create token <название_аккаунта>
         ```

## Работа с ресурсами Yandex Cloud {#yandex-cloud-resources}

В приложении доступен сценарий `YCChaos`, который позволяет моделировать отказы ВМ узлов (например, перезапуск или остановку). С его помощью можно проверять отказоустойчивость систем, зависящих от облачной инфраструктуры.

Например, чтобы смоделировать перезапуск ВМ узлов с помощью `YCChaos`:

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `compute.operator`.
1. [Выпустите авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните его в файл `sa-key.json`
1. Создайте пространство имен `chaos-testing`.
1. Создайте секрет Kubernetes на основе созданного ранее авторизованного ключа:

   ```shell
   kubectl create secret generic yc-sa-secret \
       --from-file=sa-key.json=./sa-key.json \
       -n chaos-testing
   ```

1. Сохраните в файле `chaos.yaml` пример workflow со сценарием `YCChaos`:

   ```yaml
   apiVersion: chaos-mesh.org/v1alpha1
   kind: Workflow
   metadata:
     name: yc-random-batch
     namespace: chaos-testing
   spec:
     entry: parallel
     templates:
     - name: parallel
       templateType: Parallel
       children: [yc-1, yc-2]

     - name: yc-1
       templateType: YCChaos
       deadline: 5m
       ycChaos:
         action: compute-restart
         computeInstance: <идентификатор_ВМ_1>
         secretName: yc-sa-secret

     - name: yc-2
       templateType: YCChaos
       deadline: 5m
       ycChaos:
         action: compute-restart
         computeInstance: <идентификатор_ВМ_2>
         secretName: yc-sa-secret
   ```

   Описание доступных полей сценария `YCChaos`:

   * `action` — выполняемое действие. Возможные значения: `compute-stop` — остановить ВМ, `compute-restart` — перезапустить ВМ. Значение по умолчанию — `compute-stop`.
   * `computeInstance` — идентификатор ВМ, с которой выполняются действия сценария.
   * (опционально) `duration` — длительность сценария.
   * (опционально) `remoteCluster` — кластер, где должен быть запущен сценарий.
   * (опционально) `secretName` — имя секрета Kubernetes с авторизованным ключом сервисного аккаунта, от имени которого выполняется сценарий.

1. Создайте workflow с помощью команды:

   ```shell
   kubectl apply -f chaos.yaml
   ```

1. Убедитесь, что указанные виртуальные машины перезапустились после создания workflow.

   Также вы можете посмотреть результаты работы workflow в [веб-интерфейсе Chaos Mesh](#interface-and-authorization).

{% note info %}

Вы можете проводить эксперименты с использованием сценария `YCChaos` непосредственно в веб-интерфейсе Chaos Mesh.

{% endnote %}

## Полезные ссылки {#see-also}

* [Документация Chaos Mesh](https://chaos-mesh.org/docs/).