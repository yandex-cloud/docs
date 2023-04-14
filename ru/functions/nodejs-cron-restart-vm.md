# yandex-functions-restart-server
# Отказоустойчивая архитектура с прерываемыми Виртуальными Машинами на Cloud Functions.

Данный материал подходит для тех, кто хочет запустить не критичные нагрузки на Виртуальных Машинах, но при этом по-максимуму использовать тариф на прерываемые ресурсы.

## Отказоустойчивость не значит дорого:

Выгода от прерываемых Виртуальных Машин (ВМ) составляет в среднем более 65%.
Если вы используете 2 и более взаимозаменяемых ВМ для ваших ежедневных нагрузок, вы сможете обеспечить высокую доступность приложений с большой скидкой. Прерываемые машины позволят вам сэкономить более 65% от счета, при условии что содержимое ВМ может быть прервано в любой момент и сможет продолжить работу после перезапуска.

## Описание решения:

Сервис Cloud Functions позволяет описывать исполнять код через Функцию. Функция обращается к API Облака и запускает остановленные Виртуальные Машины. Функция выполняется по расписанию и автоматически возобновляет работу прерываемых ВМ, которые были остановлены по условиям скидки. 

**Плюсы:**
- Cloud Functions практически бесплатны для применения
- Существенная скидка на Виртуальные Машины

**Минусы:**
- Виртуальные машины могут быть остановлены без предупреждения
- Частота вызова Функции ограничена одной минутой

## Инструкция: 

Данная инструкция подразумевает что вы уже обладаете аккаунтом в Yandex.Cloud и запустили ВМ в сервисе ComputeCloud.

1. Создайте Функцию в Cloud Functions
2. Настройте триггеры для Cloud Functions 
3. Соберите переменные окружения
4. Добавьте код в Функцию
5. Протестируйте работу Функции 


### 1. Создайте Функцию 
- В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали сервисный аккаунт.
    1. Выберите сервис [Cloud functions]{{ sf-name }}.
        1. Создайте функцию:
        1. Нажмите кнопку Создать функцию.
        1. Введите имя функции `function-restart-vms`.
    1. Нажмите кнопку Создать.
        1. Создайте версию функции:
        1. Выберите среду выполнения Node.js-16, выключите опцию Добавить файлы с примерами кода и нажмите кнопку Продолжить.

### 2. Настройте триггеры для Cloud Functions
- Выберите сервис [Cloud functions]{{ sf-name }}.
- Перейдите на вкладку Триггеры
- Создайте триггер:
  1. Имя: `restart-trigger`
  1. Тип: `Таймер`
  1. Запускаемый ресурс: `Функция`
  1. Cron-выражение: `Каждую минуту`
  1. Настройки функции - `function-restart-vms`
  1. Тег версии функции - `$latest`
  1. Сервисный аккаунт - `ваш сервисный аккаунт`
- Нажмите кнопку Создать Триггер
	
### 3. Соберите переменные окружения
- Перейдите в сервис Compute Cloud
  1. FolderID
    + В адресной строке браузера скопируйте содержимое между console.cloud.yandex.ru/folders/.. и ../compute/instances, Например, `ia0fj4mrx8u055prqwdx`
  1. InstanceID
    + Скопируйте содержимое в колонке Идентификатор, Например, `3rp4wlh0ta83eg084zeyi`
  1. OAUTHToken
    + Для получения токена перейдите по ссылке https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token и выберите “запроса” к сервису Яндекс OAuth.

### 4. Добавьте код в функцию
	
- Вернитесь в сервис Cloud Functions
- В редакторе функции создайте версию для Node.js
- Уберите выбор “добавить файлы с примерами кода”. 
- Нажмите создать функцию
- Создайте файл `package.json`
- Добавьте Код

```
import { serviceClients, Session, cloudApi } from '@yandex-cloud/nodejs-sdk';

const {
    compute: {
        instance_service: {
            ListInstancesRequest,
            GetInstanceRequest,
            StartInstanceRequest,
        },
        instance: {
            IpVersion,
        },
    },
} = cloudApi;

const FOLDER_ID = process.env.FOLDER_ID;
const INSTANCE_ID = process.env.INSTANCE_ID;
const OAUTHTOKEN = process.env.OAUTHTOKEN;

export const handler = async function (event, context) {

    const session = new Session({ oauthToken: OAUTHTOKEN });
    const instanceClient = session.client(serviceClients.InstanceServiceClient);
    const list = await instanceClient.list(ListInstancesRequest.fromPartial({
        folderId: FOLDER_ID,
    }));
    const state = await instanceClient.get(GetInstanceRequest.fromPartial({
        instanceId: INSTANCE_ID,
    }));


    var status = state.status
    if (status == 4){
        const startcommand = await instanceClient.start(StartInstanceRequest.fromPartial({
            instanceId: INSTANCE_ID,
        }));
    }


    return {
        statusCode: 200,
        body: {
            status
        }
    };
};
```

- Создайте файл `package.json`
- Добавьте код

```
  "name": "my-awesome-package",
  "version": "1.0.0",
  "type": "module",
  "dependencies": {
      "@yandex-cloud/nodejs-sdk": "latest"
  }
}
```

- Точку входа укажите `index.handler`
- В блоке Параметры укажите:
  1. Таймаут — 3 секунд;
  1. Память — 128 МБ;
  1. Сервисный аккаунт — ваш сервисный аккаунт;
  1. Переменные окружения:
    1. FOLDER_ID — идентификатор каталога, в котором вы хотите останавливать виртуальные машины.
    1. INSTANCE_ID - идентификатор виртуальной машины, которую хотите запускать при прерывании
    1. OAUTHTOKEN - уникальный токен для авторизации функции
- Нажмите кнопку Создать версию.

### 5. Протестируйте работу функции

- Перейдите на вкладку тестирование, 
- Нажмите Запустить тест
- Перейдите в сервис Compute Cloud, 
- Выключите выбранную виртуальную машину 
- Проверьте ее состояние через 1 минуту или более
