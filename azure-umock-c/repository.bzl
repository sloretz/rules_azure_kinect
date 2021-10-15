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

def azure_umock_c():
    maybe(
        new_git_repository,
        name='azure-umock-c',
        commit='5e3d93112360ee2d4a622b1c48eb70896da3e8c7',
        remote='https://github.com/Azure/umock-c.git',
        build_file='@rules_azure_kinect//azure-umock-c:package.BUILD.bazel',
    )
