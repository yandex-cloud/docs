# Подключение капчи в React

Для подключения {{ captcha-name }} в React можно использовать npm-пакет `@yandex/smart-captcha`.

## Установка пакета {#install-packet}

Выполните внутри вашего проекта:

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

## Состав пакета {#package-content}

Пакет предоставляет два компонента для работы со {{ captcha-name }}:

Компонент | Описание
--- | ---
`SmartCaptcha`          | Компонент для валидации пользователя на сайтах с кнопкой **Я не робот** ([обычная капча](./validation.md#usual-captcha)).
`InvisibleSmartCaptcha` | Компонент для валидации пользователя на сайтах без кнопки **Я не робот** ([невидимая капча](./validation.md#invisible-captcha)).

### Компонент SmartCaptcha {#smartcaptcha-component}

Список доступных свойств:

Свойство | Тип | Описание
--- | --- | ---
`sitekey`            | `string`                                  | Ключ клиента.
`language`           | `ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined` | Язык виджета.
`test`               | `boolean` \| `undefined`                  | Запуск капчи в тестовом режиме. Пользователь всегда будет получать задание. Используйте это свойство только для отладки и тестирования.
`webview`               | `boolean` \| `undefined`                  | Запуск капчи в **WebView**. Используется для повышения точности оценки пользователей при добавлении капчи в мобильные приложения с помощью **WebView**.
`onChallengeVisible` | `() => void` \| `undefined`               | Метод вызывается, когда появляется всплывающее окно с заданием.
`onChallengeHidden`  | `() => void` \| `undefined`               | Метод вызывается, когда закрывается всплывающее окно с заданием.
`onNetworkError`     | `() => void` \| `undefined`               | Метод вызывается, когда происходит ошибка сети.
`onSuccess`          | `(token: string) => void` \| `undefined`  | Метод вызывается, когда пользователь успешно прошел проверку. Аргумент для обработчика — уникальный токен пользователя.

Пример использования `SmartCaptcha`:

```ts
import { SmartCaptcha } from '@yandex/smart-captcha';

export const ComponentWithCaptcha = () => {
  const [token, setToken] = useState('');

  return <SmartCaptcha sitekey="<ключ_клиента>" onSuccess={setToken} />;
};
```

### Компонент InvisibleSmartCaptcha {#invisiblesmartcaptcha-component}

Список доступных свойств:

Свойство | Тип | Описание
--- | --- | ---
`sitekey`            | `string`                                  | Ключ клиента.
`visible`            | `boolean` \| `undefined`                  | Показывать задание пользователю.
`language`           | `ru` \| `en` \| `be` \| `kk` \| `tt` \| `uk` \| `uz` \| `tr` \| `undefined` | Язык виджета.
`test`               | `boolean` \| `undefined`                  | Запуск капчи в тестовом режиме. Пользователь всегда будет получать задание. Используйте это свойство только для отладки и тестирования.
`webview`               | `boolean` \| `undefined`                  | Запуск капчи в **WebView**. Используется для повышения точности оценки пользователей при добавлении капчи в мобильные приложения с помощью **WebView**.
`shieldPosition`     | `top-left` \| `center-left` \| `bottom-left` \| `top-right` \| `center-right` \| `bottom-right` \| `undefined` | Расположение [блока](invisible-captcha.md#data-processing-notice) с уведомлением об обработке данных.
`hideShield`         | `boolean` \| `undefined` | Скрыть [блок](invisible-captcha.md#data-processing-notice) с уведомлением об обработке данных.
`onChallengeVisible` | `() => void` \| `undefined`               | Метод вызывается, когда появляется всплывающее окно с заданием.
`onChallengeHidden`  | `() => void` \| `undefined`               | Метод вызывается, когда закрывается всплывающее окно с заданием.
`onNetworkError`     | `() => void` \| `undefined`               | Метод вызывается, когда происходит ошибка сети.
`onSuccess`          | `(token: string) => void` \| `undefined`  | Метод вызывается, когда пользователь успешно прошел проверку. В качестве аргумента обработчик получает уникальный токен пользователя.

{% include [warning-hideshield](../../_includes/smartcaptcha/warning-hideshield.md) %}

Пример использования `InvisibleSmartCaptcha`:

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
        sitekey="<ключ_клиента>"
        onSuccess={setToken}
        onChallengeHidden={handleChallengeHidden}
        visible={visible}
      />
    </>
  );
};
```

### Подписки на события {#event-subscription}

Оба компонента предоставляют методы для [подписки](./widget-methods.md#subscribe) на события в виджете:

* `onChallengeVisible`
* `onChallengeHidden`
* `onNetworkError`
* `onSuccess`

Эти методы можно использовать, например, чтобы вызвать функцию, когда пользователю показалось задание.

Пример подписки на события:

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

  return (
    <>
      Status: {status}
      <SmartCaptcha
        sitekey="<your sitekey>"
        onChallengeVisilbe={handleChallengeVisible}
        onChallengeHidden={handleChallengeHidden}
        onNetworkError={handleNetworkError}
        onSuccess={handleSuccess}
      />
    </>
  );
};
```
