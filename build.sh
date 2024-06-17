sudo apt install git-lfs
git lfs install
# Remove local_manifests directory
rm -rf .repo/local_manifests
git clone --depth=1 https://github.com/yuzumi86/local_manifest -b main .repo/local_manifests

# Clone the source
repo init -u https://github.com/LineageOS/android.git -b lineage-19.0

# Clone the manifest repository
rm -rf kernel/realme/even
git clone --recurse-submodules --depth=1 https://github.com/yuzumi86/kernel_realme_even -b OSS-KSU-R ./kernel/realme/even
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
lunch lineage_even-userdebug

# Build for even device
mka bacon
