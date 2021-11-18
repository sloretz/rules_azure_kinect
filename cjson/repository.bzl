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

load('@bazel_tools//tools/build_defs/repo:http.bzl', 'http_archive')
load('@bazel_tools//tools/build_defs/repo:utils.bzl', 'maybe')

def libcjson_dev():
    # Uses cjson from libcjson-dev Debian package
    # TODO do this on Focal
    pass


def cjson():
    maybe(
        http_archive,
        name='cjson',
        url='https://github.com/DaveGamble/cJSON/archive/refs/tags/v1.7.8.tar.gz',
        sha256='e2544bd48d98005b1d0f7dc8a02e1559f9d303b9d8120f130362a40b548bcfcd',
        build_file='@rules_azure_kinect//cjson:package.BUILD.bazel',
        strip_prefix='cJSON-1.7.8'
    )
