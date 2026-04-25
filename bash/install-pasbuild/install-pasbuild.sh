
## Installation de [PasBuild](https://github.com/graemeg/PasBuild)

DIR=pasbuild

git clone --single-branch --depth 1 https://github.com/graemeg/PasBuild.git $DIR

cd $DIR
mkdir -p target/units
sed 's/\${project.version}/1.0.0/g' src/main/resources/version.inc > target/version.inc

fpc -Mobjfpc -O1 \
-FEtarget \
-FUtarget/units \
-Fitarget \
-Fusrc/main/pascal \
src/main/pascal/PasBuild.pas

./target/PasBuild --version
./target/PasBuild compile

./target/pasbuild --version

sudo cp -fv target/pasbuild /usr/local/bin/pasbuild
pasbuild --version
