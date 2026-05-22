---
title: Установка node-sitter
description: Следуя данной инструкции, вы сможете установить node-sitter.
---

# Установка node-sitter


**node-sitter** — это инструмент для обеспечения отказоустойчивости приложений в группе узлов с прерываемыми ВМ.

Возможности node-sitter:

* Расселение подов при выключении узлов кластера на прерываемых ВМ.
* Установка дополнительных доверенных корневых сертификатов.
* Настройка скачивания образов контейнеров через прокси.
* Установка дополнительных параметров запуска для `kubelet`.

## Перед началом работы {#before-you-begin}

1. [Создайте группу узлов](../node-group/node-group-create.md) со следующими параметрами:

   * **{{ ui-key.yacloud.compute.instances.create.section_platform }}** — выберите **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}**.
   * В поле **{{ ui-key.yacloud.component.compute.resources.field_advanced }}** активируйте опцию **{{ ui-key.yacloud.component.compute.resources.field_preemptible }}**.
   * В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_additional }}** добавьте произвольную taint-политику для приложения (например `node-sitter: 1`).

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ k8s }} и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [node-sitter](/marketplace/products/yc/node-sitter) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `node-sitter`). Если вы оставите пространство имен по умолчанию, node-sitter может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Установить node-drainer** — оставьте опцию включенной, чтобы скрипт `node-drainer` в составе приложения предотвращал появление подов в состоянии `Error` или `Completed` на узлах группы с прерываемыми ВМ.
   * **Название ключа tolerations** — укажите название ключа taint-политики, заданной [ранее](#before-you-begin). Поды `node-sitter` выполнят настройку новых узлов группы с прерываемыми ВМ до того, как на эти узлы распределится пользовательская нагрузка. После успешной настройки узлов приложение `node-sitter` снимает с них taint-политику, и на узлах могут запускаться пользовательские приложения. Если не указывать этот параметр, настройка узлов будет производиться параллельно с запуском пользовательских приложений.
   * (опционально) **Доверенные сертификаты** — скопируйте содержимое файла сертификатов x.509 в формате PEM для установки в хранилище доверенных сертификатов на узлах группы с прерываемыми ВМ. При пересоздании узлов сертификаты будут устанавливаться заново.
   * (опционально) **Параметры для kubelet** — укажите дополнительные параметры запуска `kubelet` на узлах группы с прерываемыми ВМ.
   * (опционально) **Настройки прокси** — укажите настройки прокси для скачивания образов контейнеров на узлах группы с прерываемыми ВМ. Настройки передаются через переменные окружения `HTTP_PROXY` и `HTTPS_PROXY`.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с node-sitter выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_node-sitter.helmChart.name }} \
       --version {{ mkt-k8s-key.yc_node-sitter.helmChart.tag }} \
       --untar && \
    helm install \
       --namespace <пространство_имен_для_node_sitter> \
       --create-namespace \
       --set node_drainer_enabled='true' \
       --set toleration_name='<имя_taint_политики>' \
       --set custom_certs='<доверенные_сертификаты_PEM>' \
       --set custom_kubelet_flags='<дополнительные_параметры_запуска_kubelet>' \
       --set containerd_proxy='<настройки_прокси_для_скачивания_образов>' \
      node-sitter ./node-sitter
    ```

    Параметры установки:

    * `--namespace` — [пространство имен](../../concepts/index.md#namespace), где будет развернуто приложение.

      Если вы укажете в параметре `namespace` пространство имен по умолчанию, node-sitter может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `node-sitter-space`).

    * `node_drainer_enabled` — при значении `true` скрипт `node-drainer` в составе приложения предотвращает появление подов в состоянии `Error` или `Completed` на узлах группы с прерываемыми ВМ.
    * `toleration_name` — название ключа taint-политики, заданной [ранее](#before-you-begin). Поды `node-sitter` выполнят настройку новых узлов группы с прерываемыми ВМ до того, как на эти узлы распределится пользовательская нагрузка. После успешной настройки узлов приложение `node-sitter` снимает с них taint-политику, и на узлах могут запускаться пользовательские приложения. Если не указывать этот параметр, настройка узлов будет производиться параллельно запуску пользовательских приложений.
    * `custom_certs` — содержимое файла сертификатов X.509 в формате PEM для установки в хранилище доверенных сертификатов на узлах группы с прерываемыми ВМ. При пересоздании узлов сертификаты будут устанавливаться заново.
    * `custom_kubelet_flags` — дополнительные параметры запуска `kubelet` на узлах группы с прерываемыми ВМ.
    * `containerd_proxy` — настройки прокси для скачивания образов контейнеров на узлах группы с прерываемыми ВМ. Настройки передаются через переменные окружения `HTTP_PROXY` и `HTTPS_PROXY`.

    {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}
