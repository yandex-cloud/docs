# Как начать работать с {{ myt-full-name }}

Чтобы начать работу с сервисом {{ myt-name }}:

1. [Создайте demo-кластер](#cluster-create).
1. [Откройте веб-интерфейс {{ ytsaurus-name }}](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [managed-ytsaurus.editor](security/index.md#managed-ytsaurus-editor) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

## Создайте demo-кластер {#cluster-create}

{% note info %}

Создание кластера {{ ytsaurus-name }} занимает длительное время.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер {{ myt-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Выберите **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-kind-card_demo_title_4B7zu }}** для создания кластера с минимальной рабочей конфигурацией.
  1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.base-params-section_title_nfKo2 }}**:
      1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
      1. (Опционально) Введите описание кластера.
      1. (Опционально) Создайте [метки](../resource-manager/concepts/labels.md):
          1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
  
  1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.net-settings-section_title_wo42X }}** выберите:
      * [Зону доступности](../overview/concepts/geo-scope.md) для размещения кластера.
      * [Подсеть](../vpc/operations/subnet-create.md).
      * (Опционально) [Группу безопасности](../vpc/concepts/security-groups.md) для сетевого трафика кластера.
  
      {% note warning %}
         
      Сетевые настройки нельзя изменить после создания кластера.
         
      {% endnote %}
  
  1. В блоке **{{ ui-key.yacloud.managed-ytsaurus.clusters.YTSaurusClusterCreatePage.cluster-config-section_title_fPkN8 }}** ознакомьтесь с параметрами конфигурации кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Дождитесь, когда кластер будет готов к работе: его статус на панели {{ myt-name }} сменится на **Running**. Это может занять продолжительное время.

{% endlist %}

## Откройте веб-интерфейс {{ ytsaurus-name }} {#web-gui}

Для управления {{ ytsaurus-name }} можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [managed-ytsaurus.user](security/index.md#managed-ytsaurus-user). Чтобы начать работу в веб-интерфейсе {{ ytsaurus-name }}:

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположен кластер.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-ytsaurus }}**.
1. Перейдите на страницу [веб-интерфейса {{ ytsaurus-name }}](concepts/authentication.md#users).

## Что дальше {#whats-next}

* Узнайте подробнее о [создании кластера](operations/cluster-create.md) {{ ytsaurus-name }}.