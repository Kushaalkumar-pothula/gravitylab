from setuptools import setup
from setuptools import Extension
from Cython.Distutils import build_ext
import numpy

extensions = [Extension("gravitylab.solvers", ["gravitylab/solvers.pyx"])]
cmdclass = {"build_ext" : build_ext}

setup(
    name="GravityLab",
    version="2.2.0",
    packages=["gravitylab"],
    license="MIT",
    author="Kushaal Kumar Pothula",
    author_email="kushaalkumar.astronomer@gmail.com",
    url = "https://github.com/Kushaalkumar-pothula/gravitylab",
    description="Fast astrophysical N-body simulator",
    long_description=open("README.md").read(),
    long_description_content_type='text/markdown',
    cmdclass=cmdclass,
    ext_modules=extensions,
    include_dirs=[numpy.get_include()],
    install_requires = [
        'numpy>=1.20.0',
        'matplotlib>=3.3.2'
    ]
)