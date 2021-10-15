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

load('@bazel_tools//tools/build_defs/repo:utils.bzl', 'maybe')

def _spdlog_debian_impl(repository_ctx):
    # Get from spdlog-1.0-0-dev
    repository_ctx.symlink(
        '/usr/include/spdlog/',
        'include/spdlog/',
    )

    repository_ctx.symlink(
        Label('@rules_azure_kinect//spdlog:package.BUILD.bazel'),
        'BUILD'
    )

_spdlog_repository = repository_rule(
    local = True,
    configure = True,
    implementation = _spdlog_debian_impl,
)

def spdlog_debian():
    maybe(
        _spdlog_repository,
        name='spdlog'
    )
