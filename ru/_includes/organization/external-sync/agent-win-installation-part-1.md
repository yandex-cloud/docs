Чтобы установить агент {{ ad-sync-agent }}, выполните команду:

```bash
iex (New-Object System.Net.WebClient).DownloadString('{{ ad-sync-agent-windowslink }}')
```

Результат:

```text
Example config file downloaded to C:\ProgramData\YcIdentityHubSyncAgent\config.yaml. Modify it with your values
yc-identityhub-sync-agent is installed to C:\Program Files\YcIdentityHubSyncAgent\bin\yc-identityhub-sync-agent.exe
Config file is located at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml

Status   Name               DisplayName
------   ----               -----------
Stopped  yc-identityhub-... Yandex Identity Hub Sync Agent
yc-identityhub-sync-agent installed as Windows service 'yc-identityhub-sync-agent' (not started automatically)
1. Modify the config file at C:\ProgramData\YcIdentityHubSyncAgent\config.yaml with your values
2. Run: Start-Service yc-identityhub-sync-agent
```