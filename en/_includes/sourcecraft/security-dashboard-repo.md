To open the security dashboard for a [repository]({{ link-src-docs }}/sourcecraft/concepts/#repos):
1. Open the {{ src-name }} [home page]({{ link-src-main }}).
1. On the ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** tab, navigate to ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.mainApp.route_repositories_hzdYT }}** and select a repository.
1. Under ![image](../../_assets/console-icons/shield-exclamation.svg) **{{ ui-key.sourcecraft.mainApp.route_security_4Dbxc }}** on the repository page, go to ![image](../../_assets/console-icons/circles-4-square.svg) **{{ ui-key.sourcecraft.mainApp.route_security-overview_dQuX9 }}**.

    The **{{ ui-key.sourcecraft.appsec.title_overview-secrets_c6BUu }}**, **{{ ui-key.sourcecraft.appsec.title_overview-sca_nxbV5 }}**, and **{{ ui-key.sourcecraft.appsec.title_overview-sast_i4bAJ }}** dashboards provide the following statistics:
    * **{{ ui-key.sourcecraft.appsec.title_alert-status_8gX2y }}**.
    * **{{ ui-key.sourcecraft.appsec.title_resolved-alerts_cUQ2s }}**.
    * **{{ ui-key.sourcecraft.appsec.title_security-risks_mkLFM }}** (**{{ ui-key.sourcecraft.appsec.title_overview-sca_nxbV5 }}** and **{{ ui-key.sourcecraft.appsec.title_overview-sast_i4bAJ }}** dashboards).

    To download SARIF (Static Analysis Results Interchange Format) or SBOM (Software Bill of Materials) files in SPDX format for audit or integration with external systems, click **Download SARIF** or **Download SBOM** on the dashboard.

    The security dashboard also shows the last scan time.
