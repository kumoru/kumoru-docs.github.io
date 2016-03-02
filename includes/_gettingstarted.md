# Getting Started

## Quickstart
The goal of this quickstart is to create, deploy, update, and delete an appliction using the Kumoru Command Line Interface.  This is intended to be a short dive into the CLI, but if you would like more information we have anchored the quickstart steps to more detailed sections in the documentation.  

<aside class="warning">Please note that during Alpha release, user accounts must be manually enabled by Kumoru team.</aside>

1. [Install the CLI](#kumoru-command-line-interface)
    - <https://github.com/kumoru/kumoru-cli/releases>
1. [Create an Account](#account-management)
    - <code>$ kumoru accounts create -f $firstName -l $lastName -p $yourPassword $emailAddress</code>
1. Request Kumoru [account activation](mailto:support@kumoru.io)
1. [Login via CLI](#kumoru-command-line-interface)
    - <code> $ kumoru login </code>
1. [Select Region to Deploy Application](#regions)
    - <code>$ kumoru regions list</code>
1. [Create Application](#applications)
    - <code>$ kumoru applications create -p 80:8080 -r green=100 -e VERSION=v1 -l $tagName $poolUUID quay.io/kumoru/sample-app $yourAppName</code>
1. [Deploy Application](#deployments)
    - <code>$ kumoru applications deploy $yourAppUUID</code>

## Kumoru Command Line Interface

### Getting the Kumoru CLI Client
There is multiple ways to install the Kumoru CLI client.  Choose the most appropiate method for you:

- Download latest release:
    - <https://github.com/kumoru/kumoru-cli/releases>
- Build from source:
    - <https://github.com/kumoru/kumoru-cli>

<aside class="info">If you do not have a Kumoru account, please visit the <a href="http://docs.kumoru.io/#create-an-account">Accounts</a> section of the documentation to sign up.</aside>

### Basic Usage

```shell
$ kumoru login


Generating new token.
Enter Username:
```
Once you have installed the CLI, the first step you need to do is `login`.  This will generate a new set of [*tokens*](http://docs.kumoru.io/#tokens) for you to interface with the Kumoru service.  To get a full of list of options, you can run `kumoru` with no arugments.

## About the Kumoru Sample Application

Let's deploy a sample application which will show the deployment workflow, traffic rules, port access, tagging and environment variables.

The following steps assume you have an active user account and a valid token.

##Decide which region to deploy to:

```shell
kumoru regions list

Location   Uuid                                  Status
us-east-1  0269fc49-db71-400c-bfb5-cd5f47cc782c  running
```

Note the UUID of your region, you will need it for the next command.

##Create the sample application

```shell
kumoru applications create \
-p 80:8080 \
-r green=100 \
-e VERSION=v1 \
-l getting-started \
0269fc49-db71-400c-bfb5-cd5f47cc782c quay.io/kumoru/sample-app sample-app

Application Details:

Addresses:            []
CreatedAt:
CurrentDeployments:   map[]
Environment:          map[VERSION:v1]
Hash:
ImageUrl:             quay.io/kumoru/sample-app
Location:             us-east-1
LogToken:             45890797-48b3-47c1-bc58-2afa14674be6
Metadata:             map[tags:[getting-started]]
OrchestrationUrl:     http://kumoru-po-LoadBala-1E5BWBC9IWASE-1208370489.us-east-1.elb.amazonaws.com
Name:                 sample-app
PoolUuid:             0269fc49-db71-400c-bfb5-cd5f47cc782c
Ports:                [80:8080]
ProviderCredentials:  aws_access_key:aws_secret_key@aws
Rules:                green=100
Status:
UpdatedAt:
Url:
Uuid:                 4a12ee96-809b-4295-8e12-e082bda8004d
Certificates:         map[]
```

Next we will create our first application, `sample-app`, using a small image our team created ahead of time.

Here is some information on the options we passed:

* `-p` tells Kumoru that we want to expose port `80` on the loadbalancer and connect that to port `8080` which is exposed in the container
* `-r` tells Kumoru that we want to use the docker image tag `green` and weight the traffic at 100%
* `-e` tells Kumoru that we want the environment variable `VERSION` available to our containers
* `-l` tells Kumoru that we want to label the application with `getting-started` for easier filtering in the clients
* `0269fc49-db71-400c-bfb5-cd5f47cc782c` is the pool UUID that we want the application deployed into
* `quay.io/kumoru/sample-app` is the docker image URL (without the image tag)
* `sample-app` is the name of the application

If you get a `403 forbidden access to pool …`, make sure they UUID you used it correct.

##Deploy the sample application

```shell
kumoru applications deploy 4a12ee96-809b-4295-8e12-e082bda8004d
Deploying application 4a12ee96-809b-4295-8e12-e082bda8004d
```

You can start your first deployment using the UUID of the application we just created. This will take a few moments the first time since Kumoru must 

1. Download the docker image
1. Start the containers
1. Create an ELB and wait for the ELB DNS record to resolve prior to considering the application as `running`

This is the longest process when using Kumoru. Future deployments are considerably faster since Kumoru only needs to download docker image differentials.

##Access the sample application

```shell
kumoru applications show 4a12ee96-809b-4295-8e12-e082bda8004d
Application Details:

Addresses:            [df30014009fe4e1f9f75d7b27d8574d1-458773757.us-east-1.elb.amazonaws.com:80]
CreatedAt:            2016-01-04T16:57:10.490856
CurrentDeployments:   map[green:be03fe13-a9fd-491c-bb10-9d96f513adfb]
Environment:          map[VERSION:v1]
Hash:                 c507b10bcaaf4fca798bfea64aa12c6474d065537d28f905b294dfec8346e11f
ImageUrl:             quay.io/kumoru/sample-app
Location:             us-east-1
LogToken:             c44c38d4-440c-4ca2-8d60-a313ed62a747
Metadata:             map[tags:[getting-started]]
OrchestrationUrl:     http://kumoru-po-LoadBala-1E5BWBC9IWASE-1208370489.us-east-1.elb.amazonaws.com
Name:                 sample-app
PoolUuid:             0269fc49-db71-400c-bfb5-cd5f47cc782c 
Ports:                [80:8080]
ProviderCredentials:  aws_access_key:aws_secret_key@aws
Rules:                green=100
Status:               running
UpdatedAt:            2016-01-04T16:57:10.490876
Url:
Uuid:                 4a12ee96-809b-4295-8e12-e082bda8004d
Certificates:         map[]
```

We can access the application by leveraging the `address` associated with it. Use `kumoru application show` to see all details about a given application.

You may open the address in a browser(`df30014009fe4e1f9f75d7b27d8574d1-458773757.us-east-1.elb.amazonaws.com` in my case) or curl it from the command line to see the content.

##Update the sample application

```shell
kumoru applications patch \
-r blue=100 \
-e VERSION=v2 \
4a12ee96-809b-4295-8e12-e082bda8004d

Application Details:

Addresses:            [df30014009fe4e1f9f75d7b27d8574d1-458773757.us-east-1.elb.amazonaws.com:80]
CreatedAt:            2016-01-04T16:57:10.490856
CurrentDeployments:   map[green:be03fe13-a9fd-491c-bb10-9d96f513adfb]
Environment:          map[VERSION:v2]
Hash:                 c507b10bcaaf4fca798bfea64aa12c6474d065537d28f905b294dfec8346e11f
ImageUrl:             quay.io/kumoru/sample-app
Location:             us-east-1
LogToken:             c44c38d4-440c-4ca2-8d60-a313ed62a747
Metadata:             map[tags:[getting-started]]
OrchestrationUrl:     http://kumoru-po-LoadBala-S53V9B1YFP70-916465214.us-east-1.elb.amazonaws.com
Name:                 sample-app
PoolUuid:             0269fc49-db71-400c-bfb5-cd5f47cc782c
Ports:                [80:8080]
ProviderCredentials:  aws_access_key:aws_secret_key@aws
Rules:                blue=100
Status:               running
UpdatedAt:            2016-01-04T16:57:10.490876
Url:
Uuid:                 4a12ee96-809b-4295-8e12-e082bda8004d
Certificates:         map[]
```

Change the docker image tag to `blue` and change the ENV VERSION to `v2` to show that we do indeed get an updated version of our application without downtime.

##Deploy the changes

```shell
kumoru applications deploy 4a12ee96-809b-4295-8e12-e082bda8004d
Deploying application 4a12ee96-809b-4295-8e12-e082bda8004d
```

In the last step we changed the rules for the application but hadn't yet deployed the changes. We must initiate a new deployment of the applciation for the changes to take effect.

Refresh the page in the browser or curl the address again to see the new content. You may need to force refresh your browser to clean the cache.

Note that this process takes considerably less time than the initial deployment.

##Delete the sample application

```shell
kumoru applications delete 4a12ee96-809b-4295-8e12-e082bda8004d
Application 4a12ee96-809b-4295-8e12-e082bda8004d accepted for archival
```

You may delete the application when ready. Deleting applications removes any resources associated with it(ELB, containers, etc) but the application data will persist in the datastore in an `archived` state.
