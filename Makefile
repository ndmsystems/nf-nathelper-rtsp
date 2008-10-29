ifneq ($(KERNELRELEASE),)
# kbuild part of makefile
ifndef CONFIG_NF_CONNTRACK
$(error ** You need to enable NF_CONNTRACK in your kernel **)
endif

obj-$(CONFIG_NF_CONNTRACK) := nf_conntrack_rtsp.o nf_nat_rtsp.o
else

# Normal Makefile

KERNELDIR := /lib/modules/`uname -r`/build
all: 
	$(MAKE) -C $(KERNELDIR) M=`pwd` modules

debug:
	$(MAKE) -C $(KERNELDIR) EXTRA_CFLAGS=-DDEBUG M=`pwd` modules

modules_install:
	$(MAKE) -C $(KERNELDIR) M=`pwd` modules_install

clean:
	rm -f *.o *.ko *.mod.c
	rm -f .*.cmd
	rm -f Module.symvers modules.order 
	rm -rf .tmp_versions

endif
