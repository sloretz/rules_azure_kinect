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


def _configure_file_impl(ctx):
    # Declare file that will be written to
    out = ctx.actions.declare_file(ctx.attr.output_file)

    # handle @ONLY, but not handling @@
    substitutions = {}
    for key, value in ctx.attr.vars.items():
        substitutions['@' + key + '@'] = str(value)
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.input_file,
        substitutions = substitutions
    )

    return [DefaultInfo(files = depset([out]))]


configure_file = rule(
    implementation = _configure_file_impl,
    attrs = {
        'input_file': attr.label(allow_single_file = True, mandatory=True),
        'output_file': attr.string(mandatory=True),
        'vars': attr.string_dict()
    },
)

