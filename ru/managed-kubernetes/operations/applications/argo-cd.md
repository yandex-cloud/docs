# Установка Argo CD

[Argo CD](https://argo-cd.readthedocs.io) — декларативный инструмент для непрерывной доставки в {{ k8s }} по модели GitOps.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Argo CD](/marketplace/products/yc/argo-cd) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Argo CD или создайте новое.
   * **Название приложения** — укажите название приложения.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Получите пароль администратора (`admin`):

   ```bash
   kubectl --namespace <пространство_имен> get secret argocd-initial-admin-secret \
     --output jsonpath="{.data.password}" | base64 -d
   ```

Для доступа к приложению через `localhost`:
1. Настройте переадресацию порта сервиса ArgoCD на локальный компьютер:

   ```bash
   kubectl port-forward service/<название_приложения>-argocd-server \
     --namespace <пространство_имен> 8080:443
   ```

1. Перейдите по ссылке `http://localhost:8080` и авторизуйтесь с учетными данными администратора.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Argo CD выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_argo-cd.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_argo-cd.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     argo-cd ./argo-cd/
   ```

## См. также {#see-also}

* [Документация Argo CD](https://argo-cd.readthedocs.io/en/stable/operator-manual/).