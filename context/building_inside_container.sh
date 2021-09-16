/repo init
.repo/repo/repo init  --no-clone-bundle --repo-url https://gitlab.com/firefly-linux/git-repo.git -u https://gitlab.com/firefly-linux/manifests.git -b master -m rv1126_rv1109_linux_release.xml
.repo/repo/repo sync -c
FORCE_UNSAFE_CONFIGURE=1 ./build.sh

