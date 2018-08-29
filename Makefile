zips = $(wildcard zips/*.zip)
csvs = $(patsubst zips/%.zip, csvs/%.csv, $(zips))

.PHONY: all test clean example reset spatial

test: test_makefile 

test_makefile:
	@echo $(csvs)

all: $(csvs)

csvs: $(csvs)

csvs/%.csv: zips/%.zip
	-unzip -u $< -d csvs

spatial: spatial/allBasins.shp

spatial/allBasins.shp: spatial/LkCat_Frame_min.zip
	-unzip -j -u $< 'LkCat_Frame_min/shps/*' -d 'spatial'

reset: 
	-rm -rf $(csvs)
