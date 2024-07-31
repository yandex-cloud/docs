На сервере OpenVPN заранее создан пользователь `openvpn` с административными правами. Пароль генерируется автоматически при создании [виртуальной машины](../../compute/concepts/vm.md).

Получите пароль в [выводе последовательного порта](../../compute/operations/vm-info/get-serial-port-output.md) или в серийной консоли. Пароль отобразится в строке:

```text
To login please use the "openvpn" account with <пароль> password.
```

Где `<пароль>` — пароль пользователя `openvpn`.

Для первого входа в административную панель используйте логин `openvpn` и полученный пароль.

Если вы не получили пароль после первого [запуска сервера VPN](#create-vpn-server), необходимо заново создать ВМ с [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server). При перезапусках пароль не отображается.