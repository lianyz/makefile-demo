# set default target
# .DEFAULT_GOAL := all

.DEFAULT: all

.PHONY: all
all: clean gen build

.PHONY: clean
clean:
	@rm -f foo
	@rm -f *.txt
	@$(RM) output
	@rm -rf dest

gen:
	@touch foo

build:
	@echo "hello makefile" > foo

cat: a.txt b.txt
	@cat a.txt b.txt > c.txt

a.txt:
	@echo "this is file a" > a.txt
	@echo $(@D)
	@echo $(@F)

b.txt:
	@echo "b\nb\nb\nb" > b.txt

var-lost:
	export foo=bar; \
	echo "foo=[$$foo]"

TXT = Hello World
test:
	@# 这是测试
	@echo TODO
	@echo $(TXT)
	@echo $$HOME


# 内置变量与自动变量
output:
	$(CC) -o output input.c
	$(CC) -o $@ input.c

# 内置变量举例 
dest/%.txt: src/%.txt
	@[ -d dest ] || mkdir dest
	cp $< $@

# 判断与循环
ifeq ($(CC), gcc)
  libs=$(libs_for_gcc)
else
  libs=$(normal)
endif


LIST = one two three
loop:
	@echo $(libs)
	for i in $(LIST); do \
	  echo $$i; \
	done


func:
	srcfiles := $(shell echo src/{0..9}.txt); \
	@echo $(srcfiles)
