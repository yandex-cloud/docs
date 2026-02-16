---
title: Установка Chaos Mesh
description: Следуя данной инструкции, вы сможете установить Chaos Mesh.
---

# Установка Chaos Mesh


[Chaos Mesh](https://chaos-mesh.org/) — это платформа с открытым исходным кодом, которая позволяет симулировать отказы и нарушения в работе кластера {{ k8s }}. Симуляцию можно проводить на разных стадиях разработки и тестирования, а также после релиза. Вы можете использовать Chaos Mesh, чтобы найти потенциальные угрозы, устранить их и настроить политики безопасности (например, с помощью приложения [Kyverno](kyverno.md)).

{% note warning %}

Проверяйте сценарии отказов сначала на тестовом кластере, чтобы не нарушить работоспособность основного кластера.

{% endnote %}

## Перед началом работы {#before-you-begin}

1. [Создайте группу узлов](../node-group/node-group-create.md) с оперативной памятью не менее 14 ГБ.

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Chaos Mesh](/marketplace/products/yc/chaos-mesh) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `chaos-mech-space`). Если вы оставите пространство имен по умолчанию, Chaos Mesh может работать некорректно.
   * **Название приложения** — укажите название приложения.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Chaos Mesh выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_chaos-mesh.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_chaos-mesh.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     chaos-mesh ./chaos-mesh/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Chaos Mesh может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `chaos-mesh-space`).

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/chaos-mesh#docker-images).

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
1. Для авторизации нужны учетная запись и токен {{ k8s }}. Получите их одним из двух способов:

   * [Создайте учетную запись и токен](https://chaos-mesh.org/docs/manage-user-permissions/) для Chaos Mesh. Для учетной записи можно настроить права доступа в конкретном пространстве имен.
   * Для кластеров версии {{ k8s }} 1.24 или выше используйте сервисный аккаунт {{ k8s }} и создайте токен для этого сервисного аккаунта:

      1. Посмотрите список доступных сервисных аккаунтов {{ k8s }}:

         ```bash
         kubectl get serviceAccounts
         ```

         У каждого аккаунта свой набор прав доступа.

      1. Выберите нужный аккаунт и создайте токен:

         ```bash
         kubectl create token <название_аккаунта>
         ```

## Работа с ресурсами {{ yandex-cloud }} {#yandex-cloud-resources}

В приложении доступен сценарий `YCChaos`, который позволяет моделировать отказы ВМ узлов (например, перезапуск или остановку). С его помощью можно проверять отказоустойчивость систем, зависящих от облачной инфраструктуры.

Например, чтобы смоделировать перезапуск ВМ узлов с помощью `YCChaos`:

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `compute.operator`.
1. [Выпустите авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) и сохраните его в файл `sa-key.json`
1. Создайте пространство имен `chaos-testing`.
1. Создайте секрет {{ k8s }} на основе созданного ранее авторизованного ключа:

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
   * (опционально) `secretName` — имя секрета {{ k8s }} с авторизованным ключом сервисного аккаунта, от имени которого выполняется сценарий.

1. Создайте workflow с помощью команды:

   ```shell
   kubectl apply -f chaos.yaml
   ```

1. Убедитесь, что указанные виртуальные машины перезапустились после создания workflow.

   Также вы можете посмотреть результаты работы workflow в [веб-интерфейсе Chaos Mesh](#interface-and-authorization).

{% note info %}

Вы можете проводить эксперименты с использованием сценария `YCChaos` непосредственно в веб-интерфейсе Chaos Mesh.

{% endnote %}

## См. также {#see-also}

* [Документация Chaos Mesh](https://chaos-mesh.org/docs/).
