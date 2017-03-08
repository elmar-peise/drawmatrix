all: drawmatrix.sty drawmatrix.pdf drawmatrix.tgz

drawmatrix.sty: drawmatrix.dtx drawmatrix.ins
	rm -f drawmatrix.sty
	latex ${TEXFLAGS} drawmatrix.ins

drawmatrix.pdf: drawmatrix.dtx drawmatrix.sty
	pdflatex ${TEXFLAGS} drawmatrix.dtx
	makeindex -s gind.ist drawmatrix.idx
	makeindex -s gglo.ist -o drawmatrix.gls drawmatrix.glo
	pdflatex ${TEXFLAGS} drawmatrix.dtx

drawmatrix.tgz: README.md drawmatrix.dtx drawmatrix.ins drawmatrix.pdf
	mkdir drawmatrix
	cp $^ drawmatrix
	tar -czf $@ drawmatrix
	rm -r drawmatrix

clean:
	rm -rf drawmatrix.{sty,gls,glo,hd,idx,ilg,ind,out,toc,pdf,aux,log,tgz} texput.log

installlocal:
	tlmgr install drawmatrix.dtx
