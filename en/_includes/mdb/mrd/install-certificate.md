{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.redis && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.redis/{{ crt-local-file }} && \
   chmod 0655 ~/.redis/{{ crt-local-file }}
   ```

   The certificate is saved to the `~/.redis/{{ crt-local-file }}` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.redis; curl.exe -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

   The certificate is saved to the `$HOME\.redis\{{ crt-local-file }}` file.

{% endlist %}
