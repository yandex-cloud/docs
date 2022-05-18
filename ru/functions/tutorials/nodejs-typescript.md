# Создание функции {{ sf-full-name }} с помощью TypeScript

Поскольку Node.js не поддерживает [TypeScript](https://www.typescriptlang.org/) нативно, вам придется скомпилировать код TypeScript в JavaScript. После этого вы сможете загрузить и выполнить вашу функцию в **{{ sf-name }}**.

## Настройка среды разработки
- Установите [Node.js](https://nodejs.org/ru/).

- Войдите в директорию с вашим проектом.
- Установите [esbuild](https://esbuild.github.io/):
```
npm install esbuild --save-dev
```
- Если вы хотите проверять ваш код перед сборкой, вам также понадобится компилятор TypeScript:
```
npm install tsc --save-dev
```

- Создайте (или дополните) файл [tsconfig.json](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html):
```
{  
  "compilerOptions": {  
    "target": "ES2019",  
    "preserveConstEnums": true,  
    "sourceMap": false,  
    "module": "CommonJS",  
    "noEmit": true,  
    "moduleResolution": "Node",  
    "esModuleInterop": true,  
    "skipLibCheck": true,  
    "forceConsistentCasingInFileNames": true,  
    "isolatedModules": true,  
  },  
  "exclude": [  
    "node_modules",  
    "**/*.test.ts"  
  ]  
}
```
Вы можете изменить значение поля `target`, если вы хотите использовать более новую версию JavaScript. Максимальное значение зависит от используемой версии Node.js:
| Версия Node.js | Максимальная версия |
|----|----|
| 12 | ES2019 |
| 14 | ES2020 |
| 16 | ES2021 |

- Создайте файл build.js и поместите в него следующий код:
```
const esbuild = require('esbuild')  
const pkg = require('./package.json')  
  
esbuild.buildSync({  
    bundle: true,  
  
    platform: "node",  
    external: Object.keys(pkg.dependencies),  
  
    entryPoints: ['index.ts'],  
    outfile: "build/index.js"  
})

fs.copyFileSync("package.json", "build/package.json")
```
Вместо `index.ts` подставьте путь к файлу, в котором находится точка входа вашей функции.

 ## Сборка функции {{ sf-name }}
 Если вы хотите проверить код перед сборкой, выполните:
 ```
 npx tsc
 ```

После этого запустите скрипт `build.js`:
```
node build.js
```

В папке проекта появится директория `build`. Заархивируйте её содержимое в zip-файл.

## Загрузка функции в {{ sf-full-name }}
{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  2. В списке сервисов выберите **{{ sf-name }}**.
  3. Нажмите кнопку **Создать функцию**.
  4. Введите имя и описание функции. Требования к имени:

      {% include [name-format](../../_includes/name-format.md) %}

  5. Нажмите кнопку **Создать**.
  6. В блоке **Редактор** выберите среду выполнения **Node.js** и нажмите **Продолжить**.
  7. В блоке **Способ** выберите **ZIP-архив**.
  8. Загрузите ваш архив в **{{ sf-name }}** и нажмите на кнопку **Создать версию**.

 {% endlist %}
