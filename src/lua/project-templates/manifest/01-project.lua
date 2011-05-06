--------------------------------------------------------------------------------
-- manifest/project.lua: project description
--------------------------------------------------------------------------------

-- TODO: DSL-ize!
-- TODO: Validate a-la tools-cli-config (does not harm dsl-isation!!!)

PROJECT_TITLE = "#{PROJECT_NAME}"
title = PROJECT_TITLE

PROJECT_PATH = "${PROJECT_PATH}"
project_path = PROJECT_PATH

local_rocks_repo_path =
  PROJECT_PATH .. "/../deployment/cluster/${CLUSTER_NAME}/rocks"
local_rocks_git_repo_path = PROJECT_PATH .. "/../deployment"

local_cluster_versions_path =
  PROJECT_PATH .. "/../deployment/cluster/${CLUSTER_NAME}/versions"
local_cluster_versions_git_repo_path = PROJECT_PATH .. "/../deployment"

subtrees =
{
  {
    name = "lua-nucleo";
    git = PROJECT_PATH;
    path = "lib/lua-nucleo";
    url = "https://github.com/lua-nucleo/lua-nucleo.git";
    branch = "pk/engine";
  };
  {
    name = "lua-aplicado";
    git = PROJECT_PATH;
    path = "lib/lua-aplicado";
    url = "https://github.com/lua-aplicado/lua-aplicado.git";
    branch = "pk/engine";
  };
  {
    name = "pk-core";
    git = PROJECT_PATH;
    path = "lib/pk-core";
    url = "gitolite@git.iphonestudio.ru:pk-core.git";
    branch = "pk/banner";
  };
  {
    name = "pk-engine";
    git = PROJECT_PATH;
    path = "lib/pk-engine";
    url = "gitolite@git.iphonestudio.ru:pk-engine.git";
    branch = "pk/banner";
  };
  {
    name = "pk-tools";
    git = PROJECT_PATH;
    path = "lib/pk-tools";
    url = "gitolite@git.iphonestudio.ru:pk-tools.git";
    branch = "master";
  };
  {
    name = "pk-foreign-rocks";
    git = PROJECT_PATH;
    path = "lib/pk-foreign-rocks";
    url = "gitolite@git.iphonestudio.ru:pk-foreign-rocks.git";
    branch = "master";
  };
}
