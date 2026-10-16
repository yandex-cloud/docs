Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

```bash
curl {{ ad-sync-agent-linuxlink }} | bash
```

Результат:

```text
Example config file downloaded to /etc/yc-identityhub-sync-agent/config.yaml. Modify it with your values
Service installed as yc-identityhub-sync-agent
To start the service: sudo systemctl start yc-identityhub-sync-agent
To enable the service to start on boot: sudo systemctl enable yc-identityhub-sync-agent
To check service status: sudo systemctl status yc-identityhub-sync-agent
yc-identityhub-sync-agent is installed to /usr/bin/yc-identityhub-sync-agent
```