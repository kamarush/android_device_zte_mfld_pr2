
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <endian.h>

#include "bootheader.h"

#define ERROR(...) do { fprintf(stderr, __VA_ARGS__); return 1; } while(0)
#define CMDLINE_END (0x600)

int main(int argc, char *argv[])
{
	char *origin;
	char *bzImage;
	char *ramdisk;
	FILE *forigin;
	FILE *fbzImage;
	FILE *framdisk;
	uint32_t bzImageLen;
	uint32_t ramdiskLen;
	uint32_t missing;
	char buf[BUFSIZ];
	size_t size;

	if (argc != 4)
		ERROR("Usage: %s <image to unpack> <bzImage out> <ramdisk out>\n", argv[0]);

	origin = argv[1];
	bzImage = argv[2];
	ramdisk = argv[3];

	forigin = fopen(origin, "r");
	fbzImage = fopen(bzImage, "w");
	framdisk = fopen(ramdisk, "w");
	if (!forigin || !bzImage || !framdisk)
		ERROR("ERROR: failed to open origin or output images\n");

	/* Read bzImage length from the image to unpack */
	if (fseek(forigin, CMDLINE_END, SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	if (fread(&bzImageLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read bzImage length\n");
	else
		bzImageLen = le32toh(bzImageLen);

	/* Read ramdisk length from the image to unpack */
	if (fseek(forigin, (CMDLINE_END+sizeof(uint32_t)), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek on image\n");

	if (fread(&ramdiskLen, sizeof(uint32_t), 1, forigin) != 1)
		ERROR("ERROR: failed to read ramdisk length\n");
	else
		ramdiskLen = le32toh(ramdiskLen);

	/* Copy bzImage */
	if (fseek(forigin, sizeof(struct bootheader), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying bzImage\n");

	missing = bzImageLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size != 0) {
			fwrite(buf, 1, size, fbzImage);
			missing -= size;
		}
	}

	/* Copy ramdisk */
	if (fseek(forigin, (sizeof(struct bootheader)+bzImageLen), SEEK_SET) == -1)
		ERROR("ERROR: failed to seek when copying ramdisk\n");

	missing = ramdiskLen;
	while (missing > 0) {
		size = fread(buf, 1, ((missing > BUFSIZ) ? BUFSIZ : missing), forigin);
		if (size != 0) {
			fwrite(buf, 1, size, framdisk);
			missing -= size;
		}
	}

	return 0;
}
