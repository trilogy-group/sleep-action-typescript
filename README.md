## How to ADD New Action?

1. Clone your repository

```
git clone <repo-name>
```

2. Change your directory and go to `src` directory

```
cd <repo-name>/src/
```

3. Copy the echo directory to a directory with name `<function-name>`

```
cp -r echo <function-name>
```

Note: Directory name should match the Function Name provided in the action.

4. Go to `index.ts` in the newly created directory and start writing code for your action in the handler function.

## Testing the existing actions using `DevServer`

Open DevSpaces using the Icon in the Github Repo. A screen will open with an Input Box, an Output Box and a tab to select the existing functions.

### Testing echo action

Ensure that the current selected tab is `ECHO`.

- Input:

```json
{
  "headers": {},
  "body": {
    "message": "Hello world!"
  }
}
```

- Output:

```json
{ "statusCode": 200, "body": { "message": "Hello world!" } }
```

### Testing sleep action

Ensure that the current selected tab is `SLEEP`.

- Input:

```json
{
  "headers": {},
  "body": {
    "delayTime": 2000
  }
}
```

- Output:

Output is returned after 2s delay

```json
{ "statusCode": 200, "body": { "delayTime": 2000 } }
```

## Testing existing actions using `curl`

You can also use curl to test your actions directly instead of using the DevServer.

```shell
curl --location --request POST 'http://localhost:8000/echo' --header 'Content-Type: application/json' --data-raw '{"message": "test"}'
```

## Setting environment variables

Any value being set on the configuration settings for your application is accessed via environment variables (i.e. `process.env.ENV_NAME`).

For testing locally, you can run `gp env ENV_NAME=ENV_VALUE` on your terminal window to set mock values for the configuration variables.

To update the current terminal session with the latest set of persistent environment variables, run `eval $(gp env -e)`. You can verify that the environment variable is accessible by running the command `echo $ENV_NAME`.

