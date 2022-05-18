
# Building {{ sf-full-name }} using TypeScript

Because Node.js doesn't support [TypeScript](https://www.typescriptlang.org/) natively, you need to compile TypeScript code to JavaScript. Then you will be able to upload and run your function in **{{ sf-name }}**.

## Setting up a TypeScript development environment
- Install [Node.js](https://nodejs.org/ru/).

- Enter into your project's directory.
- Install [esbuild](https://esbuild.github.io/):
```
npm install esbuild --save-dev
```
- If you want to check your code before compilation, you need to install TypeScript Compiler:
```
npm install tsc --save-dev
```

- Create (or append) [tsconfig.json](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) file:
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
You can change the value of `target` field, if you want to use newer JavaScript version. Max value depends on Node.js version:
| Node.js version | Max ECMAScript version |
|----|----|
| 12 | ES2019 |
| 14 | ES2020 |
| 16 | ES2021 |

- Create build.js file and add this code to it:
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
Replace `index.ts` with the path to file that containing your function's entry point.

 ## Building function
  If you want to check the code before build, run:
 ```
 npx tsc
 ```

After this run `build.js` script:
```
node build.js
```

The `build` directory will appear in the project folder. Zip its contents into an archive.

## Uploading function to {{ sf-full-name }}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. In the list of services, select **{{ sf-name }}**.
  1. Click **Create function**.
  1. Enter a name and description for the function.
  1. Click **Create**.
  1. Under **Editor**, select the **Node.js** runtime environment and click **Continue**.
  1. Under **Method**, select **ZIP archive**, then specify your archive.
  1. In the upper-right corner of the **Editor** section, click **Create version**.

{% endlist %}
