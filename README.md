# Hexo Deploy Action




This [GitHub action](https://github.com/features/actions) will handle the building and deploying process of hexo
 project to upyun with upx.

## Getting Started

You can view an example of this below.

```yml
name: automatic exec hexo deploy and sync-2-gitee
on:
  push:
    branches:
      - hexo-upyun
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    name: A job to deploy blog
    steps:
      - name: Checkout
        uses: actions/checkout@master
      # Caching dependencies to speed up workflows. (GitHub will remove any cache entries that have not been accessed in over 7 days.) 缓存压缩 node_modules，不用每次下载，使用时解压，可以加快工作流的执行过程，超过 7 天没有使用将删除压缩包。
      - name: Cache node modules # step2
        uses: actions/cache@v1
        id: cache-node
        with:
          path: node_modules
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-
      - name: Install Dependencies
        if: steps.cache-node.outputs.cache-hit != 'true' # 如果变量 cache-hit 不等于 true
        run: echo node-miss && npm install # 安装 node modules 相关依赖

      - name: Cache upx  # step2
        uses: actions/cache@v1
        id: cache-upx
        with:
          path: upx-dir/upx-command-dir
          key: ${{ runner.os }}-upx-upxCahce
          restore-keys: |
            ${{ runner.os }}-upx-CacheBackUp-
      - name: Install upx
        if: steps.cache-upx.outputs.cache-hit != 'true'
        run: echo upx-cache-miss && mkdir upx-dir && cd  upx-dir && wget https://github.com/upyun/upx/releases/download/v0.3.5/upx_0.3.5_linux_x86_64.tar.gz && tar -xf upx_0.3.5_linux_x86_64.tar.gz && mkdir upx-command-dir && mv upx upx-command-dir
      - name: hexo-and-upx-2-upyun-action
        uses: Forest10/hexo-and-upx-2-upyun-action@v1
        env:
          UPX_NAME: ${{ secrets.UPX_NAME }}
          BUCKET_NAME: ${{ secrets.BUCKET_NAME }}
          UPX_PASSWORD: ${{ secrets.UPX_PASSWORD }}
          PERSONAL_TOKEN: ${{ secrets.ACTION_TOKEN }}
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
| `UPX_NAME`  | UPX_NAME | `env` | **Yes** |
| `BUCKET_NAME`  | BUCKET_NAME | `env` | **Yes** |
| `UPX_PASSWORD`  | UPX_PASSWORD | `env` | **Yes** |
| `PERSONAL_TOKEN`  | Depending on the repository permissions you may need to provide the action with a GitHub Personal Access Token in order to deploy. You can [learn more about how to generate one here](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). **This should be stored as a secret**. | `secrets` | **Yes** |

