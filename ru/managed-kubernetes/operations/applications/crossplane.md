# Установка Crossplane с поддержкой {{ yandex-cloud }}

[Crossplane](https://crossplane.io/) — свободно распространяемое дополнение к {{ k8s }}, позволяющее командам разработки платформы собрать инфраструктуру для нескольких вендоров и производить более высокоуровневые API сервисов для потребления командами разработки приложений.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `admin`. Он необходим для работы Crossplane.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Crossplane с поддержкой {{ yandex-cloud }}](/marketplace/products/yc/crossplane) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Crossplane или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла [ключа сервисной учетной записи](../../../iam/concepts/authorization/access-key.md) или создайте новый.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.