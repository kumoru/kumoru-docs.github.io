# Locations

All applications assigned to a given location will run with a minimum of 2 containers, on a minimum of 2 servers in different availablity zones.

Locations are designed to be abstract and we purposly present minimal information about them.

- The amount of resources (CPU, RAM, Disk, Network) are static for all locations in the Alpha phase.
    - CPU: 2 x 1 vCPU
    - RAM: 2 x 3.75GiB
    - Disk: 2 x 40GB (General Purpose 2)

- There is no guarantee that all containers for a given application will run on different servers. There is a guarantee of containers being re-scheduled elsewhere if a server goes offline for any reason.

## Location Security

 - Port Access to restricted to your applications in a Location. Only ports specified on an application are allowed via the loadbalancer.
 - SSH keys are the only form of remote access to the servers. Passwords are disabled.
 - Members run a recent version of the CoreOS operating system and are configured to be part of the 'stable' channel.
 - Due to the need for intra-cluster communication, port access is not restricted between servers in a location.

## Available Locations

We support the following provider/region combinations:

- Amazon Web Services
    - us-east-1 - US East (N. Virginia)
- Amazon Web Services (coming soon)
    - us-west-1 - US West (N. California)
    - us-west-2 - US West (Oregon)
    - eu-west-1 - EU (Ireland)
    - eu-central-1 EU (Frankfort)
    - ap-southeast-1 - Asia Pacific (Singapore)
    - ap-southeast-2 - Asia Pacific (Sydney)
    - ap-northeast-1 - Asia Pacific (Tokyo)
    - ap-northeast-2 - Asia Pacific (Seoul)
    - sa-east-1 - South America (Sao Paulo)
- Google Compute Engine
- Microsoft Azure
- Digital Ocean
- Rackspace Cloud

### CLI Parameters
Concept | CLI Argument | Description
------- | ---------- | -----------
identifier | 1st  | The provider specific region identifier (i.e. us-east-1 for amazo for Amazon)

## Add a Location

```shell
kumoru locations add IDENTIFIER
…
```

## Get all Locations

```shell
kumoru locations list
…
```

## Archive a Location

```shell
kumoru locations archive IDENTIFIER
…
```
Archive location
