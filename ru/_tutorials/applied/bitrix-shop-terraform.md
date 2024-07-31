1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Настройте ВМ для работы с «1C-Битрикс»](#configure-server).
1. [Настройте «1С-Битрикс»](#configure-bitrix).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [bitrix-shop-paid-resources](../_tutorials_includes/bitrix-shop-paid-resources.md) %}

## Создайте инфраструктуру {#deploy}

{% include [bitrix-create-terraform](../_tutorials_includes/bitrix-create-terraform.md) %}

## Настройте ВМ для работы с «1C-Битрикс» {#configure-server}

{% include [bitrix-website-configure-server](../_tutorials_includes/bitrix-website-configure-server.md) %}

## Настройте «1С-Битрикс» {#configure-bitrix}

{% include [bitrix-shop-configure-bitrix](../_tutorials_includes/bitrix-shop-configure-bitrix.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `bitrix-website.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    {% include [terraform-validate-plan-apply](../_tutorials_includes/terraform-validate-plan-apply.md) %}