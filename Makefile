CROSS_COMPILE=mipsel-linux-
CC = ${CROSS_COMPILE}gcc
CXX = ${CROSS_COMPILE}g++
LIBS = -lpthread

CFLAGS = -O2 -fPIC

INC+=-I. -I /root/openwrt_widora/build_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/madplay-alsa/madplay-0.15.2b -I /root/openwrt_widora/build_dir/target-mipsel_24kec+dsp_uClibc-0.9.33.2/libmad-0.15.1b -I /home/sanchrist/alsa-lib-1.0.25/include

#LDFLAGS =  -lupnp -lthreadutil -lixml -lasound -lpthread  -lushare -ltag -lping -lcrypto -lmuti_server


OBJECTS = $(SOURCES:.c=.o)
all:madplay 

#all:libCLog.so libcheckservice.so libboxutils.so libFileScan.so libhttpclient.so resetapp libssdp.so SetLevel

#libboxutils.so:register.o checknetwork.o md5.o  comm_timer.o
#	$(CXX) -fPIC -shared -o $@ register.o checknetwork.o md5.o  comm_timer.o -L$(DREAM_DIR)/lib -lcrypto
#	mipsel-linux-strip libboxutils.so
#	cp libboxutils.so $(BOX_DIR)/app/lib
#	cp register.h $(BOX_DIR)/app/include
#	cp md5.h $(BOX_DIR)/app/include
#	cp didl.h $(BOX_DIR)/app/include
#	cp ifc.h $(BOX_DIR)/app/include
#	cp comm_timer.h $(BOX_DIR)/app/include



#libhttpclient.so:httpclient.o didl.o buffer.o md5.o
#	$(CXX) -fPIC -shared -o $@ httpclient.o didl.o buffer.o md5.o -L$(DREAM_DIR)/lib -lCLog
#	mipsel-linux-strip $@
#	cp libhttpclient.so $(BOX_DIR)/app/lib
#	cp httpclient.h $(BOX_DIR)/app/include
	
madplay:main.o audio_alsa.o audio.o player.o resample.o wplayer.o 
	$(CXX) -o $@ main.o audio_alsa.o audio.o player.o resample.o wplayer.o -L. -lmad -lasound -lpthread 

.c.o:
	$(CC)  $(INC) $(CFLAGS) -c -o $@ $<

.cpp.o:
	$(CXX)  $(INC) $(CFLAGS) -c -o $@ $<
clean:
	rm -rf $(OBJECTS) *.o madplay 

