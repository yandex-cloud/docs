---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Hosting setup

{{ objstorage-name }} lets you configure a bucket:

- For static website hosting.
- For request redirects.

{% list tabs %}

- Management console
  1. In the management console, go to the bucket you want to configure hosting for.
  2. Make sure public access is allowed to the bucket. If not, follow the instructions [{#T}](../buckets/bucket-availability.md).
  1. In the left pane, select **Website**.
  2. Set up hosting or redirects in the corresponding section of the settings.
      - When setting up hosting, specify:
        - The website homepage.
        - The page to be displayed to the user in the event of 4xx errors. Optional.
      - When setting up redirects, specify:
        - The host where all requests to the current bucket will be redirected.
        - The protocol if the specified host accepts requests strictly over a specific protocol.

{% endlist %}

