CFLAGS=-Wall -fPIC -I/usr/local/include
LIBS=-L/usr/local/lib -lNgramsLocations

all: libClassifier

test: testClassifier
	./testClassifier test-map.ngt

testClassifier: Makefile classifier.h testClassifier.c
	gcc ${CFLAGS} -o testClassifier testClassifier.c ${LIBS} -lClassifier

libClassifier: Makefile classifier.o classifier.h
	gcc -shared -o libClassifier.so.1.0 classifier.o ${LIBS}

classifier.o: Makefile classifier.h classifier.c
	gcc ${CFLAGS} -c classifier.c -o classifier.o

install:
	cp libClassifier.so.1.0 /usr/local/lib
	ln -sf /usr/local/lib/libClassifier.so.1.0 /usr/local/lib/libClassifier.so.1
	ln -sf /usr/local/lib/libClassifier.so.1.0 /usr/local/lib/libClassifier.so
	ldconfig /usr/local/lib
	cp classifier.h /usr/local/include/classifier.h

clean:
	rm *.o; rm *.so*; rm core*; rm testClassifier
