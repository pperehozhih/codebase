package = "#{PROJECT_NAME}.nginx.#{JOINED_WSAPI}.#{CLUSTER_NAME}"
version = "scm-1"
source = {
   url = "" -- Installable with `luarocks make` only
}
description = {
   summary = "#{PROJECT_NAME} #{JOINED_WSAPI} nginx Configuration for #{CLUSTER_NAME}",
   homepage = "http://#{PROJECT_DOMAIN}",
   license = "Unpublished closed-source!",
   maintainer = "#{MAINTAINER}"
}
supported_platforms = {
   "unix"
}
dependencies = {
}
build = {
   type = "none",
      copy_directories = {
      "cluster/#{CLUSTER_NAME}/nginx/#{JOINED_WSAPI}";
      "cluster/#{CLUSTER_NAME}/logrotate/#{JOINED_WSAPI}";
   }
}
