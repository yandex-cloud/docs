# Создание функции Node.js с помощью TypeScript

Node.js не поддерживает [TypeScript](https://www.typescriptlang.org/) из коробки. Перед тем как загружать код на TypeScript в {{ sf-name }}, его необходимо скомпилировать в JavaScript.

1. Установите [Node.js](https://nodejs.org/ru/).
1. Откройте директорию с вашим проектом.
1. Установите [TypeScript](https://www.typescriptlang.org/download):
   {% list tabs group=node_manager %}
   - NPM {#npm}
        ```bash
        npm install typescript --save-dev
        ```
   - Yarn {#yarn}
        ```bash
        yarn add -D typescript
        ```
   {% endlist %}
1. Создайте конфигурацию Typescript:
   ```bash
       npx tsc --init --preserveConstEnums --moduleResolution Node --isolatedModules --outDir build --strict false --target ES2021
   ```

    Чтобы использовать другую версию JavaScript, измените значение аргумента `target`. Максимальное значение версии JavaScript, которое можно указать, зависит от используемой версии Node.js:
    | Версия Node.js | Максимальная версия JavaScript |
    |----|----|
    | 12 | ES2019 |
    | 14 | ES2020 |
    | 16 | ES2021 |

1. Скомпилируйте функцию:
    ```bash
    npx tsc
    ```
1. В проекте появится директория `build`. Добавьте её содержимое в ZIP-архив.
1. [Создайте функцию](../../functions/operations/function/function-create.md).
1. [Создайте версию функции](../../functions/operations/function/version-manage.md).
