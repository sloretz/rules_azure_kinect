# Copyright 2021 Shane Loretz
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

load('@bazel_tools//tools/build_defs/repo:git.bzl', 'new_git_repository')
load('@bazel_tools//tools/build_defs/repo:utils.bzl', 'maybe')

def azure_macro_utils_c():
    maybe(
        new_git_repository,
        name='azure-macro-utils-c',
        commit='5b1073c4217f47ab4c536b433e4609db3db313b5',
        remote='https://github.com/Azure/macro-utils-c.git',
        build_file='@rules_azure_kinect//azure-macro-utils-c:package.BUILD.bazel',
    )

