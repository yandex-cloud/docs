Запустите WireGuard:

```bash
sudo wg-quick up wg0
```

Результат:

```text
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 192.168.100.1/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
```

Чтобы остановить WireGuard, используйте команду `sudo wg-quick down wg0`.

{% note info %}

Чтобы включить автоматический запуск WireGuard, выполните команду:

```bash
sudo systemctl start wg-quick@wg0 && sudo systemctl enable wg-quick@wg0
```

{% endnote %}