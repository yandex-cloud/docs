# Настройка программного обеспечения

Для [виртуальных машин](../../concepts/vm.md) с [LAMP](https://yandex.cloud/ru/marketplace/products/yc/lamp), [LEMP](https://yandex.cloud/ru/marketplace/products/yc/lemp) и [Node.js](https://yandex.cloud/ru/marketplace/products/yc/nodejs) первоначальную настройку выполнять не нужно. Предустановленное ПО готово к использованию.

Для ВМ с системами, требующими развертывания, например, [Drupal](https://yandex.cloud/ru/marketplace/products/yc/drupal-8), [GitLab](https://yandex.cloud/ru/marketplace/products/yc/gitlab), [Joomla](https://yandex.cloud/ru/marketplace/products/yc/joomla) и [WordPress](https://yandex.cloud/ru/marketplace/products/yc/wordpress), для первоначальной настройки используйте [веб-установщик](#web-setup).

## Настройка ПО через веб-установщик {#web-setup}

Для запуска веб-установщика:
1. Определите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ. Узнать IP-адрес можно в [консоли управления](https://console.yandex.cloud) на странице ВМ в блоке **Сеть**.
1. Наберите в адресной строке браузера `http://<IP-адрес>`. Откроется окно авторизации.

   {% note info %}

   Если подключиться к ВМ не получилось, повторите попытку через несколько минут.

   {% endnote %}

1. Выполните шаги веб-установщика, следуя рекомендациям разработчиков: [Drupal](https://drupal.org/), [GitLab](https://about.gitlab.com), [Joomla](https://joomla.org/), [WordPress](https://wordpress.org/).

В процессе настройки ПО могут понадобиться параметры подключения к базе данных. Чтобы узнать параметры, [подключитесь к ВМ](operate.md) по [SSH](../../../glossary/ssh-keygen.md) и выполните команду:

```bash
sudo cat /root/default_passwords.txt
```