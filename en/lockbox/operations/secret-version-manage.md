# Secret version control

Managing secrets enables you to:

- [Secret version control](#secret-version-control)
   - [Creating new version {#create-version}](#create-version)
   - [Getting information about a version {#get-version}](#get-version)
   - [Creating a version based on other version {#create-version-based-on-other}](#create-version-based-on-other)
   - [Rolling back to a version {#backup}](#roll-back-to-backup-version)
   - [Set version deleting time {#set-deleting-time}](#set-deleting-time-set-deleting-time)

## Creating a new version {#create-version}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
   1. Under **Versions**, click **Add version**.
   1. Add the following parameters:
      * (optional) **Description**: Version description.
      * **Key**: Secret key.
      * **Value**: Secret value.
   1. Click **Add version**.

{% endlist %}

## Getting information about a version {#get-version}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
   1. Under **Versions**, you'll see a list of all secret versions with information about them.
   1. Click a version to see the details about its key-value pairs.

{% endlist %}

## Creating a version based on another version {#create-version-based-on-other}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Create a new version based on this one**.
   1. Edit or add the following parameters:
      * **Description**: Version description.
      * **Key**: Secret key.
      * **Value**: Secret value.
   1. Click **Add version**.

{% endlist %}

## Rolling back to a version {#backup}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Roll back to this version**.
   1. Click **Roll back**.

{% endlist %}

## Scheduling version destruction {#set-deleting-time}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the secret belongs to.
   1. In the list of services, select **{{ lockbox-short-name }}**.
   1. Click the name of the desired secret.
   1. Under **Versions**, click ![image](../../_assets/horizontal-ellipsis.svg) next to the appropriate version.
   1. Select **Schedule destruction**.
   1. Enter the time until destruction.
   1. Click **Schedule**.

{% endlist %}
