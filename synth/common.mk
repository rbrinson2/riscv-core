
YOSYS=yosys
SV_SOURCES=$(wildcard ../../core/common/*.sv) $(wildcard ../../core/$(CORETYPE)/*.sv)
LOCAL_SOURCES=$(wildcard *.sv)

build: prep
	${MAKE} synth

prep:
	cp ../config.sv .
	cp ${SV_SOURCES} .
	cp ../../tests/add.text.vh .
	cp ../../tests/add.data.vh .

synth: result.json

config.sv: ../config.sv

result.json: ${LOCAL_SOURCES}
	${YOSYS} -p "hierarchy; proc; memory -nomap; wreduce -memx; opt -full; write_verilog result.v" -o $@ ${LOCAL_SOURCES}

clean:
	rm *.vh config.sv

