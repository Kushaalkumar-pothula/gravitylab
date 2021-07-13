from setuptools import setup
from Cython.Build import cythonize
import numpy

setup(
    name="GravityLab",
    version="2.1",
    packages=["gravitylab"],
    license="MIT",
    author="Kushaal Kumar Pothula",
    author_email="kushaalkumar.astronomer@gmail.com",
    url = "https://github.com/Kushaalkumar-pothula/gravitylab",
    description="Fast astrophysical N-body simulator",
    long_description=open("README.md").read(),
    long_description_content_type='text/markdown',
    ext_modules=cythonize("gravitylab/solvers.pyx"),
    include_dirs=[numpy.get_include()],
    install_requires = [
        'numpy>=1.20.2',
        'matplotlib>=3.3.4'
    ]
)