# FAQ

1. Why can't stateful applications deployed in Kumoru.io?

Technically, they can. However there is no gaurantee of state for a given container or between containers.
This means that if you were to deploy a mysql image, there would be two running containers of mysql with no
shared data between them. If there is a failure, a new container will be scheduled and will not have any data from the failed container.

These restrictions are forced because we view infrastructure as needing separate scaling mechanisms. Databases require a very different approach to scaling than an API service and should be treated as such.

We expect users to leverage remote resources for state. This means you can consume a cloud service (i.e. RDS) or run your own service (i.e. mysql on EC2). Both can be accessed by your service via Environment Variables.

2. Do you dogfood your service?

I'm glad you asked. The answer is yes. We are our first customer!

The APIs you interact with when consuming kumoru.io are all hosted via Kumoru.io. This makes bootstraping our APIs interesting but that's a story for another time.
