#VIVO project template
This is a git repository template for working with and customizing [VIVO](http://vivoweb.org/).  It uses the [three tiered build approach](https://wiki.duraspace.org/display/VIVO/Building+VIVO+in+3+tiers) documented by the VIVO project.  The project source files (VIVO and Vitro) are tracked using [Git Submodules](http://git-scm.com/book/en/Git-Tools-Submodules).

For a more detailed explanation of setting up the VIVO environment, consult the
[VIVO version 1.10 installation instructions](https://wiki.duraspace.org/display/VIVODOC110x/Installing+VIVO).

##Checking out the project and building VIVO in three tiers

### Develop branch
~~~

    git clone https://git.tib.eu/OSL/VIVO/VIVO_project_template.git vivo
    cd vivo
    git submodule init

#Pull in VIVO and Vitro.  This will take a few minutes.

    git submodule update

#Check out specific versions of VIVO and Vitro

    cd VIVO
    git checkout develop
    cd ../Vitro
    git checkout develop

#Change back to vivo main directory

    cd ../VIVO


#Build and deploy

mvn install -s ../project-settings.xml
