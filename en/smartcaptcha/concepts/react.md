# Connecting a CAPTCHA in React

To connect {{ captcha-name }} in React, you can use the `@yandex/smart-captcha` npm package.

## Install the package {#install-packet}

In your project, run:

{% list tabs %}

- npm

   ```bash
   npm i -PE @yandex/smart-captcha
   ```

- yarn

   ```bash
   yarn add @yandex/smart-captcha
   ```

- pnpm

   ```bash
   pnpm add @yandex/smart-captcha
   ```

{% endlist %}

## Package contents {#package-content}

The package provides two components to work with {{ captcha-name }}:

| Component | Description |
--- | ---
| `SmartCaptcha` | The component for user validation on websites with the **"I’m not a robot"** button ([standard CAPTCHA](./validation.md#usual-captcha)). |
| `InvisibleSmartCaptcha` | The component for user validation on websites without the **"I’m not a robot"** button ([invisible CAPTCHA](./validation.md#invisible-captcha)). |

### SmartCaptcha component {#smartcaptcha-component}

Available properties:

| Property | Type | Description |
--- | --- | ---
| `sitekey` | `string` | Client key. |
| `language` | `ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined` | Widget language. |
| `test` | `boolean` \| `undefined` | Launching CAPTCHA in test mode. The user will always get a task. Use this property for debugging and testing only. |
| `webview` | `boolean` \| `undefined` | Launching CAPTCHA in **WebView**. It is used to make user response validation more precise when adding CAPTCHA to mobile apps via **WebView**. |
| `onChallengeVisible` | `() => void` \| `undefined` | The method is invoked when a pop-up window with a task appears. |
| `onChallengeHidden` | `() => void` \| `undefined` | The method is invoked when a pop-up window with a task closes. |
| `onNetworkError` | `() => void` \| `undefined` | The method is invoked when a network error occurs. |
| `onSuccess` | `(token: string) => void` \| `undefined` | The method is invoked when the user has successfully passed the check. As an argument, the handler gets a unique user token. |
| `onTokenExpired` | `() => void` \| `undefined` | The method is invoked when the token obtained by the user after passing the verification gets invalidated. |

`SmartCaptcha` usage example:

```ts
import { SmartCaptcha } from '@yandex/smart-captcha';

export const ComponentWithCaptcha = () => {
  const [token, setToken] = useState('');

  return <SmartCaptcha sitekey="<client_key>" onSuccess={setToken} />;
};
```

### InvisibleSmartCaptcha component {#invisiblesmartcaptcha-component}

Available properties:

| Property | Type | Description |
--- | --- | ---
| `sitekey` | `string` | Client key. |
| `visible` | `boolean` \| `undefined` | Show a task to the user. |
| `language` | `ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined` | Widget language. |
| `test` | `boolean` \| `undefined` | Launching CAPTCHA in test mode. The user will always get a task. Use this property for debugging and testing only. |
| `webview` | `boolean` \| `undefined` | Launching CAPTCHA in **WebView**. It is used to make user response validation more precise when adding CAPTCHA to mobile apps via **WebView**. |
| `shieldPosition` | `top-left` \| `center-left` \| `bottom-left` \| `top-right` \| `center-right` \| `bottom-right` \| `undefined` | Position of the [shield](invisible-captcha.md#data-processing-notice) with data processing notice. |
| `hideShield` | `boolean` \| `undefined` | Hide the [shield](invisible-captcha.md#data-processing-notice) with data processing notice. |
| `onChallengeVisible` | `() => void` \| `undefined` | The method is invoked when a pop-up window with a task appears. |
| `onChallengeHidden` | `() => void` \| `undefined` | The method is invoked when a pop-up window with a task closes. |
| `onNetworkError` | `() => void` \| `undefined` | The method is invoked when a network error occurs. |
| `onSuccess` | `(token: string) => void` \| `undefined` | The method is invoked when the user has successfully passed the check. The handler gets a unique user token as an argument. |
| `onTokenExpired` | `() => void` \| `undefined` | The method is invoked when the token obtained by the user after passing the verification gets invalidated. |

{% include [warning-hideshield](../../_includes/smartcaptcha/warning-hideshield.md) %}

`InvisibleSmartCaptcha` usage example:

```ts
import { InvisibleSmartCaptcha } from '@yandex/smart-captcha';

export const InvisibleCaptcha = () => {
  const [token, setToken] = useState('');
  const [visible, setVisible] = useState(false);

  const handleChallengeHidden = useCallback(() => setVisible(false), []);

  const handleButtonClick = () => setVisible(true);

  return (
    <>
      <button onClick={handleButtonClick}>Validate</button>
      <InvisibleSmartCaptcha
        sitekey="<client_key>"
        onSuccess={setToken}
        onChallengeHidden={handleChallengeHidden}
        visible={visible}
      />
    </>
  );
};
```

### Subscriptions to events {#event-subscription}

Both components provide methods for [subscribing](./widget-methods.md#subscribe) to events in the widget:

* `onChallengeVisible`
* `onChallengeHidden`
* `onNetworkError`
* `onSuccess`
* `onTokenExpired`

You can use these methods, for example, to invoke a function when a task is shown to the user.

Example of a subscription to events:

```ts
import { SmartCaptcha } from '@yandex/smart-captcha';

export const SubscriptionToCaptcha = () => {
  const [token, setToken] = useState('');
  const [status, setStatus] = useState('hidden');

  const handleChallengeVisible = useCallback(() => setStatus('visible'), []);
  const handleChallengeHidden = useCallback(() => setStatus('hidden'), []);
  const handleNetworkError = useCallback(() => setStatus('network-error'), []);
  const handleSuccess = useCallback((token: string) => {
    setStatus('success');
    setToken(token);
  }, []);
  const handleTokenExpired = useCallback(() => {
    setStatus('token-expired');
    setToken('');
  }, []);

  return (
    <>
      Status: {status}
      <SmartCaptcha
        sitekey="<your sitekey>"
        onChallengeVisible={handleChallengeVisible}
        onChallengeHidden={handleChallengeHidden}
        onNetworkError={handleNetworkError}
        onSuccess={handleSuccess}
        onTokenExpired={handleTokenExpired}
      />
    </>
  );
};
```
