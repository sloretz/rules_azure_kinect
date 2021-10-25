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

load('@rules_azure_kinect//util:configure_file.bzl', 'configure_file')


template_content = """
/* 
CMake - Cross Platform Makefile Generator
Copyright 2000-2018 Kitware, Inc. and Contributors
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

* Neither the name of Kitware, Inc. nor the names of Contributors
  may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/* Copied from
  Repo: https://github.com/Kitware/CMake
  Commit: f4082b0e9b1ce139a29fba5951cec068862fe28b
*/

#ifndef @INCLUDE_GUARD_NAME@
#define @INCLUDE_GUARD_NAME@

#ifdef @STATIC_DEFINE@
#  define @EXPORT_MACRO_NAME@
#  define @NO_EXPORT_MACRO_NAME@
#else
#  ifndef @EXPORT_MACRO_NAME@
#    ifdef @EXPORT_IMPORT_CONDITION@
        /* We are building this library */
#      define @EXPORT_MACRO_NAME@ @DEFINE_EXPORT@
#    else
        /* We are using this library */
#      define @EXPORT_MACRO_NAME@ @DEFINE_IMPORT@
#    endif
#  endif

#  ifndef @NO_EXPORT_MACRO_NAME@
#    define @NO_EXPORT_MACRO_NAME@ @DEFINE_NO_EXPORT@
#  endif
#endif

#ifndef @DEPRECATED_MACRO_NAME@
#  define @DEPRECATED_MACRO_NAME@ @DEFINE_DEPRECATED@
#endif

#ifndef @DEPRECATED_MACRO_NAME@_EXPORT
#  define @DEPRECATED_MACRO_NAME@_EXPORT @EXPORT_MACRO_NAME@ @DEPRECATED_MACRO_NAME@
#endif

#ifndef @DEPRECATED_MACRO_NAME@_NO_EXPORT
#  define @DEPRECATED_MACRO_NAME@_NO_EXPORT @NO_EXPORT_MACRO_NAME@ @DEPRECATED_MACRO_NAME@
#endif

#if @DEFINE_NO_DEPRECATED@ /* DEFINE_NO_DEPRECATED */
#  ifndef @NO_DEPRECATED_MACRO_NAME@
#    define @NO_DEPRECATED_MACRO_NAME@
#  endif
#endif
@CUSTOM_CONTENT@
#endif /* @INCLUDE_GUARD_NAME@ */
"""


def _write_file_impl(ctx):
    ctx.actions.write(
        output=ctx.outputs.out,
        content=ctx.attr.content,
    )
    return [DefaultInfo(files = depset([ctx.outputs.out]))]


write_file = rule(
    implementation=_write_file_impl,
    attrs = {
        'out': attr.output(mandatory=True),
        'content': attr.string(mandatory=True)
    }
)


def generate_export_header(
    out,
    library_name,
    name=None,
    base_name=None,
    export_macro_name=None,
    # export_file_name=None,  # Use `out` instead
    deprecated_macro_name=None,
    no_export_macro_name=None,
    include_guard_name=None,
    static_define=None,
    no_deprecated_macro_name=None,
    define_no_deprecated=False,
    prefix_name=None,
    custom_content_from_variable=''
    ):
    if base_name == None:
        base_name = library_name.upper()
      
    if not export_macro_name:
        export_macro_name = base_name + '_EXPORT'

    if not deprecated_macro_name:
        deprecated_macro_name = base_name + '_DEPRECATED'

    if not no_export_macro_name:
        no_export_macro_name = base_name + '_NO_EXPORT'

    if not include_guard_name:
        include_guard_name = base_name + '_EXPORT_H'

    if not static_define:
        static_define = base_name + '_STATIC_DEFINE'

    if not no_deprecated_macro_name:
        no_deprecated_macro_name = base_name + '_NO_DEPRECATED'

    if define_no_deprecated:
        define_no_deprecated = '1'
    else:
        define_no_deprecated = '0'

    substitutions = {
        'EXPORT_MACRO_NAME': export_macro_name,
        'DEPRECATED_MACRO_NAME': deprecated_macro_name,
        'NO_EXPORT_MACRO_NAME': no_export_macro_name,
        'INCLUDE_GUARD_NAME': include_guard_name,
        'STATIC_DEFINE': static_define,
        'NO_DEPRECATED_MACRO_NAME': no_deprecated_macro_name,
        'DEFINE_NO_DEPRECATED': define_no_deprecated,
        'DEFINE_EXPORT': '__attribute__((visibility("default")))',
        'EXPORT_IMPORT_CONDITION': library_name + '_EXPORTS',
        'DEFINE_DEPRECATED': '__attribute__ ((__deprecated__))',
        'DEFINE_IMPORT': '__attribute__((visibility("default")))',
        'DEFINE_NO_EXPORT': '__attribute__((visibility("hidden")))',
        'CUSTOM_CONTENT': custom_content_from_variable,
    }

    # Write the template file into the sandbox
    template_location = '__generate_export_header__/' + name + '/export.h.in'
    write_file(
        name=name + '__write_template',
        out=template_location,
        content=template_content
    )

    # Configure the template file
    configure_file(
        name=name,
        template=template_location,
        out=out,
        vars=substitutions
    )
