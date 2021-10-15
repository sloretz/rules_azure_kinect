workspace(name='rules_azure_kinect')

load('//azure-macro-utils-c:repository.bzl', 'azure_macro_utils_c')
load('//azure-umock-c:repository.bzl', 'azure_umock_c')
load('//azure-c-shared-utility:repository.bzl', 'azure_c_shared_utility')
load('//Azure-Kinect-Sensor-SDK:repository.bzl', 'azure_kinect_sensor_sdk')
load('//cjson:repository.bzl', 'cjson')
load('//libusb:repository.bzl', 'libusb_debian')
# load('//cjson/repository.bzl', 'libcjson_dev')

libusb_debian()
cjson()

azure_macro_utils_c()
azure_umock_c()
azure_c_shared_utility()
azure_kinect_sensor_sdk()
