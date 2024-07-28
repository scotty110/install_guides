#!/bin/bash
# Install Python

set -eu
# Check if Installing from main
if [ -z ${PARENT_DIR+x} ]; then
	CHILD_DIR=$PWD
else
	CHILD_DIR=$PARENT_DIR/python
fi

# Install tools
sudo apt install -y build-essential

#export CONDA_HOME="/usr/local"
export CONDA_HOME="$HOME/.my_conda"
export PATH="$CONDA_HOME/bin:$PATH"

curl -o /tmp/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp $CONDA_HOME && \
    rm -rf /tmp/miniconda.sh

#sudo conda install -y python
$CONDA_HOME/bin/conda install -y python


# Install to rc
cat >> $HOME/.crc << EOF  

# Add Conda to PATH
export CONDA_HOME="$CONDA_HOME"
export PATH="\$CONDA_HOME/bin:\$PATH"
EOF


# Clean up
#sudo conda clean --all -y
$CONDA_HOME/bin/conda clean --all -y 

sudo rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

exit
