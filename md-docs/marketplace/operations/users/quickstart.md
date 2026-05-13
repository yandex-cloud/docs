# Как начать работать с Yandex Cloud Marketplace

В Cloud Marketplace вы можете найти готовые решения для разработки, анализа данных, обеспечения безопасности, создания бизнес‑приложений и других задач. Продукты в Cloud Marketplace доступны всем пользователям Yandex Cloud.


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.
1. На [странице облака](https://console.yandex.cloud/cloud) [создайте](../../../resource-manager/operations/folder/create.md) или выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) в котором будет работать ваше решение из Cloud Marketplace.


## Выберите и установите продукт {#select-and-setup-product}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. В верхней части экрана нажмите на панель **Готовые решения Marketplace**.
  1. В поле **Поиск продукта** введите название продукта, который вы хотите установить, или воспользуйтесь фильтрами поиска по категории, [типу продукта](../../concepts/users/products-types.md) или типу тарификации. Можно также использовать сортировку.
  1. Нажмите на карточку выбранного продукта Cloud Marketplace, изучите описание продукта, примеры использования и другую информацию.
  1. Чтобы установить продукт, следуйте инструкции на карточке.

{% endlist %}


## Пример установки продукта {#examples}

Чтобы создать виртуальную машину из дистрибутива [Ubuntu 24.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-2404-lts-oslogin) в Cloud Marketplace:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Выберите на главной странице Cloud Marketplace образ ВМ Ubuntu 24.04 LTS и нажмите кнопку **Использовать**.
  1. В открывшемся окне **Создание виртуальной машины** в блоке **Образ загрузочного диска** на вкладке **Marketplace** будет выбран [образ](../../../compute/concepts/image.md) Ubuntu 24.04 LTS.
  1. В блоке **Доступ** выберите **Доступ по OS Login**, чтобы [подключаться](../../../compute/operations/vm-connect/os-login.md) к создаваемой ВМ и управлять доступом к ней с помощью [OS Login](../../../organization/concepts/os-login.md) в Yandex Identity Hub.
  1. В блоке **Общая информация** задайте имя ВМ либо оставьте имя, сгенерированное автоматически.
  1. Нажмите кнопку **Создать ВМ**.

  ВМ c Ubuntu 24.04 LTS появится в списке. При создании ВМ назначаются [IP-адрес](../../../vpc/concepts/address.md) и [имя хоста](../../../vpc/concepts/address.md#fqdn) (FQDN).

{% endlist %}

## Поддержка продуктов Marketplace {#support}

Поддержка продуктов Marketplace осуществляется их разработчиками. При возникновении проблем обращайтесь в техническую поддержку и к информационным ресурсам разработчика продукта.

Условия и способы поддержки каждого продукта индивидуальны. Они описаны на карточке в разделе **Техническая поддержка**.

Yandex Cloud не предоставляет техническую поддержку продуктов Marketplace, размещенных сторонними издателями. Стоимость продуктов Marketplace не включается в расчет тарифа платной поддержки. См. [пример расчета](../../../support/pricing.md#business-example-one-ba-cvos).