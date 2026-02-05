---
title: Создание адреса
description: Следуя данной инструкции, вы создадите адрес.
---

# Создание адреса

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать [адрес](../concepts/glossary.md#adress).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
1. В поле **{{ ui-key.yacloud.postbox.label_address }}** укажите домен, с которого будете отправлять письма. Домен может быть любого уровня.
1. (Опционально) [Привяжите конфигурацию к адресу](bind-configuration.md).
1. Настройте подписи исходящих писем (DKIM). Выберите:
    
    * **Простая**, чтобы {{ postbox-name }} подготовил ключи и DNS-записи, которые вам нужно будет добавить в ваш DNS-провайдер. Подробнее см. раздел [{#T}](../concepts/glossary.md#dkim).

    * **Расширенная**, чтобы самостоятельно задать селектор и приватный ключ:

        1. Сгенерируйте ключ для создания DKIM-подписи. {{ postbox-name }} поддерживает ключи длиной 1024 или 2048 бит. Для генерации ключа используйте следующую команду OpenSSL:

            ```bash
            openssl genrsa -out privatekey.pem 2048
            ```

            {% note info %}
     
            У некоторых DNS-провайдеров есть ограничения на длину TXT-записей. Если вы столкнулись с такой проблемой, используйте ключ длиной 1024 бита.
     
            {% endnote %}
  
        1. В поле **{{ ui-key.yacloud.postbox.label_selector }}** укажите селектор, например `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую необходимо создать при прохождении [проверки владения доменом](check-domain.md).

        1. В поле **{{ ui-key.yacloud.postbox.label_private-key }}** скопируйте содержимое файла приватного ключа `privatekey.pem`.
     
    {% endlist %}

1. (Опционально) [Настройте логирование](logs-write.md).
1. (Опционально) В блоке **{{ ui-key.yacloud.postbox.section_restrictions }}** включите опцию **{{ ui-key.yacloud.postbox.label_restrict-senders }}** и добавьте почтовые ящики, с которых будет разрешена отправка писем.  
1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.

Чтобы отправлять письма, пройдите [проверку владения доменом](check-domain.md).
