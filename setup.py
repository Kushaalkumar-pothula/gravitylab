from setuptools import setup
from Cython.Build import cythonize
import numpy

setup(
    name="GravityLab",
    version="0.1",
    packages=["gravitylab"],
    author="Kushaal Kumar Pothula",
    author_email="kushaalkumar.astronomer@gmail.com",
    description="Astrophysical N-body simulator",
    long_description=open("README.md").read(),
    ext_modules=cythonize("gravitylab/solvers.pyx"),
    include_dirs=[numpy.get_include()],
    install_requires = [
        'numpy>=1.20.2',
        'matplotlib>=3.3.4'
    ]
)