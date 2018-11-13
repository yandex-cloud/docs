# Hosting setup

---

**[!TAB Management console]**

1. In the management console, go to the bucket you want to configure hosting for.
2. Make sure public access is allowed to the bucket. If not, follow the instructions [[!TITLE]](../operations/security/bucket-availability.md).
1. In the left pane, select **Website**.
2. Set up hosting or redirects in the corresponding section of the settings.
    - When setting up hosting, specify:
      - The website's home page.
      - The page to be displayed to the user in the event of 4xx errors. Optional.
    - When setting up redirects, specify:
      - The host where all requests to the current bucket will be redirected.
      - The protocol if the specified host accepts requests strictly over a specific protocol.

---

