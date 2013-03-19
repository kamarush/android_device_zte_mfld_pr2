
#include <stdint.h>

#ifndef __BOOTHEADER__
#define __BOOTHEADER__

#define CMDLINE_SIZE   						(0x400)
#define PADDING1_SIZE						(0x1200-0x610)
#define BOOTSTUBSTACK_SIZE					(0x1000)

typedef struct __attribute__ ((packed)) {
	uint8_t something1[0x30]; /* FIXME figure out what it is */
	uint32_t sectors;         /* number of sectors after the boot sector, 1 sector = 512 bytes */
	uint8_t something2[0x4];  /* FIXME figure out what it is */
	uint8_t oxff[0x180];      /* lots of 0xFF */
	uint8_t zeros[0x46];      /* lots of zeros */
	uint16_t bootSignature;
} bootsector_t;

struct bootheader {
	bootsector_t bootSector;
	uint8_t cmdline[CMDLINE_SIZE];
	uint32_t bzImageSize;
	uint32_t initrdSize;
	uint32_t SPIUARTSuppression;
	uint32_t SPIType;
	uint8_t padding1[PADDING1_SIZE];
	uint8_t bootstubStack[BOOTSTUBSTACK_SIZE];
} __attribute__((packed));

/* Sanity check for struct size */
typedef char z[(sizeof(struct bootheader) == 0x2200) ? 1 : -1];

#endif
