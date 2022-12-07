"""library of pipeline functions used for the RBFE benchmarking"""

import warnings as _warnings

__all__ = ['analysis',
           'prep',
           'fepprep'
            ]

# check for BioSimSpace
with _warnings.catch_warnings():
    _warnings.simplefilter("ignore")
    try:
        import BioSimSpace
        del BioSimSpace
    except:
        raise EnvironmentError('BioSimSpace required: www.biosimspace.org')

from . import analysis
from . import prep
from . import utils
