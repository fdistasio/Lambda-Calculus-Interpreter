OCAMLC = ocamlc
FILES = src/types.ml src/utils.ml src/interpreter.ml test/tests.ml
TARGET = interpreter

all: $(TARGET)

$(TARGET): $(FILES)
	$(OCAMLC)  -I src -I test -o $(TARGET) $(FILES)

clean:
	rm -f $(TARGET) src/*.cmo src/*.cmi src/*.cmx test/*.cmo test/*.cmi

run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run
