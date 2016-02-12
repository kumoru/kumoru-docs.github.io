# Regions

**Definition:** Regions are clustered resources in a cloud provider managed by the Kumoru services.

All applications assigned to a given region will run with a minimum of 2 containers inside of that region.

Regions are designed to be abstract and we purposly present minimal information about them.

- The amount of resources (CPU, RAM, Disk, Network) are static for all regions in the Alpha phase.
    - CPU: 3 x 1 vCPU
    - RAM: 3 x 3.75GiB
    - Disk: 3 x 40GB (General Purpose 2)

- There is no guarantee that all containers for a given application will run on different nodes. There is a guarantee of containers being re-scheduled elsewhere if a member goes offline for any reason.

_Last updated December 2015_

## Region Security

 - Access to region members is completely locked down from the outside except for SSH access.
 - SSH keys are the only form of SSH access (passwords are not set)
 - Members run a recent version of the CoreOS operating system configured to auto-update. Members are configured to be part of the 'stable' channel.
 - Due to the need for intra-cluster communication, port access is not restricted between region members.

## Region Locations

Currently we support all Amazon Web Services regions.  You may deploy to any of the following locations today, with more providers and regions to come in the near future:

- Amazon Web Services
    - us-east-1 - US East (N. Virginia)
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
location | 1st  | The provider specific location of the region
credentials | 2nd | Credentials used to create and manager region resources. See below for provider specific formats.

### Provider Specifics

- Amazon Web Services: `access_key:secret_key@aws`

## Get all Regions

```shell
kumoru regions list
…
```

Retrieve a list of regions.

## Errors
