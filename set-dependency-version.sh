#!/bin/bash
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# (c) barthel <barthel@users.noreply.github.com> https://github.com/barthel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Replaces the version of a artifact in any kind of file.
#

# Include global functions
script_directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# shellcheck source=/dev/null #@see: https://github.com/koalaman/shellcheck/wiki/SC1090
. "${script_directory}/_set_dependencies_functions.sh"

# Find and execute scripts in the script directory starts with the file name _file_name_pattern
#   set-dependency-version-in*.sh
for set_script in ${script_directory}/set-dependency-version-in*.sh; do
  script_cmd="${set_script}"
  # append 'quiet' command line argument on each script execution if this script was executed
  # with a 'quiet' command line argument
  [ 0 -lt ${quiet} ] && script_cmd=$(_append_quiet_parameter "${script_cmd}")
  # append 'verbose' command line argument on each script execution if this script was executed
  # with a 'verbose' command line argument
  [ 0 -lt ${verbose} ] && script_cmd=$(_append_verbose_parameter "${script_cmd}")
  # append all other  command line arguments
  script_cmd="${script_cmd} ${*}"
  [ 0 -lt ${quiet} ] || echo "Execute: ${script_cmd}"
  # execute the script
  ${script_cmd}
  [ 0 != $? ] && exit $? || true
done
