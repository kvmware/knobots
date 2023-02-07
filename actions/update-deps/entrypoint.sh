#!/bin/bash

# Copyright 2021 The Knative Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

deplog=""

# Ensure files have the same owner as the checkout directory.
# See https://github.com/knative-sandbox/knobots/issues/79
chown -R --reference=. main
# This has been moved here because the scripts below use `git`
# and the parent directory does not match the docker user and
# thus gives an error. For more info see:
# https://github.com/git/git/commit/8959555cee7ec045958f9b6dd62e541affb7e7d9

cd main
echo "::set-output name=update-dep-cmd::./hack/update-deps.sh --upgrade ${releaseFlags[@]}"
deplog=`git status`
echo "::set-output name=log::$deplog"
