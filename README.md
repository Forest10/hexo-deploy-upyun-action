# Hexo Deploy Action

针对原有action无法进行CNAME操作进行整改.确保可用


This [GitHub action](https://github.com/features/actions) will handle the building and deploying process of hexo
 project with CNAME enabled.

## Getting Started

You can view an example of this below.

```yml
name: Build and Deploy
on: [push]
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@master

    - name: Build and Deploy
      uses: Forest10/hexo-deploy-action-with-cname@master
      env:
        USER_NAME: Forest10 # optional
        EMAIL: github.forest10@gmail.com # optional
        CNAME: blog.github.com # optional
        PERSONAL_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        PUBLISH_REPOSITORY: Forest10/forest10.github.io # The repository the action should deploy to.
        BRANCH: master  # The branch the action should deploy to.
        PUBLISH_DIR: ./public # The folder the action should deploy.
```

if you want to make the workflow only triggers on push events to specific branches, you can like this: 

```yml
on:
  push:	
    branches:	
      - master
```

## Configuration

The `env` portion of the workflow **must** be configured before the action will work. You can add these in the `env` section found in the examples above. Any `secrets` must be referenced using the bracket syntax and stored in the GitHub repositories `Settings/Secrets` menu. You can learn more about setting environment variables with GitHub actions [here](https://help.github.com/en/articles/workflow-syntax-for-github-actions#jobsjob_idstepsenv).

Below you'll find a description of what each option does.

| Key  | Value Information | Type | Required |
| ------------- | ------------- | ------------- | ------------- |
| `PERSONAL_TOKEN`  | Depending on the repository permissions you may need to provide the action with a GitHub Personal Access Token in order to deploy. You can [learn more about how to generate one here](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). **This should be stored as a secret**. | `secrets` | **Yes** |
| `PUBLISH_REPOSITORY`  | The repository the action should deploy to. for example `Forest10/forest10.github.io` | `env` | **Yes** |
| `BRANCH`  | The branch the action should deploy to. for example `master` | `env` | **Yes** |
| `PUBLISH_DIR`  | The folder the action should deploy. for example `./public`| `env` | **Yes** |

