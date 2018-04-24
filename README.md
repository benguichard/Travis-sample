# Travis Sample

[![Build Status](https://travis-ci.org/benguichard/Travis-sample.svg?branch=master)](https://travis-ci.org/benguichard/Travis-sample)

A continuous integration/deployment app sample

-   [Deploy the application](#deploy-the-application)
-   [Environment and Tools versions](#environment-and-tools-versions)

## Environment and Tools versions

|   **Name**  |   Ubuntu  | Packer | Terraform |
| :---------: | :-------: | :----: | :-------: |
| **Version** | 16.04 LTS |  1.2.2 |   0.11.7  |

## Deploy the application

### Setup your own AWS credentials into Travis-ci

For safety by don't have to expose publicly your Amazon Web Service credentials, it's highly recommended to encrypt the variables.
For that, you can do it with the encryption tool provided by Travis for guaranty your account.

```shell
gem install travis
travis encrypt -ar AWS_ACCESS_KEY_ID="<your access key>"
travis encrypt -ar AWS_SECRET_ACCESS_KEY="<your secret key>"
```
