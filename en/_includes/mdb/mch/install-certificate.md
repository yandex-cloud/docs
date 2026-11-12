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

   The certificate will be saved to the `{{ crt-local-dir }}{{ crt-local-file-root }}` file.

- macOS (Zsh) {#macos}

   ```bash
   sudo mkdir -p {{ crt-local-dir }} && \
   sudo wget "{{ crt-web-path-root }}" \
        --output-document {{ crt-local-dir }}{{ crt-local-file-root }} && \
   sudo chmod 655 \
        {{ crt-local-dir }}{{ crt-local-file-root }} && \
   security import {{ crt-local-dir }}{{ crt-local-file-root }} -k ~/Library/Keychains/login.keychain
   ```

   The certificate will be saved to the `{{ crt-local-dir }}{{ crt-local-file-root }}` file.

- Windows (PowerShell) {#windows}

   1. Download and import the certificate:

      ```powershell
      mkdir -Force $HOME\.yandex; `
      curl.exe {{ crt-web-path-root }} `
        --output $HOME\.yandex\{{ crt-local-file-root }}; `
      Import-Certificate `
        -FilePath $HOME\.yandex\{{ crt-local-file-root }} `
        -CertStoreLocation cert:\CurrentUser\Root
      ```

      Your corporate security policies and antivirus software may block the certificate download. For more information, see [FAQ](../../../managed-clickhouse/qa/connection.md#get-ssl-error).

   1. Confirm that that you agree to install the certificate in the _Trusted Root Certification Authorities_ store.

   The certificate will be saved to the `$HOME\.yandex\{{ crt-local-file-root }}` file.

{% endlist %}
