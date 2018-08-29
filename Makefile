zips = $(wildcard zips/*.zip)
csvs = $(patsubst zips/%.zip, csvs/%.csv, $(zips))

.PHONY: all test clean example reset

test: test_makefile 

test_makefile:
	@echo $(csvs)

all: $(csvs)

csvs: $(csvs)

csvs/%.csv: zips/%.zip
	-unzip -u $< -d csvs

gpkgs/%.gpkg: gdbs/%.gdb
	-ogr2ogr -progress -f GPKG $@ $<
	-ogr2ogr -update -f GPKG $@ $<

clean:	
	-rm -rf $(csvs)	

reset: 
	-rm -rf $(csvs)
	-rm -rf $(gpkgs)
