# Как начать работать с Yandex Managed Service for YTsaurus

Чтобы начать работу с сервисом Managed Service for YTsaurus:

1. [Создайте demo-кластер](#cluster-create).
1. [Откройте веб-интерфейс YTsaurus](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-ytsaurus.editor](security/index.md#managed-ytsaurus-editor) — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

## Создайте demo-кластер {#cluster-create}

{% note info %}

Создание кластера YTsaurus занимает длительное время.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер Managed Service for YTsaurus.
  1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Managed Service for YTsaurus**.
  1. Нажмите кнопку **Создать кластер**.
  1. Выберите **Demo-кластер** для создания кластера с минимальной рабочей конфигурацией.
  1. В блоке **Базовые параметры**:
      1. Задайте имя кластера. Имя должно быть уникальным в рамках каталога.
      1. (Опционально) Введите описание кластера.
      1. (Опционально) Создайте [метки](../resource-manager/concepts/labels.md):
          1. Нажмите кнопку **Добавить метку**.
          1. Введите метку в формате `ключ: значение`.
          1. Нажмите **Enter**.
  
  1. В блоке **Сетевые настройки** выберите:
      * [Зону доступности](../overview/concepts/geo-scope.md) для размещения кластера.
      * [Подсеть](../vpc/operations/subnet-create.md).
      * (Опционально) [Группу безопасности](../vpc/concepts/security-groups.md) для сетевого трафика кластера.
  
      {% note warning %}
         
      Сетевые настройки нельзя изменить после создания кластера.
         
      {% endnote %}
  
  1. В блоке **Конфигурация кластера** ознакомьтесь с параметрами конфигурации кластера.
  1. Нажмите кнопку **Создать**.
  1. Дождитесь, когда кластер будет готов к работе: его статус на панели Managed Service for YTsaurus сменится на **Running**. Это может занять продолжительное время.

{% endlist %}

## Откройте веб-интерфейс YTsaurus {#web-gui}

Для управления YTsaurus можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [managed-ytsaurus.user](security/index.md#managed-ytsaurus-user). Чтобы начать работу в веб-интерфейсе YTsaurus:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором расположен кластер.
1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Managed Service for YTsaurus**.
1. Перейдите на страницу [веб-интерфейса YTsaurus](concepts/authentication.md#users).

## Что дальше {#whats-next}

* Узнайте подробнее о [создании кластера](operations/cluster-create.md) YTsaurus.