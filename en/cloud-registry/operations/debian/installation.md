---
title: Configuring the APT package manager for {{ cloud-registry-full-name }}
description: Follow this guide to configure APT for {{ cloud-registry-name }}.
---

# Configuring the APT package manager

This guide describes how to connect the [APT package manager](https://en.wikipedia.org/wiki/APT_(software)) (Advanced Package Tool) to a [Debian registry](../../concepts/artifacts/debian.md) in {{ cloud-registry-full-name }}.

## Preparing a GPG key {#prepare-gpg-key}

A GPG key is required for a registry with signed metadata. The signature allows clients to verify the authenticity of packages.

1. Generate a GPG key using [GnuPG](https://www.gnupg.org/download/index.html):

    ```bash
    gpg --full-generate-key
    ```

    When prompted for `passphrase`, leave this field empty.

1. Retrieve the ID of the GPG key you created:

    ```bash
    gpg --list-secret-keys --keyid-format=long
    ```

    Result:

    ```text
    /home/user/.gnupg/secring.gpg
    ------------------------------
    sec   4096R/<GPG_key_ID> 2024-01-01 [expires: 2026-01-01]
    uid                          User Name <user@example.com>
    ssb   4096R/XXXXXXXXXXXXXXXX 2024-01-01
    ```

1. Export the secret part of the GPG key:

    ```bash
    gpg --armor --export-secret-keys <GPG_key_ID>
    ```

1. Save the secret part of the GPG key in a [{{ lockbox-full-name }}](../../../lockbox/) secret under the `gpg_secret_key_value` key:

    ```bash
    yc lockbox secret create \
      --name <secret_name> \
      --payload "[{'key': 'gpg_secret_key_value', 'text_value': '$(gpg --armor --export-secret-keys <GPG_key_ID>)'}]"
    ```

1. Grant access to the secret contents to the {{ cloud-registry-name }} service agent by assigning it the `lockbox.payloadViewer` role for this secret:

    ```bash
    yc lockbox secret add-access-binding \
      --id <secret_ID> \
      --role lockbox.payloadViewer \
      --agent cloud-registry:control-plane \
      --cloud-id <cloud_ID>
    ```

1. Save the public part of the GPG key. Registry users will need this value:

    ```bash
    gpg --armor --export <GPG_key_ID> > public-key.asc
    ```

## Configuring APT {#configure-apt}

To configure APT, add:
* Registry to the APT sources list.
* Authentication data to the `/etc/apt/auth.conf` file.

Your method of adding a registry to the APT sources list will vary depending on registry format and source type.

### Adding a registry to the APT sources list {#apt}

#### Local registry {#local}

{% list tabs %}

- With metadata signing

    1. Copy the public GPG key to the directory with APT trusted keys:

        ```bash
        cp /path/to/public-key.asc /usr/share/keyrings/ycr-pub.asc
        ```

        Where `/path/to/public-key.asc` is the path to the public GPG key file.

    1. Add the registry to the `APT` sources list:

        ```bash
        echo "deb [signed-by=/usr/share/keyrings/ycr-pub.asc] https://{{ cloud-registry }}/debian/<registry_ID> <distribution> <component>" \
          >> /etc/apt/sources.list
        ```

- Without metadata signing

    Add a registry with `trusted=yes`:

    ```bash
    echo "deb [trusted=yes] https://{{ cloud-registry }}/debian/<registry_ID> <distribution> <component>" \
      >> /etc/apt/sources.list
    ```

{% endlist %}

#### Remote registry {#remote}

{% list tabs %}

- Public source

    1. Install the package with the distribution public keys:

        * For Debian:

            ```bash
            sudo apt install debian-archive-keyring
            ```

            The key will be available at `/usr/share/keyrings/debian-archive-keyring.gpg`.

        * For Ubuntu:

            ```bash
            sudo apt install ubuntu-keyring
            ```

            The key will be available at `/usr/share/keyrings/ubuntu-archive-keyring.gpg`.

    1. Add the registry to the `APT` sources list:

        ```bash
        echo "deb [signed-by=<path_to_key>] https://{{ cloud-registry }}/debian/<registry_ID> <distribution> <component>" \
          >> /etc/apt/sources.list
        ```

        Where:
        * `<path_to_key>`: Path to the distribution key file, e.g., `/usr/share/keyrings/debian-archive-keyring.gpg` or `/usr/share/keyrings/ubuntu-archive-keyring.gpg`.
        * `<registry_ID>`: Registry ID.
        * `<distribution>`: Distribution, e.g., `bookworm`, `bullseye`, or `focal`.
        * `<component>`: Repository component, e.g., `main`.

- Custom source

    {% list tabs %}

    - Signed with a GPG key

        1. Save a GPG key to the trusted keys directory:

            ```bash
            cp /path/to/upstream-public-key.asc /usr/share/keyrings/upstream-pub.asc
            ```

            Where `/path/to/upstream-public-key.asc` is the path to the public key file of the source repository (`upstream`).

        1. Add the registry to the `APT` sources list:

            ```bash
            echo "deb [signed-by=/usr/share/keyrings/upstream-pub.asc] https://{{ cloud-registry }}/debian/<registry_ID> <distribution> <component>" \
              >> /etc/apt/sources.list
            ```

    - Not signed with a GPG key

        Specify the `trusted=yes` parameter for APT to accept unauthenticated packages:

        ```bash
        echo "deb [trusted=yes] https://{{ cloud-registry }}/debian/<registry_ID> <distribution> <component>" \
          >> /etc/apt/sources.list
        ```

    {% endlist %}

{% endlist %}

### Adding authentication credentials {#auth}

{% include [apt-auth-conf-warning](../../../_includes/cloud-registry/apt-auth-conf-warning.md) %}

1. {% include [auth-env](../../../_includes/cloud-registry/auth-env.md) %}

1. {% include [apt-auth-conf](../../../_includes/cloud-registry/apt-auth-conf.md) %}

#### Useful links {#see-also}

* [{#T}](push.md)
* [{#T}](pull.md)

[*api-key-scope]: {% include notitle [api-key-scope](../../../_popups/iam/api-key-scope.md) %}
