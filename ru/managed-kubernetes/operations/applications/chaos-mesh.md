# Установка Chaos Mesh

[Chaos Mesh](https://chaos-mesh.org/) — это платформа с открытым исходным кодом, которая позволяет симулировать отказы и нарушения в работе кластера {{ k8s }}. Симуляцию можно проводить на разных стадиях разработки и тестирования, а также после релиза. Вы можете использовать Chaos Mesh, чтобы найти потенциальные угрозы, устранить их и настроить политики безопасности (например, с помощью приложения [Kyverno](kyverno.md)).

{% note warning %}

Проверяйте сценарии отказов сначала на тестовом кластере, чтобы не нарушить работоспособность основного кластера.

{% endnote %}

Перед началом работы [создайте группу узлов](../node-group/node-group-create.md) с оперативной памятью не менее 14 ГБ.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [Chaos Mesh](/marketplace/products/yc/chaos-mesh) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Chaos Mesh или создайте новое.
   * **Название приложения** — укажите название приложения.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) последней версии и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Chaos Mesh выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_chaos-mesh.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_chaos-mesh.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     chaos-mesh ./chaos-mesh/
   ```

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

## См. также {#see-also}

* [Документация Chaos Mesh](https://chaos-mesh.org/docs/).
