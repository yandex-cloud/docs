Чтобы открыть центр контроля уязвимостей [репозитория]({{ link-src-docs }}/sourcecraft/concepts/#repos):
1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.mainApp.route_repositories_hzdYT }}** и выберите репозиторий.
1. На странице репозитория в разделе ![image](../../_assets/console-icons/shield-exclamation.svg) **{{ ui-key.sourcecraft.mainApp.route_security_4Dbxc }}** перейдите в секцию ![image](../../_assets/console-icons/circles-4-square.svg) **{{ ui-key.sourcecraft.mainApp.route_security-overview_dQuX9 }}**.

    На дашбордах **{{ ui-key.sourcecraft.appsec.title_overview-secrets_c6BUu }}**, **{{ ui-key.sourcecraft.appsec.title_overview-sca_nxbV5 }}** и **{{ ui-key.sourcecraft.appsec.title_overview-sast_i4bAJ }}** представлена следующая статистика:
    * **{{ ui-key.sourcecraft.appsec.title_alert-status_8gX2y }}**;
    * **{{ ui-key.sourcecraft.appsec.title_resolved-alerts_cUQ2s }}**;
    * **{{ ui-key.sourcecraft.appsec.title_security-risks_mkLFM }}** (на дашбордах **{{ ui-key.sourcecraft.appsec.title_overview-sca_nxbV5 }}** и **{{ ui-key.sourcecraft.appsec.title_overview-sast_i4bAJ }}**).

    Чтобы скачать файлы SARIF (Static Analysis Results Interchange Format) или SBOM (Software Bill of Materials) в формате SPDX для аудита или интеграции с внешними системами, нажмите кнопку **Скачать SARIF** или **Скачать SBOM** на нужном дашборде.

    Также в центре контроля уязвимостей отображается время последнего сканирования.
