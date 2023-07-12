{% list tabs %}

- Linux (Bash) и macOS (Zsh)

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   sudo chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   Сертификат будет сохранен в файле `{{ crt-local-dir }}{{ crt-local-file }}`.

- Windows (PowerShell)

   1. Скачайте и импортируйте сертификат:

      ```powershell
      mkdir -Force $HOME\.clickhouse; `
      (Invoke-WebRequest {{ crt-web-path }}).RawContent.Split([Environment]::NewLine)[-31..-1] `
        | Out-File -Encoding ASCII $HOME\.clickhouse\{{ crt-local-file }}; `
      Import-Certificate `
        -FilePath $HOME\.clickhouse\{{ crt-local-file }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

   1. Подтвердите согласие с установкой сертификата в хранилище <q>Доверенные корневые центры сертификации</q>.

   Сертификат будет сохранен в файле `$HOME\.clickhouse\{{ crt-local-file }}`.

{% endlist %}
