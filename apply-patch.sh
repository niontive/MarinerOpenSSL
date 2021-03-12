#!/bin/bash

echo "********* Applying CBL-Mariner Patches"

declare -a cblPatches=("CVE-2019-0190.nopatch"
                       "0001-Replacing-deprecated-functions-with-NULL-or-highest.patch"
                       "openssl-1.1.1-ec-curves.patch"
                       "openssl-1.1.1-no-brainpool.patch"
                       "openssl-1.1.0-issuer-hash.patch"
                       "openssl-1.1.1-fips.patch"
                       "openssl-1.1.1-version-override.patch"
                       "openssl-1.1.1-seclevel.patch"
                       "openssl-1.1.1-fips-post-rand.patch"
                       "openssl-1.1.1-evp-kdf.patch"
                       "openssl-1.1.1-ssh-kdf.patch"
                       "openssl-1.1.1-krb5-kdf.patch"
                       "openssl-1.1.1-edk2-build.patch"
                       "openssl-1.1.1-fips-crng-test.patch"
                       "openssl-1.1.1-fips-drbg-selftest.patch"
                       "openssl-1.1.1-fips-dh.patch"
                       "openssl-1.1.1-s390x-ecc.patch"
                       "openssl-1.1.1-kdf-selftest.patch"
                       "openssl-1.1.1-rewire-fips-drbg.patch"
                       "openssl-1.1.1-explicit-params.patch"
                       "openssl-1.1.1-fips-curves.patch"
                       "CVE-2020-1971.patch")

for i in "${cblPatches[@]}"
do
	patch -p1 < "$i"
done

echo "********* CBL-Mariner Patches Applied"
