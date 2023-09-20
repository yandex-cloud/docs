# Как начать работать с {{ cloud-desktop-name }}

{% note info %}

Инструкция содержит информацию о создании и настройке [группы рабочих столов](concepts/desktops-and-groups.md). Если вы получили от администратора ссылку на [витрину пользовательских рабочих столов](concepts/showcase.md), перейдите к подразделу [{#T}](#get-credentials).

{% endnote %}

Создайте группу рабочих столов {{ cloud-desktop-name }} в собственном облаке:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте группу рабочих столов](#create-desktop-group).
1. [Создайте рабочий стол](#create-desktop).
1. [Получите данные для подключения](#get-credentials).
1. [Подключитесь к рабочему столу](#connect-desktop).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет каталога, [создайте его](../resource-manager/operations/folder/create.md).
1. Чтобы рабочие столы имели доступ в интернет, для [подсетей](../vpc/concepts/network.md#subnet), в которых они будут размещены, [настройте](../vpc/operations/create-nat-gateway.md) NAT-шлюз.

## Создайте группу рабочих столов {#create-desktop-group}

{% include [create-desktop-group](../_includes/cloud-desktop/create-desktop-group.md) %}

## Создайте рабочий стол {#create-desktop}

{% include [create-desktop](../_includes/cloud-desktop/create-desktop.md) %}

## Получите данные для подключения {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Подключитесь к рабочему столу {#connect-desktop}

Для подключения к рабочему столу используется [Remote Desktop Protocol](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
