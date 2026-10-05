{% list tabs group=operating_system %}

- Linux (Bash) {#linux}

   ```bash
   sudo mkdir --parents {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo update-ca-certificates
   ```

   Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file-root }}`.

- macOS (Zsh) {#macos}

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} && \
   security import {{ crt-local-dir }}{{ crt-local-file-root }} -k ~/Library/Keychains/login.keychain
   ```

   Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file-root }}`.

- Windows (PowerShell) {#windows}

   1. Скачайте и импортируйте сертификат:

      ```powershell
      mkdir -Force $HOME\.yandex; `
      curl.exe {{ crt-web-path-root }} `
        --output $HOME\.yandex\{{ crt-local-file-root }}; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

      Корпоративные политики и антивирус могут блокировать скачивание сертификата. Подробнее в разделе [Вопросы и ответы](../../../managed-clickhouse/qa/connection.md#get-ssl-error).

   1. Подтвердите согласие с установкой сертификата в хранилище «Доверенные корневые центры сертификации».

   Сертификат будет сохранен в файле `$HOME\.yandex\{{ crt-local-file-root }}`.

{% endlist %}
