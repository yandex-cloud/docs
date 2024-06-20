# Как настроить защиту RDP-подключения на Windows


## Описание сценария {#case-description}

Необходимо дополнительно защитить RDP-подключение на Windows.

## Решение {#case-resolution}

У {{ yandex-cloud }} нет готовых технических решений для обеспечения защиты RDP-подключений с помощью дополнительных средств аутентификации пользователей.

Можем порекомендовать вам [использовать VPN-подключение к {{ yandex-cloud }}](../../../tutorials/routing/ipsec/ipsec-vpn.md).
Также вы можете усилить [защиту RDP-подключения на уровне ОС](https://www.mvps.net/docs/how-to-secure-remote-desktop-rdp/) или использовать [двухфакторную аутентификацию](https://winitpro.ru/index.php/2022/01/18/2fa-v-windows-multiotp/).