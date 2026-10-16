Чтобы запустить агент в режиме dry run:

{% list tabs group=operating_system %}

- Linux {#linux}

  1. В терминале Linux остановите сервис агента синхронизации:

      ```bash
      sudo systemctl stop yc-identityhub-sync-agent
      ```
  1. Внесите в конфигурацию агента изменения, которые вы хотите протестировать.
  1. В секции `dry_run` файла конфигурации агента включите режим dry run:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. В терминале Linux вручную запустите исполняемый файл агента и дождитесь завершения его работы:

      ```bash
      ./yc-identityhub-sync-agent \
        --config /etc/yc-identityhub-sync-agent/config.yaml
      ```

      {% include [ad-sync-dry-run-output](./ad-sync-dry-run-output.md) %}

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале Linux запустите сервис агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

          ```bash
          sudo systemctl start yc-identityhub-sync-agent
          ```

- Windows {#windows}

  1. В терминале PowerShell остановите службу агента синхронизации:

      ```powershell
      Stop-Service yc-identityhub-sync-agent
      ```
  1. Внесите в конфигурацию агента изменения, которые вы хотите протестировать.
  1. В секции `dry_run` файла конфигурации агента включите режим dry run:

      ```yml
      ...
      dry_run:
        enabled: true
      ...
      ```
  1. В терминале PowerShell вручную запустите исполняемый файл агента и дождитесь завершения его работы:

      ```powershell
      ./yc-identityhub-sync-agent.exe \
        --config C:\ProgramData\YcIdentityHubSyncAgent\config.yaml
      ```

      {% include [ad-sync-dry-run-output](./ad-sync-dry-run-output.md) %}

  1. Если все сохраненные в файл логов изменения являются ожидаемыми, а операции не содержат ошибок, значит, внесенные в конфигурацию агента изменения корректны, и агент можно запускать в рабочем режиме:

      1. Отключите режим dry run, заменив в файле конфигурации в секции `dry_run` значение поля на `enabled: false`.
      1. В терминале PowerShell запустите службу агента {{ ad-sync-agent }}, чтобы начать процесс синхронизации:

          ```powershell
          Start-Service yc-identityhub-sync-agent
          ```

{% endlist %}