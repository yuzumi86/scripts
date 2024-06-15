# Remove local_manifests directory

# Clone the source
repo init -u https://github.com/CipherOS/android_manifest.git -b twelve-L

# Clone the manifest repository
rm -rf device/realme/even
git clone https://github.com/yuzumi86/device_realme_even --depth 1 -b master ./device/realme/even
rm -rf kernel/realme/even
git clone --recurse-submodules --depth=1 https://github.com/yuzumi86/kernel_realme_even -b OSS-KSU-R ./kernel/realme/even
rm -rf vendor/realme/even
git clone --depth=1 https://github.com/cumaRull/vendor_realme_even -b rmui2 ./vendor/realme/even
rm -rf packages/apps/RealmeParts
git clone --depth=1 https://github.com/Realme-C25-Series-Development/android_packages_apps_RealmeParts -b aosp12 ./packages/apps/RealmeParts
rm -rf vendor/realme/even-ims
git clone --depth=1 https://github.com/eun0115/vendor_oplus_even-ims -b twelve-rmui2 ./vendor/realme/even-ims
rm -rf prebuilt/clang/zycClang
git clone --depth=1 https://gitlab.com/clangsantoni/zyc_clang -b 14 ./prebuilt/clang/zycClang

# Sync the repositories
/opt/crave/resync.sh

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
