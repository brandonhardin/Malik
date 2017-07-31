all:
	python setup.py build_ext -if

wheel:
	python setup.py bdist_wheel

clean:
	-rm -r build malik/*.cpp rng/*.cpp malik/*.so rng/*.so
