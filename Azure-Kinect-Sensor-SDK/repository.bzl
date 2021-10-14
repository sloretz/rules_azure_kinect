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


def azure_kinect_sensor_sdk():
    maybe(
        http_archive,
        name='Azure-Kinect-Sensor-SDK',
        url='https://github.com/microsoft/Azure-Kinect-Sensor-SDK/archive/refs/tags/v1.4.1.tar.gz',
        sha256='73106554449c64aff6b068078f0eada50c4474e99945b5ceb6ea4aab9a68457f',
        build_file='@rules_azure_kinect//Azure-Kinect-Sensor-SDK:package.BUILD.bazel',
        strip_prefix='Azure-Kinect-Sensor-SDK-1.4.1'
    )
