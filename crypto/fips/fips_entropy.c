# include <jitterentropy.h>
# include <openssl/fips.h>

#include "crypto/fips.h"

static int fips_entropy_init = 0;

int FIPS_init_entropy(void)
{
    int rv = 1;

    if (jent_entropy_init() != 0) {
        rv = 0;
    } else {
        fips_entropy_init = 1;
    }

    return rv;
}

ssize_t FIPS_jitter_entropy(unsigned char *buf, size_t buflen)
{
    ssize_t ent_bytes = 0;
    struct rand_data* ec = NULL;

    if (buf == NULL || buflen == 0) {
        goto end;
    }

    /* Ensure entropy source has been initiated */
    if (!fips_entropy_init) {
        if  (!FIPS_init_entropy()) {
            goto end;
        }
    }

    /* Allocate entropy collector */
    ec = jent_entropy_collector_alloc(1, JENT_FORCE_FIPS);
    if (ec == NULL) {
        goto end;
    }

    /* Get entropy */
    ent_bytes = jent_read_entropy(ec, (char *)buf, buflen);

end:
    /* Free entropy collector */
    if (ec != NULL) {
        jent_entropy_collector_free(ec);
    }

    return ent_bytes;
}