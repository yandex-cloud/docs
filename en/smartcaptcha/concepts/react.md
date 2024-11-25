# Connecting a CAPTCHA in React

To connect {{ captcha-name }} in React, you can use the `@yandex/smart-captcha` _npm_ package.

## Installing the package {#install-packet}

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

Component | Description
--- | ---
`SmartCaptcha`          | Website user validation component with the **"I’m not a robot"** button ([standard CAPTCHA](./validation.md#usual-captcha)).
`InvisibleSmartCaptcha` | Website user validation component without the **"I’m not a robot"** button ([invisible CAPTCHA](./validation.md#invisible-captcha)).

### SmartCaptcha component {#smartcaptcha-component}

Available properties:

#|
||**Property**|**Type**|**Description**||
||`sitekey`|`string`|Client key.||
||`visible`|`boolean` \| `undefined`|Show a challenge to the user.||
||`language`|`ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined`|Widget language.||
||`test`|`boolean` \| `undefined`|Launching CAPTCHA in test mode. The user will always get a challenge. Use this property for debugging and testing only.||
||`webview`|`boolean` \| `undefined`|Launching CAPTCHA in **WebView**. You can use it to make user response validation more precise when adding CAPTCHA to mobile apps via **WebView**.||
||`shieldPosition`| `top-left` \| `center-left` \| `bottom-left` \| `top-right` \| `center-right` \| `bottom-right` \| `undefined`|Position of the [shield](invisible-captcha.md#data-processing-notice) with data processing notice.||
||`hideShield`|`boolean` \| `undefined` |Hide the [shield](invisible-captcha.md#data-processing-notice) with data processing notice.||
||`onChallengeVisible`|`() => void` \| `undefined`|The method is invoked when a pop-up window with a challenge appears.||
||`onChallengeHidden`|`() => void` \| `undefined`|The method is invoked when a pop-up window with a challenge closes.||
||`onNetworkError`|`() => void` \| `undefined`|The method is invoked when a network error occurs.||
||`onJavascriptError`|`(error: { filename: string, message: string,`
`col: number, line: number }) => void` \| `undefined`
|
The method is invoked when a JavaScript critical error occurs.||
||`onSuccess`|`(token: string) => void` \| `undefined`|The method is invoked when the user has successfully passed the check. The handler gets a unique user token as an argument.||
||`onTokenExpired`|`() => void` \| `undefined`|The method is invoked when the token obtained by the user after passing the verification gets invalidated.||
|#

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

#|
||**Property**|**Type**|**Description**||
||`sitekey`|`string`|Client key.||
||`visible`|`boolean` \| `undefined`|Show a challenge to the user.||
||`language`|`ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined`|Widget language.||
||`test`|`boolean` \| `undefined`|Launching CAPTCHA in test mode. The user will always get a challenge. Use this property for debugging and testing only.||
||`webview`|`boolean` \| `undefined`|Launching CAPTCHA in **WebView**. You can use it to make user response validation more precise when adding CAPTCHA to mobile apps via **WebView**.||
||`shieldPosition`| `top-left` \| `center-left` \| `bottom-left` \| `top-right` \| `center-right` \| `bottom-right` \| `undefined`|Position of the [shield](invisible-captcha.md#data-processing-notice) with data processing notice.||
||`hideShield`|`boolean` \| `undefined` |Hide the [shield](invisible-captcha.md#data-processing-notice) with data processing notice.||
||`onChallengeVisible`|`() => void` \| `undefined`|The method is invoked when a pop-up window with a challenge appears.||
||`onChallengeHidden`|`() => void` \| `undefined`|The method is invoked when a pop-up window with a challenge closes.||
||`onNetworkError`|`() => void` \| `undefined`|The method is invoked when a network error occurs.||
||`onJavascriptError`|`(error: { filename: string, message: string,`
`col: number, line: number }) => void` \| `undefined`
|
The method is invoked when a JavaScript critical error occurs.||
||`onSuccess`|`(token: string) => void` \| `undefined`|The method is invoked when the user has successfully passed the check. The handler gets a unique user token as an argument.||
||`onTokenExpired`|`() => void` \| `undefined`|The method is invoked when the token obtained by the user after passing the verification gets invalidated.||
|#

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
* `onJavascriptError`
* `onSuccess`
* `onTokenExpired`

You can use these methods, for example, to invoke a function when a challenge is shown to the user.

Example of a subscription to events:

```ts
import { SmartCaptcha, SmartCaptchaProps } from '@yandex/smart-captcha';

export const SubscriptionToCaptcha = () => {
  const [token, setToken] = useState('');
  const [status, setStatus] = useState('hidden');

  const handleChallengeVisible = useCallback(() => setStatus('visible'), []);
  const handleChallengeHidden = useCallback(() => setStatus('hidden'), []);

  const handleSuccess = useCallback((token: string) => {
    setStatus('success');
    setToken(token);
  }, []);
  const handleTokenExpired = useCallback(() => {
    setStatus('token-expired');
    setToken('');
  }, []);

  const handleNetworkError: SmartCaptchaProps['onNetworkError'] = useCallback(() => setStatus('network-error'), []);

  const handleJavaScriptError: SmartCaptchaProps['onJavascriptError'] = useCallback((error) => {
    setStatus('javascript-error');
    logError(error);
  }, []);

  return (
    <>
      Status: {status}
      <SmartCaptcha
        sitekey="<client_key>"
        onChallengeVisible={handleChallengeVisible}
        onChallengeHidden={handleChallengeHidden}
        onNetworkError={handleNetworkError}
        onJavascriptError={handleJavaScriptError}
        onSuccess={handleSuccess}
        onTokenExpired={handleTokenExpired}
      />
    </>
  );
};
```

{% include [javascript-error](../../_includes/smartcaptcha/javascript-error.md) %}

## Resetting a {{ captcha-name }} state {#reset-status}

A CAPTCHA retains its state after a user is [validated](validation.md). To enable a user to pass validation again, configure a state reset. If this is not done, a repeat request will be sent to the server with the same one-time token as the first time.

State reset configuration example:

```ts
import { SmartCaptcha } from "@yandex/smart-captcha";
import { useState } from "react";

export default function App() {

  const [resetCaptcha, setResetCaptcha] = useState(0);

  /* Update the state */
  const handleReset = () => setResetCaptcha((prev) => prev + 1);

  return (
    <div className="App">
      <SmartCaptcha
        key={resetCaptcha}
        sitekey="<client_key>"
      \>
    <div\>
  );
}
```
