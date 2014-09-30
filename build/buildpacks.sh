#!/usr/bin/env bash
root=$(dirname $BASH_SOURCE[0])
username=${USER-vagrant}

. $root/utils.sh

echo "-----> Continuing build via buildpack $BUILDPACK_URL"

# FIXME: this setup could use some work, as is it means we can't use certain
# folder names that are used on heroku -- but we really should be able to. The
# reason we're linking like this rather than just letting everything go into
# /vagrant is because the shared filesystem between the VM and host is
# comparatively very slow, so if we actually vendor everything into it then
# loading times become excruciating. It's fine for normal work, but not for
# lots of vendored dependencies.
rm -rf /app
mkdir -p /app

mkdir -p /app/vendor
[ -e /vagrant/vendor ] || ln -s /app/vendor /vagrant/vendor
chown -R $username:$username /app/vendor

mkdir -p /app/bin
[ -e /vagrant/bin ] || ln -s /app/bin /vagrant/bin
chown -R $username:$username /app/bin

mkdir -p /app/log
[ -e /vagrant/log ] || ln -s /app/log /vagrant/log
chown -R $username:$username /app/log

# This is a bit of a hack -- some buildpacks will append to existing .profile.d
# scripts, presumably because if the file exists it was put there by the user,
# since buildpacks are always run on fresh machines. In our case we may run the
# buildpacks repeatedly for new builds, so we clean up the .profile.d folder to
# avoid the buildpacks appending to their own scripts each time they're run.
rm -rf /app/.profile.d

mkdir -p /app/.profile.d
[ -e /vagrant/.profile.d ] || ln -s /app/.profile.d /vagrant/.profile.d
chown -R $username:$username /app/.profile.d

# In a VM environment our root folder is shared across VMs but we want the
# .bundle folder to be unique to each machine.
mkdir -p /app/.bundle
ln -s /app/.bundle /vagrant/.bundle
chown -R $username:$username /app/.bundle

# Gemfile comes from our project, but we want all installed gems referenced
# from /app, not from /vagrant (our project root), so we link it and tell
# the system to call it from /app instead of /vagrant
ln -s /vagrant/Gemfile /app
ln -s /vagrant/Gemfile.lock /app
echo 'export BUNDLE_GEMFILE="/app/Gemfile"' > /app/.profile.d/bundle_gemfile.sh
export BUNDLE_GEMFILE="/app/Gemfile"

# Buildpack builder derived from:
#   https://raw.github.com/flynn/slugbuilder/master/builder/build.sh
#   https://raw.github.com/mojodna/heroku-buildpack-multi/build-env/bin/compile
build_root=/vagrant

cache_root=/tmp/buildcache
mkdir -p $cache_root
chown $username:$username $cache_root

buildpack_root=/tmp/buildpacks
mkdir -p $buildpack_root
chown $username:$username $buildpack_root

## Buildpack fixes
export REQUEST_ID=$(openssl rand -base64 32)
export CURL_TIMEOUT=600

## Buildpack detection
selected_buildpack=
if [[ -n "$BUILDPACK_URL" ]]; then
  buildpack="$buildpack_root/custom"
  url=${BUILDPACK_URL%#*}
  branch=${BUILDPACK_URL#*#}

  echo_title "Fetching buildpack ($url @ $branch)"

  rm -fr "$buildpack"
  git clone $url $buildpack 1>&2
  cd "$buildpack"
  [ "$branch" == "$url" ] || git checkout $branch 1>&2

  selected_buildpack="$buildpack"
  buildpack_name=$($buildpack/bin/detect "$build_root") && selected_buildpack=$buildpack
else
  echo_title "BUILDPACK_URL not set, set BUILDPACK_URL to the URL of your buildpack"
fi

if [[ -n "$selected_buildpack" ]]; then
  echo_title "$buildpack_name app detected"
else
  echo_title "Unable to select a buildpack"
  exit 1
fi

## Buildpack compile
sudo -E -u $username $selected_buildpack/bin/compile "$build_root" "$cache_root" | ensure_indent
sudo -E -u $username $selected_buildpack/bin/release "$build_root" "$cache_root" > $build_root/.release
