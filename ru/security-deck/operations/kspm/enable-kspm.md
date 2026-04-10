---
title: Активировать модуль Контроль {{ k8s }}® ({{ kspm-name }}) в {{ sd-full-name }}
description: Инструкция по активации и настройке модуля Контроль {{ k8s }}® ({{ kspm-name }}) в {{ sd-name }}.
---

# Активировать модуль {{ kspm-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

Модуль {{ kspm-name }} позволяет гибко выбирать и настраивать правила безопасности под специфические требования вашей организации, а также создавать исключения из правил.

## Перед началом работы {#before-you-begin}

Перед началом работы с модулем {{ kspm-name }} убедитесь, что кластеры, которые вы планируете включить в область действия модуля, соответствуют техническим требованиям:

* {{ k8s }} версии 1.28 или выше.
* В кластере {{ k8s }} отсутствует [Admission Control](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/) на базе [Kyverno](https://yandex.cloud/ru/marketplace/products/yc/kyverno). Если Kyverno был развернут ранее, его необходимо удалить вместе со всеми созданными им ресурсами [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/).
* Между узлами кластера {{ k8s }} и [сервисом {{ container-registry-full-name }}](../../../managed-kubernetes/tutorials/container-registry.md) настроено сетевое взаимодействие.
* Открыт сетевой доступ от пода, в котором запущен сенсор контроля безопасности среды выполнения, до подов кластера через порт `54321`.
* Открыт доступ от кластера к API {{ kspm-name }} (`kspm.api.cloud.yandex.net`) через порт `443` по протоколу TCP.
* С помощью [групп безопасности](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) настроен доступ от мастера кластера к компонентам {{ kspm-name }}, запущенным на узлах кластера.

## Активировать модуль {#kspm-activate}

Чтобы начать работу с модулем {{ kspm-name }}:
1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт, от имени которого модуль {{ kspm-name }} будет просматривать информацию о [кластерах](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) {{ managed-k8s-name }}, устанавливать в них необходимые компоненты и выполнять проверки.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../../security/index.md#security-deck-worker) `security-deck.worker` на организацию, облако или каталог.

    {% note info %}

    {{ kspm-name }} будет иметь доступ только к тем кластерам {{ managed-k8s-name }}, которые размещены в соответствующих организации, облаке или каталоге.

    {% endnote %}

    Если вы назначили роль на конкретный каталог, выдайте сервисному аккаунту также роль `auditor` на облако.

1. [Создайте](../workspaces/create.md) окружение {{ sd-name }} со следующими особенностями:

    * В разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.resourcesTitle_fE6qp }}** в настройках коннектора:
      * Выберите сервисный аккаунт, созданный ранее.
      * Укажите облака и каталоги, в которых вы хотите контролировать безопасность кластеров {{ managed-k8s-name }}.

        {% note tip %}

        В дальнейшем в настройках {{ kspm-name }} можно будет дополнительно сузить область контроля.

        {% endnote %}

    * В разделе **{{ ui-key.yacloud_org.security.workspaces.WorkspaceOnboardingForm.standartsTitle_cxvJ8 }}** выберите отраслевые стандарты и нормативные акты, на соответствие которым будут проверяться выбранные на предыдущем шаге ресурсы:
      
      {% include [kspm-sec-standard-list](../../../_includes/security-deck/kspm-sec-standard-list.md) %}

      Вы можете выбрать одновременно несколько стандартов. При этом в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** будут отображаться модули {{ sd-name }}, которые будут активированы в создаваемом окружении для проверки ресурсов на соответствие выбранным стандартам и нормативным актам.
1. Завершите настройку {{ kspm-name }}:
    1. На странице созданного окружения нажмите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.edit_action }}**.
    1. Перейдите на вкладку **Контроль {{ k8s }}®**.
    1. В блоке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceKspmResourcesForm.section-title_iYCNY }}** выберите облака, каталоги или кластеры в пределах ресурсов окружения, в которых будет производиться контроль за соблюдением правил безопасности {{ k8s }}.

        {% note warning %}

        Один кластер может входить только в одно окружение {{ sd-name }}. В противном случае будут возникать конфликты.

        {% endnote %}

    1. Нажмите **{{ ui-key.yacloud.common.save }}** и подтвердите действие.

        После этого в кластерах {{ managed-k8s-name }}, которые находятся в области действия контроля, будут автоматически установлены необходимые компоненты в пространстве имен `yc-security`.

        В зависимости от размера кластера установка компонентов может занять от 1 до 10 минут.

{% note tip %}

Чтобы удалить кластеры из области контроля и прекратить отслеживать их безопасность, [удалите](../workspaces/delete.md) окружение {{ sd-name }} или отключите стандарты безопасности, относящиеся к {{ k8s }}.

{% endnote %}