
# Recreating Conda Environments

Conda environments are backed up using the script at
`scripts/conda-env-export-all`. This results in two files being generated for
each environment: `$ENVIRONMENT.yml` and `$ENVIRONMENT.txt`.  The yml file is
used to initially recreate the environment from the packages that had been
directly requested. Then the txt file is used to recreate any packages
installed in develop mode. The txt file can also be used to compare with exact
versions of the backup.

NOTE: the next two steps are now combined in the command `recreate-conda-env
$ENVIRONMENT`, located in `scripts`.

To initially recreate the environment:

```bash
$CONDA env create -n $ENVIRONMENT -f $ENVIRONMENT.yml
```

where `$CONDA` can be either `conda` or `mamba`.

To reinstall developer installations:

```bash
dev-install -c dev-installs.yml -e $ENVIRONMENT $ENVIRONMENT.txt
```

The `dev-install` script is `scripts/dev-install`. The `dev-installs.yml`
contains a mapping `packages` that maps to a `name`, `directory`, and `install`
for each packages. Defaults for `directory` and `install` can be given in a
global `defaults` key. Some recognized special variables: `$NAME`, `$PYTHON`.

```yaml
defaults:
  directory: ~/pysrc/$NAME
  install: $PYTHON -m pip install -e .

packages:
  - name: nep29
    # uses default directory/install
  - name: contact-map
    directory: ~/pysrc/contact_map
    install: $PYTHON setup.py install
```
