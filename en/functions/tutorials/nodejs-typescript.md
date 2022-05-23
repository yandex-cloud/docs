
  
# Building Node.js function using TypeScript

Because Node.js doesn't support [TypeScript](https://www.typescriptlang.org/) natively, you need to compile TypeScript code to JavaScript. Then you will be able to upload and run your function in **{{ sf-name }}**.

## Setting up a TypeScript development environment
- Install [Node.js](https://nodejs.org/ru/).

- Enter into your project's directory.
- Install [TypeScript](https://www.typescriptlang.org/download):
```
npm install typescript --save-dev
```

- Initialize a TypeScript project, run:
```
npx ts --init --preserveConstEnums --moduleResolution Node --isolatedModules --outDir build --strict false --target ES2021
```

You can change the value of `target` argument, if you want to use newer JavaScript version. Max value depends on Node.js version:
| Node.js version | Max ECMAScript version |
|----|----|
| 12 | ES2019 |
| 14 | ES2020 |
| 16 | ES2021 |

 ## Building function
  To compile your function, run:
 ```
npx tsc
 ```

The `build` directory will appear in the project folder. Zip its contents into an archive.

## [Upload function to {{ sf-full-name }}](../operations/function/version-manage.md)
