paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	python plot.py -i $*.dat -o $@

.PHONY: clean
clean: 
	# rm -rf *.png
	git ls-files -o | xargs rm -f