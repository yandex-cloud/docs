Run WireGuard:

```bash
sudo wg-quick up wg0
```

Result:

```text
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 192.168.100.1/24 dev wg0
[#] ip link set mtu 1420 up dev wg0
```

To stop WireGuard, run this command: `sudo wg-quick down wg0`.

{% note info %}

To activate WireGuard autostarting, run this command:

```bash
sudo systemctl start wg-quick@wg0 && sudo systemctl enable wg-quick@wg0
```

{% endnote %}