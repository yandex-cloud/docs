{% list tabs %}

- Linux (Bash) and macOS (Zsh)

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file }} && \
   sudo chmod 0655 {{ crt-local-dir }}{{ crt-local-file }}
   ```

   The certificate is saved to the `{{ crt-local-dir }}{{ crt-local-file }}` file.

- Windows (PowerShell)

   1. Download and import the certificate:

      ```powershell
      mkdir -Force $HOME\.clickhouse; `
      (Invoke-WebRequest {{ crt-web-path }}).RawContent.Split([Environment]::NewLine)[-31..-1] `
        | Out-File -Encoding ASCII $HOME\.clickhouse\{{ crt-local-file }}; `
      Import-Certificate `
        -FilePath $HOME\.clickhouse\{{ crt-local-file }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

   1. Confirm that you agree to install the certificate in the <q>Trusted Root Certification Authorities</q> store.

   The certificate is saved to the `$HOME\.clickhouse\{{ crt-local-file }}` file.

{% endlist %}
