---
title: Kumoru Documentation

language_tabs:
  - shell

toc_footers:
  - <a href='http://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - gettingstarted
  - access
  - accounts
  - regions
  - applications
  - deployments
  - faq
  - glossary
search: true
---

# Introduction

Welcome to the Kumoru.io documentation. Kumoru is a service for making application management and deployment as simple as possible on public clouds.
The documenation on this site is intended to describe Kumoru concepts and how to consume the Kumoru service through the CLI.

We do not currently have language bindings for the APIs. Please let us know if you would like to see bindings for your favorite language. The commands shown are done so with the official [kumoru cli](https://github.com/kumoru/kumoru-cli).

## Customer Fit

### Stateless Applications

Kumoru was designed to run and scale applications with ease. As part of this design there is no shared state between containers. This means that any data local to a container is lost if that contianer stops for any reason, whether it's failure or a scaling down event.

A good guide for applications that will run great in kumoru is the [12 factor app](http://12factor.net/).

It is intended for users to store state in another location, such as a remote database, cache or queue.

### SOA and Microservice

Kumoru allows users to run multiple applications on the same set of resources. Ideally users should plan their architecture around either a Service Oriented Architexture or a Microservices model. Both are accetable inside Kumoru.

All publicly exposed applications are load balanced automatically. Connecting applications can be done by referncing their addresses.

### Cloud First

Currently Kumoru only runs applications on AWS however additional public clouds will be allowed in the future. This means that applications can take full advantage of what AWS has to offer (RDS, S3, DynamoDB, etc).
