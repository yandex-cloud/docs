To open the security dashboard for an [organization]({{ link-src-docs }}/sourcecraft/concepts/#org):
1. Open the {{ src-name }} [home page]({{ link-src-main }}).
1. Go to the ![image](../../_assets/console-icons/briefcase.svg) **{{ ui-key.sourcecraft.lib.organizations_5CjkW }}** tab and select an organization.
1. Under ![image](../../_assets/console-icons/shield-exclamation.svg) **{{ ui-key.sourcecraft.mainApp.route_security_4Dbxc }}**, navigate to ![image](../../_assets/console-icons/circles-4-square.svg) **{{ ui-key.sourcecraft.mainApp.route_security-overview_dQuX9 }}**.

    The **{{ ui-key.sourcecraft.appsec.title_secrets-scanning_qjZ4J }}**, **{{ ui-key.sourcecraft.appsec.title_sca_djQmF }}**, and **{{ ui-key.sourcecraft.appsec.title_sast_aUyTA }}** dashboards provide the following statistics:
    * **{{ ui-key.sourcecraft.appsec.title_alert-status_8gX2y }}**.
    * **{{ ui-key.sourcecraft.appsec.title_resolved-alerts_cUQ2s }}**.
    * **{{ ui-key.sourcecraft.appsec.title_security-risks_mkLFM }}** (**{{ ui-key.sourcecraft.appsec.title_sca_djQmF }}** and **{{ ui-key.sourcecraft.appsec.title_sast_aUyTA }}** dashboards).

    To access detailed lists of issues of a specific type, click ![image](../../_assets/console-icons/arrow-up-right-from-square.svg) next to the dashboard header.

    This page also provides a full list of detected security issues with the following information:
    * Repository name.
    * Issue type.
    * Scanner that detected the problem.
    * Last scan time.
    * Warning data.
