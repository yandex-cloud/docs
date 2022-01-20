# Использование ES-модулей в функции на Node.js

Сейчас функции на Node.js всегда запускаются в режиме [CommonJS](https://nodejs.org/docs/latest/api/modules.html#modules-commonjs-modules), т.е. предполагают использование `require()` для подключения зависимостей. Чтобы писать код функции в новом формате [ES-модулей](https://nodejs.org/docs/latest-v17.x/api/esm.html#modules-ecmascript-modules), а также подключать npm пакеты, которые опубликованы [только](https://gist.github.com/sindresorhus/a39789f98801d908bbc7ff3ecc99d99c) в формате ES-модулей, необходима небольшая настройка.

## Настройка ES-модулей в функции
Чтобы ES-модули заработали в функции, нужно сделать следующее:

1. Добавить в корневой `package.json` поле `type: "module"` 
2. Создать `index.js` в формате esm:
   ```js
   import fetch from 'node-fetch';
   
   export const handler = (event, context) => { 
     return { body: 'hello esm!' };
   }
   ```

3. Добавить отдельную папку (например, `cjs`) и создать в ней ещё один `package.json` с единственным полем:
   ```json
   {
     "type": "commonjs"
   }
   ```
4. Рядом положить `cjs/index.js` в формате `commonjs`. Именно он служит универсальным мостиком между `commonjs` и `esm`:
   ```js
   exports.handler = async (...args) => {
     const { handler } = await import('../index.js');
     return handler(...args);
   };
   ```
6. В настройках функции установить точку входа: `cjs/index.handler`
7. В настройках функции установить runtime `nodejs12` и выше

Финальная файловая структура:
```
cjs/
  index.js
  package.json
index.js
package.json
```

После запуска такой функции в ответе получаем `hello esm!`. Ошибки пропали, ES-модули работают.

## TypeScript
Если вы пишите на TypeScript, для компиляции функции в ES-модулях нужно сделать следующее:

1. Проделать все шаги из раздела выше (только вместо корневого `index.js` будет `index.ts`) 
2. В файле `tsconfig.json` указать `"module": "es2020"` 
3. При импорте файлов везде использвать полный путь с расширением `.js` ([обсуждение, почему так](https://github.com/microsoft/TypeScript/issues/16577#issuecomment-754941937))
4. Чтобы при компиляции автоматически копировался файл `cjs/index.js`, можно выставить в `tsconfig.json` настройку `"allowJs": true`
5. И наконец, чтобы автоматически забирать `cjs/package.json` можно выставить в `tsconfig.json` настройку `"resolveJsonModule": true`. А в файле `cjs/index.js`  использовать reference:
   ```js
   /// <reference path="./package.json" />

   exports.handler = async (...args) => {
     const { handler } = await import('../index.js');
     return handler(...args);
   }
   ```

Финальная файловая структура:
```
cjs/
  index.js
  package.json
index.ts
package.json
tsconfig.json
```

После компиляции через команду `tsc` получится код функции в ES-модулях, готовый к запуску в облаке.

Полный код всех файлов можно посмотреть [в примере на GitHub](https://github.com/yandex-cloud/examples/tree/master/serverless/functions/typescript-esm).
