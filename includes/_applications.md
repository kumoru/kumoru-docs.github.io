# Applications

### Definition: information that kumoru will use to create a deployment.

Applications are the primary focus of Kumoru. We expect users to interact with Kumoru primarily by creating applications and deploying them.

When an application is created, is is not deployed by default. You'll need to create an initial [deployment](#deployments) to have a running application.

## Create an Application

```shell
kumoru applications create [OPTIONS] POOL_UUID IMG_URL APP_NAME

```

### CLI

Concept | CLI Option | Description
------- | ---------- | -----------
certificate | --certificate_file | The path to a PEM encoded SSL certificate. Setting this on an application will enable SSL on all Ports
private key | --private_key_file | The path to a PEM encoded private key tied to the certificate. Required if used --certificate
certificate chain| --cetificate_chain_file | The path to a PEM encoded certificate chain. (optional)
provider credentials | -c | A set of credentials that will be used to create resources on behalf of the application (i.e. ELB)
environment | -e | String containing a KEY=value environment variable that will be passed to the containers. You may specify multiple of these
rule | -r  | String containing tag=weight (i.e. latest=100). You may specify multiple of these and doing so will cause multiple deployments (1 for each tag)
port | -p | String standard docker port mapping (i.e. 80:8080 where 80 is the frontend port and 8080 is the port accessible in the container. You may specify multiple of these
tags | -t | String to be used as an identifier. You may specify multiple of these
metadata | -m | JSON string of arbitrary metadata
file | -f | File containing environment variables

Concept | CLI Arguement | Description
------- | ------------- | -----------
pool uuid | 1st | The UUID of the pool the application is to be deployed in.
image url| 2nd | The url of the docker image. See below for acceptable urls.
application name | 3rd | The name of the application.

The following types of image urls are acceptable and may be transformed:

Input | Transformation
----- | --------------
image | registry.hub.docker.com/library/image
username/image | registry.hub.docker.com/username/image
myregistry.com/username/image | myregistry.com/usernameimage
user:password@myregistry.com/username/image | Private image

* If you are familiar with Docker you may Notice there is no image tag listed. These are provided via the `rules` flag.

## Get an Application

```shell
kumoru applications show APPLICATION_UUID
```

## Get all Applications

```shell
kumoru applications list
```

## Update an Application

```shell
kumoru applications update [OPTIONS] APPLICATION UUID
```

## Delete an Application

```shell
kumoru applications delete APPLICATION UUID
```

Deleting an application will remove the loadbalancer associated with the application. Running containers will be stopped as well.

## Application Security

* External ingress traffic is only allowed to applications via their load balancer and only on the port specified. If no port is specified, external ingress traffic is not allowed.
* Access to the instances and containers is completely isolated to all except the Kumoru support team.

## Statuses

Status | Description
------ | -----------
Instantiating | The application has been created but not yet deployed.
Deploying | A deployment action has been started.
Checking | Kumoru is determining if the application is available ( running and/or externally available)
Running  | The application has been deployed and is available externally. 
Archiving | The archival process us underway.
Archived | All archive actions are complete and the deployments are no longer available.
Errored- | An error has ocurred. The relevant error message wil be included in the status.

## Logging

## Errors
