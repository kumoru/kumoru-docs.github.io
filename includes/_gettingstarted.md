# Getting Started

## Quickstart
The goal of this quickstart is to create, deploy, update, and delete an appliction using the Kumoru Command Line Interface.  This is intended to be a short dive into the CLI, but if you would like more information we have anchored the quickstart steps to more detailed sections in the documentation.

<aside class="warning">Please note that during Alpha release, user accounts must be manually enabled by Kumoru team.</aside>

1. [Install the CLI](#kumoru-command-line-interface)
    - <https://github.com/kumoru/kumoru-cli/releases>
1. [Create an Account](#account-management)
    - <code>$ kumoru accounts create -f `Your First Name` -l `Your Last Name` `Your Email Address`</code>
1. Request Kumoru [account activation](mailto:support@kumoru.io)
1. [Login via CLI](#kumoru-command-line-interface)
    - <code> $ kumoru login </code>
1. [Add a Location](#locations)
    - <code> $ kumoru locations add us-east-1</code>
1. [Select Location to Deploy Application](#locations)
    - <code>$ kumoru locations list</code>
1. [Create Application](#applications)
    - <code>$ kumoru applications create -p 80:8080 -r green=100 -e VERSION=v1 -l getting-started `Your location UUID` quay.io/kumoru/sample-app <Your App Name></code>
1. [Deploy Application](#deployments)
    - <code>$ kumoru applications deploy `Your app UUID`</code>

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

##Decide which location to deploy to:

```shell
kumoru locations list

Location   Provider  UUID                                  Status
us-east-1  amazon    0269fc49-db71-400c-bfb5-cd5f47cc782c  running
```

Note the UUID of your location, you will need it for the next command.

##Create the sample application

```shell
kumoru applications create \
-p 80:8080 \
-r green=100 \
-e VERSION=v1 \
-l getting-started \
0269fc49-db71-400c-bfb5-cd5f47cc782c quay.io/kumoru/sample-app sample-app

Application Details:
Addresses:
CreatedAt:           Tue, 05 Apr 2016 15:00:02 CDT
CurrentDeployments:
DeploymentToken:     7b1dffd9-2b1d-4b8a-b91a-1343c83a81ba
ImageURL:            quay.io/kumoru/sample-app
Location:            Identifier: us-east-1       UUID: 0269fc49-db71-400c-bfb5-cd5f47cc782c
Metadata:            {"labels":["getting-started"]}
Name:                sample-app
Ports:
……                   80:8080
Rules:
……                   green=100
SSLPorts:
Status:              instantiating
UpdatedAt:           Tue, 05 Apr 2016 15:00:02 CDT
URL:
UUID:                ced76a97-276b-4d24-bc9c-f9c33942ae8b
Version:             v0
Certificates:        Use "--full" to see certificates
– PrivateKey:


Environment:
VERSION=v1
```

Next we will create our first application, `sample-app`, using a small image our team created ahead of time.

Here is some information on the options we passed:

* `-p` tells Kumoru that we want to expose port `80` on the loadbalancer and connect that to port `8080` which is exposed in the container
* `-r` tells Kumoru that we want to use the docker image tag `green` and weight the traffic at 100%
* `-e` tells Kumoru that we want the environment variable `VERSION` available to our containers
* `-l` tells Kumoru that we want to label the application with `getting-started` for easier filtering in the clients
* `0269fc49-db71-400c-bfb5-cd5f47cc782c` is the location UUID that we want the application deployed into
* `quay.io/kumoru/sample-app` is the docker image URL (without the image tag)
* `sample-app` is the name of the application

If you get a `403 forbidden access to location …`, make sure they UUID you used it correct.

##Deploy the sample application

```shell
kumoru applications deploy ced76a97-276b-4d24-bc9c-f9c33942ae8b
Deploying application ced76a97-276b-4d24-bc9c-f9c33942ae8b
```

You can start your first deployment using the UUID of the application we just created. This will take a few moments the first time since Kumoru must

1. Download the docker image
1. Start the containers
1. Create an ELB and wait for the ELB DNS record to resolve prior to considering the application as `running`

This is the longest process when using Kumoru. Future deployments are considerably faster since Kumoru only needs to download docker image differentials and start new containers.

##Access the sample application

```shell
kumoru applications show ced76a97-276b-4d24-bc9c-f9c33942ae8b

Application Details:
Addresses:
……                   ced76a97276b4d24bc9cf9c33942ae8b-1090232792.us-east-1.elb.amazonaws.com:80
CreatedAt:           Tue, 05 Apr 2016 14:42:16 CDT
CurrentDeployments:
……                   green: 3008de98-6d6f-4647-9020-c3ac83149d15
DeploymentToken:     b17fd92d-ae75-48d4-977b-9343362ea85f
ImageURL:            quay.io/kumoru/sample-app
Location:            Identifier: us-east-1	 UUID: 0269fc49-db71-400c-bfb5-cd5f47cc782c
Metadata:            {"labels":["getting-started"]}
Name:                sample-app
Ports:
……                   80:8080
Rules:
……                   green=100
SSLPorts:
Status:              running
UpdatedAt:           Tue, 05 Apr 2016 14:50:14 CDT
URL:                 /v1/applications/ced76a97-276b-4d24-bc9c-f9c33942ae8b
UUID:                ced76a97-276b-4d24-bc9c-f9c33942ae8b
Version:             v0
Certificates:        Use "--full" to see certificates
– PrivateKey:


Environment:
VERSION=v1
```

We can access the application by leveraging the `address` associated with it. Use `kumoru application show` to see all details about a given application.

You may open the address in a browser(`ced76a97276b4d24bc9cf9c33942ae8b-1090232792.us-east-1.elb.amazonaws.com` in my case) or curl it from the command line to see the content.

##Update the sample application

```shell
kumoru applications patch \
-r blue=100 \
-e VERSION=v2 \
ced76a97-276b-4d24-bc9c-f9c33942ae8

Application Details:
Addresses:
……                   ced76a97276b4d24bc9cf9c33942ae8b-1090232792.us-east-1.elb.amazonaws.com:80
CreatedAt:           Tue, 05 Apr 2016 14:42:16 CDT
CurrentDeployments:
……                   green: 3008de98-6d6f-4647-9020-c3ac83149d15
DeploymentToken:     b17fd92d-ae75-48d4-977b-9343362ea85f
ImageURL:            quay.io/kumoru/sample-app
Location:            Identifier: us-east-1	 UUID: 0269fc49-db71-400c-bfb5-cd5f47cc782c
Metadata:            {"labels":[]}
Name:                sample-app
Ports:
……                   80:8080
Rules:
……                   blue=100
SSLPorts:
Status:              running
UpdatedAt:           Tue, 05 Apr 2016 14:50:14 CDT
URL:
UUID:                ced76a97-276b-4d24-bc9c-f9c33942ae8b
Version:             v0
Certificates:        Use "--full" to see certificates
– PrivateKey:


Environment:
VERSION=v2
```

Change the docker image tag to `blue` and change the ENV VERSION to `v2` to show that we do indeed get an updated version of our application without downtime.

##Deploy the changes

```shell
kumoru applications deploy ced76a97-276b-4d24-bc9c-f9c33942ae8b
Deploying application ced76a97-276b-4d24-bc9c-f9c33942ae8b
```

In the last step we changed the rules for the application but hadn't yet deployed the changes. We must initiate a new deployment of the applciation for the changes to take effect.

Refresh the page in the browser or curl the address again to see the new content. You may need to force refresh your browser to clean the cache.

Note that this process takes considerably less time than the initial deployment.

##Delete the sample application

```shell
kumoru applications delete ced76a97-276b-4d24-bc9c-f9c33942ae8b
Application ced76a97-276b-4d24-bc9c-f9c33942ae8b accepted for archival
```

You may delete the application when ready. Deleting applications removes any resources associated with it(ELB, containers, etc) but the application data will persist in the datastore in an `archived` state.
