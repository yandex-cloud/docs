# Использование ES-модулей в функции на Node.js

Сейчас функции на Node.js всегда запускаются в режиме [CommonJS](https://nodejs.org/docs/latest/api/modules.html#modules-commonjs-modules), 
т.е. предполагают использование `require()` для подключения зависимостей.
Чтобы писать код функции в более современном формате [ES-модулей](https://nodejs.org/docs/latest-v17.x/api/esm.html#modules-ecmascript-modules), 
а также подключать npm пакеты, которые опубликованы [только](https://gist.github.com/sindresorhus/a39789f98801d908bbc7ff3ecc99d99c) в формате ES-модулей,
необходима небольшая настройка.

### Пример ошибки
Если создать функцию и подключить, например, пакет [node-fetch](https://www.npmjs.com/package/node-fetch) версии 3+:
```js
const fetch = require('node-fetch');

exports.handler = (event, context) => { 
  return { body: 'hello esm!' };
};
```
то при вызове будет ошибка:
```
Must use import to load ES Module: /function/code/node_modules/node-fetch/src/index.js
```

Если же заменить `require()` на `import`:
```js
import fetch from 'node-fetch';

exports.handler = (event, context) => { 
  return { body: 'hello esm!' };
};
```
то получим другую ошибку:
```
Cannot use import statement outside a module
```

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
cjs
  index.js
  package.json
index.js
package.json
```

После запуска такой функции в ответе получаем `hello esm!`. Ошибки пропали, ES-модули работают.

## TypeScript
Если вы пишите на TypeScript, для компиляции функции в ES-модулях нужно сделать следующее:

1. Проделать все шаги из пункта выше (только вместо корневого `index.js` будет `index.ts`) 
2. В файле `tsconfig.json` указать `"module": "es2020"` 
3. При импорте файлов везде добавить расширение `.js` ([для чего это нужно](https://github.com/microsoft/TypeScript/issues/16577#issuecomment-754941937))
4. Чтобы при компиляции автоматически копировался файл `cjs/index.js`, можно выставить в `tsconfig.json` настройку `"allowJs": true`
5. И наконец, чтобы автоматически забирать `cjs/package.json` можно выставить в `tsconfig.json` настройку `"resolveJsonModule": true`. 
А в файле `cjs/index.js` просто использовать reference:
   ```js
   /// <reference path="./package.json" />

   exports.handler = async (...args) => {
     const { handler } = await import('../index.js');
     return handler(...args);
   }
   ```

Финальная файловая структура:
```
cjs
  index.js
  package.json
index.ts
package.json
tsconfig.json
```

После компиляции через команду `tsc` получится код функции в ES-модулях, готовый к загрузке в облако.
