#!/bin/bash
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"
# setup constants
REPO="webgpu.github.io"
GH_REPO="github.com/webgpu/${REPO}.git"
MSG=$(git log -1 --oneline)
git config --global user.email "dakkak@illinois.edu"
git config --global user.name "Abdul Dakkak"

# Build the project.
hugo -t academic # if using a theme, replace by 'hugo -t <yourtheme>'

git clone "https://$GH_REPO"
# clean up repo
cd  ${REPO}
rm -rf *
cd ..
# copy files to commit
cp -R public/* ${REPO}
cd ${REPO}
git remote
git add -A :/
git commit -a -m "via travis -- for $MSG"
git push "https://${GH_TOKEN}@${GH_REPO}" gh-pages > /dev/null 2>&1
