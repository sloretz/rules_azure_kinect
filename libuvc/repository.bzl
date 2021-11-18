# Copyright 2021 Shane Loretz
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load('@bazel_tools//tools/build_defs/repo:git.bzl', 'new_git_repository')
load('@bazel_tools//tools/build_defs/repo:utils.bzl', 'maybe')


def libuvc():
    # libuvc hasn't had a new release in a while
    maybe(
        new_git_repository,
        name='libuvc',
        commit='92621946160855f8154c35ca4f0299f5392f6c93',
        remote='https://github.com/libuvc/libuvc.git',
        build_file='@rules_azure_kinect//libuvc:package.BUILD.bazel',
    )
