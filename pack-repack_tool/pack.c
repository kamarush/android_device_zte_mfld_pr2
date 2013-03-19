
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <endian.h>

#include "bootheader.h"

#define ERROR(...) do { fprintf(stderr, __VA_ARGS__); return 1; } while(0)

int main(int argc, char *argv[])
{
	char *origin;
	char *bzImage;
	char *ramdisk;
	char *output;
	FILE *forigin;
	FILE *foutput;
	FILE *fbzImage;
	FILE *framdisk;
	struct stat st;
	uint32_t tmp;
	char buf[BUFSIZ];
	size_t size;
	struct bootheader *file;

	if (argc != 5) {
		ERROR("Usage: %s <valid image> <bzImage> <ramdisk> <output>\n", argv[0]);
	}

	origin = argv[1];
	bzImage = argv[2];
	ramdisk = argv[3];
	output = argv[4];

	forigin = fopen(origin, "rb");
	fbzImage = fopen(bzImage, "rb");
	framdisk = fopen(ramdisk, "rb");
	foutput = fopen(output, "wb");
	if (!forigin || !foutput)
		ERROR("ERROR: failed to open origin or output image\n");

	/* Allocate memory and copy bootstub to it */
	file = malloc(sizeof(struct bootheader));
	if (file == NULL)
		ERROR("ERROR allocating memory\n");

	if (fread(file, sizeof(struct bootheader), 1, forigin) != 1)
		ERROR("ERROR reading bootstub\n");

	/* Figure out the bzImage size and set it */
	if (stat(bzImage, &st) == 0) {
		tmp = st.st_size;
		file->bzImageSize = htole32(tmp);
	} else
		ERROR("ERROR reading bzImage size\n");

	/* Figure out the ramdisk size and set it */
	if (stat(ramdisk, &st) == 0) {
		tmp = st.st_size;
		file->initrdSize = htole32(tmp);
	} else
		ERROR("ERROR reading ramdisk\n");

	uint32_t usefulSize = sizeof(struct bootheader) + file->bzImageSize + file->initrdSize;
	uint32_t placeHolderSize = 0;
	if (usefulSize % 512) {
		placeHolderSize = ((usefulSize / 512) + 1) * 512 - usefulSize;
	}

	file->bootSector.sectors = ((usefulSize + placeHolderSize) / 512) - 1;

	/* Write the patched bootstub to the new image */
	if (fwrite(file, sizeof(struct bootheader), 1, foutput) != 1)
		ERROR("ERROR writing image\n");

	/* Then copy the new bzImage */
	while ((size = fread(buf, 1, BUFSIZ, fbzImage))) {
		fwrite(buf, 1, size, foutput);
	}

	/* And finally copy the ramdisk */
	while ((size = fread(buf, 1, BUFSIZ, framdisk))) {
		fwrite(buf, 1, size, foutput);
	}

	char placeHolder[] = {"\xFF"};
	for (uint32_t i = 0; i < placeHolderSize; i++) {
		fwrite(placeHolder, 1, 1, foutput);
	}

	return 0;
}
