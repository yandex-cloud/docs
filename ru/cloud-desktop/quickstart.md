# Как начать работать с {{ cloud-desktop-name }}

Создайте [группу рабочих столов](concepts/desktops-and-groups.md) {{ cloud-desktop-name }} в собственном облаке:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу рабочих столов](#create-desktop-group).
1. [Создайте рабочий стол](#create-desktop).
1. [Получите данные для подключения](#get-credentials).
1. [Подключитесь к рабочему столу](#connect-desktop).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Чтобы рабочие столы имели доступ в интернет, для [подсетей](../vpc/concepts/network.md#subnet), в которых они будут размещены, [настройте](../vpc/operations/create-nat-gateway.md) NAT-шлюз.

## Создайте группу рабочих столов {#create-desktop-group}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **Cloud Desktop**.
  1. Нажмите кнопку **Создать группу рабочих столов**.
  1. Введите имя и описание группы рабочих столов.
  1. Выберите образ операционной системы.
  1. В блоке **Вычислительные ресурсы**:
      * Выберите [платформу](../compute/concepts/vm-platforms.md).
      * Укажите [гарантированную долю](../compute/concepts/performance-levels.md) и необходимое количество vCPU, а также объем RAM.
  1. В блоке **Сетевые настройки** выберите [облачную сеть](../vpc/concepts/network.md#network) и подсети из списка.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте рабочий стол {#create-desktop}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан [рабочий стол](concepts/desktops-and-groups.md).
  1. В списке сервисов выберите **Cloud Desktop**.
  1. На панели слева выберите ![image](../_assets/cloud-desktop/desktops.svg) **Рабочие столы**.
  1. Нажмите кнопку **Создать рабочий стол**.
  1. Выберите группу рабочих столов, созданную ранее.
  1. Укажите подсеть, в которой будет размещен рабочий стол.
  1. Выберите себя, как пользователя, для которого создается рабочий стол.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Получите данные для подключения {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Подключитесь к рабочему столу {#connect-desktop}

Для подключения к рабочему столу используется [Remote Desktop Protocol](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
