# Настройка программного обеспечения

Для [виртуальных машин](../../concepts/vm.md) с [LAMP](/marketplace/products/yc/lamp), [LEMP](/marketplace/products/yc/lemp) и [Node.js](/marketplace/products/yc/nodejs) первоначальную настройку выполнять не нужно. Предустановленное ПО готово к использованию.

Для ВМ с системами, требующими развертывания, например, [Drupal](/marketplace/products/yc/drupal-8), [{{ GL }}](/marketplace/products/yc/gitlab), [Joomla](/marketplace/products/yc/joomla) и [WordPress](/marketplace/products/yc/wordpress), для первоначальной настройки используйте [веб-установщик](#web-setup).

## Настройка ПО через веб-установщик {#web-setup}

Для запуска веб-установщика:
1. Определите [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) ВМ. Узнать IP-адрес можно в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. Наберите в адресной строке браузера `http://<IP-адрес>`. Откроется окно авторизации.

   {% note info %}

   Если подключиться к ВМ не получилось, повторите попытку через несколько минут.

   {% endnote %}

1. Выполните шаги веб-установщика, следуя рекомендациям разработчиков: [Drupal](https://drupal.org/), [{{ GL }}](https://about.gitlab.com), [Joomla](https://joomla.org/), [WordPress](https://wordpress.org/).

В процессе настройки ПО могут понадобиться параметры подключения к базе данных. Чтобы узнать параметры, [подключитесь к ВМ](operate.md) по [SSH](../../../glossary/ssh-keygen.md) и выполните команду:

```bash
sudo cat /root/default_passwords.txt
```