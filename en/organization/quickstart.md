# Getting started with {{ org-name }}

To get started, create an organization and add users to it.

_Organization_ is a workspace that combines different types of {{ yandex-cloud }} resources and users. [Learn more about organizations, resources, and users](../overview/roles-and-resources.md).

You can manage organization settings in the **{{ ui-key.yacloud_org.layout.organization }}** section of the [{{ cloud-center }} interface]({{ cloud-center-link }}).

Before you start using {{ org-full-name }}, [log in]({{ link-passport }}) to your Yandex account. If you do not have an account, [create]({{ support-passport-create }}) one.

## Create an organization {#create}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [create-new-org](../_includes/organization/create-new-org.md) %}

{% endlist %}

After registering, you will become the organization owner. You will be able to manage employee accounts, connect and disconnect services.

## Add employees {#add-users}

To grant your employees access to the organization's services, connect them using their Yandex accounts. If your company already uses a different account management system (such as Active Directory or Google Workspace), configure an identity federation so that your employees can use their work accounts to access {{ yandex-cloud }} services.

{% include [console-user-access](../_includes/organization/console-user-access.md) %}

### Connect employees with Yandex accounts {#add-ya-users}

If your employees have Yandex accounts, e.g., `{{ login-example }}`, they can use them to access {{ yandex-cloud }} services enabled in your organization.

To connect employees with Yandex accounts:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [add-yandex-user](../_includes/organization/add-yandex-user.md) %}

{% endlist %}

The users will be connected to the organization upon accepting the invitation via the emailed link and selecting an account for log-in.

### Configure an identity federation {#add-federation}

An identity federation is a technology that allows you to implement a Single Sign-On (SSO) authentication scheme and use corporate accounts to log in to {{ org-full-name }}. In this case, your corporate account management system acts as an identity provider (IdP).

To configure your identity federation, follow these steps:

* Set up the configurations in {{ yandex-cloud }}:

    {% list tabs group=instructions %}

    - {{ cloud-center }} interface {#cloud-center}

      1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

      1. In the left-hand panel, select ![icon-federation](../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

      1. Click ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}** in the top-right corner of the page. In the window that opens:

          1. Enter the federation name and description.

          1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

          1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, specify the IdP server ID to use for authentication. While authenticating the user, the IdP server must send the same ID in its response to {{ org-name }}.

              {% note info %}

              ID format depends on the type of IdP server you use (for example, Active Directory or Google Workspace).

              {% endnote %}

          1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** field, choose **POST**.

          1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, specify the address of the page to which the browser redirects the user for authentication.

          1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to add authenticated users to your organization automatically.
         
             If you do not enable this option, you will need to [manually add](operations/add-account.md#add-user-sso) your federated users.

          1. Click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

    {% endlist %}

* Configure the identity provider's server to transmit successful authentication information and user attributes to {{ yandex-cloud }}.

   User attributes supported by {{ org-full-name }} services are listed in identity federation setup guides for different identity providers:

   * [Active Directory](./tutorials/federations/integration-adfs.md).
   * [Google Workspace](./tutorials/federations/integration-gworkspace.md).
   * [Microsoft Entra ID](./tutorials/federations/integration-azure.md).
   * [Keycloak](./tutorials/federations/integration-keycloak.md).
   * [Other SAML-compatible identity providers](./operations/setup-federation.md)