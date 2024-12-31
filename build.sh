#!/bin/bash

# check if we're in vercel CI
# if [ -n "$VERCEL" ]; then
# 	yum update -y
# 	yum install -y tar cmake python3 git llvm clang diffutils
#
# 	rm -rf emsdk
# 	git clone https://github.com/emscripten-core/emsdk.git
# 	cd emsdk || exit
# 	./emsdk install latest
# 	./emsdk activate latest
# 	# shellcheck disable=SC1091
# 	source ./emsdk_env.sh
# 	cd ..
# fi

# exit if DOOM_WAD_URL is not set
if [ ! -f "sdldoom-1.10/doom1.wad" ]; then
	if [ -z "$DOOM_WAD_URL" ]; then
		echo "DOOM_WAD_URL is not set. Please set it to the URL of the DOOM WAD file."
		exit 1
	fi
	curl "$DOOM_WAD_URL" -s -L -o sdldoom-1.10/doom1.wad
	sha1sum sdldoom-1.10/doom1.wad
fi

cd sdldoom-1.10 || exit
export EMCC_CFLAGS="-std=gnu89 -sUSE_SDL"
emconfigure ./configure
emmake make
emcc -o index.html ./*.o --preload-file doom1.wad \
	-s ALLOW_MEMORY_GROWTH=1 --shell-file ../shell.html
mkdir -p ../public
mv index.* ../public
