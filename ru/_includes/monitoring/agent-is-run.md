Чтобы убедиться, что {{ unified-agent-short-name }} успешно установлен и запущен, выполните команду:

```bash
systemctl status unified-agent
```

Результат:

```bash
● unified-agent.service - Yandex Unified Agent service
     Loaded: loaded (/lib/systemd/system/unified-agent.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2025-10-01 08:49:44 UTC; 27min ago
   Main PID: 1106 (unified_agent)
      Tasks: 8 (limit: 2308)
     Memory: 5.2M
        CPU: 136ms
     CGroup: /system.slice/unified-agent.service
             └─1106 /usr/bin/unified_agent --config /etc/yandex/unified_agent/config.yml --log-priority NOTICE
```