{% list tabs %}

- Authenticator app {#app-auth}

  1. Select **Authenticator app**.
  1. Use an application or service to generate one-time codes, for example:

     * [Yandex ID](https://yandex.ru/id/about)
     * [Google Authenticator](https://support.google.com/accounts/answer/1066447)
     * [Microsoft Authenticator](https://www.microsoft.com/ru-ru/security/mobile-authenticator-app)
     * [Multifactor](https://multifactor.pro/docs/saml/yandex-cloud-2fa/)
  1. Open the app and scan the QR code displayed on the screen.
  1. Enter the code from the app in the **Confirmation code** field.
  1. Click **Confirm**.

- Security key {#key-auth}

  1. Select [Security key](../../vpc/concepts/security-groups.md).
  1. Plug in a hardware security key, e.g., [Rutoken](https://www.rutoken.ru/) or [JaCarta](https://www.aladdin-rd.ru/catalog/jacarta), to your computer.
  1. Follow the prompts in your browser to register the key.
  1. Click **Confirm**.

- Biometrics {#bio-auth}

  1. Select **By face or fingerprint**.
  1. Follow the prompts in your browser to set up biometric authentication.
  1. Click **Confirm**.

{% endlist %}
