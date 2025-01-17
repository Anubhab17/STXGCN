# STXGCN

R Libraries required:
```evmix```, ```forecast```, ```dfms```, ```gstar```, ```xts```

Python libraries required are listed in the ```requirements.txt``` file.


# Folders

```data``` contains the cleaned data of the air pollutants along with their locations and the Haversine matrix.

```rscripts``` conatins all the R codes that have been implemented for the model.

```pyscripts``` conatins all the python codes that have been implemented for the model.

```results``` contains the folders to the results for all the models.

# Obtaining the results

To get the results for Peaks over threshold run ```Fitting_GPD.R``` in the ```rscripts``` folder. Change the chunk of code for the ```data_folder``` to the location where you have cloned the repository.

```r
data_folder <- "C:/Users/anubhab.biswas/OneDrive - SUPSI/Documenti/"
```

Also set a new storage folder for saving the results by changing the following code.

```r
result_folder <- paste0(data_folder,"STXGCN/results/")
```
Note that a subfolder called ```pot_results``` inside ```result_folder``` will be required.

For obtaining the results for individual baseline models create the following sub-folders inside ```result_folder```:

```ha```, ```arima```, ```dfm```, ```gstar```, ```lstm```, ```stgcn```, ```stxgcn```


# Model Architecture

![Model](https://github.com/Anubhab17/STXGCN/assets/115042418/99ecf5a1-fbfb-4785-8b4f-2f2b657e5156)

