#!/bin/bash
set -e
export PATH="/opt/local/bin:/sbin:/usr/sbin:/opt/ruby/bin:$PATH"

set -x
if [ "$BUILD_NUMBER" == "" ];then
  echo "BUILD_NUMBER environment not set - producing debug build"
  export BUILD_NUMBER=debug0
fi
echo "Going for bundle install and build:"
cd /package
cp -r /package_source/* /package/
/opt/ruby/bin/gem install --no-ri --no-rdoc /package/vendor/bundler-1.6.3.gem
/opt/ruby/bin/bundle install --binstubs --local
/opt/ruby/bin/bundle exec bin/fpm-cook package recipe.rb </dev/null
echo "Copying package to the dist folder"
cp -v pkg/* /package_dest/
echo "Package copying worked!"
exit 0
