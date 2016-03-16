## python environment 
# in general, it might be better to use conda, but I keep a MacPorts setup
# ... these may already be installed as +universal
# python 2.7 was installed as 
# matplotlib for plotting
py_primary="27"
py_secondary="35"
for pyV in ${py_primary} ${py_secondary}
do
port install python${pyV} 
port install py${pyV}-matplotlib +latex +cairo +tkinter
# scipy does a lot of the heavy lifting on science stuff. Includes numpy
port install py${pyV}-scipy
port install py${pyV}-pandas
port install py${pyV}-jupyter py${pyV}-ipython 
port install py${pyV}-scikit-learn
port install py${pyV}-coverage py${pyV}-pip py${pyV}-netcdf4
port install py${pyV}-yaml
port install py${pyV}-virtualenvwrapper
port install py${pyV}-flake8 py${pyV}-pylint
port install py${pyV}-networkx
port install py${pyV}-graphviz
port install py${pyV}-psutil
done

# here's the only place where you decide whether py2 or py3 is primary
port select --set python python${py_primary}
port select --set ipython py${py_primary}-ipython
port select --set python3 python${py_secondary}
port select --set ipython3 py${py_secondary}-ipython

port select --set cython cython${py_primary}
port select --set sphinx py${py_primary}-sphinx

port select --set nosetests nosetests${py_primary}
port select --set pip pip${py_primary}
port select --set pep8 pep8-${py_primary}
port select --set pyflakes py${py_primary}-pyflakes
port select --set flake8 flake8-${py_primary}
port select --set pylint pylint${py_primary}

## pip installs: 
pip install numpydoc sphinx-rtd-theme
pip install mdtraj # TODO: this should be done via git, for local use
pip install fastcluster msmbuilder
pip install pymbar --pre
pip install svgwrite
pip install line_profiler


