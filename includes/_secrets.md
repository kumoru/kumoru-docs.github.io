# Secrets

###Definition:
A secret is a sensitive piece of information that may be used by or on behalf of your application. Values are currently limited to **strings**.

As of May 2016 the `value` of a secret are stored encrypted via Rackspace [Cloudkeep](https://developer.rackspace.com/docs/cloud-keep/v1/developer-guide/#document-getting-started).

Today the following sensitive information are stored on your behalf:

- private SSL key
- private half of your token pair

Coming Soon:

- reference secrets for:
 - pull credentials for private docker images
 - private SSL keys
 - environment variables (e.g., database password)

## Create a Secret

```shell
kumoru secrets create -l mysql_password mySecurePassword123

Secret Details:

CreatedAt:  Sun, 31 Dec 0000 18:00:00 CST
Labels:     [mysql_password]
UpdatedAt:  Sun, 31 Dec 0000 18:00:00 CST
Uuid:       19085c5b-8898-4268-9685-60e328c3a6e4
Value:      mySecurePassword123
```

Concept | CLI Option | Description
------- | ---------- | -----------
labels  | -l | Descriptive labels that may be attached to a secret.

## Delete a Secret

**Not Implemented**

## List Secrets

```shell
kumoru secrets list

UUID                                  Created At                     Labels
19085c5b-8898-4268-9685-60e328c3a6e4  Sun, 31 Dec 0000 18:00:00 CST  [mysql_password]
…
```

Lists all available secrets. The values are purposely not displayed. Use `kumoru show secret UUID` to deplay the value.

## Show a Secret

```shell
kumoru secrets show 19085c5b-8898-4268-9685-60e328c3a6e4

Secret Details:

CreatedAt:  Sun, 31 Dec 0000 18:00:00 CST
Labels:     [mysql_password]
UpdatedAt:  Sun, 31 Dec 0000 18:00:00 CST
Uuid:       19085c5b-8898-4268-9685-60e328c3a6e4
Value:      mySecurePassword123
```

Displays all details about a secret including the value.
