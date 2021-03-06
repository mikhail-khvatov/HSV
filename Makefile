# PATHS.
SRC_PREFIX=src/
BIN_PREFIX=bin/
LIBS_PREFIX=.libs/
OBJS_PREFIX=.objs/

CC=gcc

# TYPES.
HSV_TYPES=hsv_types/
HSV_TYPES_SRC_PREFIX=$(SRC_PREFIX)$(HSV_TYPES)
HSV_TYPES_FILE=$(HSV_TYPES_SRC_PREFIX)hsv_types.h

CFLAGS=-g -Wall -Wextra -std=c99 -Ofast -funroll-loops -I$(HSV_TYPES_SRC_PREFIX)

all: $(BIN_PREFIX)example

# RING BUFFER.
RB=rb
RB_PREFIX=$(RB)/
RB_SRC_PREFIX=$(SRC_PREFIX)$(RB_PREFIX)
RB_SRC=$(shell find $(RB_SRC_PREFIX) -maxdepth 1 -name '*.c')
RB_OBJS_PREFIX=$(OBJS_PREFIX)$(RB_PREFIX)
RB_OBJS=$(patsubst $(RB_SRC_PREFIX)%.c,$(RB_OBJS_PREFIX)%.o,$(RB_SRC))
RB_LIB_PREFIX=$(LIBS_PREFIX)$(RB_PREFIX)
RB_LIB=$(RB_LIB_PREFIX)$(RB).a
$(RB_LIB): $(RB_OBJS)
	mkdir -p $(RB_LIB_PREFIX)
	ar rcs $@ $^
$(RB_OBJS_PREFIX)%.o: $(RB_SRC_PREFIX)%.c $(RB_SRC_PREFIX)%.h
	mkdir -p $(RB_OBJS_PREFIX)
	$(CC) $(CFLAGS) -c $< -o $@

# UTILS.
UTILS=utils
UTILS_PREFIX=$(UTILS)/
UTILS_SRC_PREFIX=$(SRC_PREFIX)$(UTILS_PREFIX)
UTILS_SRC=$(shell find $(UTILS_SRC_PREFIX) -maxdepth 1 -name '*.c')
UTILS_OBJS_PREFIX=$(OBJS_PREFIX)$(UTILS_PREFIX)
UTILS_OBJS=$(patsubst $(UTILS_SRC_PREFIX)%.c,$(UTILS_OBJS_PREFIX)%.o,$(UTILS_SRC))
UTILS_LIB_PREFIX=$(LIBS_PREFIX)$(UTILS_PREFIX)
UTILS_LIB=$(UTILS_LIB_PREFIX)$(UTILS).a
$(UTILS_LIB): $(UTILS_OBJS)
	mkdir -p $(UTILS_LIB_PREFIX)
	ar rcs $@ $^
$(UTILS_OBJS_PREFIX)%.o: $(UTILS_SRC_PREFIX)%.c $(UTILS_SRC_PREFIX)%.h $(HSV_TYPES_FILE)
	mkdir -p $(UTILS_OBJS_PREFIX)
	$(CC) $(CFLAGS) -c $< -o $@

# DISCRETE FOURIER TRANSFORM.
DFT=dft
DFT_PREFIX=$(DFT)/
DFT_SRC_PREFIX=$(SRC_PREFIX)$(DFT_PREFIX)
DFT_SRC=$(shell find $(DFT_SRC_PREFIX) -maxdepth 1 -name '*.c')
DFT_OBJS_PREFIX=$(OBJS_PREFIX)$(DFT_PREFIX)
DFT_OBJS=$(patsubst $(DFT_SRC_PREFIX)%.c,$(DFT_OBJS_PREFIX)%.o,$(DFT_SRC))
DFT_LIB_PREFIX=$(LIBS_PREFIX)$(DFT_PREFIX)
DFT_LIB=$(DFT_LIB_PREFIX)$(DFT).a
$(DFT_LIB): $(DFT_OBJS)
	mkdir -p $(DFT_LIB_PREFIX)
	ar rcs $@ $^
$(DFT_OBJS_PREFIX)%.o: $(DFT_SRC_PREFIX)%.c $(DFT_SRC_PREFIX)%.h $(HSV_TYPES_FILE)
	mkdir -p $(DFT_OBJS_PREFIX)
	$(CC) $(CFLAGS) -c $< -o $@

# ESTIMATOR.
ESTIMATOR=estimator
ESTIMATOR_PREFIX=$(ESTIMATOR)/
ESTIMATOR_SRC_PREFIX=$(SRC_PREFIX)$(ESTIMATOR_PREFIX)
ESTIMATOR_SRC=$(shell find $(ESTIMATOR_SRC_PREFIX) -maxdepth 1 -name '*.c')
ESTIMATOR_OBJS_PREFIX=$(OBJS_PREFIX)$(ESTIMATOR_PREFIX)
ESTIMATOR_OBJS=$(patsubst $(ESTIMATOR_SRC_PREFIX)%.c,$(ESTIMATOR_OBJS_PREFIX)%.o,$(ESTIMATOR_SRC))
ESTIMATOR_LIB_PREFIX=$(LIBS_PREFIX)$(ESTIMATOR_PREFIX)
ESTIMATOR_LIB=$(ESTIMATOR_LIB_PREFIX)$(ESTIMATOR).a
$(ESTIMATOR_LIB): $(ESTIMATOR_OBJS)
	mkdir -p $(ESTIMATOR_LIB_PREFIX)
	ar rcs $@ $^
$(ESTIMATOR_OBJS_PREFIX)%.o: $(ESTIMATOR_SRC_PREFIX)%.c $(ESTIMATOR_SRC_PREFIX)%.h $(HSV_TYPES_FILE)
	mkdir -p $(ESTIMATOR_OBJS_PREFIX)
	$(CC) $(CFLAGS) -c $< -o $@

# SUPPRESSOR.
SUPPRESSOR=suppressor
SUPPRESSOR_PREFIX=$(SUPPRESSOR)/
SUPPRESSOR_SRC_PREFIX=$(SRC_PREFIX)$(SUPPRESSOR_PREFIX)
SUPPRESSOR_SRC=$(shell find $(SUPPRESSOR_SRC_PREFIX) -maxdepth 1 -name '*.c')
SUPPRESSOR_OBJS_PREFIX=$(OBJS_PREFIX)$(SUPPRESSOR_PREFIX)
SUPPRESSOR_OBJS=$(patsubst $(SUPPRESSOR_SRC_PREFIX)%.c,$(SUPPRESSOR_OBJS_PREFIX)%.o,$(SUPPRESSOR_SRC))
SUPPRESSOR_LIB_PREFIX=$(LIBS_PREFIX)$(SUPPRESSOR_PREFIX)
SUPPRESSOR_LIB=$(SUPPRESSOR_LIB_PREFIX)$(SUPPRESSOR).a
$(SUPPRESSOR_LIB): $(SUPPRESSOR_OBJS)
	mkdir -p $(SUPPRESSOR_LIB_PREFIX)
	ar rcs $@ $^
$(SUPPRESSOR_OBJS_PREFIX)%.o: $(SUPPRESSOR_SRC_PREFIX)%.c $(SUPPRESSOR_SRC_PREFIX)%.h $(DFT_SRC_PREFIX)dft.h $(UTILS_SRC_PREFIX)utils.h $(HSV_TYPES_FILE)
	mkdir -p $(SUPPRESSOR_OBJS_PREFIX)
	$(CC) $(CFLAGS) -I$(DFT_SRC_PREFIX) -I$(UTILS_SRC_PREFIX) -c $< -o $@

# HSV.
HSV=hsv
HSV_SRC_PREFIX=$(SRC_PREFIX)
HSV_SRC=$(shell find $(HSV_SRC_PREFIX) -maxdepth 1 -name '*.c')
HSV_OBJS_PREFIX=$(OBJS_PREFIX)
HSV_OBJS=$(patsubst $(HSV_SRC_PREFIX)%.c,$(HSV_OBJS_PREFIX)%.o,$(HSV_SRC))
HSV_LIB_PREFIX=$(LIBS_PREFIX)
HSV_LIB=$(HSV_LIB_PREFIX)$(HSV).a
$(HSV_LIB): $(HSV_OBJS)
	mkdir -p $(HSV_LIB_PREFIX)
	ar rcs $@ $^
$(HSV_OBJS_PREFIX)%.o: $(HSV_SRC_PREFIX)%.c $(HSV_SRC_PREFIX)%.h $(HSV_SRC_PREFIX)/hsv_priv.h $(HSV_TYPES_FILE)
	mkdir -p $(HSV_OBJS_PREFIX)
	$(CC) $(CFLAGS) -I$(RB_SRC_PREFIX) -I$(UTILS_SRC_PREFIX) -I$(DFT_SRC_PREFIX) \
	-I$(ESTIMATOR_SRC_PREFIX) -I$(SUPPRESSOR_SRC_PREFIX) -c $< -o $@

# EXAMPLE.
$(BIN_PREFIX)example: examples/example.c $(HSV_LIB) $(RB_LIB) $(UTILS_LIB) $(DFT_LIB) $(ESTIMATOR_LIB) $(SUPPRESSOR_LIB)
	mkdir -p $(BIN_PREFIX)
	$(CC) $(CFLAGS) -I$(RB_SRC_PREFIX) -I$(UTILS_SRC_PREFIX) -I$(DFT_SRC_PREFIX) \
	-I$(ESTIMATOR_SRC_PREFIX) -I$(SUPPRESSOR_SRC_PREFIX) -I$(HSV_SRC_PREFIX) $^ -o $@ -lm

.PHONY: clean

clean:
	rm -rf $(BIN_PREFIX) $(OBJS_PREFIX) $(LIBS_PREFIX)
