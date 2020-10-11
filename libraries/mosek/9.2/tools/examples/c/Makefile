
#
# Compile and run MOSEK examples
#

CC=clang
IPATHS=-I../../platform/osx64x86/h
LPATHS=-L../../platform/osx64x86/bin

blas_lapack: blas_lapack.c
	$(CC) -g $(IPATHS) $(LPATHS) -o blas_lapack blas_lapack.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib blas_lapack || rm -f blas_lapack
callback: callback.c
	$(CC) -g $(IPATHS) $(LPATHS) -o callback callback.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib callback || rm -f callback
portfolio_1_basic: portfolio_1_basic.c
	$(CC) -g $(IPATHS) $(LPATHS) -o portfolio_1_basic portfolio_1_basic.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib portfolio_1_basic || rm -f portfolio_1_basic
portfolio_2_frontier: portfolio_2_frontier.c
	$(CC) -g $(IPATHS) $(LPATHS) -o portfolio_2_frontier portfolio_2_frontier.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib portfolio_2_frontier || rm -f portfolio_2_frontier
portfolio_3_impact: portfolio_3_impact.c
	$(CC) -g $(IPATHS) $(LPATHS) -o portfolio_3_impact portfolio_3_impact.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib portfolio_3_impact || rm -f portfolio_3_impact
portfolio_4_transcost: portfolio_4_transcost.c
	$(CC) -g $(IPATHS) $(LPATHS) -o portfolio_4_transcost portfolio_4_transcost.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib portfolio_4_transcost || rm -f portfolio_4_transcost
portfolio_5_card: portfolio_5_card.c
	$(CC) -g $(IPATHS) $(LPATHS) -o portfolio_5_card portfolio_5_card.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib portfolio_5_card || rm -f portfolio_5_card
cqo1: cqo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o cqo1 cqo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib cqo1 || rm -f cqo1
ceo1: ceo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o ceo1 ceo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib ceo1 || rm -f ceo1
pow1: pow1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o pow1 pow1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib pow1 || rm -f pow1
errorreporting: errorreporting.c
	$(CC) -g $(IPATHS) $(LPATHS) -o errorreporting errorreporting.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib errorreporting || rm -f errorreporting
feasrepairex1: feasrepairex1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o feasrepairex1 feasrepairex1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib feasrepairex1 || rm -f feasrepairex1
lo1: lo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o lo1 lo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib lo1 || rm -f lo1
lo2: lo2.c
	$(CC) -g $(IPATHS) $(LPATHS) -o lo2 lo2.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib lo2 || rm -f lo2
logistic: logistic.c
	$(CC) -g $(IPATHS) $(LPATHS) -o logistic logistic.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib logistic || rm -f logistic
gp1: gp1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o gp1 gp1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib gp1 || rm -f gp1
milo1: milo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o milo1 milo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib milo1 || rm -f milo1
mioinitsol: mioinitsol.c
	$(CC) -g $(IPATHS) $(LPATHS) -o mioinitsol mioinitsol.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib mioinitsol || rm -f mioinitsol
mico1: mico1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o mico1 mico1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib mico1 || rm -f mico1
modelLib: modelLib.c
	$(CC) -g $(IPATHS) $(LPATHS) -o modelLib modelLib.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib modelLib || rm -f modelLib
opt_server_async: opt_server_async.c
	$(CC) -g $(IPATHS) $(LPATHS) -o opt_server_async opt_server_async.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib opt_server_async || rm -f opt_server_async
opt_server_sync: opt_server_sync.c
	$(CC) -g $(IPATHS) $(LPATHS) -o opt_server_sync opt_server_sync.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib opt_server_sync || rm -f opt_server_sync
parameters: parameters.c
	$(CC) -g $(IPATHS) $(LPATHS) -o parameters parameters.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib parameters || rm -f parameters
reoptimization: reoptimization.c
	$(CC) -g $(IPATHS) $(LPATHS) -o reoptimization reoptimization.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib reoptimization || rm -f reoptimization
qcqo1: qcqo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o qcqo1 qcqo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib qcqo1 || rm -f qcqo1
qo1: qo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o qo1 qo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib qo1 || rm -f qo1
response: response.c
	$(CC) -g $(IPATHS) $(LPATHS) -o response response.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib response || rm -f response
sdo1: sdo1.c
	$(CC) -g $(IPATHS) $(LPATHS) -o sdo1 sdo1.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib sdo1 || rm -f sdo1
sdo2: sdo2.c
	$(CC) -g $(IPATHS) $(LPATHS) -o sdo2 sdo2.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib sdo2 || rm -f sdo2
sensitivity: sensitivity.c
	$(CC) -g $(IPATHS) $(LPATHS) -o sensitivity sensitivity.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib sensitivity || rm -f sensitivity
simple: simple.c
	$(CC) -g $(IPATHS) $(LPATHS) -o simple simple.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib simple || rm -f simple
solutionquality: solutionquality.c
	$(CC) -g $(IPATHS) $(LPATHS) -o solutionquality solutionquality.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib solutionquality || rm -f solutionquality
solvebasis: solvebasis.c
	$(CC) -g $(IPATHS) $(LPATHS) -o solvebasis solvebasis.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib solvebasis || rm -f solvebasis
solvelinear: solvelinear.c
	$(CC) -g $(IPATHS) $(LPATHS) -o solvelinear solvelinear.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib solvelinear || rm -f solvelinear
sparsecholesky: sparsecholesky.c
	$(CC) -g $(IPATHS) $(LPATHS) -o sparsecholesky sparsecholesky.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib sparsecholesky || rm -f sparsecholesky
unicode: unicode.c
	$(CC) -g $(IPATHS) $(LPATHS) -o unicode unicode.c -lmosek64 -Wl,-headerpad,128
	install_name_tool -change libmosek64.9.2.dylib `pwd`/../../platform/osx64x86/bin/libmosek64.9.2.dylib unicode || rm -f unicode
.PHONY: clean test all

all: blas_lapack callback portfolio_1_basic portfolio_2_frontier portfolio_3_impact portfolio_4_transcost portfolio_5_card cqo1 ceo1 pow1 errorreporting feasrepairex1 lo1 lo2 logistic gp1 milo1 mioinitsol mico1 modelLib opt_server_async opt_server_sync parameters reoptimization qcqo1 qo1 response sdo1 sdo2 sensitivity simple solutionquality solvebasis solvelinear sparsecholesky unicode

clean:
	rm -f blas_lapack callback portfolio_1_basic portfolio_2_frontier portfolio_3_impact portfolio_4_transcost portfolio_5_card cqo1 ceo1 pow1 errorreporting feasrepairex1 lo1 lo2 logistic gp1 milo1 mioinitsol mico1 modelLib opt_server_async opt_server_sync parameters reoptimization qcqo1 qo1 response sdo1 sdo2 sensitivity simple solutionquality solvebasis solvelinear sparsecholesky unicode

test: blas_lapack callback portfolio_1_basic portfolio_2_frontier portfolio_3_impact portfolio_4_transcost portfolio_5_card cqo1 ceo1 pow1 errorreporting feasrepairex1 lo1 lo2 logistic gp1 milo1 mioinitsol mico1 modelLib opt_server_async opt_server_sync parameters reoptimization qcqo1 qo1 response sdo1 sdo2 sensitivity simple solutionquality solvebasis solvelinear sparsecholesky unicode
	./blas_lapack
	./callback
	./portfolio_1_basic
	./portfolio_2_frontier
	./portfolio_3_impact
	./portfolio_4_transcost
	./portfolio_5_card
	./cqo1
	./ceo1
	./pow1
	./errorreporting
	./feasrepairex1
	./lo1
	./lo2
	./logistic
	./gp1
	./milo1
	./mioinitsol
	./mico1
	./modelLib
	./opt_server_async
	./opt_server_sync
	./parameters
	./reoptimization
	./qcqo1
	./qo1
	./response
	./sdo1
	./sdo2
	./sensitivity
	./simple
	./solutionquality
	./solvebasis
	./solvelinear
	./sparsecholesky
	./unicode
