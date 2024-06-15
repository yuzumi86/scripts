# Remove local_manifests directory
rm -rf .repo/local_manifests

# Clone the source
repo init -u https://github.com/CipherOS/android_manifest.git -b twelve-L

# Clone the manifest repository
git clone https://github.com/yuzumi86/local_manifest --depth 1 -b main .repo/local_manifests

# Sync the repositories
/opt/crave/resync.sh

#Extra
rm -rf prebuilts/clang/host/linux-x86/clang-r450784d
git clone https://gitlab.com/ImSurajxD/clang-r450784d -b master prebuilts/clang/host/linux-x86/clang-r450784d
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_USERNAME=ismasrull 
export BUILD_HOSTNAME=TRIDENT
export TZ=Asia/Jakarta

# Set up the build environment
source build/envsetup.sh
repo forall -c 'git lfs install && git lfs pull && git lfs checkout'

# Lunch for even device
lunch cipher_even-userdebug

# Build for even device
mka bacon
