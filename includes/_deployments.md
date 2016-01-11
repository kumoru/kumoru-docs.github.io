# Deployments

### Definition: The immutable instantiation of an application.

Deployments represent a running rule for an application. There will be a deployment for every rule specified on an application.

Deployments are immutable and capture the application details at the time of their creation. This means that an application can be rolled back via the details of that deployment.

When an application is deployed, Kumoru will attempt to figure out if any changes have been made (i.e. a new docker image hash, change environment variables, etc). If no changes are present, no actions are taken.

## Create a deployment

```shell
kumoru applications deploy APPLICATION_UUID
…
```

Deploying a new or changed application always following the same process

1. Commit code and create a new docker image.
1. Update the application rules if required (i.e. if a new docker tag is needed)
1. Create a deployment.

Ideally docker image building should be automated. If this is the case then most of the time the only step needed to get the new software running is to create the deployment.

## Errors
