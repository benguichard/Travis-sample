# Travis Sample

[![Build Status](https://travis-ci.org/benguichard/Travis-sample.svg?branch=master)](https://travis-ci.org/benguichard/Travis-sample)

This project has been made as a continuous integration/deployment app sample. It's free of use and copy. But if you see some mistakes or possible optimisation, don't hesitate to signal it. Every help and advise is welcomed.

-   [Environment](#environment)
    -   [Tools versions](#tools-versions)
    -   [Execution process](#execution-process)
-   [Deployment of the application](#deployment-of-the-application)
    -   [Setup AWS credentials](#setup-aws-credentials)

## Environment

### Tools versions

|   **Name**  |   Ubuntu  | Packer | Terraform |
| :---------: | :-------: | :----: | :-------: |
| **Version** | 16.04 LTS |  1.2.2 |   0.11.7  |

### execution process

1.  Test of the website. Here, an execution of php is faked due to the only HTML content of the website;
2.  Packing of the website into an Amazon Machine Image (AMI) with Packer;
3.  Deploy of a basic Virtual Private Cloud (VPC) with the new website release;
4.  Once the environment ready, the public IP is output, ready to be visited.

## Deployment of the application

If you proceed to a fork of the repository, the demonstration will not be functional before you apply your own setting. The following instruction will show where some variables could need to be change according to your need.

### Setup AWS credentials

For safety and not have to expose publicly your Amazon Web Service credentials, it's highly recommended to encrypt the variables.
For that, you can do it with the encryption tool provided by Travis to secure your account.

```shell
gem install travis
travis encrypt -ar AWS_ACCESS_KEY_ID="<your access key>"
travis encrypt -ar AWS_SECRET_ACCESS_KEY="<your secret key>"
```
