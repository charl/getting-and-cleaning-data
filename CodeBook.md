Code Book
-

This code book describes the variables, data and any transformations or work that were performed to clean up the data for this project.

Unless specified otherwise, all commands were run from within a R CLI session (on GNU Linux).

**Note: All data files are kept in ./data.**

For more information on the purpose of the project and how to run the R script, see [README.md](https://github.com/charl/getting-and-cleaning-data/blob/master/README.md).

Save/Extract Raw Data
-

The following steps we followed to download and extract the [raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip):

```r
> download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./data/getdata_projectfiles_UCI_HAR_Dataset.zip", method="curl")
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 59.6M  100 59.6M    0     0   339k      0  0:03:00  0:03:00 --:--:--  378k
>
> unzip ("./data/getdata_projectfiles_UCI_HAR_Dataset.zip", exdir = "./data")
> list.files("./data")
[1] "getdata_projectfiles_UCI_HAR_Dataset.zip"
[2] "UCI HAR Dataset"
```

The raw [data file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is a little big so an exclusion entry was added to the project's .gitignore file to avoid pushing the file to Github.
