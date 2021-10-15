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

def _libusb_debian_impl(repository_ctx):
    # Get from libusb-1.0-0-dev
    repository_ctx.symlink(
        '/usr/include/libusb-1.0/libusb.h',
        'include/libusb.h',
    )

    repository_ctx.symlink(
        '/usr/lib/x86_64-linux-gnu/libusb-1.0.so',
        'lib/libusb-1.0.so',
    )

    repository_ctx.symlink(
        Label('@rules_azure_kinect//libusb:package-debian.BUILD.bazel'),
        'BUILD'
    )

_libusb_debian_repository = repository_rule(
    local = True,
    configure = True,
    implementation = _libusb_debian_impl,
)

def libusb_debian():
    maybe(
        _libusb_debian_repository,
        name='libusb'
    )



def libusb():
    pass
    # maybe(
    #     _libusb_repository,
    #     name='libusb'
    # )
