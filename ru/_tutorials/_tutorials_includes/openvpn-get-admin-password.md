На сервере OpenVPN заранее создан пользователь `openvpn` с административными правами. Пароль генерируется автоматически при создании [виртуальной машины](../../compute/concepts/vm.md).

Получите пароль в [выводе последовательного порта](../../compute/operations/vm-info/get-serial-port-output.md). Пароль отобразится в строках:

```text
Admin URL: https://<IP-адрес>:943/admin/
Username: openvpn
Password: <пароль>
```

В строке `Password` указан пароль пользователя `openvpn`.

Для первого входа в административную панель используйте логин `openvpn` и полученный пароль.

{% note info %}

В образе из {{ marketplace-full-name }} настроен редирект с порта 443 на порт 943, поэтому панели доступны по адресам без порта.

{% endnote %}

Если вы не получили пароль после первого [запуска сервера VPN](#create-vpn-server), необходимо заново создать ВМ с [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server). При перезапусках пароль не отображается.