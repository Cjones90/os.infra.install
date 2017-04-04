
# Create a default user
# Disable root access
# Add hosts to /etc/hosts
#    127.0.0.1    localhost.localdomain localhost
#    127.0.1.1    my-machine
#
# For now - since Im only reviewing the puppet course now
# Run order:
# ./network.sh
# ./essentials.sh
# ./ufw.sh
# ./docker.sh

#### Currently:
#   -We build on the server and do not use the designated docker registry for
#   more rapid development cycle, as there are no qa/testers
#   -We need to auto generate ssh key authentication on prod servers
#   to communicate/clone app repos with our current deploment

#### What we do:
#   -What we need is a clone of the repos on the remote machine since the apps
#   require it to build


#### We want:
#   -To push/publish to docker registry and pull down to the single/multi-node
#   swarm or qa/testers.
#       -We need to make we put proper docker registry credentials on each server
#   -This would strictly require ubuntu basic packages/network security
#       -docker-compose and a docker-compose file for each app
#   -We ideally would like to auto-generate docs based on comments or tests
#   -Next logical step is appropriate logging and monitor over the server/services
#       -Currently only if the "web server" is up
#           -This ui/display could integrate with testing info
#
#  Misc:
#   -Service Discovery
#   -Package upgrades gracefully
#
#  Future:
#   -Builds auto-generated after push to repo
#   -If tests/build successful, deploy to production


#### Huge team ideas
# -Puppet
# -Jenkins

# Ideal scenario is -
# - Build 1 to N servers at once
# - Configure all servers to be (almost) the same (DB server, maybe DNS server etc, are diff)
# - Unit/Acceptance/Integration tests passing with automated testing/building - maybe a build server
#    - I feel as though build servers have more to do with apps that have binaries over web apps however
# - Deploy app to all servers using swarm
#    - We can dive deeper and do routing/A-B (I think) testing
#    - Route traffic to new application gradually
#       - Hope having 2 diff versions of app live does not break anything
