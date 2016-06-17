# Deployments

Deployments represent a running rule for an application and there will one created per rule.

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

If your docker image creation is an automated process, then deploying and updated application should be as simple as causing a new deployment once the image is built.

## Deploying via webhook

Applications can be deployed by a simple webhook which is ideal as a final step in a Continious Integration run. You'll need to retrieve the deployment token from the application details:

```bash
kumoru applications show

$ ./kumoru applications show fbe1646b-0651-4b2b-ac75-318bb0bdf0d1

Application Details:
Addresses:
…
DeploymentToken:     d5c545c1-e1e4-43a7-a7c8-c97e646fbd13
…
```

You can then perform a HTTP POST to cause the deployment if you don't have the CLI installed by leveraging the `deployment_token` query parameter:

```bash
curl -X POST https://application.kumoru.io/v1/applications/fbe1646b-0651-4b2b-ac75-318bb0bdf0d1/deployments/?deployment_token=d5c545c1-e1e4-43a7-a7c8-c97e646fbd13
```

**Note:** your application UUID and deployment_token will be different for all applications

