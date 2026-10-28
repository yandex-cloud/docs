Чтобы проверить конфигурацию агента без запуска синхронизации, укажите путь к файлу конфигурации и один из параметров `--check-config` или `--validate-config`:

{% list tabs group=operating_system %}

- Linux {#linux}

  ```bash
  ./yc-identityhub-sync-agent \
    --config /etc/yc-identityhub-sync-agent/config.yaml \
    --check-config
  ```

- Windows {#windows}

  ```powershell
  .\yc-identityhub-sync-agent.exe --config C:\ProgramData\YcIdentityHubSyncAgent\config.yaml --validate-config
  ```

{% endlist %}

Проверка конфигурации не запускает синхронизацию. Чтобы проверить, какие изменения агент внесет в данные пользователей и групп, используйте [тестовый запуск](#dry-run).
