
{% list tabs %}

- Linux (Bash)

   ```bash
   sudo mkdir --parents {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo wget "{{ crt-web-path-int }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} \
        {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo update-ca-certificates
   ```

   Сертификаты будут сохранены в файлах:

   * `{{ crt-local-dir }}{{ crt-local-file-root }}`
   * `{{ crt-local-dir }}{{ crt-local-file-int }}`

- macOS (Zsh)

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo wget "{{ crt-web-path-int }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-int }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} \
        {{ crt-local-dir }}{{ crt-local-file-int }} && \
   security import {{ crt-local-dir }}{{ crt-local-file-root }} -k ~/Library/Keychains/login.keychain; \
   security import {{ crt-local-dir }}{{ crt-local-file-int }} -k ~/Library/Keychains/login.keychain
   ```

   Сертификаты будут сохранены в файлах:

   * `{{ crt-local-dir }}{{ crt-local-file-root }}`
   * `{{ crt-local-dir }}{{ crt-local-file-int }}`

- Windows (PowerShell)

   1. Скачайте и импортируйте сертификаты:

      ```powershell
      mkdir -Force $HOME\.yandex; `
      curl.exe {{ crt-web-path-root }} `
        --output $HOME\.yandex\{{ crt-local-file-root }}; `
      curl.exe {{ crt-web-path-int }} `
        --output $HOME\.yandex\{{ crt-local-file-int }}; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
        -CertStoreLocation cert:\CurrentUser\Root; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-int }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

   1. Подтвердите согласие с установкой сертификатов в хранилище <q>Доверенные корневые центры сертификации</q>.

   Сертификаты будут сохранены в файлах:

   * `$HOME\.yandex\{{ crt-local-file-root }}`
   * `$HOME\.yandex\{{ crt-local-file-int }}`

{% endlist %}

