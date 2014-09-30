#!/usr/bin/env bash
set -e -o pipefail

# [[ $DEBUG == "true" ]] && set -x

# Build script for an all-in-one Heroku-Cedar-like virtual machine. It first
# adds the "all-in-one" dependencies that would be on separate servers in a
# real Heroku setup (postgresql, elastic search, redis, etc...) then uses the
# same buildpacks used in production to build the rest of the machine as it
# will be built when deployed to Heroku.
username=${USER-vagrant}
root=$(dirname $BASH_SOURCE[0])

. $root/utils.sh

if dpkg -s ruby > /dev/null; then
  echo_title "Heroku Cedar stack already installed, skipping..."
else
  echo_title "Installing Heroku Cedar stack (this will take a while...)"
  $root/cedar-14.sh
fi

set +x

$root/environment.sh
$root/buildpacks.sh

# /app is recreated for buildpacks, so setting up our .profile.d has to happen
# _after_ buildpacks
echo 'export HOME="/vagrant"' > /app/.profile.d/home.sh

[ -e /vagrant/.profile.sh ] ||
  touch /vagrant/.profile.sh
ln -s /vagrant/.profile.sh /app/.profile.d/profile.sh
chown -h $username:$username /app/.profile.d/profile.sh

echo ""
echo "=====> All done."
echo ""
echo "       SSH in to VM: vagrant ssh"
echo ""
